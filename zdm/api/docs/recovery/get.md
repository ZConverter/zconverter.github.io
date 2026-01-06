---
layout: docs
title: GET /recoveries/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 복구 작업 정보를 조회합니다.

---

## `GET /recoveries/:identifier` {#get-recovery}

> * 특정 복구 작업 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 조회
curl -X GET "https://api.example.com/api/v1/recoveries/system-recovery-job" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/recoveries/1?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 작업 ID 또는 작업명 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | `run`, `complete`, `waiting`, `cancel` |
| `platform` | Query | string | Optional | - | 플랫폼 타입 필터 | `linux`, `windows` |
| `mode` | Query | string | Optional | - | 복구 모드 필터 | `full`, `incremental` |
| `detail` | Query | boolean | Optional | - | 상세 정보 포함 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-detail",
  "data": {
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
  },
  "message": "복구 작업 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
