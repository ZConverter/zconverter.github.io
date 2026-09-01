
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

> * `center` 는 ID/이름을 콤마로 여러 개 지정할 수 있습니다 (예: `?center=1,zdm-b`). 조각 앞뒤 공백은 API 가 정규화합니다.
> * `center` · `server` 는 **키를 보냈는데 값이 비어 있으면**(`?center=`) 400 입니다. 파라미터를 **생략**하는 것은 종전대로 "필터 없음" 이므로 동작 변화가 없습니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

> 일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열(`"data": []`)을 200 으로 반환합니다 (에러가 아님). 단건 조회의 404 는 종전대로이며, 지목한 리소스가 실제로 없다는 뜻이므로 의미가 다릅니다.

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
