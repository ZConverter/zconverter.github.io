---
layout: docs
title: GET /recoveries/monitoring/system/:identifier
section_title: ZDM API Documentation
navigation: api-0.2.0
---

특정 서버의 복구 모니터링 정보를 조회합니다.

---

## `GET /recoveries/monitoring/system/:identifier` {#get-recoveries-monitoring-system}

> * 특정 서버의 복구 모니터링 정보를 조회합니다.
> * 서버 ID 또는 서버 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/recoveries/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/recoveries/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/v1/recoveries/monitoring/system/target-server" \
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
| `serverName` | Query | string | Optional | - | 서버 이름 필터 | - |
| `serverType` | Query | string | Optional | - | 서버 타입 필터 | {% include zdm/server-modes.md %} |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
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
            "status": "complete",
            "percent": "100%",
            "message": "Recovery completed",
            "start": "2025-01-15T10:00:00Z",
            "elapsed": "00:30:00",
            "end": "2025-01-15T10:30:00Z"
          }
        },
        {
          "partition": "/home",
          "progressInfo": {
            "status": "run",
            "percent": "45%",
            "message": "Transferring data...",
            "start": "2025-01-15T10:30:00Z",
            "elapsed": "00:15:00",
            "end": "-"
          }
        }
      ]
    }
  },
  "message": "Server recovery monitoring info",
  "timestamp": "2025-01-15T10:45:00Z"
}
```

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
| `job.details[].progressInfo.status` | string | 현재 상태 |
| `job.details[].progressInfo.percent` | string | 진행률 |
| `job.details[].progressInfo.message` | string | 진행 상태 메시지 |
| `job.details[].progressInfo.start` | string | 시작 시간 |
| `job.details[].progressInfo.elapsed` | string | 경과 시간 |
| `job.details[].progressInfo.end` | string | 종료 시간 |

</details>

---
