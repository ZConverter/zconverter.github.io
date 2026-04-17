
특정 복제 작업을 삭제합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `DELETE /replications/:identifier` {#delete-replications-identifier}

> * 복제 ID 또는 작업 이름으로 특정 복제 작업을 삭제합니다.
> * 삭제 시 관련된 모든 데이터(복제 정보, 히스토리, 로그)가 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복제 ID로 삭제
curl -X DELETE "https://api.example.com/api/replications/1" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 삭제
curl -X DELETE "https://api.example.com/api/replications/backup-replication-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복제 작업 ID (숫자) 또는 작업 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "deletedJob": {
      "id": 1,
      "name": "backup-replication-01"
    },
    "deletedRelations": {
      "replicationInfo": 1,
      "history": 5,
      "logEvent": 12
    }
  },
  "message": "Replication job deleted",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `deletedJob.id` | number | 삭제된 작업 ID |
| `deletedJob.name` | string | 삭제된 작업 이름 |
| `deletedRelations.replicationInfo` | number | 삭제된 복제 정보 수 |
| `deletedRelations.history` | number | 삭제된 히스토리 수 |
| `deletedRelations.logEvent` | number | 삭제된 로그 이벤트 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복제 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Replication을 찾을 수 없습니다",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
