
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
  -H "Authorization: <token>"

# 스케줄 ID로 조회 (ID = 15)
curl -X GET "https://api.example.com/api/schedules/15" \
  -H "Authorization: <token>"
```

> `:identifier`는 숫자 스케줄 ID만 받습니다. 숫자가 아닌 값은 400 `DTO-VALIDATION-02` 입니다(v4.0.0). 종전에는 조회까지 가서 404 로 응답했습니다.

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID (숫자 문자열). 숫자가 아니면 400 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK) — Basic 타입 (예: type=3 Daily)**

스케줄 유형(`type`)이 Daily 인 단순 주기 스케줄. `description`은 `[Basic]` prefix와 함께 생성합니다.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**성공 응답 (200 OK) — Smart(Advanced) 타입 (예: type=7 Smart Weekly, 다중 요일)**

스케줄 유형(`type`)이 Smart Weekly 이고 요일이 2개 이상 지정되면 `[Advanced]` prefix가 붙습니다. (단일 요일이면 `[Basic]`)

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**성공 응답 (200 OK) — type/state 매핑 실패 시 Unknown fallback (state 한정)**

스케줄 상태가 알 수 없는 값일 때 `state`는 `"Unknown"`으로 내려옵니다. 스케줄 유형이 정의되지 않은 값이면 오류 없이 `type` 은 `"Unknown"`, `description` 은 `"-"` 로 내려옵니다(4.0.0 이전에는 500). type 12 는 `"Yearly"` 로 표시됩니다.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

> `description` prefix 규칙: 단순 주기(`Once`/`Every Minute`/`Hourly`/`Daily`/`Weekly`/`Monthly...`)는 항상 `[Basic]`. type 12(`Yearly`)도 항상 `[Basic]`. Smart(`SMART_*`, type 7~11)는 다중 선택일 때 `[Advanced]`, 단일 선택일 때 `[Basic]`이 자동 부착됩니다.

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

해당 ID의 스케줄이 DB에 존재하지 않는 경우 반환됩니다. 실제 응답 메시지는 `customMessage`(영문)가 그대로 내려옵니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE_NOT_FOUND",
    "message": "Schedule with ID '999' not found"
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**스케줄 ID 형식 오류 (400 Bad Request) — `DTO-VALIDATION-02`**

`:identifier` 가 숫자가 아닌 경우 반환됩니다(v4.0.0).

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-02",
    "message": "URL parameter validation failed.",
    "details": {
      "identifier": ["identifier must be a number (Schedule ID only)"]
    }
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**스케줄 설명 변환 실패 (422 Unprocessable Entity) — `SCHEDULE_DESCRIPTION_CONVERSION_FAILED`**

스케줄 설명 변환이 실패한 경우 반환됩니다. 정의되지 않은 스케줄 유형은 이 오류가 아니라 `type` `"Unknown"` · `description` `"-"` 로 내려옵니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE_DESCRIPTION_CONVERSION_FAILED",
    "message": "Schedule description conversion failed."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

</details>

---
