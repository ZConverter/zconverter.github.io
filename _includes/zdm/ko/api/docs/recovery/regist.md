{% include zdm/base-path.html %}
새로운 복구 작업을 등록합니다.

---

## `POST /recoveries` {#post-recoveries}

> * 새로운 복구 작업을 시스템에 등록합니다.
> * Source 서버의 백업 데이터를 Target 서버로 복구합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/recoveries</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 복구 작업 등록
curl -X POST "https://api.example.com/api/recoveries" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "source": "source-server",
    "target": "target-server",
    "platform": "vmware",
    "repository": {
      "id": 13
    },
    "mode": "full",
    "jobName": "daily-recovery"
  }'

# 상세 설정 포함 복구 작업 등록
curl -X POST "https://api.example.com/api/recoveries" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "source": "source-server",
    "target": "target-server",
    "platform": "aws",
    "repository": {
      "id": 13,
      "type": "smb",
      "path": "//192.168.1.100/backup"
    },
    "mode": "full",
    "afterReboot": "reboot",
    "overwrite": "allow",
    "jobList": [
      {
        "sourcePartition": "/",
        "targetPartition": "/dev/sda1",
        "backupJob": "daily-backup-root"
      },
      {
        "sourcePartition": "/home",
        "targetPartition": "/dev/sdb1",
        "mode": "increment",
        "backupJob": "daily-backup-home",
        "backupFile": "backup-home-2025-01-15.ZIA"
      }
    ]
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `source` | string | Required | 소스 서버 ID (숫자) 또는 서버 이름 | - |
| `target` | string | Required | 타겟 서버 ID (숫자) 또는 서버 이름 | - |
| `platform` | string | Required | 타겟 플랫폼 | {% include zdm/platforms.md inline=true %} |
| `repository` | object | Required | 레포지토리 정보 | - |
| `repository.id` | number | Required | 레포지토리 ID (ZDM에 등록된 Repository ID) | - |
| `repository.type` | string | Optional | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `repository.path` | string | Optional | 레포지토리 경로 | - |
| `mode` | string | Required | 작업 모드 | {% include zdm/job-modes.md %} |
| `jobName` | string | Optional | 작업 이름 | - |
| `overwrite` | string | Optional | 덮어쓰기 허용 여부 | `allow`, `not allow` |
| `user` | string | Optional | 사용자 ID (숫자) 또는 이메일 | - |
| `schedule` | object \| number | Optional | 스케줄 객체 또는 스케줄 ID. 복구는 type `0`~`6`(basic)만 지원합니다. [스케줄 개요]({{ base_path }}/docs/schedule/overview) 참조 | - |
| `afterReboot` | string | Optional | 작업 후 부팅 방식 | {% include zdm/after-reboot.md %} |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한) | - |
| `excludePartition` | string | Optional | 제외할 파티션 목록 (콤마 구분, 예: `"h,d"` 또는 `"/boot,/home"`) | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `autoStart` | string | Optional | 등록 직후 자동 시작 여부. 대상 서버가 사용 중이면 등록은 되고 자동 시작만 생략됩니다 — 아래 "대상 서버가 사용 중일 때" 참고 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `cloudAuth` | string | Optional | 클라우드 인증 정보 ID/Name | - |
| `listOnly` | boolean | Optional | `true`: jobList에 지정된 파티션만 작업, `false`: 전체 파티션 작업 (기본값) | - |
| `jobList` | array | Optional | 개별 작업 설정 배열 | - |

**jobList 항목 구조:**

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `sourcePartition` | string | Required | 소스 파티션 |
| `targetPartition` | string | Required | 타겟 파티션 |
| `overwrite` | string | Optional | 덮어쓰기 허용 여부 (`allow`, `not allow`) |
| `backupJob` | string | Optional | 사용할 백업 작업 이름 (미지정 시 최신 성공 작업 자동 선택). **마지막 실행이 실패한 작업을 지정하면 거부됩니다** — 아래 "백업 작업 사용 가능 조건" 참고 |
| `backupFile` | string \| string[] | Optional | 사용할 백업 이미지 파일명 (미지정 시 최신 이미지 자동 선택). 배열로 여러 장 지정 시 순서가 곧 복구 순서입니다 |
| `mode` | string | Optional | 작업 모드 (`full`, `increment`) |
| `repository` | object | Optional | 레포지토리 정보 (미지정 시 공통 repository 사용) |
| `repository.id` | number | Required | 레포지토리 ID |
| `repository.type` | string | Optional | 레포지토리 타입 |
| `repository.path` | string | Optional | 레포지토리 경로 |

> **백업 작업 사용 가능 조건 (since 3.0.0)**
>
> 복구는 **success 상태인 백업 작업만** 참조할 수 있습니다. 진행 중이거나 마지막 실행이 실패한 작업은
> 복구 대상이 될 수 없습니다.
>
> - **`backupJob` 지정**: 그 작업의 **마지막 실행 결과**로 갈립니다. 실패한 작업이면 `JOB-ERROR-67` (400) 으로 거부됩니다.
> - **`backupFile` 지정**: 이미지가 속한 작업이 success 면 그대로 등록됩니다.
>   작업이 사용 불가 상태여도 **지정한 이미지가 그 작업의 최신 이미지가 아니면 등록됩니다** —
>   최신 이미지는 실패한 실행의 산출물일 수 있지만, 그보다 오래된 이미지는 성공한 실행이 남긴 완결된 파일이기 때문입니다.
>   최신 이미지를 지정하면 `JOB-ERROR-67` (400) 으로 거부됩니다.
> - **둘 다 지정**: `backupFile` 규칙이 우선합니다. 다만 이미지의 소속 작업명이 `backupJob` 과 다르면
>   기존대로 `BAD_REQUEST` (400) 으로 거부됩니다.
>
> 자동 선택 경로(`backupJob`·`backupFile` 모두 미지정)는 애초에 **사용 가능한 작업만** 후보로 삼습니다.

> **필수 식별자의 공백 값 (since 2026-09-01)**
>
> `center` / `source` / `target` 등 필수 식별자 필드는 **공백만 있거나 빈 문자열이면 거부**됩니다. 값은 앞뒤 공백을 제거한 뒤 사용됩니다. (예: `"center": " "` → 400, 메시지는 기존 `center is required`와 동일)

> **Windows 파티션 정규화 (since 2026-05-15)**
>
> Windows 서버 대상으로 등록 시 `sourcePartition` / `targetPartition` 입력값은 비교 단계에서 자동으로 대문자 변환 및 `:` 보정이 적용됩니다. 입력 `c`, `C`, `c:`, `C:` 모두 동일하게 `C:`로 취급되어 서버 파티션 정보와 매칭됩니다. (Linux는 정규화 없음 — 원본 그대로 비교)

> **`overwrite` 는 Linux 전용입니다 (since 3.0.0)**
>
> `overwrite` 는 target 에 짝이 없는 데이터 파티션을 `/` 로 통합하는 Linux 규칙입니다. Windows 는 드라이브 단위라 통합할 상위 대상이 없어 이 옵션이 의미를 갖지 않습니다.
>
> Windows 대상 등록에 `overwrite: "allow"` (전역 또는 `jobList[].overwrite`) 를 보내면 **거부하지 않고 옵션을 무시**합니다 — 값은 `"not allow"` 로 처리되어 등록되고, 응답 `notices` 에 무시했다는 안내가 담깁니다. 응답의 `partitions[].overwrite` 는 **`"Not overwritten"`** 으로 나옵니다.
>
> **이전 동작과 다릅니다.** 3.0.0 이전에는 같은 요청이 `JOB-ERROR-56` (409 Conflict) 로 거부됐습니다. 이 에러에 의존하던 소비자는 영향을 받습니다.

> **대상 서버가 사용 중일 때 (since 3.0.0)**
>
> 대상 서버에 다른 복구 작업이 진행 중이어도 **등록은 언제나 성공합니다.** 막히는 것은 등록이 아니라 실행입니다.
>
> | 요청 | 동작 |
> |------|------|
> | `autoStart` 미지정 | 등록 성공. `notices` 에 진행 중인 작업 안내가 담깁니다 |
> | `autoStart: "use"` | 등록 성공. **자동 시작만 생략**되고 사유가 `notices` 에 담깁니다. 이때 응답의 `common.autoStart` 는 요청한 `"use"` 가 아니라 **`"not use"`** 입니다 |
> | `PUT /recoveries/:identifier` 의 `status: "start"` | `JOB-ERROR-64` (409 Conflict) 로 **거부**됩니다 |
>
> 자동 시작이 생략된 작업은 진행 중인 복구가 끝난 뒤 `PUT /recoveries/:identifier` 에 `status: "start"` 를 보내 실행하세요.
>
> 진행 중 복구를 확인하는 조회 자체가 실패하면 등록도 자동 시작도 막지 않습니다 — 확인이 되지 않는다는 이유로 정상 요청을 거부하지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

> **v2.0.2 변경 사항**:
> - `schedule.basic` 객체에 `id` 필드 신규 추가 (type/description 은 기존 형식 그대로)
> - 응답에 `notices?: string[]` 필드 신규 — backup 없는 partition 자동 skip 안내 (값이 있을 때만 포함)

> **자동 partition skip 동작**: source 서버의 partition 중 복구에 쓸 수 있는 백업이 없는 partition 은 자동으로 jobList 에서 제외됩니다 (silent skip). skip 된 partition 은 `notices` 에 안내 메시지로 포함됩니다. 전체 partition 이 skip 되면 `JOB-ERROR-14` (400 Bad Request) 응답이 반환되며, 각 partition 이 왜 제외됐는지가 메시지에 함께 담깁니다. `excludePartition` 옵션을 명시하지 않아도 동일하게 동작합니다.

> **skip 사유 분류 (since 3.0.0)**
>
> 제외 사유는 아래 여섯 가지로 구분되어 안내됩니다. 사유마다 필요한 조치가 다릅니다.
>
> | 사유 | 안내 | 조치 |
> |------|------|------|
> | 백업 작업 없음 | `Partition '/' has no backup job.` | 해당 파티션의 백업 작업을 먼저 등록·실행 |
> | 마지막 실행 실패 | `... the last run failed for every backup job (jobs: ...)` | 백업 재실행, 또는 다른 이미지를 `backupFile` 로 직접 지정 |
> | 진행 중 | `... a backup job is currently running (jobs: ...)` | 백업 완료 후 재시도 |
> | 실행 이력 없음 | `... the backup job is registered but has never run (jobs: ...)` | 백업을 최초 실행 |
> | 이미지 조회 실패 | `... backup job '...' succeeded, but no backup image was found in repository N.` | 저장소 상태 확인 |
> | repository 불일치 | `... backup job '...' backs up to repository N, but this request specifies repository M.` | `repository.id` 를 맞추거나 `backupFile` 로 직접 지정 |
>
> 백업 작업 없음 · 진행 중 · 실행 이력 없음 세 가지에는 `backupFile` 지정 안내가 붙지 않습니다 —
> 해당 파티션에 성공 이력이 없어 지정할 이미지 자체가 존재하지 않기 때문입니다.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "common": {
      "state": "success",
      "jobName": "daily-recovery",
      "autoStart": "not use",
      "platform": "vmware",
      "bootMode": "reboot",
      "schedule": {
        "basic": {
          "id": 7,
          "type": "Daily",
          "description": "[Basic] Start working at 03:00 every day."
        }
      },
      "scriptPath": "/opt/scripts/post-recovery.sh",
      "scriptRunTiming": "after job"
    },
    "partitions": [
      {
        "sourcePartition": "/",
        "targetPartition": "/dev/sda1",
        "jobMode": "Full Recovery",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLatest": "true",
          "backupFile": "backup-2025-01-15.img",
          "backupJob": "daily-backup"
        },
        "repository": {
          "id": "1",
          "path": "/backup",
          "type": "nfs"
        }
      },
      {
        "sourcePartition": "/home",
        "targetPartition": "/dev/sdb1",
        "jobMode": "Incremental Recovery",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLatest": "true",
          "backupFile": "backup-home-2025-01-15.img",
          "backupJob": "daily-backup-home"
        },
        "repository": {
          "id": "1",
          "path": "/backup",
          "type": "nfs"
        }
      }
    ],
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    }
  },
  "message": "Recovery job registration completed",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `common.state` | string | 등록 결과 (`success` / `fail`) |
| `common.jobName` | string | 등록된 작업 이름 |
| `common.autoStart` | string | 자동 시작 여부 — **요청값의 반향이 아니라 실제로 적용된 값**입니다. `autoStart: "use"` 로 요청해도 대상 서버가 사용 중이면 자동 시작이 생략되고 이 필드는 `"not use"` 로 반환됩니다. 요청값과 응답값이 항상 같다고 가정하지 마세요 |
| `common.platform` | string | 타겟 플랫폼 |
| `common.bootMode` | string | 작업 후 부팅 모드 (`reboot` / `shutdown` / `maintain`) |
| `common.schedule.basic` | object | 기본 스케줄 정보 (설정시에만 포함) — `{ id, type, description }` 객체 |
| `common.schedule.basic.id` | number | 스케줄 ID (v2.0.2 신규) |
| `common.schedule.basic.type` | string | 스케줄 타입 이름 (예: `"Daily"`). 값 목록은 [스케줄 개요]({{ base_path }}/docs/schedule/overview#스케줄-타입별-구조-및-설명)의 타입 표이며, 조회 실패 시 `"Unknown"` |
| `common.schedule.basic.description` | string | 스케줄 내용을 설명하는 영문 한 줄 (예: `"[Basic] Start working at 03:00 every day."`). 조회 실패 시 `"Schedule lookup failed"` |
| `common.scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `common.scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `common.errorMessage` | string | 실패 시 오류 메시지 |
| `partitions[].sourcePartition` | string | 소스 파티션/드라이브 명 |
| `partitions[].targetPartition` | string | 타겟 파티션/드라이브 명 |
| `partitions[].jobMode` | string | 파티션별 작업 모드 (`Full Recovery` · `Incremental Recovery`) |
| `partitions[].overwrite` | string | 덮어쓰기 상태 |
| `partitions[].fileSystem` | string | 파일시스템 |
| `partitions[].backup.useLatest` | string | 최신 백업 파일 사용 여부 |
| `partitions[].backup.backupFile` | string | 백업 파일 이름 |
| `partitions[].backup.backupJob` | string | 백업 작업 이름 |
| `partitions[].repository.id` | string | 레포지토리 ID |
| `partitions[].repository.path` | string | 레포지토리 경로 |
| `partitions[].repository.type` | string | 레포지토리 타입 |
| `summary.total` | number | 총 파티션 수 |
| `summary.successful` | number | 성공한 파티션 수 |
| `summary.failed` | number | 실패한 파티션 수 |
| `notices` | string[] (optional) | 사용자 안내 메시지 배열 (v2.0.2 신규). 안내할 내용이 있을 때만 응답에 포함되며, 사유는 세 가지입니다. ① 대상 서버가 사용 중 (since 3.0.0) — 아래 "대상 서버 사용 중 안내 문구" 참고. ② backup 작업·이미지가 없는 partition 자동 skip — 예: `"Partition/drive 'D:' was skipped — no backup available: Backup job not found for partition 'D:' on server 'src-win01'"`. ③ Windows 대상에서 `overwrite` 무시 (since 3.0.0) — `"The overwrite option is Linux-only and was ignored for this Windows recovery job."`. 여러 사유가 함께 발생하면 **`overwrite` 무시 안내 → 대상 서버 안내 → partition skip 안내** 순으로 배열에 담깁니다 |

> **대상 서버 사용 중 안내 문구 (since 3.0.0)**
>
> 대상 서버에 진행 중인 복구가 있으면 아래 문구가 `notices` 에 담깁니다. `<jobName>` 은 진행 중인 복구 작업 이름, `<targetServer>` 는 대상 서버 이름입니다.
>
> - `autoStart: "use"` 로 요청해 자동 시작이 생략된 경우
>   `Recovery job '<jobName>' is currently in progress on target server '<targetServer>' — this job was registered but autoStart was skipped. Start it with a status update once the running job completes.`
> - `autoStart` 없이 등록한 경우
>   `Recovery job '<jobName>' is currently in progress on target server '<targetServer>' — this job was registered but not started.`
>
> 두 경우 모두 **등록은 거부되지 않습니다** — 대상 서버가 사용 중이라는 이유로 실패하지 않습니다.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (422 Unprocessable Entity)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "platform": [
        "platform must be one of: oci, ncp, gcp, aws, azure, vmware, scp, openstack, cloudstack, kt, nhn, nutanix, proxmox, kvm, hyperv, xenserver"
      ]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**사용할 수 없는 백업 작업 지정 (400 Bad Request) — since 3.0.0**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-67",
    "message": "[Recovery registration] - Backup job 'daily-backup-root' cannot be used for recovery because its last run failed (server: SOURCE-01, partition: /). Re-run the backup job, or specify an older image with 'backupFile'."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**등록할 파티션이 하나도 남지 않음 (400 Bad Request)**

전체 partition 이 skip 된 경우입니다. 메시지에 partition 별 제외 사유가 함께 담깁니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-14",
    "message": "[Recovery registration] No partitions left to register — every candidate partition was excluded. Reason(s): Partition/drive '/' was skipped — no backup available: Partition '/' has no usable backup job — the last run failed for every backup job (jobs: daily-backup-root). Re-run the backup job, or check separately whether another usable image exists and specify it with 'backupFile'."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**주요 에러 코드**

| code | HTTP | 발생 조건 |
|------|------|-----------|
| `JOB-ERROR-14` | 400 | 등록 대상 partition 이 0건 — 전체 skip 또는 `excludePartition` 으로 전부 제외 |
| `JOB-ERROR-67` | 400 | 지정한 `backupJob` 이 사용 불가 상태이거나, 사용 불가 작업의 **최신** 이미지를 `backupFile` 로 지정 |
| `JOB-ERROR-63` | 400 | `listOnly: true` 인데 `jobList` 가 비었거나 없음 |
| `JOB-ERROR-68` | 500 | 이미지 조회 시간 초과 — 데몬이 이미지 목록을 채우지 못함. 재시도할 수 있는 이미지 조회 실패입니다(종전 408 `TIMEOUT_ERROR`) |
| `BAD_REQUEST` | 400 | `backupFile` 의 파티션이 `sourcePartition` 과 불일치, 또는 이미지의 소속 작업명이 `backupJob` 과 불일치 |

> **이미지 조회 대기와 클라이언트 timeout (since 4.0.0).** 이미지 조회 대기는 (center, repository) 조합마다 30초이고, 서버의 바깥 한도는 대기 합계 + 25초입니다. 조합이 1·2·3·4개이면 기본 폴링 간격(1초)에서 각각 55·85·115·145초입니다. 클라이언트의 요청 timeout 은 이보다 길게 두세요. 시간이 초과되면 408 대신 500 `JOB-ERROR-68`(`Backup image lookup timed out …`, center·repository·마지막 작업 상태 포함)이 나가며, 이를 재시도할 수 있는 이미지 조회 실패로 처리하세요.

> **`JOB-ERROR-64` (409) 는 이 엔드포인트에서 발생하지 않습니다 (since 3.0.0).** 대상 서버에 진행 중인 복구가 있어도 등록은 거부되지 않습니다 — `autoStart` 를 요청했다면 자동 시작만 생략되고 사유가 `notices` 로 안내됩니다. 이 에러는 등록된 작업을 실제로 시작할 때, 즉 `PUT /recoveries/:identifier` 의 `status: "start"` 에서만 반환됩니다.

</details>

<details markdown="1">
<summary><strong>schedule 동봉 예시</strong></summary>

{% include zdm/schedule-object.md smart=false %}

**복구 스케줄 정책**

- 복구 작업은 `basic` 스케줄만 지원합니다. `mode` 는 `full` / `increment` 만 허용되며 `smart` 모드가 없습니다. Smart 스케줄(type 7~11)을 보내면 400 `JOB-ERROR-101` 로 거부됩니다. `advanced` 는 사용하지 않습니다.
- `schedule` 을 생략하면 별도 예약 없이 등록되고, 응답에 `common.schedule` 이 포함되지 않습니다. `autoStart=use` 와 함께 쓰면 즉시 1회 실행됩니다. 다만 대상 서버에 진행 중인 복구가 있으면 등록만 되고 **자동 시작은 생략**됩니다 (위 "대상 서버가 사용 중일 때" 참고).
- `schedule` 과 `autoStart` 는 독립적입니다. `autoStart=use` 는 등록 직후 1회 즉시 실행을, `schedule` 은 이후 반복/예약 실행을 제어합니다. 대상 서버가 사용 중이어서 자동 시작이 생략되어도 `schedule` 등록에는 영향이 없습니다.
- 응답의 `common.schedule` 은 `schedule` 을 보냈을 때만 `{ basic: { id, type, description } }` 형태로 포함됩니다.
- 숫자 ID 는 **복사 없이 그 스케줄을 참조**합니다. 작업의 스케줄 ID 가 입력한 ID 가 됩니다. 객체 안 `basic` 자리의 숫자는 그 내용을 복사해 새 스케줄로 저장하므로 응답의 ID 가 입력한 ID 와 다릅니다. 존재하지 않는 ID 는 404 `SCHEDULE-ERROR-01` 입니다. 지정한 스케줄이 요청 `center` 의 것이 아니면 403 `CENTER-ERROR-01`(`Schedule ID '<id>' does not belong to center <center>`)이며, `nCenterID = 0` 도 하나의 center 로 비교합니다. 객체 안 `basic` 자리의 숫자도 같은 center 검사를 받고, 행의 type 이 요청 `type` 과 다르면 400 `JOB-ERROR-108`(`Schedule ID '<id>' is type <n>, but the request type is <m>.`)입니다. 검사 순서는 존재(404) → center(403) → type(400)입니다.

---

**1. schedule type 3 (Daily)**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": {
    "id": 13
  },
  "mode": "full",
  "schedule": {
    "type": 3,
    "basic": {
      "time": "10:00"
    }
  }
}
```

성공 응답 (200 OK) — `common.schedule.basic`:

```json
{
  "basic": {
    "id": 8,
    "type": "Daily",
    "description": "[Basic] Start working at 10:00 every day."
  }
}
```

타입별 `basic` 구성(type 0~6)은 [스케줄 개요]({{ base_path }}/docs/schedule/overview#타입별-요청-예시-type-0--11)를 참조하세요.

---

**2. 스케줄 ID 지정 — 기존 스케줄을 참조**

요청 body — `schedule` 에 객체 대신 등록된 스케줄 ID 를 보냅니다:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": {
    "id": 13
  },
  "mode": "full",
  "schedule": 42
}
```

신규 스케줄을 만들지 않고 ID `42` 의 스케줄을 작업에 연결합니다.

---

**3. 거부 — Smart 스케줄 (type 7 ~ 11)**

복구는 `advanced` 동봉 여부와 무관하게 type 7~11 을 모두 거부합니다.

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": {
    "id": 13
  },
  "mode": "full",
  "schedule": {
    "type": 7,
    "basic": {
      "day": "mon",
      "time": "10:00"
    }
  }
}
```

응답 (400 Bad Request):

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-101",
    "message": "For full/increment job types, schedule must contain only basic."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

---

**4. 거부 — 존재하지 않는 스케줄 ID (`SCHEDULE-ERROR-01` / 404 Not Found)**

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": {
    "id": 13
  },
  "mode": "full",
  "schedule": 99999
}
```

응답 (404 Not Found):

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-01",
    "message": "Schedule ID '99999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

숫자를 `basic` 자리에 넣은 경우(`{ "type": 3, "basic": 999 }`)도 같은 코드이며 메시지 끝에 마침표가 붙습니다(`Schedule ID '999' not found.`).

---

**schedule 동봉 시 주요 에러 코드**

| code | HTTP | 발생 조건 |
|------|------|-----------|
| `DTO-VALIDATION-01` | 422 | `schedule.type` 범위 위반, `schedule.basic` 누락, type별 필수 필드 누락 |
| `JOB-ERROR-101` | 400 | 복구에 Smart 스케줄(type 7 ~ 11) 동봉됨 |
| `JOB-ERROR-108` | 400 | 객체 안 `basic` 자리의 숫자 ID 행 type 이 요청 `type` 과 다름 |
| `SCHEDULE-ERROR-01` | 404 | 전달한 스케줄 ID 가 존재하지 않음 |
| `CENTER-ERROR-01` | 403 | 전달한 스케줄 ID 가 요청 `center` 의 스케줄이 아님 |
| `SCHEDULE-ERROR-16` | 400 | `time` 형식 오류 (`HH:mm` 아님) |
| `SCHEDULE-ERROR-19` | 400 | type 6 의 `day` 가 `1 ~ 31` 범위 밖 |
| `SCHEDULE-ERROR-22` | 422 | type 4/5 의 `day` 값이 `mon ~ sun` 외 |
| `ZDM-ERROR-01` | 404 | `center` 미존재 |

요청 형식 오류와 스케줄 값 오류의 요청·응답 예시는 [스케줄 개요]({{ base_path }}/docs/schedule/overview#검증-실패-응답-예시)를 참조하세요.

</details>

---
