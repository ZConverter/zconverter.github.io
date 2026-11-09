
ZOS 클라우드 인증 정보를 삭제합니다.

---

## `DELETE /cloud-auth/zos/:identifier` {#delete-cloud-auth-zos}

> * ID(숫자) 또는 파일명(문자열)으로 삭제할 수 있습니다.
> * `center` 는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 주면 400이고, `?center=` 처럼 키만 보내고 값이 비어도 400입니다. 파라미터를 **생략**하는 것은 종전대로 허용됩니다.

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
| `center` | Query | string | Optional | 센터 ID 또는 이름 — **정확히 1개만** 허용(여러 개·빈 값은 400). 지정 시 대상 레코드가 해당 center 소속인지 검증(불일치 시 `CENTER-ERROR-01`/403) |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": {
    "id": 1,
    "displayName": "OCI_1712345678901",
    "fileName": "config.conf"
  },
  "message": "Cloud Auth ZOS deleted",
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**`center` 다중 지정 / 빈 값 (400 Bad Request)**

삭제는 대상이 모호하면 안 되므로 `center` 는 정확히 1개만 허용합니다. 콤마로 여러 개를 주거나 `?center=` 처럼 값이 비면 반환됩니다. 이전에도 같은 규칙이었으나 검증 위치가 서비스 계층에서 요청 스키마로 옮겨져 에러 형식이 `DTO-VALIDATION-03` 으로 바뀌었습니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["exactly one center must be specified"]
    }
  },
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>
