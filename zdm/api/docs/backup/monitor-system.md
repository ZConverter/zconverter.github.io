---
layout: docs
title: GET /backups/monitoring/system/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 시스템의 백업 모니터링 정보를 조회합니다.

---

## `GET /backups/monitoring/system/:identifier` {#monitor-backup-system}

> * 특정 시스템의 백업 모니터링 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 시스템명으로 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/system/web-server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 시스템 ID 또는 시스템명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-system-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "jobs": [
      {
        "name": "daily-backup-web",
        "status": "PROCESSING",
        "progress": "75%",
        "startTime": "2024-01-31T02:00:00.000Z"
      }
    ]
  },
  "message": "시스템 백업 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
