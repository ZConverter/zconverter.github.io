
백업 작업의 실행 히스토리 목록을 조회합니다.

---

## `GET /backups/histories` {#get-backups-histories}

> * 백업 작업의 실행 이력(히스토리) 목록을 조회합니다.
> * 필터 옵션을 통해 특정 조건의 히스토리만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/histories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 백업 히스토리 조회
curl -X GET "https://api.example.com/api/backups/histories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/backups/histories?result=success&server=server-01" \
  -H "Authorization: Bearer <token>"

# 파티션 필터 적용 조회
curl -X GET "https://api.example.com/api/backups/histories?server=server-01&partition=C:" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/backups/histories?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 작업 대상 서버 이름 필터 | - |
| `partition` | Query | string | Optional | - | 드라이브/파티션 필터 (정확 매칭) | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | `success`, `failed` |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능) | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

> **참고:**
> - `partition` 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`가 모두 허용됩니다. 서버 OS나 `server` 지정 여부와 관계없이 값 자체로 판별해 저장 표기로 맞춥니다. (예: `C` → `C:`)
> - `server`, `center`는 **키만 보내고 값이 비면**(`?center=`) 400입니다. 파라미터를 **생략**하는 것은 종전대로 "해당 필터 없음"이며 동작이 달라지지 않습니다.
> - `center`는 ID/이름을 콤마로 여러 개 지정할 수 있습니다. (예: `?center=1,zdm-b`)
> - `server`는 서버 **이름**으로만 필터링합니다.
> - 조건에 맞는 이력이 없으면 **200 + 빈 배열**입니다. 404가 아닙니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
    },
    {
      "id": 2,
      "system": {
        "name": "server-02"
      },
      "job": {
        "name": "weekly-backup",
        "id": 20,
        "backupType": "Increment Backup",
        "drive": "/",
        "repositoryPath": "/backup/server-02"
      },
      "result": {
        "status": "FAIL",
        "description": "Disk space insufficient"
      },
      "time": {
        "start": "2026-03-03 03:00:00",
        "end": "2026-03-03 03:05:00",
        "elapsed": "00:05:00"
      }
    }
  ],
  "message": "Backup history list",
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Backup history list",
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>빈 결과 응답 (200 OK)</summary>

> 일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열을 반환합니다 (에러가 아님).

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Backup history list",
  "success": true,
  "data": [],
  "timestamp": "2026-03-03T10:30:00.000+09:00"
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
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Token has expired."
  },
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "result": ["result must be one of: success, failed"]
    }
  },
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

`server` 또는 `center`를 키만 보내고 값을 비운 경우에도 400입니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["center must contain at least one identifier"]
    }
  },
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

</details>

---
