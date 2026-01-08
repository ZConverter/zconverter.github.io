---
layout: docs
title: GET /users
section_title: ZDM API Documentation
navigation: api-0.2.0
---

등록된 전체 사용자 목록을 조회합니다.

---

## `GET /users` {#get-users}

> * 시스템에 등록된 모든 사용자 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 사용자만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/users</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 사용자 목록 조회
curl -X GET "https://api.example.com/api/v1/users" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/users?company=Acme&country=KR" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `user_name` | Query | string | Optional | - | 사용자 이름 필터 | - |
| `position` | Query | string | Optional | - | 직책 필터 | - |
| `company` | Query | string | Optional | - | 회사 필터 | - |
| `country` | Query | string | Optional | - | 국가 필터 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "Acme Corp",
      "country": "KR",
      "position": "Manager"
    }
  ],
  "message": "User information list",
  "timestamp": "2025-01-15T10:30:00Z"
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

---
