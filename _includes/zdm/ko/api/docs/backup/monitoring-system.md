
특정 서버의 백업 모니터링 정보를 조회합니다.

---

## `GET /backups/monitoring/system/:identifier` {#get-backups-monitoring-system}

> * 특정 서버의 백업 모니터링 정보를 조회합니다.
> * 서버 ID 또는 서버 이름으로 조회할 수 있습니다.
> * **그 서버에 등록된 백업 작업을 전부 반환합니다.** 같은 파티션에 작업이 여러 개면 모두 나옵니다 —
>   종전에는 파티션당 한 건만 노출됐습니다.
> * 등록된 작업이 없으면 오류가 아니라 **`200` + 빈 `job` 배열**입니다.
> * 작업 로그(`job[].log`)는 **`detail=true`** 일 때만 채워집니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 모니터링 조회
curl -X GET "https://api.example.com/api/backups/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 모니터링 조회
curl -X GET "https://api.example.com/api/backups/monitoring/system/server-01" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/backups/monitoring/system/server-01?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md backup=true %} |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`drive`와 택일) | - |
| `drive` | Query | string | Optional | - | 파티션/드라이브 필터 (`partition`과 택일) | - |
| `server` | Query | string | Optional | - | 서버 이름 또는 ID 필터. **이 경로에서는 무시됩니다** — 경로의 `identifier` 가 이미 서버 하나를 지목하기 때문입니다 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/job-status.md %} |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능) | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |

> **참고:**
> - 위 표에 없는 query 파라미터는 **받지 않습니다** — 요청에 실으면 `400` (`DTO-VALIDATION-03`) 이고 `error.details` 에 해당 이름이 담깁니다. 종전에 문서에 적혀 있던 `sort` 도 이 경로에서는 지원하지 않습니다.
> - `partition`과 `drive`는 같은 대상을 가리키는 **하나의 필터**입니다. 함께 지정하면 400을 반환하므로 **둘 중 하나만** 사용합니다.
> - 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`가 모두 허용됩니다. OS에 따라 파라미터를 구분해 고를 필요가 없습니다.
> - `server`는 **키만 보내고 값이 비면**(`?server=`) 400입니다. 파라미터를 **생략**하는 것은 종전대로 "해당 필터 없음"이며 동작이 달라지지 않습니다.
> - `server` 에 **존재하지 않는 서버 ID/이름**을 넣어도 이제 404 가 아닙니다 — 어차피 무시되는 필터였는데 해석 단계에서 404 를 던지고 있었습니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "system": {
      "name": "linux-server-01"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "canceled": 0,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "name": "daily-backup-root",
          "partition": "/"
        },
        "progressInfo": {
          "status": "Scheduled",
          "percent": "100%",
          "message": "Backup completed",
          "start": "2025-01-15 02:00:00",
          "elapsed": "00:30:00",
          "end": "2025-01-15 02:30:00"
        },
        "log": []
      },
      {
        "info": {
          "name": "daily-backup-home",
          "partition": "/home"
        },
        "progressInfo": {
          "status": "Processing",
          "percent": "45%",
          "message": "Processing files...",
          "start": "2025-01-15 03:00:00",
          "elapsed": "00:15:00",
          "end": "-"
        },
        "log": ["Starting backup...", "Processing files..."]
      }
    ]
  },
  "message": "Server backup monitoring info",
  "timestamp": "2025-01-15T11:15:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>Windows 서버 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "system": {
      "name": "windows-server-01"
    },
    "summary": {
      "total": 2,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 0,
      "canceled": 0,
      "overallProgress": "75%"
    },
    "job": [
      {
        "info": {
          "name": "daily-backup-c",
          "drive": "C:"
        },
        "progressInfo": {
          "status": "Scheduled",
          "percent": "100%",
          "message": "Backup completed",
          "start": "2025-01-15 02:00:00",
          "elapsed": "00:30:00",
          "end": "2025-01-15 02:30:00"
        },
        "log": []
      },
      {
        "info": {
          "name": "daily-backup-d",
          "drive": "D:"
        },
        "progressInfo": {
          "status": "Processing",
          "percent": "50%",
          "message": "Processing files...",
          "start": "2025-01-15 03:00:00",
          "elapsed": "00:15:00",
          "end": "-"
        },
        "log": ["Starting backup...", "Processing files..."]
      }
    ]
  },
  "message": "Server backup monitoring info",
  "timestamp": "2025-01-15T11:15:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>페이지네이션 적용 (200 OK) - page, limit 파라미터 사용 시</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "system": {
      "name": "linux-server-01"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "canceled": 0,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "name": "daily-backup-root",
          "partition": "/"
        },
        "progressInfo": {
          "status": "Scheduled",
          "percent": "100%",
          "message": "Backup completed",
          "start": "2025-01-15 02:00:00",
          "elapsed": "00:30:00",
          "end": "2025-01-15 02:30:00"
        },
        "log": []
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 3,
      "itemsPerPage": 1,
      "hasNextPage": true,
      "hasPreviousPage": false
    }
  },
  "message": "Server backup monitoring info",
  "timestamp": "2025-01-15T11:15:00.000+09:00"
}
```

</details>

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
| `summary.canceled` | number | 취소된 작업 수 |
| `summary.overallProgress` | string | 전체 진행률. **진행 중인 작업이 하나도 없으면 `"-"`** 입니다 — `"0%"` 는 "진행률을 0으로 측정했다" 로 읽혀 대기·완료 상태와 구분되지 않으므로 쓰지 않습니다 |
| `job[].info.name` | string | 작업 이름 |
| `job[].info.partition` | string | 대상 파티션 (Linux) |
| `job[].info.drive` | string | 대상 드라이브 (Windows) |
| `job[].progressInfo.status` | string | 현재 작업 상태 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`). **작업 본체가 정합니다** — 진행 정보가 종료 단계에 들어가도 본체가 아직 진행 중이라고 말하면 `Processing` 입니다. 반대로 데몬이 중단돼 **진행 행만 남은 경우**에는 그 행을 없는 것으로 보고 본체 상태를 냅니다(종전에는 영구히 `Processing`) |
| `job[].progressInfo.percent` | string | 진행률. **`"100%"` 인데 `status` 가 `Processing` 인 것은 모순이 아닙니다** — 복사가 끝난 뒤에도 후속 단계가 남아 있으면 작업은 아직 진행 중입니다. 완료 판정은 `status` 로만 하세요 |
| `job[].progressInfo.message` | string | 진행 상태 메시지 |
| `job[].progressInfo.start` | string | 시작 시간 |
| `job[].progressInfo.elapsed` | string | 경과 시간 |
| `job[].progressInfo.end` | string | 종료 시간 |
| `job[].log` | string[] | 작업 로그 목록. **`detail=true` 일 때만 채워집니다** — 기본 조회(폴링 용도)에서는 빈 배열입니다 |
| `pagination.currentPage` | number | 현재 페이지 번호 (페이지네이션 적용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (페이지네이션 적용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (페이지네이션 적용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (페이지네이션 적용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (페이지네이션 적용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (페이지네이션 적용 시) |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

> **등록된 작업이 없거나 필터에 맞는 작업이 없으면 오류가 아닙니다.**
> `200` 과 함께 **빈 `job` 배열**(`summary.total: 0`, `overallProgress: "-"`)을 돌려줍니다.
> 종전에는 이 경우 `404`(`JOB-ERROR-01`)였습니다 — 컬렉션 조회의 0건은 실패가 아니라는 계약으로 바뀌었습니다.
> `status` 필터로 걸러 0건이 된 경우도 같습니다.

**서버를 찾을 수 없음 (404 Not Found)**

경로의 `identifier` 에 해당하는 서버가 없거나, `center` 필터로 좁힌 범위 안에 없는 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "SERVER-ERROR-01",
    "message": "Server with Name 'server-01' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**작업 데이터 불완전 (400 Bad Request)**

작업 본체와 상세 정보 중 한쪽만 존재하는 경우입니다.

> **서버 기준 조회에서는 이 오류가 나지 않습니다.** 상세 정보에 짝이 되는 본체가 없으면
> **그 작업만 목록에서 빠지고** 나머지는 정상 반환됩니다 — 작업 하나의 데이터 결손이
> 서버 전체 조회를 실패시키지 않습니다. 아래 예시는 작업 기준 조회(`/monitoring/job/:identifier`)의 형태입니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "JOB-ERROR-20",
    "message": "Job data is incomplete. Could not find backup or backupInfo job info for partition '/'."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

`partition`과 `drive`를 함께 지정했거나, `server`를 키만 보내고 값을 비운 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "partition": ["partition and drive filter the same column and cannot be used together. Use one of them — 'C', 'C:' and '/data' are all accepted."]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
