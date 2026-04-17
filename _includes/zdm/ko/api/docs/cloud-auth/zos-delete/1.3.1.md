
ZOS 클라우드 인증 정보를 삭제합니다.

---

## `DELETE /cloud-auth/zos/:identifier` {#delete-cloud-auth-zos}

> * ID(숫자) 또는 파일명(문자열)으로 삭제할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/cloud-auth/zos/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 삭제
curl -X DELETE "https://api.example.com/api/cloud-auth/zos/1" \
  -H "Authorization: Bearer <token>"

# 파일명으로 삭제
curl -X DELETE "https://api.example.com/api/cloud-auth/zos/config.conf" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | ID(숫자) 또는 파일명 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "id": 1,
    "displayName": "OCI_1712345678901",
    "fileName": "config.conf"
  },
  "message": "Cloud Auth ZOS deleted",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
