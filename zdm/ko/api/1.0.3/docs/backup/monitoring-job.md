---
layout: docs
title: GET /backups/monitoring/job/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 백업 작업의 모니터링 정보를 조회합니다.

---

## `GET /backups/monitoring/job/:identifier` {#get-backups-monitoring-job}

> * 특정 백업 작업의 모니터링 정보를 조회합니다.
> * 백업 ID 또는 백업 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/job/1" \
  -H "Authorization: Bearer <token>"

# 백업 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/job/daily-backup" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/job/1?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md backup=true %} |
| `partition` | Query | string | Optional | - | 작업 대상 파티션 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "server-01"
    },
    "job": {
      "info": {
        "name": "daily-backup",
        "partition": "/"
      },
      "progressInfo": {
        "status": "complete",
        "percent": "100%",
        "message": "Backup completed successfully",
        "start": "2025-01-15T02:00:00Z",
        "elapsed": "00:30:00",
        "end": "2025-01-15T02:30:00Z"
      },
      "log": [
        "Starting backup...",
        "Processing files...",
        "Backup completed"
      ]
    }
  },
  "message": "Backup monitoring info",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 대상 서버 이름 |
| `job.info.name` | string | 작업 이름 |
| `job.info.partition` | string | 대상 파티션 (Linux) |
| `job.info.drive` | string | 대상 드라이브 (Windows) |
| `job.progressInfo.status` | string | 현재 상태 |
| `job.progressInfo.percent` | string | 진행률 |
| `job.progressInfo.message` | string | 진행 상태 메시지 |
| `job.progressInfo.start` | string | 시작 시간 |
| `job.progressInfo.elapsed` | string | 경과 시간 |
| `job.progressInfo.end` | string | 종료 시간 |
| `job.log` | string[] | 작업 로그 목록 |

</details>

---
