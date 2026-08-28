
OS 복제 히스토리 목록을 조회합니다.

---

## `GET /os-replications/histories` {#get-os-replications-histories}

> * 실행된 OS 복제 작업의 히스토리를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/histories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/histories?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `jobId` | Query | number | Optional | 작업 ID 필터 | |
| `jobName` | Query | string | Optional | 작업 이름 필터 | |
| `server` | Query | string | Optional | 서버 이름 필터 | |
| `result` | Query | string | Optional | 작업 결과 필터 | `success`, `failed` |
| `page` | Query | number | Optional | 페이지 번호 | |
| `limit` | Query | number | Optional | 페이지당 개수 | |
| `center` | Query | string | Optional | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "id": 1,
      "system": { "name": "server-01" },
      "job": {
        "name": "os_repl_upload_server-01",
        "id": 10,
        "sourcePath": "/source",
        "targetPath": "/target",
        "unitType": "Upload"
      },
      "result": { "status": "COMPLETE", "description": "OS replication completed successfully" },
      "size": { "total": 0, "replicated": 0 },
      "count": { "total": 0, "replicated": 0 },
      "time": { "start": "2025-01-15 10:00:00", "end": "2025-01-15 10:30:00", "elapsed": "00:30:00" }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 1,
    "totalItems": 1,
    "itemsPerPage": 20,
    "hasNextPage": false,
    "hasPreviousPage": false
  },
  "message": "OS Replication histories retrieved",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

> 각 항목 구조는 단건 조회(`GET /os-replications/histories/:identifier`)와 동일합니다. `size` / `count` 는 현재 항상 `0` 이며, `pagination` 은 `page`/`limit` 지정 시에만 포함됩니다.

</details>

---
