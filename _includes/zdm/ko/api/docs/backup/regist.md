{% include zdm/base-path.html %}

새로운 백업 작업을 등록합니다.

---

## `POST /backups` {#post-backups}

> * 새로운 백업 작업을 시스템에 등록합니다.
> * 여러 파티션에 대해 개별 설정으로 등록할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/backups</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 백업 작업 등록
curl -X POST "https://api.example.com/api/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "server": "server-01",
    "type": "full",
    "partition": ["/", "/home"],
    "repository": {
      "type": "nfs",
      "path": "/backup/server-01"
    },
    "jobName": "daily-backup",
    "rotation": 7
  }'

# 스케줄 포함 백업 작업 등록
curl -X POST "https://api.example.com/api/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "server": "server-01",
    "type": "smart",
    "partition": ["/"],
    "repository": {
      "type": "smb",
      "path": "//192.168.1.100/backup"
    },
    "schedule": {
      "type": 3,
      "basic": {
        "time": "02:00"
      }
    },
    "compression": "use",
    "encryption": "use"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string \| number | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `server` | string \| number | Required | 서버 ID (숫자) 또는 서버 이름 | - |
| `type` | string | Required | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `partition` | array | Required | 작업 대상 파티션 배열 (전체 작업시 빈 배열 `[]`) | - |
| `repository` | object | Required | 레포지토리 정보 | - |
| `repository.id` | number | Required | 레포지토리 ID | - |
| `repository.type` | string | Optional | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `repository.path` | string | Optional | 레포지토리 경로 | - |
| `jobName` | string | Optional | 작업 이름 | - |
| `user` | string \| number | Optional | 사용자 ID (숫자) 또는 이메일 | - |
| `schedule` | object \| number | Optional | 스케줄 객체 또는 스케줄 ID. `smart` 모드는 필수입니다. [스케줄 개요]({{ base_path }}/docs/schedule/overview) 참조 | - |
| `rotation` | number | Optional | 작업 반복 횟수 (1~30, 기본값 `1`) | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string | Optional | 작업에서 제외힐 디렉토리 목록 | - |
| `excludePartition` | string | Optional | 작업에서 제외할 파티션 목록 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한, 그외: 해당 속도로 제한) | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `individual` | array | Optional | 개별 작업 설정 배열 | - |

</details>

<details markdown="1">
<summary><strong>individual 객체 구조</strong></summary>

> 파티션별로 개별 설정을 적용할 수 있습니다. 지정하지 않은 필드는 상위 요청의 기본값을 사용합니다.

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `partition` | string | Required | 작업 대상 파티션 | - |
| `center` | string \| number | Optional | 센터 ID 또는 이름 (미입력시 기본 center 사용) | - |
| `server` | string \| number | Optional | 서버 ID 또는 이름 (미입력시 기본 server 사용) | - |
| `type` | string | Optional | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `repository` | object | Optional | 레포지토리 정보 | - |
| `jobName` | string | Optional | 작업 이름. 명시적으로 지정 시 파티션 suffix 없이 그대로 사용. 미지정 시 자동 생성 | - |
| `schedule` | object \| number | Optional | 스케줄 객체 또는 스케줄 ID. `smart` 모드는 필수입니다. [스케줄 개요]({{ base_path }}/docs/schedule/overview) 참조 | - |
| `rotation` | number | Optional | 작업 반복 횟수 (1~30) | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string/array | Optional | 제외 디렉토리 | - |
| `excludePartition` | string/array | Optional | 제외 파티션 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |

**사용 예시:**

```json
{
  "center": "1",
  "server": "main-server",
  "type": "full",
  "partition": ["/", "/data", "/var"],
  "repository": { "type": "nfs", "path": "/backup" },
  "individual": [
    {
      "partition": "/data",
      "center": "2",
      "server": "backup-server",
      "rotation": 14
    },
    {
      "partition": "/var",
      "compression": "use",
      "encryption": "use"
    }
  ]
}
```

위 예시에서:
- `/` 파티션: 기본 설정 사용 (center=1, server=main-server)
- `/data` 파티션: center=2, server=backup-server, rotation=14 적용
- `/var` 파티션: 압축/암호화만 개별 적용, 나머지는 기본값 사용

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

{% include zdm/schedule-object.md %}

- Smart 모드(`type: "smart"`)는 `schedule` 이 필수이고 `schedule.type` 은 `7`~`11` 이어야 합니다.
- 숫자 ID 를 넣으면 그 스케줄을 **복사**해 새 스케줄로 연결합니다. 최상위 숫자 하나는 Full·Increment 작업(basic)용이며, Smart 스케줄은 `{ "type": 7, "basic": <ID>, "advanced": <ID> }` 형식으로 지정합니다. 도메인별 처리는 [숫자 ID 로 지정할 때 도메인별 처리]({{ base_path }}/docs/schedule/overview#숫자-id-로-지정할-때-도메인별-처리)를 참조하세요.
- `schedule` 을 생략하면 응답에 `schedule` 필드가 포함되지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

> **v2.0.2 변경 사항**: `schedule.basic` / `schedule.advanced` 객체에 `id` 필드가 신규 추가되었습니다. (그 외 type/description 형식은 기존 그대로)

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "backupTest_ROOT",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "id": 7,
            "type": "Monthly on Specific Date",
            "description": "[Basic] Start working at 12:00 25, 28 every month."
          }
        }
      },
      {
        "state": "success",
        "jobName": "backupTest_boot_efi",
        "partition": "/boot/efi",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "id": 8,
            "type": "Monthly on Specific Date",
            "description": "[Basic] Start working at 12:00 25, 28 every month."
          }
        }
      }
    ]
  },
  "timestamp": "2026-01-17T21:03:52.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `summary.total` | number | 총 작업 수 |
| `summary.successful` | number | 성공한 작업 수 |
| `summary.failed` | number | 실패한 작업 수 |
| `results[].state` | string | 등록 결과 (`success` / `fail`) |
| `results[].jobName` | string | 작업 이름 |
| `results[].partition` | string | 대상 파티션 |
| `results[].jobMode` | string | 작업 모드 (`Full Backup`, `Incremental Backup`, `Smart Backup`) |
| `results[].autoStart` | string | 자동 시작 여부 (`use` / `not use`) |
| `results[].schedule` | object | 스케줄 정보 (설정시에만 포함) |
| `results[].schedule.basic` | object | 기본 스케줄 정보 |
| `results[].schedule.basic.id` | number | 기본 스케줄 ID (**v2.0.2 신규**) |
| `results[].schedule.basic.type` | string | 스케줄 타입 이름 (예: `Daily`, `Monthly on Specific Date`) |
| `results[].schedule.basic.description` | string | 스케줄 설명 (예: `[Basic] Start working at 12:00 25, 28 every month.`) |
| `results[].schedule.advanced` | object | 고급 스케줄 정보 (Smart 스케줄 type 7~11 설정시에만 포함) |
| `results[].schedule.advanced.id` | number | 고급 스케줄 ID (**v2.0.2 신규**) |
| `results[].schedule.advanced.type` | string | 고급 스케줄 타입 이름 |
| `results[].schedule.advanced.description` | string | 고급 스케줄 설명 |
| `results[].scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `results[].scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `results[].errorMessage` | string | 실패 시 오류 메시지 |

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
      "type": ["type must be one of: full, increment, smart"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**라이선스가 할당되지 않은 서버 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "LICENSE-ERROR-13",
    "message": "No license is assigned to the server: web-01"
  },
  "timestamp": "2026-10-12T10:30:00.000+09:00"
}
```

> `server` 와 `individual[].server` 로 지정한 서버를 모두 검사하며, 라이선스가 없는 서버 이름을 메시지에 나열합니다. 라이선스를 먼저 할당(`PUT /licenses/assign`)한 뒤 등록하세요.

**작업 이름 중복 (409 Conflict)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-07",
    "message": "Job name 'daily-backup' already exists."
  },
  "timestamp": "2026-02-05T10:30:00.000+09:00"
}
```

> `individual.jobName`을 명시적으로 지정했으나 동일한 이름의 작업이 이미 존재하는 경우 발생합니다.
>
> **검사는 등록 직전에 한 번 더 수행됩니다.** 요청 검증 시점과 실제 INSERT 사이에 같은 이름이
> 들어올 수 있어, 이름 확정과 INSERT 를 하나의 임계 구역에서 처리합니다.
> 같은 이름을 **동시에** 등록하려는 요청이 겹치면 뒤의 요청이 이 오류를 받습니다 — 재시도하면 됩니다.

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-03",
    "message": "Center '999' not found."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary><strong>schedule 동봉 등록 예시</strong></summary>

> 성공 응답은 HTTP **200 OK** 입니다. 모든 예시는 `partition: ["/"]` 단일 파티션이며, 전체 응답 구조는 위의 응답 예시를 참조하세요. 타입별 `basic`/`advanced` 구성은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참조하세요.

#### 1. basic — Daily (`type: 3`)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 3,
    "basic": { "time": "02:00" }
  }
}
```

응답 `schedule` 부분:

```json
"schedule": {
  "basic": {
    "id": 10,
    "type": "Daily",
    "description": "[Basic] Start working at 02:00 every day."
  }
}
```

#### 2. Smart Weekly (`type: 7`) — `smart` 모드 + basic/advanced

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 7,
    "basic": {
      "day": "mon",
      "time": "10:00"
    },
    "advanced": {
      "day": "tue,wed,thu,fri",
      "time": "12:00"
    }
  }
}
```

`basic.day` 는 단일 요일만 허용하고 `advanced.day` 는 복수 요일을 허용합니다.

응답 `schedule` 부분:

```json
"schedule": {
  "basic": {
    "id": 13,
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Basic] Start working every Monday at 10:00"
  },
  "advanced": {
    "id": 14,
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
  }
}
```

#### 3. 스케줄 ID 지정 (number)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": 42
}
```

ID `42` 의 스케줄을 복사해 새 스케줄로 저장하므로 응답의 ID 는 입력한 ID 와 다릅니다. `advanced` 는 채워지지 않습니다.

```json
"schedule": {
  "basic": {
    "id": 17,
    "type": "Daily",
    "description": "[Basic] Start working at 02:00 every day."
  }
}
```

#### 4. Smart 스케줄을 ID 로 지정 (`type: 7`, `basic` 과 `advanced` 모두 ID)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 7,
    "basic": 15,
    "advanced": 16
  }
}
```

ID `15` 는 단일 선택 스케줄(basic 용), ID `16` 은 복수 선택 스케줄(advanced 용)이어야 합니다. `basic` 과 `advanced` 중 한쪽만 ID 로 지정하고 다른 쪽은 객체로 보내는 조합도 가능합니다.

```json
"schedule": {
  "basic": {
    "id": 19,
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Basic] Start working every Monday at 10:00"
  },
  "advanced": {
    "id": 20,
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>schedule 동봉 검증 실패 예시</strong></summary>

> 요청 형식 오류(`DTO-VALIDATION-01`)와 스케줄 값 오류(`SCHEDULE-ERROR-*`)는 [스케줄 개요]({{ base_path }}/docs/schedule/overview#검증-실패-응답-예시)를 참조하세요. 아래는 백업 등록에서만 발생하는 오류입니다. HTTP 상태는 5번만 404 이고 나머지는 400 입니다. `error.message` 는 영문입니다.

#### 1. smart 모드인데 `schedule` 누락 (`JOB-ERROR-107`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 }
}
```

응답:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-107",
    "message": "Schedule is required for Smart Backup."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

#### 2. smart 모드에 일반 스케줄(type 0~6) 동봉 (`JOB-ERROR-102`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 3,
    "basic": { "time": "02:00" }
  }
}
```

응답:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-102",
    "message": "For smart job type, schedule must contain both basic and advanced."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

`advanced` 가 없는 Smart 스케줄(type 7~11)도 같은 코드 `JOB-ERROR-102` 로 거부됩니다. 이 경우 메시지는 `Smart job mode requires both a basic and an advanced schedule.` 입니다.

#### 3. full/increment 모드에 Smart 스케줄(type 7~11) 동봉 (`JOB-ERROR-101`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 7,
    "basic": { "day": "mon", "time": "10:00" }
  }
}
```

응답:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-101",
    "message": "For full/increment job types, schedule must contain only basic."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

#### 4. Smart 스케줄 ID 를 맞지 않는 자리에 지정 (`JOB-ERROR-108`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 7,
    "basic": 16,
    "advanced": 16
  }
}
```

응답:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-108",
    "message": "Schedule ID '16' cannot be used as basic schedule. This schedule is for advanced use."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

복수 선택 스케줄(ID `16`)은 `advanced` 자리에만 쓸 수 있고, 단일 선택 스케줄은 `basic` 자리에만 쓸 수 있습니다.

#### 5. 존재하지 않는 스케줄 ID (404, `SCHEDULE-ERROR-01`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": 999
}
```

응답:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-01",
    "message": "Schedule ID '999' not found."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

`schedule` 자리의 숫자와 `basic`/`advanced` 자리의 숫자 모두 같은 코드로 응답합니다.

</details>

<details markdown="1">
<summary><strong>schedule 동작 안내</strong></summary>

#### 1. smart 모드의 schedule 필수 정책

- `type: "smart"` 등록 요청은 `schedule` 이 항상 필수입니다. 누락 시 400 (`JOB-ERROR-107`).
- `schedule.type` 은 `7`~`11`, `basic` 과 `advanced` 모두 필요합니다.
- Smart 스케줄을 ID 로 지정하려면 객체 형식 `{ "type": 7, "basic": <ID>, "advanced": <ID> }` 을 사용합니다.

#### 2. 작업 모드와 스케줄 type 의 정합

등록 요청에서는 작업 모드와 스케줄 type 이 맞지 않으면 400 으로 거부합니다. 모드에 맞춰 자동으로 바꾸는 동작은 [수정 API]({{ base_path }}/docs/backup/update)에만 있습니다.

| 요청 모드 | 허용 schedule type | 위반 시 |
|----------|------------------|---------|
| `full` / `increment` | 0 ~ 6 | `JOB-ERROR-101` (400) |
| `smart` | 7 ~ 11 | `JOB-ERROR-102` (400) |
| `smart` (basic 또는 advanced 누락) | - | `JOB-ERROR-102` (400, 종전 500) |
| `smart` + 최상위 숫자 ID | - | `JOB-ERROR-102` (400) |
| `smart` (schedule 자체 누락) | - | `JOB-ERROR-107` (400) |

#### 3. 스케줄 객체와 스케줄 ID

- `schedule` 에는 객체 또는 숫자 중 하나를 보냅니다.
- 숫자 ID 는 그 스케줄의 내용을 **복사해 새 스케줄로 저장**합니다. 응답의 스케줄 ID 는 입력한 ID 와 다르며 `advanced` 는 비어 있습니다. 기존 스케줄을 그대로 재사용하지 않습니다.
- 객체 안의 `basic`·`advanced` 자리에 숫자를 넣어도 같은 방식으로 복사합니다. 한쪽만 ID 로, 다른 쪽은 객체로 보내는 조합도 가능합니다.
- Smart 스케줄을 부분 ID 로 지정할 때는 참조하는 스케줄의 저장 패턴이 자리와 맞아야 합니다. 단일 선택 스케줄은 `basic` 에만, 복수 선택 스케줄은 `advanced` 에만 쓸 수 있고 어긋나면 400 (`JOB-ERROR-108`)입니다.
- 존재하지 않는 ID 는 404 (`SCHEDULE-ERROR-01`)입니다.
- 최상위 숫자 ID 는 **full/increment 전용**입니다. `mode` 가 `smart` 인데 숫자 ID 를 보내면 400 (`JOB-ERROR-102`, `Smart job mode cannot use a single schedule ID. Use the object form { type, basic: <id>, advanced: <id> }.`)입니다. Smart 는 객체 형식 `{ "type": 7, "basic": <ID>, "advanced": <ID> }` 으로 지정하세요.
- full/increment 에 Smart 스케줄 행(타입 7~11)의 ID 를 보내면 400 (`JOB-ERROR-101`, `Schedule ID '<id>' is a smart schedule (type N). Full/increment job modes accept schedule type 0-6 only.`)입니다.
- 지정한 스케줄이 요청 `center` 의 것이 아니면 403 (`CENTER-ERROR-01`, `Schedule ID '<id>' does not belong to center <center>`)입니다. `nCenterID = 0` 도 하나의 center 로 비교합니다.
- 객체 안 `basic`·`advanced` 자리의 숫자 ID 는 행의 type 이 요청 `type` 과 같아야 하며 어긋나면 400 (`JOB-ERROR-108`, `Schedule ID '<id>' is type <n>, but the request type is <m>.`), 다른 center 의 행이면 403 (`CENTER-ERROR-01`)입니다.
- 검사 순서는 존재(404) → center(403) → mode·type(400)입니다.

#### 4. 입력 규칙

요일·날짜 표기와 Smart `basic` 의 단일값 제한은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참조하세요.

</details>

---
