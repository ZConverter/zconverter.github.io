
전체 서버의 파티션 정보를 조회합니다.

---

## `GET /servers/partitions` {#get-servers-partitions}

> * 시스템에 등록된 모든 서버의 파티션 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 파티션만 조회할 수 있습니다.
> * 작업 대상이 될 수 없는 파티션(swap, `/media/cdrom*`, `/mnt/cdrom` 등 `free` 용량이 0인 파티션)은 응답에서 자동 제외됩니다.
> * `partition` 과 `drive` 는 **같은 컬럼을 가리키는 하나의 필터**입니다. 둘을 함께 지정하면 400이므로 **둘 중 하나만** 사용하세요. `?partition=` · `?drive=` 처럼 키만 보내고 값이 비어도 400입니다.
> * 값 형식은 API가 정규화하므로 `C`, `C:`, `/data` 를 그대로 쓸 수 있습니다. OS에 따라 파라미터를 갈라 쓸 필요가 없습니다.
> * 여기의 `partition` 은 **파티션 하나를 지목하는 값**입니다. `GET /servers` · `GET /servers/:identifier` 의 `partition` 은 "파티션 정보를 응답에 포함할지" 를 묻는 **포함 플래그(`true`/`false`)** 로 의미가 다릅니다. `?partition=true` 관용구를 이 API에 그대로 옮겨 쓰면 조용히 0건이 됩니다.
> * `center` 는 ID 또는 이름을 콤마로 여러 개 지정할 수 있습니다. 파라미터를 **생략**하면 종전대로 center 필터 없이 조회하지만, `?center=` 처럼 **키만 보내고 값이 비면 400**입니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/servers/partitions</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 파티션 정보 조회
curl -X GET "https://api.example.com/api/servers/partitions" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/servers/partitions?fileSystem=ext4" \
  -H "Authorization: Bearer <token>"

# 파티션 지목 필터 (값 형식은 API가 정규화 - "/home", "C", "C:" 모두 허용)
curl -X GET "https://api.example.com/api/servers/partitions?partition=/home" \
  -H "Authorization: Bearer <token>"

# drive는 partition과 같은 컬럼을 가리키는 별칭 - 둘 중 하나만 사용 (동시 지정 시 400)
curl -X GET "https://api.example.com/api/servers/partitions?drive=C" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/servers/partitions?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `partition` | Query | string | Optional | - | 파티션 지목 필터 (`/home`, `C`, `C:` 모두 허용 - API가 정규화). `drive` 와 동시 지정 불가, 값이 빈 `?partition=` 는 400 | - |
| `drive` | Query | string | Optional | - | `partition` 과 **같은 컬럼**을 가리키는 별칭. 동시 지정 시 400, 값이 빈 `?drive=` 도 400 | - |
| `device` | Query | string | Optional | - | 디바이스 경로 필터 | - |
| `fileSystem` | Query | string | Optional | - | 파일 시스템 타입 필터 | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`). 값이 빈 `?center=` 는 400 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

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
      "system": "server-01",
      "letter": "/",
      "device": "/dev/sda1",
      "size": {
        "raw": 107374182400,
        "formatted": "100.0 GB"
      },
      "used": {
        "raw": 21474836480,
        "formatted": "20.0 GB"
      },
      "free": {
        "raw": 85899345920,
        "formatted": "80.0 GB"
      },
      "usage": 20,
      "fileSystem": "ext4",
      "lastUpdated": "2025-01-15 10:30:00"
    },
    {
      "system": "server-02",
      "letter": "C:",
      "device": "\\Device\\HarddiskVolume1",
      "size": {
        "raw": 214748364800,
        "formatted": "200.0 GB"
      },
      "used": {
        "raw": 107374182400,
        "formatted": "100.0 GB"
      },
      "free": {
        "raw": 107374182400,
        "formatted": "100.0 GB"
      },
      "usage": 50,
      "fileSystem": "NTFS",
      "lastUpdated": "2025-01-15 10:30:00"
    }
  ],
  "message": "Partition information list",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
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
      "system": "server-01",
      "letter": "/",
      "device": "/dev/sda1",
      "size": {
        "raw": 107374182400,
        "formatted": "100.0 GB"
      },
      "used": {
        "raw": 21474836480,
        "formatted": "20.0 GB"
      },
      "free": {
        "raw": 85899345920,
        "formatted": "80.0 GB"
      },
      "usage": 20,
      "fileSystem": "ext4",
      "lastUpdated": "2025-01-15 10:30:00"
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
  "message": "Partition information list",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>빈 결과 응답 (200 OK)</summary>

> 일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열을 반환합니다 (에러가 아님).

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": [],
  "message": "Partition information list",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system` | string | 서버 이름 |
| `letter` | string | 마운트 포인트 (Linux) 또는 드라이브 문자 (Windows) |
| `device` | string | 디바이스 경로 |
| `size.raw` | number | 전체 크기 (bytes) |
| `size.formatted` | string | 전체 크기 (포맷) |
| `used.raw` | number | 사용 중인 용량 (bytes) |
| `used.formatted` | string | 사용 중인 용량 (포맷) |
| `free.raw` | number | 남은 용량 (bytes) |
| `free.formatted` | string | 남은 용량 (포맷) |
| `usage` | number | 사용률 (0-100) |
| `fileSystem` | string | 파일 시스템 타입 (ext4, NTFS 등) |
| `lastUpdated` | string | 마지막 업데이트 시간 |
| `pagination.currentPage` | number | 현재 페이지 번호 (페이지네이션 적용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (페이지네이션 적용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (페이지네이션 적용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (페이지네이션 적용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (페이지네이션 적용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (페이지네이션 적용 시) |

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
    "message": "Token expired."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**`partition` 과 `drive` 동시 지정 (400 Bad Request)**

두 파라미터는 같은 컬럼을 가리키는 하나의 필터이므로 함께 사용할 수 없습니다. 값 형식은 API가 정규화하므로 하나만 쓰면 됩니다. `?partition=` 처럼 값이 비어 쓸 수 있는 식별자가 하나도 남지 않는 경우에도 같은 400이 반환됩니다.

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

**`center` 빈 값 (400 Bad Request)**

`?center=` 처럼 키만 보내고 값이 비면 반환됩니다. 파라미터를 **생략**한 경우는 종전대로 "필터 없음"이며 동작 변화가 없습니다.

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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
