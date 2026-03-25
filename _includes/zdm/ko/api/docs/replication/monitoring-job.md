
특정 복제 작업의 모니터링 정보를 조회합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `GET /replications/monitoring/job/:identifier` {#get-replications-monitoring-job}

> * 특정 복제 작업의 실시간 모니터링 정보를 조회합니다.
> * 복제 ID 또는 작업 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/replications/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복제 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/replications/monitoring/job/1" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/replications/monitoring/job/backup-replication-01" \
  -H "Authorization: Bearer <token>"

# 상태 필터 적용
curl -X GET "https://api.example.com/api/replications/monitoring/job/1?status=running" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복제 작업 ID (숫자) 또는 작업 이름 | - |
| `server` | Query | string | Optional | - | 서버 이름 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/replication-job-status.md %} |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>실행 중인 작업 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "center-01"
    },
    "job": {
      "info": {
        "name": "backup-replication-01",
        "id": 1
      },
      "log": [
        "Starting replication...",
        "Connecting to target repository...",
        "Transferring files...",
        "Processing: /backup/source/data.tar.gz"
      ],
      "progress": {
        "status": "running",
        "step": "Transferring",
        "percent": "65%",
        "message": "Transferring files to target repository"
      },
      "time": {
        "start": "2026-03-20 02:00:00",
        "end": "-",
        "elapsed": "00:20:00"
      }
    }
  },
  "message": "Replication monitoring info",
  "timestamp": "2026-03-20 02:20:00"
}
```

</details>

<details markdown="1">
<summary>완료된 작업 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "center-01"
    },
    "job": {
      "info": {
        "name": "backup-replication-01",
        "id": 1
      },
      "log": [
        "Starting replication...",
        "Connecting to target repository...",
        "Transferring files...",
        "Replication completed successfully"
      ],
      "progress": {
        "status": "success",
        "step": "Complete",
        "percent": "100%",
        "message": "Replication completed successfully"
      },
      "time": {
        "start": "2026-03-20 02:00:00",
        "end": "2026-03-20 02:30:00",
        "elapsed": "00:30:00"
      }
    }
  },
  "message": "Replication monitoring info",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 센터 이름 |
| `job.info.name` | string | 작업 이름 |
| `job.info.id` | number | 작업 ID |
| `job.log` | string[] | 작업 로그 목록 (최근 10건) |
| `job.progress.status` | string | 현재 작업 상태 |
| `job.progress.step` | string | 현재 작업 단계 |
| `job.progress.percent` | string | 진행률 |
| `job.progress.message` | string | 진행 상태 메시지 |
| `job.time.start` | string | 작업 시작 시간 |
| `job.time.end` | string | 작업 종료 시간 |
| `job.time.elapsed` | string | 경과 시간 |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**작업을 찾을 수 없음 (404 Not Found)**

조건에 맞는 복제 작업이 존재하지 않는 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Name이 'backup-replication-01'인 조건에 맞는 Replication 작업을 찾을 수 없습니다.",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
