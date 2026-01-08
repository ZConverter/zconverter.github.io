---
layout: docs
title: GET /backups/monitoring/system/:identifier
section_title: ZDM API Documentation
navigation: api-0.2.0
---

특정 서버의 백업 모니터링 정보를 조회합니다.

---

## `GET /backups/monitoring/system/:identifier` {#get-backups-monitoring-system}

> * 특정 서버의 백업 모니터링 정보를 조회합니다.
> * 서버 ID 또는 서버 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/backups/monitoring/system/server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md backup=true %} |
| `partition` | Query | string | Optional | - | 작업 대상 파티션 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |

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
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "name": "daily-backup-root",
          "partition": "/"
        },
        "progressInfo": {
          "status": "complete",
          "percent": "100%",
          "message": "Backup completed",
          "start": "2025-01-15T02:00:00Z",
          "elapsed": "00:30:00",
          "end": "2025-01-15T02:30:00Z"
        },
        "log": []
      },
      {
        "info": {
          "name": "daily-backup-home",
          "partition": "/home"
        },
        "progressInfo": {
          "status": "run",
          "percent": "45%",
          "message": "Processing files...",
          "start": "2025-01-15T03:00:00Z",
          "elapsed": "00:15:00",
          "end": "-"
        },
        "log": ["Starting backup...", "Processing files..."]
      }
    ]
  },
  "message": "Server backup monitoring info",
  "timestamp": "2025-01-15T11:15:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 대상 서버 이름 |
| `summary.total` | number | 전체 작업 수 |
| `summary.completed` | number | 완료된 작업 수 |
| `summary.inProgress` | number | 진행 중인 작업 수 |
| `summary.failed` | number | 실패한 작업 수 |
| `summary.pending` | number | 대기 중인 작업 수 |
| `summary.overallProgress` | string | 전체 진행률 |
| `job[].info.name` | string | 작업 이름 |
| `job[].info.partition` | string | 대상 파티션 (Linux) |
| `job[].info.drive` | string | 대상 드라이브 (Windows) |
| `job[].progressInfo.status` | string | 현재 상태 |
| `job[].progressInfo.percent` | string | 진행률 |
| `job[].progressInfo.message` | string | 진행 상태 메시지 |
| `job[].progressInfo.start` | string | 시작 시간 |
| `job[].progressInfo.elapsed` | string | 경과 시간 |
| `job[].progressInfo.end` | string | 종료 시간 |
| `job[].log` | string[] | 작업 로그 목록 |

</details>

---
