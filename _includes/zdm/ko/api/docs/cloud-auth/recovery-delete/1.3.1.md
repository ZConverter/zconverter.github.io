
Recovery 클라우드 인증 정보를 삭제합니다.

---

## `DELETE /cloud-auth/recovery/:identifier` {#delete-cloud-auth-recovery}

> * ID(숫자)로 삭제합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/cloud-auth/recovery/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X DELETE "https://api.example.com/api/cloud-auth/recovery/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | number | Required | 삭제할 인증 정보 ID |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "id": 1,
    "displayName": "AWS_RECOVERY_1712345678901"
  },
  "message": "Cloud Auth Recovery deleted",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
