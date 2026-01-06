---
layout: docs
title: GET /servers/partitions
section_title: ZDM API Documentation
navigation: api
---

모든 서버의 파티션 정보를 조회합니다.

---

## `GET /servers/partitions` {#get-partitions}

> * 모든 서버의 파티션 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/servers/partitions</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 파티션 목록 조회
curl -X GET "https://api.example.com/api/v1/servers/partitions" \
  -H "Authorization: Bearer <token>"

# 서버명 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/servers/partitions?serverName=web-server-01" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/servers/partitions?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `serverName` | Query | string | Optional | - | 서버명 필터 | - |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-all-partitions",
  "data": [
    {
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
          "available": "55GB"
        }
      ]
    },
    {
      "server": {
        "id": "2",
        "name": "db-server-01"
      },
      "partitions": [
        {
          "device": "/dev/sda1",
          "mountPoint": "/",
          "fileSystem": "xfs",
          "size": "500GB",
          "used": "200GB",
          "available": "300GB"
        }
      ]
    }
  ],
  "message": "전체 서버 파티션 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
