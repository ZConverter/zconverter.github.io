
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

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `identifier` | Path | string | Required | 작업 ID(숫자) 또는 작업 이름 | |
| `server` | Query | string | Optional | 작업 대상 서버 이름 필터. 불일치 시 404 | |
| `page` | Query | number | Optional | `job.log` 의 페이지 번호 (기본 1). `page`·`limit` 중 하나라도 보내면 적용됩니다 | |
| `limit` | Query | number | Optional | `job.log` 의 페이지당 줄 수 (기본 20). `page`·`limit` 중 하나라도 보내면 적용됩니다 | |
| `sort` | Query | string | Optional | `job.log` 정렬 순서. 로그 번호 기준이며 기본은 `desc` 입니다 | `asc`, `desc` |

> * `page` · `limit` · `sort` 는 `job.log` 에 적용됩니다. 셋 다 보내지 않으면 정렬된 로그의 앞 10줄(기본 `desc` 이므로 최근 10줄)만 반환하고 `data.pagination` 은 없습니다. `page` 또는 `limit` 중 하나라도 보내면 기본값(page 1, limit 20)으로 자르고 `data.pagination`(`currentPage`·`totalPages`·`totalItems`·`itemsPerPage`·`hasNextPage`·`hasPreviousPage`)을 함께 반환합니다. 범위를 벗어난 `page` 는 빈 `log` 와 200 입니다.

> * `status` 는 **제거되었습니다.** 보내면 400 (`DTO-VALIDATION-03`) 입니다 — 종전에는 활성 작업의 계산된 status 와 불일치 시 404 였습니다. 경로 `identifier` 로 이미 작업 하나를 지목한 단건 조회이므로, 상태는 응답의 `job.progress.status` 를 읽으면 됩니다.
> * 종전 `status` 에 `scheduled` · `registered` 를 주면 **항상 404** 였습니다. 이 경로의 상태는 실행 중인 활성 작업에서 계산하므로 그 두 값은 나올 수 없었습니다. 파라미터가 사라지면서 이 함정도 없어졌습니다.
> * `server` 는 **키를 보냈는데 값이 비어 있으면**(`?server=`) 400 입니다. 파라미터를 **생략**하는 것은 종전대로 "필터 없음" 이므로 동작 변화가 없습니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-04-08T12:01:00.000+09:00"
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
| `Scheduled` | 스케줄 대기 상태의 작업 (남아 있는 진행 기록은 무시) |
| `Canceling` | 작업 취소 중 |
| `Canceled` | 작업 취소됨 (진행 기록이 없는 취소 작업 포함) |
| `Error` | 에러 발생 |

</details>

<details markdown="1" open>
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `NOT_FOUND` | 404 | 작업 미존재 또는 `server` 필터와 불일치 |
| `DTO-VALIDATION-03` | 400 | 지원하지 않는 query 파라미터 (제거된 `status` 포함) 또는 값이 빈 `server` |
| `INTERNAL_SERVER_ERROR` | 500 | 내부 오류 |

</details>
