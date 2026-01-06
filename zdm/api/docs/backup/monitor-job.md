---
layout: docs
title: GET /backups/monitoring/job/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 백업 작업의 모니터링 정보를 조회합니다.

---

## `GET /backups/monitoring/job/:identifier` {#monitor-backup-job}

> * 특정 백업 작업의 모니터링 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 모니터링
curl -X GET "https://api.example.com/api/v1/backups/monitoring/job/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 모니터링
curl -X GET "https://api.example.com/api/v1/backups/monitoring/job/daily-backup-web" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 작업 ID 또는 작업명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "job": {
      "info": {
        "name": "daily-backup-web",
        "partition": "/dev/sda1",
        "drive": "C:"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "75",
        "message": "Backing up system files",
        "start": "2024-01-31T02:00:00.000Z",
        "elapsed": "30m 15s",
        "end": null
      },
      "log": [
        "2024-01-31 02:00:00 - Backup started",
        "2024-01-31 02:15:00 - Processing system files",
        "2024-01-31 02:30:00 - 75% completed"
      ]
    }
  },
  "message": "백업 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
