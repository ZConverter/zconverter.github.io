---
layout: docs
title: GET /recoveries/histories
section_title: ZDM API Documentation
navigation: ko-api-2.0.0
lang: ko
---

복구 작업의 실행 히스토리 목록을 조회합니다.

---

## `GET /recoveries/histories` {#get-recoveries-histories}

> * 복구 작업의 실행 이력(히스토리) 목록을 조회합니다.
> * 필터 옵션을 통해 특정 조건의 히스토리만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/histories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 복구 히스토리 조회
curl -X GET "https://api.example.com/api/recoveries/histories" \
  -H "Authorization: Bearer <token>"

# 타겟 서버로 필터 (기본값: target)
curl -X GET "https://api.example.com/api/recoveries/histories?server=target-server" \
  -H "Authorization: Bearer <token>"

# 소스 서버로 필터
curl -X GET "https://api.example.com/api/recoveries/histories?server=source-server&serverType=source" \
  -H "Authorization: Bearer <token>"

# 파티션 + 결과 필터
curl -X GET "https://api.example.com/api/recoveries/histories?partition=C:&result=failed" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/recoveries/histories?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 서버 이름 필터 (`serverType`에 따라 소스/타겟 구분) | - |
| `serverType` | Query | string | Optional | `target` | 서버 타입 (`server`와 함께 사용) | `source`, `target` |
| `partition` | Query | string | Optional | - | 드라이브/파티션 필터 (개별 항목 정확 매칭) | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | `success`, `failed` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

> **참고:**
> - `serverType`이 `target`(기본값)이면 `server`는 복구 대상 서버(`sRecoverySystemName`)를, `source`이면 소스 서버(`sSystemName`)를 기준으로 필터링합니다.
> - `partition` 파라미터는 콤마 구분된 `sRecoverDrive` 필드에서 개별 항목을 정확히 매칭합니다.
> - `partition` + `server` 사용 시, 해당 서버가 Windows이면 `:` 누락 시 자동으로 추가됩니다. (예: `C` → `C:`)

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
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
    },
    {
      "id": 2,
      "system": {
        "name": "linux-server"
      },
      "job": {
        "name": "weekly-recovery",
        "id": 20,
        "recoverySystemName": "target-linux",
        "recoverDrive": ["/"]
      },
      "result": {
        "status": "FAIL",
        "description": "Target server unreachable"
      },
      "time": {
        "start": "2026-03-03 11:00:00",
        "end": "2026-03-03 11:05:00",
        "elapsed": "00:05:00"
      }
    }
  ],
  "message": "Recovery history list",
  "timestamp": "2026-03-03 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
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
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalItems": 25,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Recovery history list",
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
  "requestID": "req-abc123",
  "success": false,
  "error": "Token has expired.",
  "timestamp": "2026-03-03 10:30:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Invalid enum value. Expected 'success' | 'failed', received 'unknown'",
  "timestamp": "2026-03-03 10:30:00"
}
```

</details>

---
