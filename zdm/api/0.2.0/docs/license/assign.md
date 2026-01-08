---
layout: docs
title: PUT /licenses/assign
section_title: ZDM API Documentation
navigation: api-0.2.0
---

라이선스를 서버에 할당합니다.

---

## `PUT /licenses/assign` {#put-licenses-assign}

> * 특정 서버에 라이선스를 할당합니다.
> * 서버와 라이선스는 ID 또는 이름으로 지정할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/licenses/assign</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 할당
curl -X PUT "https://api.example.com/api/v1/licenses/assign" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "server": "1",
    "license": "5"
  }'

# 이름으로 할당
curl -X PUT "https://api.example.com/api/v1/licenses/assign" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "server": "server-01",
    "license": "Enterprise-License",
    "user": 1
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `server` | string | Required | 서버 ID (숫자) 또는 서버 이름 |
| `license` | string | Required | 라이선스 ID (숫자) 또는 라이선스 이름 |
| `user` | number | Optional | 할당 요청 사용자 ID |

```json
{
  "server": "server-01",
  "license": "Enterprise-License",
  "user": 1
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
    "server": {
      "id": "1",
      "name": "server-01"
    },
    "license": {
      "id": "5",
      "name": "Enterprise-License",
      "category": "zdm(backup)",
      "created": "2025-01-01",
      "expiration": "2026-01-01"
    }
  },
  "message": "License assigned successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `server.id` | string | 서버 ID |
| `server.name` | string | 서버 이름 |
| `license.id` | string | 라이선스 ID |
| `license.name` | string | 라이선스 이름 |
| `license.category` | string | 라이선스 카테고리 |
| `license.created` | string | 라이선스 생성일 |
| `license.expiration` | string | 라이선스 만료일 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**서버를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "SERVER_NOT_FOUND",
    "message": "ID가 '999'인 Server를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**라이선스를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "LICENSE_NOT_FOUND",
    "message": "ID가 '999'인 License를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
