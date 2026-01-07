---
layout: docs
title: GET /licenses
section_title: ZDM API Documentation
navigation: api
---

등록된 전체 라이선스 목록을 조회합니다.

---

## `GET /licenses` {#get-licenses}

> * 시스템에 등록된 모든 라이선스 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 라이선스만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/licenses</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 라이선스 목록 조회
curl -X GET "https://api.example.com/api/v1/licenses" \
  -H "Authorization: Bearer <token>"

# 카테고리별 조회
curl -X GET "https://api.example.com/api/v1/licenses?category=zdm(backup)" \
  -H "Authorization: Bearer <token>"

# 만료일 기준 조회
curl -X GET "https://api.example.com/api/v1/licenses?exp=2025-12-31" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | {% include zdm/license-categories.md %} |
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
  "data": [
    {
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
    }
  ],
  "message": "License information list",
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

---
