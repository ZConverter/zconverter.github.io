---
layout: docs
title: POST /auth/issue
section_title: ZDM API Documentation
navigation: api
---

토큰을 발급합니다.

---

## `POST /auth/issue` {#token-issue}

> * 토큰을 발급합니다.

모든 보호된 엔드포인트는 토큰이 필요합니다:

```text
Authorization: Bearer <token>
```

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/auth/issue</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X POST "https://api.example.com/api/v1/auth/issue" \
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
| `email` | Body | string | Required | - | 사용자 이메일 | - |
| `password` | Body | string | Required | - | 사용자 비밀번호 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-123",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expiresAt": "2024-12-31T23:59:59.000Z"
  },
  "message": "토큰이 성공적으로 발급되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
