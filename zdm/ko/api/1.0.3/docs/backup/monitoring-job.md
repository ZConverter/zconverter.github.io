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
  <code>GET /api/backups/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/backups/monitoring/job/1" \
  -H "Authorization: Bearer <token>"

# 백업 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/backups/monitoring/job/daily-backup" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md backup=true %} |
| `partition` | Query | string | Optional | - | 파티션 필터 (Linux) | - |
| `drive` | Query | string | Optional | - | 드라이브 필터 (Windows) | - |
| `server` | Query | string | Optional | - | 서버 이름 또는 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "linux-server-01"
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
        "start": "2025-01-15 02:00:00",
        "elapsed": "00:30:00",
        "end": "2025-01-15 02:30:00"
      },
      "log": [
        "Starting backup...",
        "Processing files...",
        "Backup completed"
      ]
    }
  },
  "message": "Backup monitoring info",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>Windows 서버 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "windows-server-01"
    },
    "job": {
      "info": {
        "name": "daily-backup-win",
        "drive": "C:"
      },
      "progressInfo": {
        "status": "run",
        "percent": "60%",
        "message": "Processing files...",
        "start": "2025-01-15 02:00:00",
        "elapsed": "00:20:00",
        "end": "-"
      },
      "log": [
        "Starting backup...",
        "Processing files..."
      ]
    }
  },
  "message": "Backup monitoring info",
  "timestamp": "2025-01-15 10:20:00"
}
```

</details>

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

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**작업을 찾을 수 없음 (404 Not Found)**

조건에 맞는 백업 작업이 존재하지 않는 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Name이 'daily-backup'인 조건에 맞는 Backup 작업을 찾을 수 없습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

**작업 데이터 불완전 (400 Bad Request)**

백업 작업 데이터가 불완전한 경우 반환됩니다. (backup 또는 backupInfo 테이블 중 하나만 존재하는 경우)

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "작업 데이터가 불완전합니다. backup 정보가 누락되었습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
