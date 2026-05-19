
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
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
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
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
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

> 기존 스케줄 ID(숫자)를 사용하거나, 새 스케줄 객체를 생성할 수 있습니다.
> 스케줄 타입별 상세 구조는 [POST /schedules](../schedule/regist)를 참고하세요.

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `type` | number | Required | 스케줄 타입 (0~11) |
| `basic` | object/number | Required | 기본 스케줄 구조 또는 기존 스케줄 ID |
| `advanced` | object/number | Optional | 고급 스케줄 구조 (Smart 스케줄 type 7~11) |

**스케줄 타입별 basic/advanced 구조:**

| Type | 이름 | 구조 |
|------|------|------|
| 0 | once | `{ year, month, day, time }` |
| 1 | every minute | `{ time, interval: { minute } }` |
| 2 | hourly | `{ time, interval: { hour } }` |
| 3 | daily | `{ time }` |
| 4 | weekly | `{ day, time }` |
| 5 | monthly on specific week | `{ week, day, time }` |
| 6 | monthly on specific day | `{ day, time }` |
| 7~11 | smart schedules | basic + advanced 모두 필요 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "requestID": "46f53c9a-86f7-4c8f-9947-1e3ac642e27f",
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
            "type": "Monthly on Specific Date",
            "description": "[Basic] Start working at 12:00 25, 28 every month."
          }
        }
      }
    ]
  },
  "timestamp": "2026-01-17 21:03:52"
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
| `results[].schedule.basic.type` | string | 스케줄 타입 이름 (예: `Daily`, `Monthly on Specific Date`) |
| `results[].schedule.basic.description` | string | 스케줄 설명 (예: `[Basic] Start working at 12:00 25, 28 every month.`) |
| `results[].schedule.advanced` | object | 고급 스케줄 정보 (Smart 스케줄 type 7~11 설정시에만 포함) |
| `results[].schedule.advanced.type` | string | 고급 스케줄 타입 이름 |
| `results[].schedule.advanced.description` | string | 고급 스케줄 설명 |
| `results[].scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `results[].scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `results[].errorMessage` | string | 실패 시 오류 메시지 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "type은 full, increment, smart중 하나여야 합니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**작업 이름 중복 (409 Conflict)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "JOB_NAME_ALREADY_EXISTS",
  "timestamp": "2026-02-05 10:30:00"
}
```

> `individual.jobName`을 명시적으로 지정했으나 동일한 이름의 작업이 이미 존재하는 경우 발생합니다.

</details>

<details markdown="1">
<summary><strong>schedule 동봉 등록 예시 (Type별 정상 케이스)</strong></summary>

> 본 블록의 응답 예시는 실제 코드 기준입니다. 성공 응답은 HTTP **200 OK**이며, `jobMode` 문자열은 `Full Backup` / `Increment Backup` / `Smart Backup` 중 하나로 직렬화됩니다.
> 본 블록의 모든 예시는 `partition: ["/"]` 단일 파티션 가정 (전체 응답 구조는 위의 응답 예시 블록 참고).

#### 1. schedule 없음 — 즉시 1회 실행 (`autoStart: "use"`)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "autoStart": "use"
}
```

```bash
curl -X POST "https://api.example.com/api/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "server": "server-01",
    "type": "full",
    "partition": ["/"],
    "repository": { "id": 5 },
    "autoStart": "use"
  }'
```

**응답 (200 OK)** — schedule 필드 자체가 응답에서 누락됩니다.

```json
{
  "requestID": "46f53c9a-86f7-4c8f-9947-1e3ac642e27f",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": { "total": 1, "successful": 1, "failed": 0 },
    "results": [
      {
        "state": "success",
        "jobName": "server-01_ROOT_Backup_1",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "use"
      }
    ]
  },
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 2. basic — Daily (`type: 3`)

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

**응답 (200 OK)**

```json
{
  "requestID": "req-001",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": { "total": 1, "successful": 1, "failed": 0 },
    "results": [
      {
        "state": "success",
        "jobName": "server-01_ROOT_Backup_1",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "type": "Daily",
            "description": "[Basic] Start working at 02:00 every day."
          }
        }
      }
    ]
  },
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 3. basic — Weekly (`type: 4`) — `increment` 모드

```json
{
  "center": "1",
  "server": "server-01",
  "type": "increment",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 4,
    "basic": {
      "day": "mon,wed,fri",
      "time": "01:30"
    }
  }
}
```

**응답 (200 OK)**

```json
{
  "requestID": "req-002",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": { "total": 1, "successful": 1, "failed": 0 },
    "results": [
      {
        "state": "success",
        "jobName": "server-01_ROOT_Backup_1",
        "partition": "/",
        "jobMode": "Increment Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "type": "Weekly",
            "description": "[Basic] Start working at 01:30 Monday, Wednesday, Friday every week."
          }
        }
      }
    ]
  },
  "timestamp": "2026-05-19 10:30:00"
}
```

> 요청은 짧은 요일 표기(`mon,wed,fri`)를 사용하지만 응답 description은 풀네임(`Monday, Wednesday, Friday`)으로 변환됩니다.

#### 4. basic — Monthly on Specific Date (`type: 6`)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 6,
    "basic": {
      "day": "1,15",
      "time": "12:00"
    }
  }
}
```

**응답 schedule 부분**

```json
"schedule": {
  "basic": {
    "type": "Monthly on Specific Date",
    "description": "[Basic] Start working at 12:00 1, 15 every month."
  }
}
```

#### 5. Smart Weekly (`type: 7`) — `smart` 모드 + basic/advanced 동봉

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

> Smart 모드는 `schedule` 필드 자체가 필수입니다. `basic.day`는 **단일 요일만 허용**되며 `advanced.day`는 다중 요일 허용.

**응답 schedule 부분**

```json
"schedule": {
  "basic": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Basic] Start working every Monday at 10:00"
  },
  "advanced": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
  }
}
```

#### 6. Smart Custom — Specific Month and Date (`type: 11`)

```json
{
  "center": "1",
  "server": "server-01",
  "type": "smart",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 11,
    "basic": {
      "month": "3",
      "day": "1",
      "time": "03:00"
    },
    "advanced": {
      "month": "6,9,12",
      "day": "15,30",
      "time": "04:00"
    }
  }
}
```

> Smart Custom 11 타입은 가장 복잡한 형태입니다. `basic`은 `month`/`day` 모두 **단일 값**, `advanced`는 다중 값 가능. 월·일 조합(예: 2월 30일 같은 비현실적 일자)에 대한 별도 검증 로직은 없으며 각 값은 1~12 / 1~31 범위면 모두 허용됩니다.

**응답 schedule 부분** — basic은 count==1 분기, advanced는 count>1 분기로 description이 다릅니다.

```json
"schedule": {
  "basic": {
    "type": "Smart Custom (Specific Month and Date)",
    "description": "[Basic] Start working on March 1 at 03:00"
  },
  "advanced": {
    "type": "Smart Custom (Specific Month and Date)",
    "description": "[Advanced] Start working at 04:00 on the 15, 30 of June, September, December"
  }
}
```

#### 7. schedule ID 참조 (number)

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

> ID 참조 경로는 해당 ID의 기존 스케줄 데이터를 **읽어와 새 schedule 레코드로 INSERT**합니다. 즉, 응답에 노출되는 schedule은 입력 ID와 다른 새로운 ID를 가지며, `advanced` 필드는 채워지지 않습니다 (basic만 복사).

**응답 schedule 부분**

```json
"schedule": {
  "basic": {
    "type": "Daily",
    "description": "[Basic] Start working at 02:00 every day."
  }
}
```

#### 8. 부분 ID 참조 — basic만 ID (`type: 1` Once)

inline 객체의 `basic` 또는 `advanced` 자리에 number를 넣으면 해당 ID의 schedule 레코드를 읽어 **새 schedule 레코드로 INSERT**합니다 (전체 ID 참조와 동일한 새 INSERT 동작).

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 1,
    "basic": 15
  }
}
```

**응답 (200 OK)**

```json
{
  "requestID": "req-008",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": { "total": 1, "successful": 1, "failed": 0 },
    "results": [
      {
        "state": "success",
        "jobName": "server-01_ROOT_Backup_1",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "type": "Once",
            "description": "[Basic] Start working on 2026-06-01 at 02:00"
          }
        }
      }
    ]
  },
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 9. 부분 ID 참조 — smart에서 basic/advanced 모두 ID (`type: 7` Smart Weekly)

`smart` 모드에서도 `basic`과 `advanced` 양쪽에 각각 다른 schedule ID를 지정할 수 있습니다. 단, 참조되는 schedule 레코드는 ID 15가 단일 선택 패턴(basic 용), ID 16이 다중 선택 패턴(advanced 용)이어야 합니다 (자세한 제약은 동작 안내 참고).

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

**응답 schedule 부분**

```json
"schedule": {
  "basic": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Basic] Start working every Monday at 10:00"
  },
  "advanced": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
  }
}
```

#### 10. 부분 ID 참조 — smart에서 basic은 inline 객체 + advanced만 ID (`type: 7`)

inline 객체와 ID 참조는 `basic`/`advanced` 각각 독립적으로 섞어 쓸 수 있습니다.

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
      "time": "02:00"
    },
    "advanced": 16
  }
}
```

**응답 schedule 부분**

```json
"schedule": {
  "basic": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Basic] Start working every Monday at 02:00"
  },
  "advanced": {
    "type": "Smart Weekly (Specific Day of the Week)",
    "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>schedule 동봉 검증 실패 예시</strong></summary>

> 모든 예시는 실제 코드의 errorCode/HTTP/메시지에 정합합니다. `error` 문자열은 영문/한글이 혼재하며, default message는 영문, customMessage가 지정된 경로는 한글일 수 있습니다.

#### 1. smart 모드인데 `schedule` 누락 (400 / `JOB-ERROR-107`)

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
  "requestID": "req-err-001",
  "error": "Schedule is required for Smart Backup.",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 2. smart 모드 + scheduleType < 7 (400 / `JOB-ERROR-102`)

요청 — smart 모드에 일반 Daily(type 3) 스케줄을 동봉:

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

응답 — `resolveForRegist`의 mode-type 매칭 검증에서 default message 노출:

```json
{
  "success": false,
  "requestID": "req-err-002",
  "error": "For smart job type, schedule must contain both basic and advanced.",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 3. smart 모드 + scheduleType ≥ 7 + `advanced` 누락 (400 / `JOB-ERROR-102`)

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
    "basic": { "day": "mon", "time": "10:00" }
  }
}
```

응답 — `validateJobScheduleCompatibility`의 ProcessedSmart 가드에서 한국어 customMessage 노출:

```json
{
  "success": false,
  "requestID": "req-err-003",
  "error": "Smart 작업 모드에는 basic + advanced schedule이 모두 필요합니다.",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 4. full/increment 모드인데 Smart type(7~11) 스케줄 동봉 (400 / `JOB-ERROR-101`)

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

응답 — `resolveForRegist`의 backupMode-scheduleType 매칭 검증:

```json
{
  "success": false,
  "requestID": "req-err-004",
  "error": "For full/increment job types, schedule must contain only basic.",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 5. schedule.type 범위 위반 (422 / `DTO-VALIDATION-01`)

요청:

```json
{
  "center": "1",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 },
  "schedule": {
    "type": 100,
    "basic": { "time": "02:00" }
  }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-err-005",
  "error": "Request body validation failed.",
  "timestamp": "2026-05-19 10:30:00",
  "detail": {
    "validationErrors": {
      "schedule.type": ["invalid schedule type (must be 0 ~ 11)"]
    }
  }
}
```

#### 6. type 7 + `basic.time` 누락 (422 / `DTO-VALIDATION-01`)

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
    "basic": { "day": "mon" },
    "advanced": { "day": "tue,wed", "time": "12:00" }
  }
}
```

응답 — superRefine이 type별 schema로 재검증한 결과를 합쳐 단일 issue로 출력:

```json
{
  "success": false,
  "requestID": "req-err-006",
  "error": "Request body validation failed.",
  "timestamp": "2026-05-19 10:30:00",
  "detail": {
    "validationErrors": {
      "schedule.basic": ["basic schedule validation failed (type: 7): time: time is required"]
    }
  }
}
```

#### 7. schedule ID 참조인데 해당 ID 미존재 (404 / `JOB-ERROR-100`)

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
  "requestID": "req-err-007",
  "error": "Schedule ID '999' not found",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 8. Center NOT_FOUND (404 / `JOB-ERROR-03`)

요청:

```json
{
  "center": "999",
  "server": "server-01",
  "type": "full",
  "partition": ["/"],
  "repository": { "id": 5 }
}
```

응답 — backup 도메인의 `getCenterInfo` 경로 (schedule 도메인의 `ZDM-ERROR-01`과 다른 코드):

```json
{
  "success": false,
  "requestID": "req-err-008",
  "error": "Center '999' not found.",
  "timestamp": "2026-05-19 10:30:00"
}
```

#### 9. 부분 ID 참조인데 해당 ID 미존재 (404 / `SCHEDULE-ERROR-01`)

inline 객체의 `basic` 또는 `advanced`에 number를 넣었으나 해당 ID의 schedule 레코드가 없을 때 발생. **errorCode 자체는 전체 ID 미존재(#7, `JOB-ERROR-100`)와 다른 `SCHEDULE-ERROR-01`** (부분 ID 경로의 NOT_FOUND가 schedule 도메인 NOT_FOUND로 throw되기 때문). HTTP 상태와 메시지 골격은 동일.

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
    "basic": { "day": "mon", "time": "10:00" },
    "advanced": 999
  }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-err-009",
  "error": "Schedule ID '999' not found.",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>schedule 동작 안내</strong></summary>

#### 1. smart 모드의 schedule 필수 정책

- `type: "smart"` 등록 요청은 `schedule` 필드가 **항상 필수**입니다. 누락 시 즉시 400 (`JOB-ERROR-107`) 반환.
- smart 모드의 `schedule.type`은 반드시 7~11 범위 (Smart Weekly ~ Smart Custom).
- smart 모드의 `schedule`은 **basic + advanced 모두 필수**.

#### 2. mode ↔ schedule type 정합성 (regist에는 자동 전환이 없음)

regist 단계에서는 mode와 schedule type이 정합하지 않으면 즉시 400을 반환합니다. **mode-schedule 교차 변경 자동 전환은 update 전용**으로, regist에서는 동작하지 않습니다.

| 요청 mode | 허용 schedule type | 위반 시 errorCode |
|----------|------------------|------------------|
| `full` / `increment` | 0 ~ 6 | `JOB-ERROR-101` (HTTP 400) |
| `smart` | 7 ~ 11 | `JOB-ERROR-102` (HTTP 400) |
| `smart` (advanced 누락) | — | `JOB-ERROR-102` (HTTP 400) |
| `smart` (schedule 자체 누락) | — | `JOB-ERROR-107` (HTTP 400) |

#### 3. inline schedule 객체 vs schedule ID(number) 우선순위

- 두 형식은 같은 `schedule` 필드 위에 **union**으로 정의되어 있어 상호 배타입니다. 형태(object 또는 number)에 따라 zod가 자동으로 한쪽을 선택합니다.
- **schedule ID(number) 경로의 특수 동작**: 참조된 schedule 레코드의 데이터를 읽어 **새 schedule 레코드로 INSERT**합니다. 즉, 응답에 노출되는 schedule은 입력 ID와 다른 새 ID를 가지며 `advanced`는 항상 빈 상태입니다. 기존 schedule을 그대로 재사용하는 동작이 아닙니다.
- **부분 ID 참조도 동일하게 새 INSERT 동작**: inline 객체 내부의 `basic` 또는 `advanced` 자리에 number를 넣어도, 참조된 schedule 레코드의 데이터를 읽어 **새 schedule 레코드로 INSERT**합니다. 응답에 노출되는 schedule ID는 입력 ID와 다른 새 ID입니다.
- **부분 ID + inline 객체 혼합 허용**: `basic`만 ID + `advanced` 객체, `basic` 객체 + `advanced`만 ID, 양쪽 모두 ID — 세 조합 모두 동작합니다. (예시: 정상 케이스 #8 / #9 / #10)
- **부분 ID 미존재 시**: HTTP 404로 응답하되 errorCode는 `SCHEDULE-ERROR-01` (전체 ID 미존재의 `JOB-ERROR-100`과 코드 자체는 다름 — 검증 실패 #9 참고). HTTP 상태와 메시지 골격(`Schedule ID '...' not found.`)은 동일.
- **smart 타입 부분 ID의 모드 일치 제약**: smart 타입(7~11) schedule을 부분 ID로 참조할 경우, 참조되는 schedule 레코드의 저장 패턴(`day`/`week`/`month`/`date`의 비트 개수)에 따라 사용 자리가 결정됩니다. **단일 선택(count==1) 패턴은 `basic` 자리에만**, **다중 선택(count>1) 패턴은 `advanced` 자리에만** 사용 가능합니다. 위반 시 400 (`JOB-ERROR-108`).

#### 4. 요일/주차 입력 형식 ↔ 응답 description 형식

- 요청 입력: 짧은 표기(`mon`, `tue`, `wed`, …) 또는 콤마로 묶은 다중 표기(`"mon,wed,fri"`).
- 응답 `description`: 풀네임(`Monday`, `Wednesday`, …)으로 변환되어 출력.
- 자세한 변환 규칙: [요일 입력 ↔ DB 저장 형식 (binary) 변환](../overview#요일-입력--db-저장-형식-binary-변환).

#### 5. Smart 스케줄 basic 필드 단일값 제약

Smart 타입(7~11)의 `basic`에서는 `day`/`week`/`month`가 모두 **단일 값만 허용**됩니다. 복수 값이 필요하면 `advanced` 쪽에 명시하세요.

자세한 규칙: [Smart 스케줄 basic 필드 제한사항](../overview#smart-스케줄-basic-필드-제한사항).

</details>

---
