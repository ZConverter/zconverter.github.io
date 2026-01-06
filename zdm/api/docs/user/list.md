---
layout: docs
title: GET /users
section_title: ZDM API Documentation
navigation: api
---

사용자 목록을 조회합니다.

---

## `GET /users` {#get-users}

> * 사용자 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/users</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 목록 조회
curl -X GET "https://api.example.com/api/v1/users" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/users?company=ZDM%20Corp&country=KR" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `userName` | Query | string | Optional | - | 사용자명 필터 | - |
| `position` | Query | string | Optional | - | 직책 필터 | - |
| `company` | Query | string | Optional | - | 회사명 필터 | - |
| `country` | Query | string | Optional | - | 국가 필터 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-456",
  "data": [
    {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "개발자"
    }
  ],
  "message": "사용자 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
