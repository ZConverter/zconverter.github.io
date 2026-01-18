---
layout: docs
title: GET /users/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 사용자의 상세 정보를 조회합니다.

---

## `GET /users/:identifier` {#get-users-identifier}

> * 사용자 ID 또는 이메일로 특정 사용자의 정보를 조회합니다.
> * identifier가 숫자인 경우 사용자 ID로, 그 외에는 이메일로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/users/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 사용자 ID로 조회
curl -X GET "https://api.example.com/api/users/1" \
  -H "Authorization: Bearer <token>"

# 이메일로 조회
curl -X GET "https://api.example.com/api/users/user@example.com" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 사용자 ID (숫자) 또는 이메일 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "id": "1",
    "email": "user@example.com",
    "userName": "홍길동",
    "company": "Acme Corp",
    "country": "KR",
    "position": "Manager"
  },
  "message": "User information retrieved",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | string | 사용자 ID |
| `email` | string | 사용자 이메일 |
| `userName` | string | 사용자 이름 |
| `company` | string | 회사명 |
| `country` | string | 국가 |
| `position` | string | 직책 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**사용자를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 User를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
