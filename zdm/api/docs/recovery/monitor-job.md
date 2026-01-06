---
layout: docs
title: GET /recoveries/monitoring/job/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 복구 작업의 모니터링 정보를 조회합니다.

---

## `GET /recoveries/monitoring/job/:identifier` {#monitor-recovery-job}

> * 특정 복구 작업의 모니터링 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/recoveries/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 모니터링
curl -X GET "https://api.example.com/api/v1/recoveries/monitoring/job/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 모니터링
curl -X GET "https://api.example.com/api/v1/recoveries/monitoring/job/system-recovery-job" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 작업 ID 또는 작업명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-monitoring",
  "data": {
    "system": {
      "source": "web-server-01",
      "target": "backup-server-01"
    },
    "job": {
      "info": {
        "name": "system-recovery-job",
        "mode": "full",
        "partition": "/dev/sda1"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "60",
        "message": "Restoring system files",
        "start": "2024-01-31T03:00:00.000Z",
        "elapsed": "1h 30m",
        "end": null
      },
      "log": [
        "2024-01-31 03:00:00 - Recovery started",
        "2024-01-31 03:30:00 - Restoring partition data",
        "2024-01-31 04:30:00 - 60% completed"
      ]
    }
  },
  "message": "복구 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
