---
layout: docs
title: GET /licenses/:identifier
section_title: ZDM API Documentation
navigation: api-1.0.3
---

특정 라이선스의 상세 정보를 조회합니다.

---

## `GET /licenses/:identifier` {#get-licenses-identifier}

> * 라이선스 ID 또는 라이선스 이름으로 특정 라이선스의 정보를 조회합니다.
> * identifier가 숫자인 경우 라이선스 ID로, 그 외에는 라이선스 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/licenses/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 라이선스 ID로 조회
curl -X GET "https://api.example.com/api/v1/licenses/1" \
  -H "Authorization: Bearer <token>"

# 라이선스 이름으로 조회
curl -X GET "https://api.example.com/api/v1/licenses/Enterprise-License" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 라이선스 ID (숫자) 또는 라이선스 이름 | - |
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | `zdm(backup)`, `zdm(dr)`, `zdm(migration)` |
| `exp` | Query | string | Optional | - | 만료일 필터 (YYYY-MM-DD) | - |
| `created` | Query | string | Optional | - | 생성일 필터 (YYYY-MM-DD) | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

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
      "used": 25,
      "available": 75,
      "usage": 25
    },
    "description": "Enterprise backup license",
    "dates": {
      "created": "2025-01-01",
      "expires": "2026-01-01",
      "daysRemaining": 365
    }
  },
  "message": "License information retrieved",
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
| `copies.usage` | number | 사용률 (0-100) |
| `description` | string | 라이선스 설명 |
| `dates.created` | string | 생성일 |
| `dates.expires` | string | 만료일 |
| `dates.daysRemaining` | number | 만료까지 남은 일수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

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

## `GET /licenses/key/:key` {#get-licenses-key}

> * 라이선스 키로 특정 라이선스의 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/licenses/key/:key</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/v1/licenses/key/XXXX-XXXX-XXXX-XXXX" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `key` | Path | string | Required | - | 라이선스 키 | - |
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | `zdm(backup)`, `zdm(dr)`, `zdm(migration)` |
| `exp` | Query | string | Optional | - | 만료일 필터 (YYYY-MM-DD) | - |
| `created` | Query | string | Optional | - | 생성일 필터 (YYYY-MM-DD) | - |

</details>

---
