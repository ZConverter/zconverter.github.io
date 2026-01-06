---
layout: docs
title: GET /licenses/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 라이선스 정보를 조회합니다.

---

## `GET /licenses/:identifier` {#get-license}

> * 특정 라이선스 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/licenses/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/licenses/1" \
  -H "Authorization: Bearer <token>"

# 라이선스명으로 조회
curl -X GET "https://api.example.com/api/v1/licenses/ZDM%20Enterprise%20License" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 라이선스 ID 또는 이름 | - |
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
  "requestID": "req-license-detail",
  "data": {
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
    },
    "assignedServers": [
      {
        "serverId": "SRV-001",
        "serverName": "web-server-01",
        "assignedAt": "2024-01-15T10:00:00.000Z"
      }
    ]
  },
  "message": "라이선스 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
