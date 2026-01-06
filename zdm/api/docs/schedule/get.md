---
layout: docs
title: GET /schedules/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 스케줄 정보를 조회합니다.

---

## `GET /schedules/:identifier` {#get-schedule}

> * 특정 스케줄 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/schedules/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/schedules/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 조회
curl -X GET "https://api.example.com/api/v1/schedules/daily-backup-job" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID 또는 작업명 | - |
| `id` | Query | string | Optional | - | 스케줄 ID 필터 | - |
| `type` | Query | string | Optional | - | 스케줄 타입 필터 | `backup`, `recovery` |
| `state` | Query | string | Optional | - | 활성 상태 필터 | `active`, `inactive` |
| `jobName` | Query | string | Optional | - | 작업명 필터 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-schedule-detail",
  "data": {
    "id": "1",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "daily-backup-job",
    "lastRunTime": "2024-01-31T02:00:00.000Z",
    "description": "Daily backup schedule"
  },
  "message": "스케줄 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
