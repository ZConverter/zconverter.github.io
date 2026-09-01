
특정 스케줄을 삭제합니다.

---

## `DELETE /schedules/:identifier` {#delete-schedules-identifier}

> * 스케줄 ID로 특정 스케줄을 삭제합니다.
> * 작업(Backup/Recovery/Replication)에서 참조 중인 스케줄은 삭제할 수 없습니다.
> * `center` 는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 주면 400이고, `?center=` 처럼 키만 보내고 값이 비어도 400입니다. 파라미터를 **생략**하는 것은 종전대로 허용됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/schedules/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 스케줄 ID로 삭제
curl -X DELETE "https://api.example.com/api/schedules/1" \
  -H "Authorization: Bearer <token>"

# center 소속 검증과 함께 삭제 (스케줄이 해당 센터 소속이 아니면 403)
curl -X DELETE "https://api.example.com/api/schedules/1?center=1" \
  -H "Authorization: Bearer <token>"

# path param 형태 — 스케줄 ID 15 삭제
curl -X DELETE "https://api.example.com/api/schedules/15" \
  -H "Authorization: Bearer <token>"

# path param + center 검증 — 스케줄 ID 15가 center ID 1 소속인지 확인 후 삭제
curl -X DELETE "https://api.example.com/api/schedules/15?center=1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID (숫자만 허용) | - |
| `center` | Query | string | Optional | - | 센터 식별자(ID 또는 이름). **정확히 1개만** 허용(여러 개·빈 값은 400). 지정 시 스케줄이 해당 센터 소속인지 검증 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 1,
    "name": "daily-backup",
    "type": "Daily",
    "description": "[Basic] Start working at 03:00 every day."
  },
  "message": "Schedule has been successfully deleted",
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**성공 응답 (200 OK) — `sJobName`이 비어 있어 `Schedule-<id>`로 대체된 경우 + Advanced 스케줄**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 15,
    "name": "Schedule-15",
    "type": "Smart Monthly (Specific Week and Day of the Week)",
    "description": "[Advanced] Start working on the second Monday of every month at 02:30."
  },
  "message": "Schedule has been successfully deleted",
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `data.id` | number | 삭제된 스케줄 ID |
| `data.name` | string | 삭제된 스케줄 이름 (작업명) |
| `data.type` | string | 삭제된 스케줄 타입 |
| `data.description` | string | 삭제된 스케줄 설명 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**스케줄을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-01",
    "message": "Schedule with ID '999' not found"
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**스케줄이 사용 중 (409 Conflict)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-51",
    "message": "Schedule ID '1' is referenced by: backup(2), recovery(1)"
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**다른 센터 소속 (403 Forbidden)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CENTER-ERROR-01",
    "message": "Schedule does not belong to center '1'"
  },
  "timestamp": "2026-05-15T10:30:00.000+09:00"
}
```

**잘못된 파라미터 (400 Bad Request)**

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
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**`center` 다중 지정 / 빈 값 (400 Bad Request)**

삭제는 대상이 모호하면 안 되므로 `center` 는 정확히 1개만 허용합니다. 콤마로 여러 개를 주거나 `?center=` 처럼 값이 비면 반환됩니다. 이전에도 같은 규칙이었으나 검증 위치가 서비스 계층에서 요청 스키마로 옮겨져 에러 형식이 `DTO-VALIDATION-03` 으로 바뀌었습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["exactly one center must be specified"]
    }
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>참조 검증 동작</strong></summary>

스케줄 삭제 전에 다음 4개 컬럼을 조회해 참조 카운트를 계산합니다. 어느 하나라도 카운트가 0보다 크면 `SCHEDULE_IN_USE` (409 Conflict) 로 차단됩니다.

| 도메인 | 테이블 | 컬럼 |
|--------|--------|------|
| Backup | `job_backup` | `nScheduleID` |
| Backup (Advanced) | `job_backup` | `nScheduleID_advanced` |
| Recovery | `job_recovery` | `nScheduleID` |
| Replication | `job_replication` | `nScheduleID` |

> * `job_backup.nScheduleID` 와 `job_backup.nScheduleID_advanced` 는 합산되어 `backup(N)` 으로 보고됩니다.
> * 에러 메시지의 도메인 카운트는 0인 경우 생략됩니다 (예: replication 참조가 없으면 `backup(2), recovery(1)` 형태).

</details>

---
