---
layout: docs
title: PUT /users/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 사용자의 정보를 업데이트합니다.

---

## `PUT /users/:identifier` {#put-users-identifier}

> * 사용자 ID 또는 이메일로 특정 사용자의 정보를 업데이트합니다.
> * 최소 하나 이상의 필드가 요청 본문에 포함되어야 합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/users/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 사용자 ID로 업데이트
curl -X PUT "https://api.example.com/api/v1/users/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "김철수",
    "company": "New Company",
    "position": "Director"
  }'

# 이메일로 업데이트
curl -X PUT "https://api.example.com/api/v1/users/user@example.com" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "010-1234-5678",
    "timezone": "Asia/Seoul"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 사용자 ID (숫자) 또는 이메일 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `username` | string | Optional | 사용자 이름 (최소 2자) |
| `password` | string | Optional | 비밀번호 (최소 4자) |
| `company` | string | Optional | 회사명 |
| `company_addr` | string | Optional | 회사 주소 |
| `company_size` | string | Optional | 회사 규모 |
| `organization` | string | Optional | 조직명 |
| `phone` | string | Optional | 전화번호 |
| `position` | string | Optional | 직책 |
| `country` | string | Optional | 국가 |
| `timezone` | string | Optional | 타임존 |
| `language` | string | Optional | 언어 |
| `email_notice` | string | Optional | 이메일 알림 설정 |

```json
{
  "username": "김철수",
  "company": "New Company",
  "position": "Director",
  "phone": "010-1234-5678"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "userInfo": {
      "id": "1",
      "email": "user@example.com"
    },
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "사용자 이름",
          "previous": "홍길동",
          "new": "김철수"
        },
        {
          "field": "회사명",
          "previous": "Old Company",
          "new": "New Company"
        }
      ]
    }
  },
  "message": "User information updated successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `userInfo.id` | string | 사용자 ID |
| `userInfo.email` | string | 사용자 이메일 |
| `summary.state` | string | 업데이트 결과 (`success` / `fail`) |
| `summary.updatedFields` | array | 변경된 필드 목록 |
| `summary.updatedFields[].field` | string | 변경된 필드 한글명 |
| `summary.updatedFields[].previous` | any | 변경 전 값 |
| `summary.updatedFields[].new` | any | 변경 후 값 |

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
    "message": "ID가 '999'인 User를 찾을 수 없습니다"
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
    "message": "username은 최소 2자 이상이어야 합니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
