---
layout: docs
title: GET /servers/:identifier/partitions
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 서버의 파티션 정보를 조회합니다.

---

## `GET /servers/:identifier/partitions` {#get-servers-identifier-partitions}

> * 특정 서버의 파티션 정보만 조회합니다.
> * 서버 ID 또는 서버 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/servers/:identifier/partitions</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 파티션 조회
curl -X GET "https://api.example.com/api/v1/servers/1/partitions" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 파티션 조회
curl -X GET "https://api.example.com/api/v1/servers/server-01/partitions" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/servers/1/partitions?fileSystem=ext4" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/v1/servers/1/partitions?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `partition` | Query | string | Optional | - | 마운트 포인트 필터 (Linux) | - |
| `drive` | Query | string | Optional | - | 드라이브 문자 필터 (Windows) | - |
| `device` | Query | string | Optional | - | 디바이스 경로 필터 | - |
| `fileSystem` | Query | string | Optional | - | 파일 시스템 타입 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

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
      "lastUpdated": "2025-01-15T10:30:00Z"
    },
    {
      "system": "server-01",
      "letter": "/home",
      "device": "/dev/sda2",
      "size": {
        "raw": 536870912000,
        "formatted": "500.0 GB"
      },
      "used": {
        "raw": 107374182400,
        "formatted": "100.0 GB"
      },
      "free": {
        "raw": 429496729600,
        "formatted": "400.0 GB"
      },
      "usage": 20,
      "fileSystem": "ext4",
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "Partition information retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
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
      "lastUpdated": "2025-01-15T10:30:00Z"
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
  "message": "Partition information retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
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

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**서버를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "SERVER_NOT_FOUND",
    "message": "ID가 '999'인 Server를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
