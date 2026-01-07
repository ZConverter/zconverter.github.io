---
layout: docs
title: POST /auth/issue
section_title: ZDM API Documentation
navigation: api
---

사용자 인증 후 JWT 토큰을 발급합니다.

---

## `POST /auth/issue` {#post-auth-issue}

> * 사용자 이메일과 비밀번호를 검증하여 JWT 토큰을 발급합니다.
> * 기존 토큰이 있으면 업데이트, 없으면 새로 생성합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/auth/issue</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 토큰 발급 요청
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
    "expiresAt": "2025-01-16T10:30:00Z"
  },
  "message": "Token issued successfully.",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `token` | string | 발급된 JWT 토큰 |
| `expiresAt` | string | 토큰 만료 시간 (ISO 8601 형식) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**사용자를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "등록되지 않은 사용자이거나 비밀번호가 일치하지 않습니다."
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "유효한 이메일 형식이 아닙니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**타임아웃 (408 Request Timeout)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "TIMEOUT_ERROR",
    "message": "사용자 조회 시간이 초과되었습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
