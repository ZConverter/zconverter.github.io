---
layout: docs
title: GET /backups/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 백업 작업 정보를 조회합니다.

---

## `GET /backups/:identifier` {#get-backup}

> * 특정 백업 작업 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/backups/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 조회
curl -X GET "https://api.example.com/api/v1/backups/daily-backup-web" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/backups/1?detail=true&history=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 작업 ID 또는 작업명 | - |
| `mode` | Query | string | Optional | - | 백업 모드 필터 | `full`, `incremental` |
| `partition` | Query | string | Optional | - | 파티션 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | `run`, `complete`, `waiting`, `cancel` |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | - |
| `history` | Query | boolean | Optional | `false` | 히스토리 포함 | - |
| `logs` | Query | boolean | Optional | `false` | 로그 포함 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-backup-detail",
  "data": {
    "system": {
      "id": "SRV-001",
      "name": "web-server-01",
      "os": "Ubuntu 20.04"
    },
    "job": {
      "info": {
        "id": "JOB-001",
        "name": "daily-backup-web",
        "mode": "full",
        "partition": "/dev/sda1",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "status": {
          "current": "completed",
          "time": {
            "start": "2024-01-31T02:00:00.000Z",
            "elapsed": "45m 30s",
            "end": "2024-01-31T02:45:30.000Z"
          }
        }
      },
      "lastUpdated": "2024-01-31T02:45:30.000Z"
    },
    "repository": {
      "id": "REPO-001",
      "type": "local",
      "path": "/backup/storage"
    }
  },
  "message": "백업 작업 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
