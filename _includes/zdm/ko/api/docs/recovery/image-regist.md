source 서버 없이 backup image 파일만으로 복구 작업을 등록합니다.

---

## `POST /recoveries/image` {#post-recoveries-image}

> * 일반 복구 등록(`POST /api/recoveries`)은 source 서버를 지정해야 하지만, 이 엔드포인트는 **backup image 파일만으로** 등록합니다.
> * source 서버가 ZDM 에서 이미 삭제된 경우에도 이미지가 저장소에 남아 있으면 복구할 수 있습니다.
> * 각 이미지의 소속 파티션·작업 이름은 저장소의 이미지 정보에서 역으로 읽습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /recoveries/image</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>일반 복구 등록과의 차이</strong></summary>

| 항목 | `POST /recoveries` | `POST /recoveries/image` |
|------|--------------------|--------------------------|
| `source` | Required — source 서버 식별자 | **사용하지 않음** |
| 최상위 `backupFile` | 없음 | **Required** — 사용할 이미지 목록 (`source` 자리를 대신함) |
| `jobList[].sourcePartition` | Required | **사용하지 않음** — 이미지에서 읽습니다 |
| `jobList[].backupJob` | Optional | **사용하지 않음** — 이미지에서 읽습니다 |
| 그 외 필드 | — | 일반 복구 등록과 동일 |

</details>

<details markdown="1" open>
<summary><strong>요청 필드</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string \| number | Required | 작업을 등록할 center 식별자 (ID 또는 이름) |
| `backupFile` | string | Required | 사용할 backup image 파일명 목록. 구분자는 `,` 또는 `\|` |
| `target` | string \| number | Required | 복구 대상 서버 식별자 |
| `platform` | string | Required | 대상 서버 플랫폼 |
| `repository` | object | Required | 이미지가 저장된 레포지토리 |
| `repository.id` | number | Required | 레포지토리 ID |
| `repository.type` | string | Optional | `nfs`, `smb`, `zdm(nfs)`, `zdm(smb)` |
| `repository.path` | string | Optional | 레포지토리 경로. 타입별 형식 검증을 통과해야 합니다 |
| `mode` | string | Required | `full`, `increment` |
| `jobName` | string | Optional | 작업 이름. 미지정 시 자동 생성되며, 같은 이름이 있으면 `-1`, `-2` 로 번호가 붙습니다 |
| `listOnly` | boolean | Optional | `true` 면 `jobList` 에 지정한 항목만 등록합니다 |
| `jobList` | array | Optional | 파티션별 상세 지정. 미지정 이미지는 자동 매핑됩니다 |
| `jobList[].targetPartition` | string | Required | 복구할 대상 파티션 |
| `jobList[].backupFile` | string \| string[] | Required | 이 항목에 사용할 이미지. **최상위 `backupFile` 안에 있어야 합니다** |
| `jobList[].mode` | string | Optional | 항목별 복구 모드. 미지정 시 공통 `mode` |
| `jobList[].overwrite` | string | Optional | `allow`, `not allow` |
| `jobList[].repository` | object | Optional | 항목별 레포지토리. 미지정 시 공통 `repository` |
| `overwrite` | string | Optional | 공통 덮어쓰기 허용 여부 |
| `excludePartition` | string | Optional | 작업에서 제외할 파티션 |
| `afterReboot` | string | Optional | `reboot`(기본), `shutdown`, `maintain` |
| `autoStart` | string | Optional | `use`, `not use`(기본) |
| `networkLimit` | number | Optional | 네트워크 제한 속도. `0` 은 무제한 |
| `schedule` | object \| number | Optional | 스케줄 객체 또는 기존 스케줄 ID |
| `cloudAuth` | string \| number | Optional | 대상 플랫폼 인증정보 |
| `scriptPath` / `scriptRun` | string | Optional | 작업 전후 실행할 스크립트 |
| `mailEvent` | string | Optional | 작업 로그 수신 이메일 |

</details>

<details markdown="1" open>
<summary><strong>파티션 매핑 규칙</strong></summary>

**하나의 target 파티션은 같은 source 파티션의 이미지를 최대 1장만 받습니다.**

같은 파티션을 서로 다른 시점에 백업한 이미지 두 장을 한 파티션에 함께 복구하면, 나중에 복구된 이미지가 앞선 것을 덮어써 결과가 결정되지 않습니다. 등록 단계에서 `JOB-ERROR-55` 로 거부됩니다.

| 배치 | 허용 |
|------|------|
| target `/` ← 이미지 A, B (둘 다 source `/` 의 이미지) | ✗ |
| target `/` ← A, target `/data` ← B (둘 다 source `/` 의 이미지) | ✓ |
| target `/` ← A(source `/`), C(source `/data`) | ✓ |

출신 파티션이 다르면 서로 다른 데이터이므로 한 target 에 함께 복구할 수 있습니다.

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

**최소 요청 — 자동 매핑**

이미지 목록만 주면 각 이미지의 파티션을 읽어 같은 이름의 target 파티션에 자동 매핑합니다.

```bash
curl -X POST "https://api.example.com/api/recoveries/image" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "center-01",
    "backupFile": "server01_ROOT_0262.ZIA,server01_boot_0262.ZIA",
    "target": "target-server",
    "platform": "oci",
    "mode": "full",
    "repository": { "id": 9 }
  }'
```

**파티션별 지정 — `listOnly`**

```bash
curl -X POST "https://api.example.com/api/recoveries/image" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "center-01",
    "backupFile": "server01_ROOT_0262.ZIA,server01_boot_0262.ZIA",
    "target": "target-server",
    "platform": "oci",
    "mode": "full",
    "repository": { "id": 9, "type": "nfs", "path": "192.168.0.10:/repo" },
    "jobName": "image-recovery",
    "listOnly": true,
    "jobList": [
      { "targetPartition": "/",     "backupFile": ["server01_ROOT_0262.ZIA"] },
      { "targetPartition": "/boot", "backupFile": ["server01_boot_0262.ZIA"] }
    ]
  }'
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "traceId": "968d34f6065fd12a9e5637eeac160f8e",
  "message": "Recovery job registration completed",
  "success": true,
  "data": {
    "common": {
      "state": "success",
      "jobName": "api-image-cli",
      "platform": "oci",
      "bootMode": "Reboot"
    },
    "partitions": [
      {
        "sourcePartition": "/",
        "targetPartition": "/",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "xfs",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_ROOT_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_ROOT_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      },
      {
        "sourcePartition": "/boot",
        "targetPartition": "/boot",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "xfs",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_boot_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_boot_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      },
      {
        "sourcePartition": "/boot/efi",
        "targetPartition": "/boot/efi",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "vfat",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_boot_efi_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_boot_efi_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      }
    ],
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    }
  },
  "timestamp": "2026-08-28T15:22:27.075+09:00"
}
```

> `summary.total` 은 **등록된 작업 수**이며 파티션 수가 아닙니다. 위 예시는 파티션 3개를 한 작업으로 등록한 결과입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `common.state` | string | 등록 결과 |
| `common.jobName` | string | 최종 확정된 작업 이름 |
| `common.platform` | string | 대상 플랫폼 |
| `common.bootMode` | string | 작업 후 부팅 방식 |
| `partitions[].sourcePartition` | string | 이미지에서 읽은 원본 파티션 |
| `partitions[].targetPartition` | string | 복구 대상 파티션 |
| `partitions[].jobMode` | string | 복구 모드 |
| `partitions[].backup.backupFile` | string | 사용된 이미지 파일명 |
| `partitions[].backup.backupJob` | string | 이미지가 소속된 backup 작업 이름 |
| `partitions[].repository` | object | 사용된 레포지토리 |
| `summary` | object | 등록 성공·실패 집계 |
| `notices` | string[] | 자동 skip 된 파티션 안내 (해당 시에만 포함) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**이미지 미존재 (404 Not Found)**

지정한 이미지가 저장소에 없는 경우 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-01",
    "message": "백업 이미지가 존재하지 않음 (Center: center-01, Repository ID: 9)"
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

**한 파티션에 같은 출신 이미지 중복 배정 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-55",
    "message": "target partition '/' was given 2 images of source partition '/' (server01_ROOT_0261.ZIA, server01_ROOT_0262.ZIA). These are snapshots of the same partition taken at different points in time, so they cannot both be restored to one partition — the one restored later would overwrite the earlier. Keep one image, or assign each image to a different target partition."
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

**레포지토리 미존재 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "Repository with ID '99' does not exist in this center. Available repository IDs: 9, 10."
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

**유효성 검사 실패 (422 Unprocessable Entity)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "backupFile": ["backupFile is required"]
    }
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

</details>

---
