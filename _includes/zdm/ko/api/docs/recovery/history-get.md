
특정 복구 히스토리를 조회합니다.

---

## `GET /recoveries/histories/:identifier` {#get-recoveries-histories-identifier}

> * 히스토리 ID 또는 작업 이름으로 복구 히스토리를 조회합니다.
> * identifier가 숫자인 경우 작업 ID로, 그 외에는 작업 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/histories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업 ID로 조회
curl -X GET "https://api.example.com/api/recoveries/histories/10" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 조회
curl -X GET "https://api.example.com/api/recoveries/histories/daily-recovery" \
  -H "Authorization: Bearer <token>"

# 작업 이름 + 필터 적용
curl -X GET "https://api.example.com/api/recoveries/histories/daily-recovery?result=failed&server=target-server" \
  -H "Authorization: Bearer <token>"

# center 범위를 지정해 조회
curl -X GET "https://api.example.com/api/recoveries/histories/10?center=1,zdm-b" \
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
| `server` | Query | string | Optional | - | 서버 이름 필터 (`serverType`에 따라 소스/타겟 구분) | - |
| `serverType` | Query | string | Optional | `target` | 서버 타입 (`server`와 함께 사용) | `source`, `target` |
| `partition` | Query | string | Optional | - | 드라이브/파티션 필터 (개별 항목 정확 매칭) | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | `success`, `failed` |
| `center` | Query | string | Optional | - | center 식별자 (ID/이름, comma-separated 다중 가능) | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

> **참고:**
> - `partition` 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`를 모두 그대로 쓸 수 있습니다. **OS에 따라 골라 쓸 필요 없이 하나만 사용**하면 됩니다. (예: `C` → `C:`)
> - `?server=`, `?partition=`처럼 **키만 보내고 값이 비어 있으면 400**입니다. 파라미터를 아예 **생략**하는 것(필터 없음)과는 다릅니다. `center`도 동일하게 `?center=`는 400입니다.
> - `center`는 ID/이름을 콤마로 여러 개 지정할 수 있습니다. (예: `?center=1,zdm-b`)
> - 조회 대상을 정하는 것은 경로의 `identifier`이고, `center`는 그 대상의 **조회 범위를 좁힙니다.** 지정한 `center`에 속하지 않는 히스토리는 404입니다. 존재하지 않는 center를 지정한 경우에도 404입니다. `center`를 **생략하면** center 스코프가 붙지 않아 종전과 동일하게 동작합니다.
> - **identifier 형태에 따라 적용되는 필터가 다릅니다.** 작업 이름으로 조회하면 `jobId`, `server`, `serverType`, `partition`, `result`, `sort`가 모두 결과에 반영되지만, **숫자(히스토리 ID)로 조회하면 `center`를 제외한 나머지 필터(`jobId`, `jobName`, `server`, `serverType`, `partition`, `result`, `sort`)가 무시되고 ID와 center만으로 단건을 반환합니다.** 같은 엔드포인트라도 identifier가 숫자인지 이름인지에 따라 결과가 달라지므로 주의하세요.
> - 작업 이름으로 조회할 때 `jobName` 쿼리는 경로의 `identifier`로 덮어써집니다. 두 값을 다르게 지정해도 경로 값이 우선합니다.
> - `page`, `limit`은 이 엔드포인트에서는 적용되지 않습니다(숫자/이름 두 분기 모두). 페이지 단위로 끊어 받으려면 목록 조회 `GET /recoveries/histories`를 사용하세요.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>ID로 조회 시 (단건 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 1,
    "system": {
      "name": "source-server"
    },
    "job": {
      "name": "daily-recovery",
      "id": 10,
      "recoverySystemName": "target-server",
      "recoverDrive": ["C:", "D:"]
    },
    "result": {
      "status": "COMPLETE",
      "description": "Recovery completed successfully"
    },
    "time": {
      "start": "2026-03-03 10:00:00",
      "end": "2026-03-03 10:30:00",
      "elapsed": "00:30:00"
    }
  },
  "message": "Recovery history retrieved",
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>작업 이름으로 조회 시 (목록 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "id": 1,
      "system": {
        "name": "source-server"
      },
      "job": {
        "name": "daily-recovery",
        "id": 10,
        "recoverySystemName": "target-server",
        "recoverDrive": ["C:", "D:"]
      },
      "result": {
        "status": "COMPLETE",
        "description": "Recovery completed successfully"
      },
      "time": {
        "start": "2026-03-03 10:00:00",
        "end": "2026-03-03 10:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "message": "Recovery history list",
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
| `system.name` | string | 소스 서버 이름 |
| `job.name` | string | 복구 작업 이름 |
| `job.id` | number | 복구 작업 ID |
| `job.recoverySystemName` | string | 복구 대상(타겟) 서버 이름 |
| `job.recoverDrive` | string[] | 복구 대상 드라이브/파티션 목록 |
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "NOT_FOUND",
    "message": "Recovery history not found (ID: 999)"
  },
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

작업 이름으로 조회한 경우 `message`는 `Recovery history not found (JobName: daily-recovery)` 형태입니다.

**center 범위 밖의 히스토리 (404 Not Found)**

숫자(히스토리 ID)로 조회했을 때 **히스토리는 존재하지만 지정한 `center`에 속하지 않는 경우**, 원인을 구분한 메시지가 반환됩니다. ID 자체가 잘못된 경우(위 예시)와 문구로 구별할 수 있습니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "NOT_FOUND",
    "message": "Recovery history ID '10' does not belong to Center 'zdm-b'"
  },
  "timestamp": "2026-03-03T10:30:00.000+09:00"
}
```

원인을 구분한 이 문구는 **숫자로 조회할 때만** 반환됩니다. 작업 이름으로 조회한 경우 center가 맞지 않아도 `Recovery history not found (JobName: daily-recovery)`가 반환됩니다. 또한 지정한 `center` 자체가 존재하지 않는 경우에는 이 문구가 아니라 위의 `Recovery history not found (ID: ...)`가 반환됩니다.

**잘못된 요청 파라미터 (400 Bad Request)**

`server`, `partition`, `center`를 키만 보내고 값을 비운 경우 반환됩니다.

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
