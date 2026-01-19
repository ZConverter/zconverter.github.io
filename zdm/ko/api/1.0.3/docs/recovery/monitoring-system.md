---
layout: docs
title: GET /recoveries/monitoring/system/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 서버의 복구 모니터링 정보를 조회합니다.

---

## `GET /recoveries/monitoring/system/:identifier` {#get-recoveries-monitoring-system}

> * 특정 서버의 복구 모니터링 정보를 조회합니다.
> * 서버 ID 또는 서버 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md %} |
| `partition` | Query | string | Optional | - | 파티션 필터 (Linux) | - |
| `drive` | Query | string | Optional | - | 드라이브 필터 (Windows) | - |
| `server` | Query | string | Optional | - | 서버 이름 또는 ID 필터 | - |
| `serverType` | Query | string | Optional | - | 서버 타입 필터 | {% include zdm/server-modes.md %} |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/job-status.md %} |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "source": {
        "name": "source-server"
      },
      "target": {
        "name": "target-server"
      }
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": {
      "info": {
        "name": "daily-recovery"
      },
      "log": [
        "Starting recovery...",
        "Transferring data..."
      ],
      "details": [
        {
          "partition": "/",
          "progressInfo": {
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed",
            "start": "2025-01-15 10:00:00",
            "elapsed": "00:30:00",
            "end": "2025-01-15 10:30:00"
          }
        },
        {
          "partition": "/home",
          "progressInfo": {
            "status": "Processing",
            "percent": "45%",
            "message": "Transferring data...",
            "start": "2025-01-15 10:30:00",
            "elapsed": "00:15:00",
            "end": "-"
          }
        }
      ]
    }
  },
  "message": "Server recovery monitoring info",
  "timestamp": "2025-01-15 10:45:00"
}
```

</details>

<details markdown="1">
<summary>Windows 서버 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "source": {
        "name": "source-win-server"
      },
      "target": {
        "name": "target-win-server"
      }
    },
    "summary": {
      "total": 2,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 0,
      "overallProgress": "75%"
    },
    "job": {
      "info": {
        "name": "daily-recovery-win"
      },
      "log": [
        "Starting recovery...",
        "Transferring data..."
      ],
      "details": [
        {
          "drive": "C:",
          "progressInfo": {
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed",
            "start": "2025-01-15 10:00:00",
            "elapsed": "00:30:00",
            "end": "2025-01-15 10:30:00"
          }
        },
        {
          "drive": "D:",
          "progressInfo": {
            "status": "Processing",
            "percent": "50%",
            "message": "Transferring data...",
            "start": "2025-01-15 10:30:00",
            "elapsed": "00:15:00",
            "end": "-"
          }
        }
      ]
    }
  },
  "message": "Server recovery monitoring info",
  "timestamp": "2025-01-15 10:45:00"
}
```

</details>

<details markdown="1">
<summary>페이지네이션 적용 (200 OK) - page, limit 파라미터 사용 시</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "source": {
        "name": "source-server"
      },
      "target": {
        "name": "target-server"
      }
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": {
      "info": {
        "name": "daily-recovery"
      },
      "log": [
        "Starting recovery...",
        "Transferring data..."
      ],
      "details": [
        {
          "partition": "/",
          "progressInfo": {
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed",
            "start": "2025-01-15 10:00:00",
            "elapsed": "00:30:00",
            "end": "2025-01-15 10:30:00"
          }
        }
      ]
    },
    "pagination": {
      "currentPage": 1,
      "totalPages": 2,
      "totalItems": 2,
      "itemsPerPage": 1,
      "hasNextPage": true,
      "hasPreviousPage": false
    }
  },
  "message": "Server recovery monitoring info",
  "timestamp": "2025-01-15 10:45:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.source.name` | string | 소스 서버 이름 |
| `system.target.name` | string | 타겟 서버 이름 |
| `summary.total` | number | 전체 작업 수 |
| `summary.completed` | number | 완료된 작업 수 |
| `summary.inProgress` | number | 진행 중인 작업 수 |
| `summary.failed` | number | 실패한 작업 수 |
| `summary.pending` | number | 대기 중인 작업 수 |
| `summary.overallProgress` | string | 전체 진행률 |
| `job.info.name` | string | 복구 작업 이름 |
| `job.log` | string[] | 작업 로그 목록 |
| `job.details[].partition` | string | 대상 파티션 (Linux) |
| `job.details[].drive` | string | 대상 드라이브 (Windows) |
| `job.details[].progressInfo.status` | string | 현재 상태 (PascalCase: Preparing, Processing, Complete, Scheduled, Registered, Canceling, Canceled, Error) |
| `job.details[].progressInfo.percent` | string | 진행률 |
| `job.details[].progressInfo.message` | string | 진행 상태 메시지 |
| `job.details[].progressInfo.start` | string | 시작 시간 |
| `job.details[].progressInfo.elapsed` | string | 경과 시간 |
| `job.details[].progressInfo.end` | string | 종료 시간 |
| `pagination.currentPage` | number | 현재 페이지 번호 (페이지네이션 적용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (페이지네이션 적용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (페이지네이션 적용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (페이지네이션 적용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (페이지네이션 적용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (페이지네이션 적용 시) |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**작업을 찾을 수 없음 (404 Not Found)**

서버에 등록된 복구 작업이 없거나, 조건에 맞는 작업이 존재하지 않는 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "서버 'target-server'에 파티션 '/data'에 해당하는 Recovery 작업을 찾을 수 없습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

파티션 필터 없이 서버에 복구 작업이 없는 경우:

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "서버 'target-server'에 등록된 Recovery 작업을 찾을 수 없습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

**작업 데이터 불완전 (400 Bad Request)**

복구 작업 데이터가 불완전한 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "작업 데이터가 불완전합니다. 파티션 '/' 에 대한 recovery 또는 recoveryInfo 작업 정보를 찾을 수 없습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
