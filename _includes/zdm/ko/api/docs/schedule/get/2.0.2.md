
특정 스케줄의 상세 정보를 조회합니다.

---

## `GET /schedules/:identifier` {#get-schedules-identifier}

> * 스케줄 ID로 특정 스케줄의 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/schedules/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 스케줄 ID로 조회 (ID = 1)
curl -X GET "https://api.example.com/api/schedules/1" \
  -H "Authorization: Bearer <token>"

# 스케줄 ID로 조회 (ID = 15)
curl -X GET "https://api.example.com/api/schedules/15" \
  -H "Authorization: Bearer <token>"
```

> `:identifier`는 숫자 스케줄 ID만 의미 있습니다. 내부적으로 `Number(identifier)`로 변환되며, 비숫자 값은 `NaN`이 되어 `404 Not Found`로 응답합니다.

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK) — Basic 타입 (예: type=3 Daily)**

`nScheduleType = 3` (Daily) 인 단순 주기 스케줄. `description`은 `processScheduleInfo`가 `[Basic]` prefix와 함께 생성합니다.

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "id": "1",
    "center": {
      "id": "1",
      "name": "Main Center"
    },
    "type": "Daily",
    "state": "Enabled",
    "jobName": "daily-backup",
    "lastRunTime": "2026-01-15 10:00:00",
    "description": "[Basic] Start working at 10:00 every day."
  },
  "message": "Schedule information retrieved",
  "timestamp": "2026-05-19 10:30:00"
}
```

**성공 응답 (200 OK) — Smart(Advanced) 타입 (예: type=7 Smart Weekly, 다중 요일)**

`nScheduleType = 7` (Smart Weekly) 에서 `sDayweek`가 2개 이상의 요일을 지정하면 `processScheduleInfo`가 `[Advanced]` prefix를 부착합니다. (단일 요일이면 `[Basic]`)

```json
{
  "success": true,
  "requestID": "req-abc124",
  "data": {
    "id": "15",
    "center": {
      "id": "1",
      "name": "Main Center"
    },
    "type": "Smart Weekly (Specific Day of the Week)",
    "state": "Enabled",
    "jobName": "smart-weekly-backup",
    "lastRunTime": "2026-05-15 10:00:00",
    "description": "[Advanced] Start working every Monday, Wednesday, Friday at 10:00"
  },
  "message": "Schedule information retrieved",
  "timestamp": "2026-05-19 10:30:00"
}
```

**성공 응답 (200 OK) — type/state 매핑 실패 시 Unknown fallback (state 한정)**

`nStatus` 가 알 수 없는 값일 때 `state`는 `"Unknown"`으로 내려옵니다 (`ScheduleTypes.ActiveStatus.Map.toString` 의 fallback). 단, `nScheduleType` 자체가 알 수 없는 값이면 `processScheduleInfo`가 422 `Schedule description conversion failed.`로 실패하므로 type 측 `"Unknown"`을 성공 응답에서 받는 경우는 없습니다.

```json
{
  "success": true,
  "requestID": "req-abc125",
  "data": {
    "id": "21",
    "center": {
      "id": "1",
      "name": "Main Center"
    },
    "type": "Daily",
    "state": "Unknown",
    "jobName": "legacy-job",
    "lastRunTime": "-",
    "description": "[Basic] Start working at 10:00 every day."
  },
  "message": "Schedule information retrieved",
  "timestamp": "2026-05-19 10:30:00"
}
```

> `description` prefix 규칙: 단순 주기(`Once`/`Every Minute`/`Hourly`/`Daily`/`Weekly`/`Monthly...`)는 항상 `[Basic]`. Smart(`SMART_*`, type 7~11)는 다중 선택일 때 `[Advanced]`, 단일 선택일 때 `[Basic]`이 자동 부착됩니다.

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | string | 스케줄 ID |
| `center.id` | string | 센터 ID |
| `center.name` | string | 센터 이름 |
| `type` | string | 스케줄 타입 |
| `state` | string | 활성화 상태 |
| `jobName` | string | 작업 이름 |
| `lastRunTime` | string | 마지막 실행 시간 |
| `description` | string | 스케줄 설명 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**스케줄을 찾을 수 없음 (404 Not Found) — `SCHEDULE_NOT_FOUND`**

해당 ID의 스케줄이 DB에 존재하지 않거나, `:identifier`가 비숫자여서 `Number(identifier) = NaN`인 경우 반환됩니다. 실제 응답 메시지는 `customMessage`(영문)가 그대로 내려옵니다.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Schedule with ID '999' not found",
  "timestamp": "2026-05-19 10:30:00"
}
```

**스케줄 설명 변환 실패 (422 Unprocessable Entity) — `SCHEDULE_DESCRIPTION_CONVERSION_FAILED`**

`nScheduleType`이 지원되지 않는 값(예: `99` `UNKNOWN` 등 정의되지 않은 enum)이거나, `processScheduleInfo` 내부 파싱이 실패한 경우 반환됩니다. 입력 path param 형식 위반은 별도 422가 아니라 위의 404로 떨어집니다(스키마가 `z.string().min(1)`만 검증).

```json
{
  "success": false,
  "requestID": "req-abc124",
  "error": "Schedule description conversion failed.",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

---
