
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
| `center` | Query | string | Optional | 센터 ID/이름. 지정 시 작업의 센터 소속과 일치하지 않으면 `CENTER_MISMATCH`(403) |

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

<details markdown="1" open>
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `NOT_FOUND` | 404 | 작업 / center 미존재 |
| `CENTER-ERROR-01` | 403 | 작업의 center 소속과 요청 center 불일치 |
| `INTERNAL_SERVER_ERROR` | 500 | 트랜잭션 실패 등 내부 오류 |

</details>
