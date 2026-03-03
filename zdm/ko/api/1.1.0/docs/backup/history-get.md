---
layout: docs
title: GET /backups/histories/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.1.0
lang: ko
---

특정 백업 히스토리를 조회합니다.

---

## `GET /backups/histories/:identifier` {#get-backups-histories-identifier}

> * 히스토리 ID 또는 작업 이름으로 백업 히스토리를 조회합니다.
> * identifier가 숫자인 경우 작업 ID로, 그 외에는 작업 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/histories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업 ID로 조회
curl -X GET "https://api.example.com/api/backups/histories/10" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 조회
curl -X GET "https://api.example.com/api/backups/histories/daily-backup" \
  -H "Authorization: Bearer <token>"

# 작업 이름 + 필터 적용
curl -X GET "https://api.example.com/api/backups/histories/daily-backup?result=success&page=1&limit=5" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 작업 ID (숫자) 또는 작업 이름 | - |
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 작업 대상 서버 이름 필터 | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | `success`, `failed` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>ID로 조회 시 (단건 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "id": 1,
    "system": {
      "name": "server-01"
    },
    "job": {
      "name": "daily-backup",
      "id": 10,
      "backupType": "Full Backup",
      "drive": "C:",
      "repositoryPath": "\\\\nas\\backup"
    },
    "result": {
      "status": "COMPLETE",
      "description": "Backup completed successfully"
    },
    "time": {
      "start": "2026-03-03 02:00:00",
      "end": "2026-03-03 02:30:00",
      "elapsed": "00:30:00"
    }
  },
  "message": "Backup history retrieved",
  "timestamp": "2026-03-03 10:30:00"
}
```

</details>

<details markdown="1">
<summary>작업 이름으로 조회 시 (목록 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": 1,
      "system": {
        "name": "server-01"
      },
      "job": {
        "name": "daily-backup",
        "id": 10,
        "backupType": "Full Backup",
        "drive": "C:",
        "repositoryPath": "\\\\nas\\backup"
      },
      "result": {
        "status": "COMPLETE",
        "description": "Backup completed successfully"
      },
      "time": {
        "start": "2026-03-03 02:00:00",
        "end": "2026-03-03 02:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "message": "Backup history list",
  "timestamp": "2026-03-03 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 히스토리 ID |
| `system.name` | string | 대상 서버 이름 |
| `job.name` | string | 백업 작업 이름 |
| `job.id` | number | 백업 작업 ID |
| `job.backupType` | string | 백업 타입 (Full Backup, Increment Backup, Smart Backup 등) |
| `job.drive` | string | 대상 드라이브/파티션 |
| `job.repositoryPath` | string | 레포지토리 경로 |
| `result.status` | string | 작업 결과 상태 |
| `result.description` | string | 작업 결과 설명 |
| `time.start` | string | 작업 시작 시간 |
| `time.end` | string | 작업 종료 시간 |
| `time.elapsed` | string | 경과 시간 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**히스토리를 찾을 수 없음 (404 Not Found)**

지정한 ID 또는 작업 이름의 히스토리가 존재하지 않는 경우 반환됩니다.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Backup history not found for ID '999'",
  "timestamp": "2026-03-03 10:30:00"
}
```

</details>

---
