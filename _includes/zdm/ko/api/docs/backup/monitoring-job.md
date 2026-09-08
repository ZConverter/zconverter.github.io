
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
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`drive`와 택일) | - |
| `drive` | Query | string | Optional | - | 파티션/드라이브 필터 (`partition`과 택일) | - |
| `server` | Query | string | Optional | - | 서버 이름 또는 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `page` | Query | number | Optional | - | 페이지 번호 (1부터 시작, 이 경로에서는 적용되지 않음) | - |
| `limit` | Query | number | Optional | - | 페이지당 항목 수 (이 경로에서는 적용되지 않음) | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능) | - |

> **참고:**
> - `partition`과 `drive`는 같은 대상을 가리키는 **하나의 필터**입니다. 함께 지정하면 400을 반환하므로 **둘 중 하나만** 사용합니다.
> - 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`가 모두 허용됩니다. OS에 따라 파라미터를 구분해 고를 필요가 없습니다.
> - `server`는 **키만 보내고 값이 비면**(`?server=`) 400입니다. 파라미터를 **생략**하는 것은 종전대로 "해당 필터 없음"이며 동작이 달라지지 않습니다.
> - `status`는 **제거되었습니다.** 보내면 400(`DTO-VALIDATION-03`)입니다 — 종전에는 지정한 상태와 어긋나면 404였습니다. 이 경로는 경로 `identifier`로 작업 하나를 지목한 단건 조회이므로, 상태는 응답의 `job.progressInfo.status`를 읽으면 됩니다. 상태로 목록을 거르려면 [서버 기준 모니터링](/zdm/ko/api/3.0.0/docs/backup/monitoring-system)을 사용합니다.
> - `center`는 ID/이름을 콤마로 여러 개 지정할 수 있습니다. (예: `?center=1,zdm-b`) 키만 보내고 값이 비면(`?center=`) 400입니다.
> - `page`와 `limit`은 스키마가 받기는 하지만 **이 경로에서는 결과에 영향을 주지 않습니다.** 경로 `identifier`로 작업 하나를 지목한 단건 조회라 자를 목록이 없기 때문이며, 페이지네이션은 [서버 기준 모니터링](/zdm/ko/api/3.0.0/docs/backup/monitoring-system)에서만 동작합니다. 표에서 행을 지우지 않은 것은 선언되지 않은 query 파라미터가 400이기 때문입니다.
> - `sort`는 이 경로의 스키마에 **없는 이름입니다.** 보내면 400(`DTO-VALIDATION-03`)이므로 요청에서 빼야 합니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 (200 OK)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
        "status": "Scheduled",
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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>Windows 서버 (200 OK)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
        "status": "Processing",
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
  "timestamp": "2025-01-15T10:20:00.000+09:00"
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
| `job.progressInfo.status` | string | 현재 작업 상태 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`). **작업 본체가 정합니다** — 진행 정보가 종료 단계에 들어가도 본체가 아직 진행 중이라고 말하면 `Processing` 입니다 |
| `job.progressInfo.percent` | string | 진행률. **`"100%"` 인데 `status` 가 `Processing` 인 것은 모순이 아닙니다** — 복사가 끝난 뒤에도 후속 단계가 남아 있으면 작업은 아직 진행 중입니다. 완료 판정은 `status` 로만 하세요 |
| `job.progressInfo.message` | string | 진행 상태 메시지 |
| `job.progressInfo.start` | string | 시작 시간 |
| `job.progressInfo.elapsed` | string | 경과 시간 |
| `job.progressInfo.end` | string | 종료 시간 |
| `job.log` | string[] | 작업 로그 목록. **`detail=true` 일 때만 채워집니다** — 기본 조회에서는 빈 배열입니다 (서버 기준 조회와 같은 규칙) |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**작업을 찾을 수 없음 (404 Not Found)**

조건에 맞는 백업 작업이 존재하지 않는 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "JOB-ERROR-01",
    "message": "Backup job with Name 'daily-backup' not found."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**작업 데이터 불완전 (400 Bad Request)**

백업 작업 데이터가 불완전한 경우 반환됩니다. (backup 은 존재하지만 backupInfo 정보가 없는 경우)

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "JOB-ERROR-20",
    "message": "Job data is incomplete. backupInfo info is missing."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

`partition`과 `drive`를 함께 지정했거나, `server`를 키만 보내고 값을 비운 경우, 또는 제거된 `status`처럼 지원하지 않는 query 파라미터를 보낸 경우 반환됩니다.

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
