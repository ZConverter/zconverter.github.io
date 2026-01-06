---
layout: docs
title: GET /recoveries
section_title: ZDM API Documentation
navigation: api
---

복구 작업 목록을 조회합니다.

---

## `GET /recoveries` {#get-recoveries}

> * 복구 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/recoveries</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 복구 작업 목록 조회
curl -X GET "https://api.example.com/api/v1/recoveries" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/recoveries?status=completed&mode=full" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/recoveries?detail=true&server=web-server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `status` | Query | string | Optional | - | 작업 상태 필터 | `run`, `complete`, `waiting`, `cancel` |
| `platform` | Query | string | Optional | - | 플랫폼 타입 필터 | `linux`, `windows` |
| `mode` | Query | string | Optional | - | 복구 모드 필터 | `full`, `incremental` |
| `partition` | Query | string | Optional | - | 파티션 필터 | - |
| `drive` | Query | string | Optional | - | 드라이브 필터 | - |
| `backupName` | Query | string | Optional | - | 백업명 필터 | - |
| `repositoryID` | Query | string | Optional | - | 리포지토리 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 리포지토리 타입 필터 | - |
| `repositoryPath` | Query | string | Optional | - | 리포지토리 경로 필터 | - |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |
| `server` | Query | string | Optional | - | 서버명 필터 | - |
| `serverType` | Query | string | Optional | - | 서버 타입 필터 | `source`, `target` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-list",
  "data": [
    {
      "system": {
        "source": {
          "id": "SRV-001",
          "name": "web-server-01",
          "os": "Ubuntu 20.04"
        },
        "target": {
          "id": "SRV-002",
          "name": "backup-server-01",
          "os": "Ubuntu 20.04"
        }
      },
      "job": {
        "info": {
          "id": "REC-001",
          "name": "system-recovery-job",
          "schedule": {
            "basic": "0 3 * * 0"
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2024-01-31T03:00:00.000Z",
              "elapsed": "2h 15m",
              "end": "2024-01-31T05:15:00.000Z"
            }
          },
          "lastUpdated": "2024-01-31T05:15:00.000Z"
        },
        "detail": []
      }
    }
  ],
  "message": "복구 작업 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
