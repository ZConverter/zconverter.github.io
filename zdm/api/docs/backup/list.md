---
layout: docs
title: GET /backups
section_title: ZDM API Documentation
navigation: api
---

백업 작업 목록을 조회합니다.

---

## `GET /backups` {#get-backups}

> * 백업 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 백업 작업 목록 조회
curl -X GET "https://api.example.com/api/v1/backups" \
  -H "Authorization: Bearer <token>"

# 필터링 조회
curl -X GET "https://api.example.com/api/v1/backups?mode=full&status=completed&detail=true" \
  -H "Authorization: Bearer <token>"

# 특정 서버의 백업 작업 조회
curl -X GET "https://api.example.com/api/v1/backups?serverName=web-server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `mode` | Query | string | Optional | - | 백업 모드 필터 | `full`, `incremental` |
| `partition` | Query | string | Optional | - | 파티션 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | `run`, `complete`, `waiting`, `cancel` |
| `repositoryID` | Query | string | Optional | - | 리포지토리 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 리포지토리 타입 필터 | - |
| `repositoryPath` | Query | string | Optional | - | 리포지토리 경로 필터 | - |
| `serverName` | Query | string | Optional | - | 서버명 필터 | - |
| `serverType` | Query | string | Optional | - | 서버 타입 필터 | `source`, `target` |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | - |
| `active` | Query | boolean | Optional | `false` | 활성 작업만 조회 | - |
| `history` | Query | boolean | Optional | `false` | 히스토리 포함 | - |
| `logs` | Query | boolean | Optional | `false` | 로그 포함 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-backup-list",
  "data": [
    {
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
    }
  ],
  "message": "백업 작업 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
