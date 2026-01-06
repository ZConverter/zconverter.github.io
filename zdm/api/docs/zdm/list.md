---
layout: docs
title: GET /zdms
section_title: ZDM API Documentation
navigation: api
---

ZDM 센터 목록을 조회합니다.

---

## `GET /zdms` {#get-zdms}

> * ZDM 센터 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 ZDM 센터 목록 조회
curl -X GET "https://api.example.com/api/v1/zdms" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/zdms?connection=online&activation=active" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/zdms?detail=true&repository=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `connection` | Query | string | Optional | - | 연결 상태 필터 | `online`, `offline` |
| `activation` | Query | string | Optional | - | 활성화 상태 필터 | `active`, `inactive` |
| `network` | Query | boolean | Optional | - | 네트워크 정보 포함 여부 | - |
| `disk` | Query | boolean | Optional | - | 디스크 정보 포함 여부 | - |
| `partition` | Query | boolean | Optional | - | 파티션 정보 포함 여부 | - |
| `repository` | Query | boolean | Optional | - | 리포지토리 정보 포함 여부 | - |
| `zosRepository` | Query | boolean | Optional | - | zOS 리포지토리 정보 포함 여부 | - |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-zdm-list",
  "data": [
    {
      "name": {
        "center": "Main-ZDM-Center",
        "host": "zdm-center-01"
      },
      "id": {
        "center": "ZDM-001",
        "install": "INSTALL-2024-001"
      },
      "os": {
        "version": "Windows Server 2019"
      },
      "ip": {
        "public": "192.168.1.10",
        "private": ["10.0.0.10", "172.16.0.10"]
      },
      "status": {
        "connect": "online",
        "activate": "active"
      },
      "path": {
        "logFile": "C:\\ZDM\\logs\\zdm.log",
        "install": "C:\\ZDM"
      },
      "disk": [],
      "partition": [],
      "drive": [],
      "network": [],
      "repository": [],
      "zosRepository": [],
      "lastUpdated": "2024-01-31T10:30:45.123Z"
    }
  ],
  "message": "ZDM 센터 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
