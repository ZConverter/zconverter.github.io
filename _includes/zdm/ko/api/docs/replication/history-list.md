
복제 작업의 실행 히스토리 목록을 조회합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `GET /replications/histories` {#get-replications-histories}

> * 복제 작업의 실행 이력(히스토리) 목록을 조회합니다.
> * 필터 옵션을 통해 특정 조건의 히스토리만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/replications/histories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 복제 히스토리 조회
curl -X GET "https://api.example.com/api/replications/histories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/replications/histories?result=success&server=center-01" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/replications/histories?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 대상 서버 이름 필터 | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | {% include zdm/replication-history-result.md %} |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": 1,
      "system": {
        "name": "center-01"
      },
      "job": {
        "name": "backup-replication-01",
        "id": 10,
        "sourcePath": "/backup/source",
        "targetPath": "/replication/target",
        "unitType": "repository",
        "replicationMode": "full"
      },
      "result": {
        "status": "COMPLETE",
        "description": "Replication completed successfully"
      },
      "size": {
        "total": 1073741824,
        "replicated": 1073741824
      },
      "count": {
        "total": 150,
        "replicated": 150
      },
      "time": {
        "start": "2026-03-20 02:00:00",
        "end": "2026-03-20 02:30:00",
        "elapsed": "00:30:00"
      }
    },
    {
      "id": 2,
      "system": {
        "name": "center-02"
      },
      "job": {
        "name": "server-replication-01",
        "id": 20,
        "sourcePath": "/data",
        "targetPath": "/replication/server",
        "unitType": "server",
        "replicationMode": "sync"
      },
      "result": {
        "status": "FAIL",
        "description": "Connection timeout"
      },
      "size": {
        "total": 536870912,
        "replicated": 268435456
      },
      "count": {
        "total": 80,
        "replicated": 40
      },
      "time": {
        "start": "2026-03-20 03:00:00",
        "end": "2026-03-20 03:15:00",
        "elapsed": "00:15:00"
      }
    }
  ],
  "message": "Replication history list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": 1,
      "system": {
        "name": "center-01"
      },
      "job": {
        "name": "backup-replication-01",
        "id": 10,
        "sourcePath": "/backup/source",
        "targetPath": "/replication/target",
        "unitType": "repository",
        "replicationMode": "full"
      },
      "result": {
        "status": "COMPLETE",
        "description": "Replication completed successfully"
      },
      "size": {
        "total": 1073741824,
        "replicated": 1073741824
      },
      "count": {
        "total": 150,
        "replicated": 150
      },
      "time": {
        "start": "2026-03-20 02:00:00",
        "end": "2026-03-20 02:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Replication history list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 히스토리 ID |
| `system.name` | string | 대상 센터 이름 |
| `job.name` | string | 복제 작업 이름 |
| `job.id` | number | 복제 작업 ID |
| `job.sourcePath` | string | 소스 경로 |
| `job.targetPath` | string | 타겟 경로 |
| `job.unitType` | string | 복제 단위 유형 |
| `job.replicationMode` | string | 복제 모드 |
| `result.status` | string | 작업 결과 상태 |
| `result.description` | string | 작업 결과 설명 |
| `size.total` | number | 전체 크기 (bytes) |
| `size.replicated` | number | 복제 완료 크기 (bytes) |
| `count.total` | number | 전체 파일 수 |
| `count.replicated` | number | 복제 완료 파일 수 |
| `time.start` | string | 작업 시작 시간 |
| `time.end` | string | 작업 종료 시간 |
| `time.elapsed` | string | 경과 시간 |
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Token has expired.",
  "timestamp": "2026-03-20 10:30:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Invalid enum value. Expected 'success' | 'failed', received 'unknown'",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
