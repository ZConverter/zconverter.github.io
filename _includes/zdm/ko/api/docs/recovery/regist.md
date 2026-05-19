
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
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `afterReboot` | string | Optional | 작업 후 부팅 방식 | {% include zdm/after-reboot.md %} |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한) | - |
| `excludePartition` | string | Optional | 제외할 파티션 목록 (콤마 구분, 예: `"h,d"` 또는 `"/boot,/home"`) | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
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
| `backupJob` | string | Optional | 사용할 백업 작업 이름 (미지정 시 최신 성공 작업 자동 선택) |
| `backupFile` | string | Optional | 사용할 백업 이미지 파일명 (미지정 시 최신 이미지 자동 선택) |
| `mode` | string | Optional | 작업 모드 (`full`, `increment`) |
| `repository` | object | Optional | 레포지토리 정보 (미지정 시 공통 repository 사용) |
| `repository.id` | number | Required | 레포지토리 ID |
| `repository.type` | string | Optional | 레포지토리 타입 |
| `repository.path` | string | Optional | 레포지토리 경로 |

> **Windows 파티션 정규화 (since 2026-05-15)**
>
> Windows 서버 대상으로 등록 시 `sourcePartition` / `targetPartition` 입력값은 비교 단계에서 자동으로 대문자 변환 및 `:` 보정이 적용됩니다. 입력 `c`, `C`, `c:`, `C:` 모두 동일하게 `C:`로 취급되어 서버 파티션 정보와 매칭됩니다. (Linux는 정규화 없음 — 원본 그대로 비교)

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "common": {
      "state": "success",
      "jobName": "daily-recovery",
      "autoStart": "not use",
      "platform": "vmware",
      "bootMode": "reboot",
      "schedule": {
        "basic": {
          "type": "daily",
          "description": "Every day at 10:00"
        }
      },
      "scriptPath": "/opt/scripts/post-recovery.sh",
      "scriptRunTiming": "after job"
    },
    "partitions": [
      {
        "sourcePartition": "/",
        "targetPartition": "/dev/sda1",
        "jobMode": "full",
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
        "jobMode": "increment",
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
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `common.state` | string | 등록 결과 (`success` / `fail`) |
| `common.jobName` | string | 등록된 작업 이름 |
| `common.autoStart` | string | 자동 시작 여부 |
| `common.platform` | string | 타겟 플랫폼 |
| `common.bootMode` | string | 작업 후 부팅 모드 (`reboot` / `shutdown` / `maintain`) |
| `common.schedule.basic` | object/string | 기본 스케줄 정보 (설정시에만 포함) |
| `common.scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `common.scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `common.errorMessage` | string | 실패 시 오류 메시지 |
| `partitions[].sourcePartition` | string | 소스 파티션/드라이브 명 |
| `partitions[].targetPartition` | string | 타겟 파티션/드라이브 명 |
| `partitions[].jobMode` | string | 파티션별 작업 모드 |
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

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "platform은 oci, ncp, gcp, aws, azure, vmware, scp, openstack, cloudstack, kt, nhn, nutanix, proxmox, kvm, hyperv, xenserver중 하나여야 합니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>schedule 동봉 예시 — 정상 등록</strong></summary>

> **Recovery 스케줄 정책**
>
> * Recovery 작업은 **`basic` 스케줄만** 지원합니다. (`mode`는 `full` / `increment`만 허용 — `smart` 모드 없음)
> * 스케줄 `type`은 **0 ~ 6** 만 허용됩니다. (Smart 타입 7~11 불가 — 아래 거부 케이스 참조)
> * `schedule` 필드를 생략하면 별도 예약 없이 등록되며, `autoStart=use` 와 함께 사용하면 즉시 1회 실행됩니다.
> * 응답의 `common.schedule` 은 `schedule` 이 동봉되었을 때만 포함되며, `{ basic: { type, description } }` 형태로 직렬화됩니다. (`type` 은 문자열 표기, `description` 은 `[Basic]` prefix 포함)
> * `schedule` 동봉 여부와 `autoStart` 는 **독립적**입니다. `autoStart=use` 는 등록 직후 1회 즉시 실행을, `schedule` 은 이후 반복/예약 실행을 각각 제어합니다.

---

**1. schedule 미동봉 (즉시 1회 실행 또는 수동 시작)**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "jobName": "daily-recovery",
  "autoStart": "use"
}
```

성공 응답 (200 OK) — `common.schedule` 필드 자체가 응답에 포함되지 않음:

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "common": {
      "state": "success",
      "jobName": "daily-recovery",
      "autoStart": "use",
      "platform": "vmware",
      "bootMode": "reboot"
    },
    "partitions": [ /* ... */ ],
    "summary": { "total": 1, "successful": 1, "failed": 0 }
  },
  "message": "Recovery job registration completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**2. schedule type 0 (Once) — 일회성 예약 복구**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "jobName": "once-recovery",
  "schedule": {
    "type": 0,
    "basic": {
      "year": "2026",
      "month": "06",
      "day": "01",
      "time": "10:00"
    }
  }
}
```

성공 응답 (200 OK) — `common.schedule.basic`:

```json
{
  "common": {
    "state": "success",
    "jobName": "once-recovery",
    "autoStart": "not use",
    "platform": "vmware",
    "bootMode": "reboot",
    "schedule": {
      "basic": {
        "type": "Once",
        "description": "[Basic] Start working on 01/06/2026 10:00."
      }
    }
  }
}
```

---

**3. schedule type 1 (Every Minute)**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "increment",
  "schedule": {
    "type": 1,
    "basic": {
      "time": "10:00",
      "interval": { "minute": "5" }
    }
  }
}
```

성공 응답 — `common.schedule.basic`:

```json
{
  "basic": {
    "type": "Every Minute",
    "description": "[Basic] Start working at 10:00 every 5 Minute."
  }
}
```

---

**4. schedule type 2 (Hourly)**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "increment",
  "schedule": {
    "type": 2,
    "basic": {
      "time": "10:00",
      "interval": { "hour": "2" }
    }
  }
}
```

성공 응답 — `common.schedule.basic`:

```json
{
  "basic": {
    "type": "Hourly",
    "description": "[Basic] Start working at 10:00 every 2 Hour."
  }
}
```

---

**5. schedule type 3 (Daily) — 매일 동일 시간**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "jobName": "daily-recovery",
  "schedule": {
    "type": 3,
    "basic": { "time": "10:00" }
  }
}
```

성공 응답 — `common.schedule.basic`:

```json
{
  "basic": {
    "type": "Daily",
    "description": "[Basic] Start working at 10:00 every day."
  }
}
```

---

**6. schedule type 4 (Weekly) — 특정 요일**

요청 body — 요일은 `mon, tue, wed, thu, fri, sat, sun` 문자열의 콤마 구분 (basic 다중 선택 가능):

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 4,
    "basic": {
      "day": "mon,wed,fri",
      "time": "10:00"
    }
  }
}
```

성공 응답 — `common.schedule.basic` (요일은 응답에서 풀네임으로 표기):

```json
{
  "basic": {
    "type": "Weekly",
    "description": "[Basic] Start working at 10:00 Monday, Wednesday, Friday every week."
  }
}
```

---

**7. schedule type 5 (Monthly — 특정 주차 + 요일)**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 5,
    "basic": {
      "week": "1,3",
      "day": "mon",
      "time": "10:00"
    }
  }
}
```

---

**8. schedule type 6 (Monthly — 특정 날짜)**

요청 body — `day` 는 `1 ~ 31` 숫자(콤마 구분으로 다중 허용):

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 6,
    "basic": {
      "day": "1,15",
      "time": "10:00"
    }
  }
}
```

---

**9. schedule ID 참조 — 이미 등록된 스케줄 사용**

요청 body — `schedule` 자리에 객체 대신 등록된 스케줄 ID(숫자)를 그대로 전달:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": 42
}
```

> ID 참조 경로는 신규 스케줄을 생성하지 않고 해당 스케줄을 그대로 작업에 연결합니다. ID 가 존재하지 않으면 아래 거부 케이스 “4” 가 반환됩니다.

---

**10. 부분 ID 참조 — `schedule.basic` 만 ID (`type` 필수 동봉)**

요청 body — `schedule.basic` 자리에 객체 대신 등록된 스케줄 ID(숫자)를 전달. `type` 은 그대로 함께 보냅니다(여기서는 Daily = `3` 예시. type 1 Every Minute 등 type 0~6 어디서나 동일하게 적용):

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 3,
    "basic": 15
  }
}
```

성공 응답 (200 OK) — 참조된 스케줄 ID(`15`)의 데이터를 그대로 읽어 **신규 schedule 레코드로 INSERT** 합니다. 응답 본문의 `common.schedule.basic` 형식은 일반 객체 입력 결과와 동일:

```json
{
  "common": {
    "state": "success",
    "jobName": "daily-recovery",
    "autoStart": "not use",
    "platform": "vmware",
    "bootMode": "reboot",
    "schedule": {
      "basic": {
        "type": "Daily",
        "description": "[Basic] Start working at 10:00 every day."
      }
    }
  }
}
```

> **동작 안내 (부분 ID vs 전체 ID)**
> - 부분 ID 동작도 전체 ID 와 동일하게 — 참조한 schedule 레코드의 데이터를 읽어 **새 schedule 레코드로 INSERT** 합니다. 즉, 작업에 연결되는 schedule ID 는 입력한 ID(`15`)와 다른 새 ID 입니다(전체 ID 경로 #9 만이 입력 ID 를 그대로 작업에 연결).
> - `schedule.advanced` 는 사용하지 않음 — Recovery 는 smart 스케줄을 지원하지 않으므로 `advanced` 필드는 동봉하더라도 무시되며, type 7~11 동봉은 본 페이지 거부 케이스 “1” (`JOB-ERROR-101`) 로 차단됩니다.

</details>

<details markdown="1">
<summary><strong>schedule 동봉 예시 — 거부 / 검증 실패</strong></summary>

> 아래 케이스는 `schedule` 필드가 동봉되었을 때만 발생합니다. Recovery 도메인의 추가 검증 로직과 zod 본문 검증을 함께 다룹니다.

---

**1. Smart schedule 거부 (type 7 ~ 11) — `JOB-ERROR-101` / 400 Bad Request**

Recovery 는 `mode` 가 `full` / `increment` 만 허용되며, 어떤 경우에도 Smart 스케줄(type 7 ~ 11)을 받아들이지 않습니다. type 7, 8, 9, 10, 11 모두 동일하게 거부됩니다.

요청 body 예시 (type 7):

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 7,
    "basic": { "day": "mon", "time": "10:00" }
  }
}
```

거부 응답 (400 Bad Request):

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "For full/increment job types, schedule must contain only basic.",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 동일한 응답이 type 8, 9, 10, 11 모든 Smart 타입에 대해 반환됩니다. (Recovery 는 `advanced` 동봉 여부와 무관하게 type ≥ 7 자체를 거부)

---

**2. `basic` 누락 — `DTO-VALIDATION-01` / 422 Unprocessable Entity**

`schedule.basic` 은 모든 type 에서 필수입니다. 누락 시 zod 본문 검증 단계에서 거부됩니다.

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": { "type": 3 }
}
```

거부 응답 (422 Unprocessable Entity):

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed: schedule.basic: basic/advanced must be a schedule object or an existing schedule ID (number)",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**3. type별 basic 필수 필드 누락 — `DTO-VALIDATION-01` / 422 Unprocessable Entity**

예시: type 3 (Daily) 에 `time` 미입력:

```json
{
  "schedule": {
    "type": 3,
    "basic": {}
  }
}
```

거부 응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed: schedule.basic: basic schedule validation failed (type: 3): time: time is required",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 동일 패턴: type 0 → `year/month/day/time`, type 1 → `time, interval.minute`, type 2 → `time, interval.hour`, type 4 → `day, time`, type 5 → `week, day, time`, type 6 → `day, time` 필수.

---

**4. 잘못된 type 범위 — `DTO-VALIDATION-01` / 422 Unprocessable Entity**

`type` 은 정수 0 ~ 11 만 허용. 12 이상이거나 음수인 경우:

요청 body:

```json
{
  "schedule": {
    "type": 12,
    "basic": { "time": "10:00" }
  }
}
```

거부 응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed: schedule.type: invalid schedule type (must be 0 ~ 11)",
  "timestamp": "2025-01-15 10:30:00"
}
```

> Recovery 도메인은 추가로 type ≥ 7 인 경우 `JOB-ERROR-101` (400) 으로 거부합니다 (위 케이스 1). zod 단계에서 12 이상이거나 음수인 경우 먼저 422 로 차단됩니다.

---

**5. 존재하지 않는 schedule ID 참조 — `JOB-ERROR-100` / 404 Not Found**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": 99999
}
```

거부 응답 (404 Not Found):

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Schedule ID '99999' not found",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**6. Center NOT_FOUND — `ZDM-ERROR-01` / 404 Not Found**

요청 body 의 `center` 가 존재하지 않는 ID/Name 인 경우 (스케줄 검증 이전 단계에서 차단):

```json
{
  "center": "999",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": { "type": 3, "basic": { "time": "10:00" } }
}
```

거부 응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Zdm with ID '999' not found",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**7. 부분 ID 미존재 — `schedule.basic` 으로 전달된 ID 가 존재하지 않음 — `SCHEDULE-ERROR-01` / 404 Not Found**

요청 body:

```json
{
  "center": "1",
  "source": "source-server",
  "target": "target-server",
  "platform": "vmware",
  "repository": { "id": 13 },
  "mode": "full",
  "schedule": {
    "type": 3,
    "basic": 999
  }
}
```

거부 응답 (404 Not Found):

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Schedule ID '999' not found.",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 부분 ID 경로(`schedule.basic` = number)와 전체 ID 경로(`schedule` = number)는 코드 상 다른 함수에서 not-found 를 발생시키므로 **에러 코드가 다릅니다**:
> - 전체 ID(케이스 5): `JOB-ERROR-100` / `"Schedule ID '99999' not found"`
> - 부분 ID(본 케이스): `SCHEDULE-ERROR-01` / `"Schedule ID '999' not found."` (문장 끝 마침표는 의도된 차이로 오타가 아닙니다)
>
> 둘 다 HTTP 404 입니다.

---

**참고: schedule 동봉 시 주요 에러 코드**

| code | HTTP | 발생 조건 |
|------|------|-----------|
| `DTO-VALIDATION-01` | 422 | `schedule.type` 범위 위반, `schedule.basic` 누락, type별 필수 필드 누락 |
| `JOB-ERROR-100` | 404 | `schedule` (전체) 자리에 전달한 ID 가 존재하지 않음 |
| `JOB-ERROR-101` | 400 | Recovery 에 Smart 스케줄(type 7 ~ 11) 동봉됨 |
| `SCHEDULE-ERROR-01` | 404 | `schedule.basic` 으로 전달한 ID 가 존재하지 않음 (부분 ID 참조 경로) |
| `SCHEDULE-ERROR-16` | 400 | `time` 형식 오류 (`HH:mm` 아님) |
| `SCHEDULE-ERROR-19` | 400 | type 6 의 `day` 가 `1 ~ 31` 범위 밖 |
| `SCHEDULE-ERROR-22` | 422 | type 4/5 의 `day` 값이 `mon ~ sun` 외 |
| `ZDM-ERROR-01` | 404 | `center` 미존재 |

</details>

---
