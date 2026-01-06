---
layout: docs
title: POST /licenses
section_title: ZDM API Documentation
navigation: api
---

새 라이선스를 등록합니다.

---

## `POST /licenses` {#create-license}

> * 새 라이선스를 등록합니다.

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
    "name": "ZDM Enterprise License",
    "licenseKey": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": 100,
    "expirationDate": "2024-12-31",
    "description": "Enterprise backup solution license"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `name` | Body | string | Required | - | 라이선스명 | - |
| `licenseKey` | Body | string | Required | - | 라이선스 키 | - |
| `category` | Body | string | Required | - | 라이선스 카테고리 | - |
| `copies` | Body | number | Required | - | 총 라이선스 수 | - |
| `expirationDate` | Body | string | Required | - | 만료일 (YYYY-MM-DD) | - |
| `description` | Body | string | Optional | - | 설명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-register",
  "data": {
    "id": "2",
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": {
      "total": 100,
      "used": 0,
      "available": 100,
      "usage": "0%"
    },
    "description": "Enterprise backup solution license",
    "dates": {
      "created": "2024-01-31T10:30:45.123Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "라이선스가 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
