---
layout: docs
title: GET /servers/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 서버 정보를 조회합니다.

---

## `GET /servers/:identifier` {#get-server}

> * 특정 서버 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/servers/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/servers/1" \
  -H "Authorization: Bearer <token>"

# 서버명으로 조회
curl -X GET "https://api.example.com/api/v1/servers/web-server-01" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/servers/1?detail=true&network=true&disk=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID 또는 서버명 | - |
| `mode` | Query | string | Optional | - | 시스템 모드 | `source`, `target` |
| `os` | Query | string | Optional | - | 운영체제 타입 | `linux`, `windows` |
| `connection` | Query | string | Optional | - | 연결 상태 | `online`, `offline` |
| `license` | Query | string | Optional | - | 라이선스 할당 상태 | - |
| `network` | Query | boolean | Optional | - | 네트워크 정보 포함 여부 | - |
| `disk` | Query | boolean | Optional | - | 디스크 정보 포함 여부 | - |
| `partition` | Query | boolean | Optional | - | 파티션 정보 포함 여부 | - |
| `repository` | Query | boolean | Optional | - | 리포지토리 정보 포함 여부 | - |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-server-detail",
  "data": {
    "id": "1",
    "name": "web-server-01",
    "agent": {
      "mode": "source",
      "version": "1.0.0"
    },
    "os": {
      "version": "Ubuntu 20.04"
    },
    "ip": {
      "public": "192.168.1.100",
      "private": ["10.0.0.100"]
    },
    "license": {
      "id": "LICENSE-001"
    },
    "status": {
      "connect": "online"
    },
    "lastUpdated": "2024-01-31T10:30:45.123Z"
  },
  "message": "서버 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
