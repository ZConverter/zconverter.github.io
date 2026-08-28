
OS 복제 히스토리를 단건 조회합니다.

---

## `GET /os-replications/histories/:identifier` {#get-os-replications-histories-identifier}

> * ID(숫자): 히스토리 단건 조회
> * 작업 이름(문자열): 해당 작업의 히스토리 목록 조회

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/histories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/histories/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | 히스토리 ID(숫자) 또는 작업 이름 |

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
    "system": {
      "name": "server-01"
    },
    "job": {
      "name": "os_repl_upload_server-01",
      "id": 10,
      "sourcePath": "/source",
      "targetPath": "/target",
      "unitType": "Upload"
    },
    "result": {
      "status": "COMPLETE",
      "description": "OS replication completed successfully"
    },
    "size": {
      "total": 0,
      "replicated": 0
    },
    "count": {
      "total": 0,
      "replicated": 0
    },
    "time": {
      "start": "2025-01-15 10:00:00",
      "end": "2025-01-15 10:30:00",
      "elapsed": "00:30:00"
    }
  },
  "message": "OS Replication history retrieved",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

> `size` 와 `count` 는 현재 항상 `0` 을 반환합니다. (replication 히스토리와 달리 `replicationMode` 필드는 없습니다.)

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 히스토리 ID |
| `system.name` | string | 시스템(서버) 이름 |
| `job.name` | string | 작업 이름 |
| `job.id` | number | 작업 ID |
| `job.sourcePath` | string | 소스 경로 |
| `job.targetPath` | string | 타겟 경로 |
| `job.unitType` | string | 작업 단위 타입 (Upload / Download 등) |
| `result.status` | string | 작업 상태 |
| `result.description` | string | 작업 설명 |
| `size.total` | number | 전체 크기 (현재 항상 `0`) |
| `size.replicated` | number | 복제된 크기 (현재 항상 `0`) |
| `count.total` | number | 전체 개수 (현재 항상 `0`) |
| `count.replicated` | number | 복제된 개수 (현재 항상 `0`) |
| `time.start` | string | 시작 시간 |
| `time.end` | string | 종료 시간 |
| `time.elapsed` | string | 소요 시간 |

</details>

---
