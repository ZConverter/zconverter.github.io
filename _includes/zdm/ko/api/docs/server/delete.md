
특정 서버 및 관련 데이터를 삭제합니다.

---

## `DELETE /servers/:identifier` {#delete-servers-identifier}

> * 서버 ID 또는 서버 이름으로 특정 서버를 삭제합니다.
> * 서버 삭제 시 관련된 모든 데이터(disk, network, partition, repository)도 함께 삭제됩니다.
> * 삭제 작업은 트랜잭션으로 처리되어 원자성이 보장됩니다.
> * `center` 는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 주면 400이고, `?center=` 처럼 키만 보내고 값이 비어도 400입니다. 파라미터를 **생략**하는 것은 종전대로 허용됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/servers/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 삭제
curl -X DELETE "https://api.example.com/api/servers/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 삭제
curl -X DELETE "https://api.example.com/api/servers/server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `center` | Query | string | Optional | - | 삭제 대상 서버의 소속 center 식별자 (ID/이름). **정확히 1개만** 허용(여러 개·빈 값은 400). 지정 시 서버가 해당 center에 속하는지 검증 후 삭제. | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "result": "success",
    "server": {
      "id": 1,
      "name": "server-01"
    },
    "message": "Server and related data successfully deleted. (disk: 2, network: 3, partition: 5, repository: 1, backup: 2, recovery: 1)"
  },
  "message": "Server deletion completed",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `result` | string | 삭제 결과 (`success` / `fail`) |
| `server.id` | number | 삭제된 서버 ID |
| `server.name` | string | 삭제된 서버 이름 |
| `message` | string | 삭제 결과 메시지 (관련 데이터 삭제 건수 포함) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**서버를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SERVER-ERROR-01",
    "message": "Server with ID '999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**center 불일치 (403 Forbidden)**

`center` 쿼리에 지정된 center에 대상 서버가 소속되어 있지 않은 경우 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CENTER-ERROR-01",
    "message": "Server does not belong to center 'center-01'"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**`center` 다중 지정 / 빈 값 (400 Bad Request)**

삭제는 대상이 모호하면 안 되므로 `center` 는 정확히 1개만 허용합니다. 콤마로 여러 개를 주거나 `?center=` 처럼 값이 비면 반환됩니다. 이전에도 같은 규칙이었으나 검증 위치가 서비스 계층에서 요청 스키마로 옮겨져 에러 형식이 `DTO-VALIDATION-03` 으로 바뀌었습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["exactly one center must be specified"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary><strong>삭제되는 관련 데이터</strong></summary>

서버 삭제 시 다음 테이블의 관련 데이터가 함께 삭제됩니다:

| 테이블 | 설명 | 삭제 기준 |
|--------|------|-----------|
| `server_basic` | 서버 기본 정보 | 서버 ID 또는 이름 |
| `server_disk` | 디스크 정보 | 대상 서버 정보 |
| `server_network` | 네트워크 정보 | 대상 서버 정보 |
| `server_partition` | 파티션 정보 | 대상 서버 정보 |
| `server_repository` | 레포지토리 정보 | 대상 서버 정보 |

</details>

---
