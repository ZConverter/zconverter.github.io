
OS 복제 작업의 실시간 모니터링 정보를 조회합니다.

---

## `GET /os-replications/monitoring/job/:identifier` {#get-os-replications-monitoring-job}

> * 현재 실행 중인 OS 복제 작업의 진행 상태를 조회합니다.
> * `progress.status`는 `Preparing`, `Processing`, `Complete`, `Canceling`, `Canceled`, `Error` 등 문자열로 반환됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/monitoring/job/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | 작업 ID(숫자) 또는 작업 이름 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "system": { "name": "center-01" },
    "job": {
      "info": { "name": "os_repl_upload_1712345678901", "id": 1 },
      "log": [
        "[2026-04-08 12:00:00] Replication started",
        "[2026-04-08 12:01:00] Uploading files..."
      ],
      "progress": {
        "status": "Processing",
        "step": "uploading",
        "percent": "45%",
        "message": "Uploading files..."
      },
      "time": {
        "start": "2026-04-08 12:00:00",
        "end": "-",
        "elapsed": "00:01:00"
      }
    }
  },
  "message": "Os Replication monitoring",
  "timestamp": "2026-04-08 12:01:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>progress.status 값</strong></summary>

| 값 | 설명 |
|----|------|
| `Preparing` | 작업 준비 중 |
| `Processing` | 작업 진행 중 |
| `Complete` | 작업 완료 |
| `Scheduled` | 스케줄 등록 상태 (완료 + 스케줄 있음) |
| `Canceling` | 작업 취소 중 |
| `Canceled` | 작업 취소됨 |
| `Error` | 에러 발생 |

</details>
