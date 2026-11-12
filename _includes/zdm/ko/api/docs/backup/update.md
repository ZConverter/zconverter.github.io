{% include zdm/base-path.html %}

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
        "day": "mon",
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
| `schedule` | object \| number | Optional | 스케줄 객체 또는 기존 스케줄 ID. 스케줄 타입에 따라 작업 모드가 자동 전환됩니다. [스케줄 개요]({{ base_path }}/docs/schedule/overview) 참조 | - |
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

{% include zdm/schedule-object.md %}

**모드-스케줄 자동 전환:**

- 아래 자동 전환은 **스케줄을 객체로 보낼 때만** 적용됩니다. 최상위 숫자 ID 는 자동 전환되지 않습니다(아래 참조).
- Full/Increment 작업에 Smart 스케줄 객체(타입 7~11)를 등록하면, 작업 모드가 자동으로 Smart로 전환됩니다.
- Smart 작업에 Full/Increment 스케줄 객체(타입 0~6)를 등록하면, 작업 모드가 자동으로 Full로 전환되고 Advanced 스케줄이 초기화됩니다.
- `mode` 필드를 함께 지정하면 해당 값이 우선 적용됩니다.
- Smart 작업(또는 `mode: "smart"`)에 최상위 숫자 ID 를 보내면 전환되지 않고 400 (`JOB-ERROR-102`)입니다. Smart 작업을 단일 basic 스케줄로 바꾸려면 숫자 ID 와 함께 `mode: "full"`(또는 `"increment"`)을 보내세요. 이때 Advanced 스케줄은 0 으로 초기화됩니다.

**스케줄 등록/수정 정책:**

| 시나리오 | 동작 |
|---------|------|
| 기존 스케줄 없음 | 신규 스케줄 등록 |
| 모드 동일(F/I→F/I, Smart→Smart) + 기존 스케줄 있음 + 입력이 스케줄 객체 | 기존 스케줄의 데이터만 입력값으로 갱신 (스케줄 ID 보존) |
| 모드 전환(F/I↔Smart) | 신규 스케줄 등록 (기존 스케줄 참조 해제, advanced 자동 초기화) |
| 입력이 스케줄 ID(숫자) | 입력 ID 의 스케줄을 **복사해 새 스케줄로 등록**하고 작업에 연결 (새 ID 발급, 기존 스케줄 ID 는 유지되지 않음). 응답 `notices` 에 복사 안내가 포함됩니다 |

- 숫자 ID 는 Full/Increment 용(basic) 스케줄만 최상위로 지정합니다. Smart 스케줄을 ID 로 지정하려면 `{ "type": 7, "basic": <ID>, "advanced": <ID> }` 형식을 사용합니다. 도메인별 처리는 [스케줄 개요]({{ base_path }}/docs/schedule/overview#숫자-id-로-지정할-때-도메인별-처리)를 참조하세요.
- 존재하지 않는 ID 는 404 (`SCHEDULE-ERROR-01`)입니다.
- 지정한 스케줄이 작업이 속한 center 의 것이 아니면 403 (`CENTER-ERROR-01`)입니다(`Schedule ID '<id>' does not belong to center <center>`). `nCenterID = 0` 도 하나의 center 로 비교합니다.
- 판정 mode 는 요청 `mode`(없으면 기존 작업 mode)입니다. Smart mode 에 최상위 숫자 ID 를 보내면 400 (`JOB-ERROR-102`, `Smart job mode cannot use a single schedule ID. Use the object form { type, basic: <id>, advanced: <id> }.`)입니다.
- Full/Increment mode 에 Smart 스케줄 행(타입 7~11)의 ID 를 보내면 400 (`JOB-ERROR-101`, `Schedule ID '<id>' is a smart schedule (type N). Full/increment job modes accept schedule type 0-6 only.`)입니다.
- 객체의 `basic` / `advanced` 자리를 비우고 Smart 스케줄을 보내면 400 (`JOB-ERROR-102`, `Smart job mode requires both a basic and an advanced schedule.`)입니다. 종전에는 500 이었습니다.
- 검사 순서는 존재(404) → center(403) → mode·type(400)입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

> **v2.0.2 변경 사항**: `Schedule` / `Schedule(Basic)` / `Schedule(Advanced)` 필드의 `previous` / `new` 가 단순 ID(숫자) 가 아닌 `{ id, type, description }` 객체 구조로 확장되었습니다. 그 외 필드 (`jobName`, `mode`, `rotation` 등) 는 기존 그대로 단순 값. 이전 양식은 [v2.0.1](/zdm/ko/api/2.0.0/docs/backup/update) 문서를 참고하세요.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
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

{% include zdm/schedule-change-value.md %}

> **참고**: id ≤ 0 (이전 schedule 없음) 인 경우 해당 필드는 `null` 로 반환됩니다. schedule 자동 복제로 새 ID 가 발급된 경우 `notices` 에 안내 메시지 첨부.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**백업 작업을 찾을 수 없음 (404 Not Found)**

> **`center` 가 그 작업의 실제 center 와 다르면 여기에 해당합니다.**
> 작업 **ID** 로 수정할 때도 `center` 를 대조합니다 — 종전에는 ID 경로에서 `center` 를 받기만 하고
> 조회에 쓰지 않아 **다른 center 의 작업이 그대로 수정**됐습니다. 올바른 `center` 를 보내는 요청은 영향이 없습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-01",
    "message": "Backup job with ID '999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
