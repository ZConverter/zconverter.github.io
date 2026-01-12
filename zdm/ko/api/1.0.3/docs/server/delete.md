---
layout: docs
title: DELETE /servers/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 서버 및 관련 데이터를 삭제합니다.

---

## `DELETE /servers/:identifier` {#delete-servers-identifier}

> * 서버 ID 또는 서버 이름으로 특정 서버를 삭제합니다.
> * 서버 삭제 시 관련된 모든 데이터(disk, network, partition, repository)도 함께 삭제됩니다.
> * 삭제 작업은 트랜잭션으로 처리되어 원자성이 보장됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/v1/servers/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 삭제
curl -X DELETE "https://api.example.com/api/v1/servers/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 삭제
curl -X DELETE "https://api.example.com/api/v1/servers/server-01" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "result": "success",
    "server": {
      "id": 1,
      "name": "server-01"
    },
    "message": "Server 및 관련 데이터가 성공적으로 삭제되었습니다. (disk: 2, network: 3, partition: 5, repository: 1)"
  },
  "message": "Server deletion completed",
  "timestamp": "2025-01-15T10:30:00Z"
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
  "requestID": "req-abc123",
  "error": {
    "code": "SERVER_NOT_FOUND",
    "message": "ID가 '999'인 Server를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary><strong>삭제되는 관련 데이터</strong></summary>

서버 삭제 시 다음 테이블의 관련 데이터가 함께 삭제됩니다:

| 테이블 | 설명 | 삭제 기준 |
|--------|------|-----------|
| `server_basic` | 서버 기본 정보 | 서버 ID 또는 이름 |
| `server_disk` | 디스크 정보 | sSystemName 일치 |
| `server_network` | 네트워크 정보 | sSystemName 일치 |
| `server_partition` | 파티션 정보 | sSystemName 일치 |
| `server_repository` | 레포지토리 정보 | sSystemName 일치 |

</details>

---
