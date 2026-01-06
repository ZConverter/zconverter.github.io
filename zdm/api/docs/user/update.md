---
layout: docs
title: PUT /users/:identifier
section_title: ZDM API Documentation
navigation: api
---

사용자 정보를 업데이트합니다.

---

## `PUT /users/:identifier` {#update-user}

> * 사용자 정보를 업데이트합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/users/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 사용자 정보 업데이트
curl -X PUT "https://api.example.com/api/v1/users/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "position": "Senior Developer"
  }'

# 이메일로 사용자 정보 업데이트
curl -X PUT "https://api.example.com/api/v1/users/user@example.com" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "userName": "홍길동",
    "company": "ZDM Corp",
    "country": "KR"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 사용자 ID 또는 이메일 | - |
| `userName` | Body | string | Optional | - | 사용자명 | - |
| `password` | Body | string | Optional | - | 비밀번호 | - |
| `pwData` | Body | string | Optional | - | 비밀번호 데이터 | - |
| `position` | Body | string | Optional | - | 직책 | - |
| `company` | Body | string | Optional | - | 회사명 | - |
| `country` | Body | string | Optional | - | 국가 코드 (2자리, 예: KR, US) | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-user-update",
  "data": {
    "userInfo": {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "Senior Developer"
    },
    "summary": {
      "state": "success",
      "message": "사용자 정보가 성공적으로 업데이트되었습니다",
      "updatedFieldsCount": 1,
      "updatedFields": [
        {
          "field": "직책",
          "previous": "개발자",
          "new": "Senior Developer"
        }
      ]
    }
  },
  "message": "사용자 정보가 성공적으로 업데이트되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
