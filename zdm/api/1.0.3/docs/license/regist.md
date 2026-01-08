---
layout: docs
title: POST /licenses
section_title: ZDM API Documentation
navigation: api-1.0.3
---

새로운 라이선스를 등록합니다.

---

## `POST /licenses` {#post-licenses}

> * 새로운 라이선스를 시스템에 등록합니다.
> * 라이선스 키를 파싱하여 관련 정보를 자동으로 추출합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/licenses</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X POST "https://api.example.com/api/v1/licenses" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "key": "XXXX-XXXX-XXXX-XXXX",
    "name": "Enterprise License",
    "description": "Enterprise backup license"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 |
| `key` | string | Required | 라이선스 키 |
| `user` | string | Optional | 라이선스 사용자 |
| `name` | string | Optional | 라이선스 이름 |
| `description` | string | Optional | 라이선스 설명 |

```json
{
  "center": "1",
  "key": "XXXX-XXXX-XXXX-XXXX",
  "name": "Enterprise License",
  "description": "Enterprise backup license"
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
    "name": "Enterprise License",
    "key": "XXXX-XXXX-XXXX-XXXX",
    "category": "zdm(backup)",
    "copies": {
      "total": 100,
      "used": 0,
      "available": 100,
      "usage": "0%"
    },
    "description": "Enterprise backup license",
    "dates": {
      "created": "2025-01-15",
      "expires": "2026-01-15",
      "daysRemaining": 365
    }
  },
  "message": "License registered successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `name` | string | 라이선스 이름 |
| `key` | string | 라이선스 키 |
| `category` | string | 라이선스 카테고리 |
| `copies.total` | number | 총 카피 수 |
| `copies.used` | number | 사용 중인 카피 수 |
| `copies.available` | number | 사용 가능한 카피 수 |
| `copies.usage` | string | 사용률 (예: "0%", "25%") |
| `description` | string | 라이선스 설명 |
| `dates.created` | string | 생성일 |
| `dates.expires` | string | 만료일 |
| `dates.daysRemaining` | number | 만료까지 남은 일수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "key가 누락되었습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**중복 라이선스 키 (409 Conflict)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "LICENSE_ALREADY_EXISTS",
    "message": "이미 등록된 라이선스 키입니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
