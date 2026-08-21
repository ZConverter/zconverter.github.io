
특정 복구 작업의 설정을 수정합니다.

---

## `PUT /recoveries/:identifier` {#put-recoveries-identifier}

> * 복구 ID 또는 복구 이름으로 특정 복구 작업의 설정을 수정합니다.
> * 수정할 필드만 요청 본문에 포함하면 됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 공통 필드 수정 (모든 파티션에 동일하게 적용)
curl -X PUT "https://api.example.com/api/recoveries/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "changeName": "weekly-recovery",
    "mode": "increment",
    "afterReboot": "shutdown"
  }'

# 개별 파티션 모드만 변경 (jobList만 사용)
curl -X PUT "https://api.example.com/api/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobList": [
      {
        "partition": "/",
        "mode": "increment"
      }
    ]
  }'

# 전체 모드 + 개별 파티션 예외 설정 (Linux)
# mode: 모든 파티션에 increment 적용 후, jobList로 "/" 파티션만 full로 재변경
curl -X PUT "https://api.example.com/api/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "mode": "increment",
    "afterReboot": "reboot",
    "jobList": [
      {
        "partition": "/",
        "mode": "full"
      }
    ]
  }'

# Windows 드라이브 개별 모드 변경
curl -X PUT "https://api.example.com/api/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobList": [
      {
        "drive": "C:",
        "mode": "increment"
      }
    ]
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 ID (숫자) 또는 복구 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string \| number | Required | 작업이 속한 center ID 또는 Name (소속 검증용) | - |
| `changeName` | string | Optional | 변경할 작업 이름 | - |
| `platform` | string | Optional | 플랫폼 | {% include zdm/platforms.md inline=true %} |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `mode` | string | Optional | 작업 모드 (전체 적용) | {% include zdm/job-modes.md %} |
| `afterReboot` | string | Optional | 작업 후 부팅 방식 | {% include zdm/after-reboot.md %} |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `status` | string | Optional | 작업 상태 변경 | {% include zdm/job-status-update.md %} |
| `jobList` | array | Optional | 개별 작업 설정 배열 | - |

**jobList 항목 구조:**

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `partition` | string | Conditional | 대상 파티션 - Linux (partition 또는 drive 중 하나 필수) |
| `drive` | string | Conditional | 대상 드라이브 - Windows (partition 또는 drive 중 하나 필수). 입력값은 대문자 변환 및 `:` 자동 추가됨 (`c` → `C:`, `c:` → `C:`) |
| `mode` | string | Optional | 변경할 작업 모드 |

> **mode와 jobList 동시 사용 시 처리 순서:**
> 1. `mode` 필드가 먼저 적용되어 **모든 파티션**의 모드가 변경됩니다.
> 2. 이후 `jobList`가 적용되어 **지정된 파티션만** 개별적으로 재변경됩니다.
>
> 예: `mode: "increment"` + `jobList["/"].mode: "full"` → `/`는 `full`, 나머지는 `increment`

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

> **v2.0.2 변경 사항**:
> - Job Status 변경 detail 의 `previous` 가 DB raw 값 (`"Complete"`) 이 아닌 UI 와 동일한 calculated 결과 (`"Registered"` / `"Processing"` / `"Scheduled"` / `"Complete"` 등) 로 표시됩니다.
> - Schedule 변경 detail (`Schedule(Basic)` 필드) 의 `previous`/`new` 가 단순 ID 가 아닌 `{ id, type, description }` 객체로 확장되었습니다. (Recovery 는 `basic` only — `advanced` 없음)

<details markdown="1" open>
<summary>공통 필드만 변경 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "weekly-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "jobName",
          "previous": "daily-recovery",
          "new": "weekly-recovery"
        },
        {
          "field": "afterReboot",
          "previous": "reboot",
          "new": "shutdown"
        }
      ],
      "eachUpdatedFields": []
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>Schedule 변경 (200 OK) — v2.0.2 양식</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "daily-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "Schedule(Basic)",
          "previous": null,
          "new": {
            "id": 7,
            "type": "Daily",
            "description": "[Basic] Start working at 03:00 every day."
          }
        }
      ],
      "eachUpdatedFields": []
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

> `previous` 가 `null` 인 경우는 기존 schedule 이 없었거나 (id ≤ 0) 모드 전환으로 schedule 이 reset 된 경우입니다.

</details>

<details markdown="1">
<summary>Job Status 변경 (200 OK) — v2.0.2 calculated previous</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "daily-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "Job Status",
          "previous": "Registered",
          "new": "start"
        }
      ],
      "eachUpdatedFields": []
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

> `previous` 는 DB raw enum 값 (`"Complete"` 등) 이 아닌 UI 와 동일한 calculated 결과 (`"Registered"` / `"Processing"` / `"Scheduled"` / `"Complete"` 등) 로 표시됩니다. `new` 는 요청 body 의 `status` 입력값을 그대로 반영합니다.

</details>

<details markdown="1">
<summary>개별 파티션만 변경 - jobList만 사용 - Linux (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "daily-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [],
      "eachUpdatedFields": [
        {
          "partition": "/",
          "summary": {
            "state": "success",
            "commonUpdatedFields": [
              {
                "field": "Recovery Mode",
                "previous": "full",
                "new": "increment"
              }
            ],
            "eachUpdatedFields": []
          }
        }
      ]
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>개별 드라이브만 변경 - jobList만 사용 - Windows (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "2",
      "name": "daily-recovery-win"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [],
      "eachUpdatedFields": [
        {
          "drive": "C:",
          "summary": {
            "state": "success",
            "commonUpdatedFields": [
              {
                "field": "Recovery Mode",
                "previous": "full",
                "new": "increment"
              }
            ],
            "eachUpdatedFields": []
          }
        }
      ]
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>전체 모드 + 개별 파티션 예외 설정 (200 OK)</summary>

요청: `mode: "increment"` (전체) + `jobList["/"].mode: "full"` (예외)

- 처리 순서: `mode` 먼저 적용 → `jobList` 나중 적용
- 결과: `/` 파티션은 `full`, 나머지 파티션은 `increment`

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "daily-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "Recovery Mode",
          "previous": "full",
          "new": "increment"
        },
        {
          "field": "After Reboot",
          "previous": "shutdown",
          "new": "reboot"
        }
      ],
      "eachUpdatedFields": [
        {
          "partition": "/",
          "summary": {
            "state": "success",
            "commonUpdatedFields": [
              {
                "field": "Recovery Mode",
                "previous": "increment",
                "new": "full"
              }
            ],
            "eachUpdatedFields": []
          }
        }
      ]
    }
  },
  "message": "Recovery job Update completed",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo.id` | string | 작업 ID |
| `jobInfo.name` | string | 작업 이름 |
| `jobInfo.errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 수정 결과 (`success` / `fail`) |
| `summary.commonUpdatedFields[].field` | string | 수정된 공통 필드명 |
| `summary.commonUpdatedFields[].previous` | any \| ScheduleChangeValue \| null | 수정 전 값. **Schedule 계열** (`Schedule(Basic)`) 인 경우 `{ id, type, description }` 객체 또는 `null` (이전 schedule 없음 / 모드 전환 reset). **Job Status** 인 경우 UI 와 동일한 calculated 결과 (`"Registered"` / `"Processing"` / `"Scheduled"` / `"Complete"` 등 — v2.0.2 부터 DB raw enum 이 아님). 그 외 단순 값. |
| `summary.commonUpdatedFields[].new` | any \| ScheduleChangeValue \| null | 수정 후 값. Schedule 계열은 동일 객체 구조. Job Status 는 요청 body 의 `status` 입력값 그대로. |
| `summary.eachUpdatedFields[].partition` | string | 파티션 (Linux) |
| `summary.eachUpdatedFields[].drive` | string | 드라이브 (Windows) |
| `summary.eachUpdatedFields[].summary` | object | 파티션별 수정 결과 |

**ScheduleChangeValue 구조** (v2.0.2 신규):

| 하위 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | schedule ID |
| `type` | string | schedule 타입 — displayMappings PascalCase 영문 (예: `"Once"`, `"Every Minute"`, `"Hourly"`, `"Daily"`, `"Weekly"`, `"Monthly (Specific Week and Day of the Week)"`, `"Monthly on Specific Date"`, `"Smart Weekly (Specific Day of the Week)"`, `"Smart Monthly (Specific Week and Day of the Week)"`, `"Smart Monthly (Specific Date)"`, `"Smart Custom (Specific Month, Week and Day of the Week)"`, `"Smart Custom (Specific Month and Date)"`). 조회 실패 시 `"Unknown"` |
| `description` | string | `processScheduleInfo` 영문 결과 (예: `"[Basic] Start working at 03:00 every day."`, `"[Basic] Start working at 03:00 Monday, Wednesday every week."`). 조회 실패 시 `"Schedule lookup failed"` |

> **참고**: id ≤ 0 (이전 schedule 없음) 인 경우 해당 필드는 `null` 로 반환됩니다. Recovery 는 `basic` 스케줄만 지원하므로 `Schedule(Advanced)` 필드는 발생하지 않습니다 (응답 발생 위치는 `Schedule(Basic)` 한 곳).

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복구 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Recovery를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
