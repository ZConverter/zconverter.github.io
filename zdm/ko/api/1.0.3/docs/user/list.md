---
layout: docs
title: GET /users
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

등록된 전체 사용자 목록을 조회합니다.

---

## `GET /users` {#get-users}

> * 시스템에 등록된 모든 사용자 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 사용자만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/users</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 사용자 목록 조회
curl -X GET "https://api.example.com/api/users" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/users?company=Acme&country=KR" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/users?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `userName` | Query | string | Optional | - | 사용자 이름 필터 | - |
| `position` | Query | string | Optional | - | 직책 필터 | - |
| `company` | Query | string | Optional | - | 회사 필터 | - |
| `country` | Query | string | Optional | - | 국가 필터 | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

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
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

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
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "User information list",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

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
| `pagination.currentPage` | number | 현재 페이지 번호 (page/limit 사용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (page/limit 사용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (page/limit 사용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (page/limit 사용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (page/limit 사용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (page/limit 사용 시) |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "토큰이 만료되었습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
