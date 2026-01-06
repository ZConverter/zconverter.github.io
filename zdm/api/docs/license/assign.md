---
layout: docs
title: PUT /licenses/assign
section_title: ZDM API Documentation
navigation: api
---

라이선스를 서버에 할당합니다.

---

## `PUT /licenses/assign` {#assign-license}

> * 라이선스를 서버에 할당합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/licenses/assign</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X PUT "https://api.example.com/api/v1/licenses/assign" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "licenseKey": "ZDME-2024-ABCD-1234-EFGH",
    "serverId": "web-server-01"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `licenseKey` | Body | string | Required | - | 라이선스 키 | - |
| `serverId` | Body | string | Required | - | 서버 ID 또는 서버명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-assign",
  "data": {
    "license": {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise"
    },
    "server": {
      "id": "1",
      "name": "web-server-01"
    },
    "assignment": {
      "assignedAt": "2024-01-31T10:30:45.123Z",
      "status": "active"
    },
    "usage": {
      "total": 100,
      "used": 76,
      "available": 24,
      "percentage": "76%"
    }
  },
  "message": "라이선스가 성공적으로 할당되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
