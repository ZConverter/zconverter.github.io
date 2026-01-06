---
layout: docs
title: GET /licenses/key/:key
section_title: ZDM API Documentation
navigation: api
---

키로 라이선스 정보를 조회합니다.

---

## `GET /licenses/key/:key` {#get-license-by-key}

> * 키로 라이선스 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/licenses/key/:key</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/v1/licenses/key/ZDME-2024-ABCD-1234-EFGH" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `key` | Path | string | Required | - | 라이선스 키 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-by-key",
  "data": {
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "isValid": true,
    "status": "active",
    "copies": {
      "total": 100,
      "used": 75,
      "available": 25,
      "usage": "75%"
    },
    "dates": {
      "created": "2024-01-01T00:00:00.000Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "라이선스 키 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
