
특정 백업 작업의 설정을 수정합니다.

---

## `PUT /backups/:identifier` {#put-backups-identifier}

> * 백업 ID 또는 백업 이름으로 특정 백업 작업의 설정을 수정합니다.
> * 수정할 필드만 요청 본문에 포함하면 됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 작업 수정
curl -X PUT "https://api.example.com/api/backups/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "changeName": "weekly-backup",
    "mode": "increment",
    "rotation": 14,
    "compression": "use"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/backups/daily-backup" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "schedule": {
      "type": 4,
      "basic": {
        "day": "1",
        "time": "03:00"
      }
    }
  }'

# 기존 스케줄 ID로 변경
curl -X PUT "https://api.example.com/api/backups/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "schedule": 123
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `changeName` | string | Optional | 변경할 작업 이름 | - |
| `mode` | string | Optional | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `status` | string | Optional | 작업 상태 변경 | {% include zdm/job-status-update.md %} |
| `rotation` | number | Optional | 작업 반복 횟수 | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string | Optional | 제외 디렉토리 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 기존 스케줄 ID (스케줄 타입에 따라 작업 모드 자동 전환) | - |
| `repository` | object | Optional | 레포지토리 정보 | - |
| `repository.id` | number | Optional | 레포지토리 ID. 생략 시 기존 백업 작업의 레포지토리를 그대로 유지하고 `repository.path` 만 변경 | - |
| `repository.type` | string | Optional | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `repository.path` | string | Optional | 레포지토리 경로 | - |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |

> **v2.0.2 변경 사항**: `repository.id` 가 Optional 로 완화되었습니다. `repository` 를 지정하면서 `id` 를 생략하면 기존 레포지토리를 유지한 채 `path` 만 단독으로 수정할 수 있습니다. (등록 API `POST /backups` 는 기존과 동일하게 `repository.id` 필수)

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

> 기존 스케줄 ID(숫자)를 사용하거나, 새 스케줄 객체를 생성할 수 있습니다.
> 스케줄 타입별 상세 구조는 [POST /schedules](../schedule/regist)를 참고하세요.

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `type` | number/string | Required | 스케줄 타입 (0~11 숫자 또는 타입명 문자열) |
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

**모드-스케줄 자동 전환:**

- Full/Increment 작업에 Smart 스케줄(타입 7~11)을 등록하면, 작업 모드가 자동으로 Smart로 전환됩니다.
- Smart 작업에 Full/Increment 스케줄(타입 0~6)을 등록하면, 작업 모드가 자동으로 Full로 전환되고 Advanced 스케줄이 초기화됩니다.
- `mode` 필드를 함께 지정하면 해당 값이 우선 적용됩니다.

**스케줄 등록/수정 정책 (v2.0.0):**

| 시나리오 | 동작 |
|---------|------|
| 기존 스케줄 없음 | 신규 스케줄 등록 |
| 모드 동일(F/I→F/I, Smart→Smart) + 기존 스케줄 있음 | 기존 스케줄의 데이터만 입력값으로 갱신 (스케줄 ID 보존) |
| 모드 전환(F/I↔Smart) | 신규 스케줄 등록 (기존 스케줄 참조 해제, advanced 자동 초기화) |
| 입력이 스케줄 ID(숫자) + 기존 스케줄 있음 | 입력 ID의 스케줄 데이터를 기존 스케줄에 복사하여 갱신 (ID 보존) |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

> **v2.0.2 변경 사항**: `Schedule` / `Schedule(Basic)` / `Schedule(Advanced)` 필드의 `previous` / `new` 가 단순 ID(숫자) 가 아닌 `{ id, type, description }` 객체 구조로 확장되었습니다. 그 외 필드 (`jobName`, `mode`, `rotation` 등) 는 기존 그대로 단순 값. 이전 양식은 [v2.0.1](../../../2.0.0/docs/backup/update) 문서를 참고하세요.

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": [
      {
        "id": "1",
        "name": "weekly-backup",
        "partition": "/"
      }
    ],
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "jobName",
          "previous": "daily-backup",
          "new": "weekly-backup"
        },
        {
          "field": "mode",
          "previous": "full",
          "new": "increment"
        },
        {
          "field": "rotation",
          "previous": 7,
          "new": 14
        },
        {
          "field": "compression",
          "previous": "not use",
          "new": "use"
        },
        {
          "field": "Schedule",
          "previous": { "id": 5,  "type": "Daily", "description": "[Basic] Start working at 03:00 every day." },
          "new":      { "id": 10, "type": "Daily", "description": "[Basic] Start working at 03:00 every day." }
        },
        {
          "field": "Job Status",
          "previous": "Registered",
          "new": "start"
        }
      ]
    },
    "notices": [
      "Schedule was duplicated (1 schedule = 1 job principle). Source schedule ID: 5, new schedule ID: 10."
    ]
  },
  "message": "Backup job updated",
  "timestamp": "2025-01-15 10:30:00"
}
```

> **v2.0.2 Status diff 정확화**: Job Status 변경 detail 의 `previous` 값이 DB raw 컬럼 값 (`"Complete"`) 이 아닌 UI 와 동일한 `calculateJobStatus` 결과 (`"Registered"` / `"Processing"` / `"Scheduled"` / `"Complete"` 등) 로 표시됩니다. `new` 는 사용자가 요청한 status 문자열을 그대로 echo.

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo[].id` | string | 작업 ID |
| `jobInfo[].name` | string | 작업 이름 |
| `jobInfo[].partition` | string | 대상 파티션 |
| `jobInfo[].errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 수정 결과 (`success` / `fail`) |
| `summary.updatedFields[].field` | string | 수정된 필드명 |
| `summary.updatedFields[].previous` | any \| ScheduleChangeValue \| null | 수정 전 값. **Schedule 계열** (`Schedule` / `Schedule(Basic)` / `Schedule(Advanced)`) 인 경우 `{ id, type, description }` 객체 또는 `null` (이전 schedule 없음 / 모드 전환 reset). 그 외 단순 값. |
| `summary.updatedFields[].new` | any \| ScheduleChangeValue \| null | 수정 후 값. Schedule 계열은 동일 객체 구조 |
| `notices` | string[] (optional) | 부가 안내 메시지 배열 (v2.0.2 신규). 안내할 내용이 있을 때만 응답에 포함 (비어 있으면 키 자체가 생략). 예: schedule 복제 알림 — `Source schedule ID: N, new schedule ID: M` |

**ScheduleChangeValue 구조** (v2.0.2 신규):

| 하위 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | schedule ID |
| `type` | string | schedule 타입 displayMappings PascalCase 영문 (예: `"Once"`, `"Every Minute"`, `"Hourly"`, `"Daily"`, `"Weekly"`, `"Monthly (Specific Week and Day of the Week)"`, `"Monthly on Specific Date"`, `"Smart Weekly (Specific Day of the Week)"`, `"Smart Monthly (Specific Week and Day of the Week)"`, `"Smart Monthly (Specific Date)"`, `"Smart Custom (Specific Month, Week and Day of the Week)"`, `"Smart Custom (Specific Month and Date)"`). 조회 실패 시 `"Unknown"` |
| `description` | string | schedule 내용 영문 설명 — `processScheduleInfo` 결과 (예: `"[Basic] Start working at 03:00 every day."`, `"[Basic] Start working at 03:00 Monday, Wednesday every week."`, `"[Basic] Start working at 03:00 on the 1, 15 of every month."`, `"[Basic] Start working at 00:00 every 2 Hour."`, `"[Basic] Start working on 15/06/2026 03:00."`). 조회 실패 시 `"Schedule lookup failed"` |

> **참고**: id ≤ 0 (이전 schedule 없음) 인 경우 해당 필드는 `null` 로 반환됩니다. schedule 자동 복제로 새 ID 가 발급된 경우 `notices` 에 안내 메시지 첨부.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**백업 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Backup을 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
