
특정 백업 작업을 삭제합니다.

---

## `DELETE /backups/:identifier` {#delete-backups-identifier}

> * 백업 ID 또는 백업 이름으로 특정 백업 작업을 삭제합니다.
> * 삭제 시 관련된 모든 데이터(기본 정보, 상세 정보, 히스토리, 로그)가 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 ID로 삭제
curl -X DELETE "https://api.example.com/api/backups/1" \
  -H "Authorization: Bearer <token>"

# 백업 이름으로 삭제
curl -X DELETE "https://api.example.com/api/backups/daily-backup" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |
| `center` | Query | string | Optional | - | center 식별자 (ID 또는 이름, **정확히 1개**) | - |

> **참고:**
> - 삭제는 대상이 모호하면 안 되므로 `center`는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 지정하면 400입니다.
> - `center`는 **키만 보내고 값이 비면**(`?center=`) 400입니다. 파라미터를 **생략**하는 것은 종전대로 "해당 필터 없음"이며 동작이 달라지지 않습니다.
> - 위 두 경우의 에러 형식은 `DTO-VALIDATION-03`입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "jobInfo": [
      {
        "name": "daily-backup",
        "partition": "/",
        "deletedComponents": {
          "basicInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        }
      }
    ],
    "summary": {
      "state": "success",
      "affectedComponents": {
        "basicInfoDeleted": 1,
        "detailInfoDeleted": 1,
        "historyDataDeleted": 5,
        "logDataDeleted": 10
      }
    }
  },
  "message": "Backup job deleted",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo[].name` | string | 삭제된 작업 이름 |
| `jobInfo[].partition` | string | 대상 파티션 |
| `jobInfo[].deletedComponents.basicInfo` | boolean | 기본 정보 삭제 여부 |
| `jobInfo[].deletedComponents.detailInfo` | boolean | 상세 정보 삭제 여부 |
| `jobInfo[].deletedComponents.historyData` | boolean | 히스토리 데이터 삭제 여부 |
| `jobInfo[].deletedComponents.logData` | boolean | 로그 데이터 삭제 여부 |
| `jobInfo[].errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 삭제 결과 (`success` / `fail` / `not_found`). **`not_found`** 는 대상 행이 이미 없어 삭제된 행이 0건인 경우로, 실패와 구분됩니다 — 예전부터 이 값이 나가고 있었고 문서에만 빠져 있었습니다 |
| `summary.affectedComponents.basicInfoDeleted` | number | 삭제된 기본 정보 수 |
| `summary.affectedComponents.detailInfoDeleted` | number | 삭제된 상세 정보 수 |
| `summary.affectedComponents.historyDataDeleted` | number | 삭제된 히스토리 데이터 수 |
| `summary.affectedComponents.logDataDeleted` | number | 삭제된 로그 데이터 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**같은 이름의 작업이 여러 개 (409 Conflict)**

작업 **이름**으로 삭제할 때, 지정한 center 안에 같은 이름의 작업이 2개 이상이면 반환됩니다.
어느 것을 지울지 알 수 없으므로 **아무것도 삭제하지 않고** 거부합니다.
메시지에 걸린 작업 ID 목록이 실리므로 **ID 로 다시 요청**하면 됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "CONFLICT",
    "message": "Multiple backup jobs named 'daily-backup' exist (ids: 10, 11). Delete by job id instead."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**백업 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-01",
    "message": "Job information not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

`center`를 2개 이상 지정했거나, 키만 보내고 값을 비운 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["exactly one center must be specified"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
