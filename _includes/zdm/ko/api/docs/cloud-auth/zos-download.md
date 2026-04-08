
ZOS 인증 키 파일을 다운로드합니다.

---

## `GET /cloud-auth/zos/download/:fileName` {#get-cloud-auth-zos-download}

> * 업로드된 인증 키 파일을 다운로드합니다.
> * 요청한 사용자의 이메일 기준 경로에서 파일을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/cloud-auth/zos/download/:fileName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/cloud-auth/zos/download/config.conf" \
  -H "Authorization: Bearer <token>" \
  -o config.conf
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `fileName` | Path | string | Required | 다운로드할 파일명 |

</details>

<details markdown="1" open>
<summary><strong>응답</strong></summary>

> 파일 바이너리가 `Content-Disposition: attachment` 헤더와 함께 반환됩니다.

</details>
