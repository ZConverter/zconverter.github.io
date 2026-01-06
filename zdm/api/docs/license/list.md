---
layout: docs
title: GET /licenses
section_title: ZDM API Documentation
navigation: api
---

라이선스 목록을 조회합니다.

---

## `GET /licenses` {#get-licenses}

> * 라이선스 목록을 조회합니다.

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

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/licenses?category=enterprise&status=active" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | - |
| `exp` | Query | string | Optional | - | 만료일 필터 (YYYY-MM-DD) | - |
| `created` | Query | string | Optional | - | 생성일 필터 (YYYY-MM-DD) | - |
| `status` | Query | string | Optional | - | 상태 필터 | `active`, `expired`, `expiring` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-list",
  "data": [
    {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise",
      "copies": {
        "total": 100,
        "used": 75,
        "available": 25,
        "usage": "75%"
      },
      "description": "Enterprise backup solution license",
      "dates": {
        "created": "2024-01-01T00:00:00.000Z",
        "expires": "2024-12-31T23:59:59.000Z",
        "daysRemaining": 334
      }
    }
  ],
  "message": "라이선스 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
