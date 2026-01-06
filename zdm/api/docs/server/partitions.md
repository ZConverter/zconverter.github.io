---
layout: docs
title: GET /servers/:identifier/partitions
section_title: ZDM API Documentation
navigation: api
---

특정 서버의 파티션 정보를 조회합니다.

---

## `GET /servers/:identifier/partitions` {#get-server-partitions}

> * 특정 서버의 파티션 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/servers/:identifier/partitions</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/servers/1/partitions" \
  -H "Authorization: Bearer <token>"

# 서버명으로 조회
curl -X GET "https://api.example.com/api/v1/servers/web-server-01/partitions" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/servers/1/partitions?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID 또는 서버명 | - |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-server-partitions",
  "data": {
    "server": {
      "id": "1",
      "name": "web-server-01"
    },
    "partitions": [
      {
        "device": "/dev/sda1",
        "mountPoint": "/",
        "fileSystem": "ext4",
        "size": "100GB",
        "used": "45GB",
        "available": "55GB",
        "usedPercent": "45%"
      },
      {
        "device": "/dev/sda2",
        "mountPoint": "/home",
        "fileSystem": "ext4",
        "size": "200GB",
        "used": "80GB",
        "available": "120GB",
        "usedPercent": "40%"
      }
    ]
  },
  "message": "서버 파티션 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
