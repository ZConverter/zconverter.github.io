
OS 복제 작업을 삭제합니다.

---

## `DELETE /os-replications/:identifier` {#delete-os-replications}

> * 관련 데이터(작업 정보, 히스토리, 로그 이벤트)도 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/os-replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X DELETE "https://api.example.com/api/os-replications/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | 작업 ID(숫자) 또는 작업 이름 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "deletedJob": { "id": 1, "name": "os_repl_upload_1712345678901" },
    "deletedRelations": { "replicationInfo": 1, "history": 5, "logEvent": 12 }
  },
  "message": "Os Replication deleted",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
