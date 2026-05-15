
사용자 인증 후 JWT 토큰을 발급합니다.

---

## `POST /token/issue` {#post-token-issue}

> * 사용자 이메일과 비밀번호를 검증하여 JWT 토큰을 발급합니다.
> * 기존 토큰이 있으면 업데이트, 없으면 새로 생성합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/token/issue</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 토큰 발급 요청
curl -X POST "https://api.example.com/api/token/issue" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "your_password"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `email` | Body | string | Required | - | 사용자 이메일 주소 (유효한 이메일 형식) | - |
| `password` | Body | string | Required | - | 사용자 비밀번호 (평문 또는 해싱된 값) | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

```json
{
  "email": "user@example.com",
  "password": "your_password"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresAt": "2026-01-17 16:14:09"
  },
  "message": "Token issued successfully.",
  "timestamp": "2026-01-17 15:14:09"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `token` | string | 발급된 JWT 토큰 |
| `expiresAt` | string | 토큰 만료 시간 (YYYY-MM-DD HH:mm:ss 형식) |

</details>

<details markdown="1" open>
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 메시지 | 발생 상황 |
|------|------|--------|-----------|
| `DTO-VALIDATION-01` | 422 | Request body validation failed. | email/password 누락 또는 이메일 형식 오류 |
| `USER-ERROR-01` | 404 | User not found. | 등록되지 않은 이메일이거나 비밀번호 불일치 (보안상 동일 코드로 응답) |
| `DTO-CREATION-01` | 500 | DTO creation error. | 응답 DTO 변환 실패 (내부 오류) |
| `INTERNAL_SERVER_ERROR` | 500 | Internal server error. | 사용자 조회 / 토큰 저장 timeout, DB 트랜잭션 실패 등 예외 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**사용자 인증 실패 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "User not found.",
  "timestamp": "2026-01-17 15:14:09"
}
```

**유효성 검사 실패 (422 Unprocessable Entity)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed.",
  "detail": {
    "validationErrors": {
      "email": ["invalid email format"]
    }
  },
  "timestamp": "2026-01-17 15:14:09"
}
```

**서버 내부 오류 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "[Token creation] - An unexpected error occurred during token creation",
  "timestamp": "2026-01-17 15:14:09"
}
```

</details>

---
