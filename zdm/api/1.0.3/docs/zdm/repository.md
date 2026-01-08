---
layout: docs
title: GET /zdms/:identifier/repositories
section_title: ZDM API Documentation
navigation: api-1.0.3
---

특정 ZDM의 레포지토리 정보를 조회합니다.

---

## `GET /zdms/:identifier/repositories` {#get-zdms-identifier-repositories}

> * 특정 ZDM의 레포지토리 목록을 조회합니다.
> * ZDM ID 또는 ZDM 이름으로 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms/:identifier/repositories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ZDM ID로 레포지토리 조회
curl -X GET "https://api.example.com/api/v1/zdms/1/repositories" \
  -H "Authorization: Bearer <token>"

# ZDM 이름으로 레포지토리 조회
curl -X GET "https://api.example.com/api/v1/zdms/Main-Center/repositories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/zdms/1/repositories?type=nfs" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | ZDM ID (숫자) 또는 ZDM 이름 | - |
| `type` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `os` | Query | string | Optional | - | OS 필터 | - |
| `path` | Query | string | Optional | - | 경로 필터 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": "1",
      "center": "Main-Center",
      "os": "Linux",
      "type": "NFS",
      "size": {
        "raw": 1099511627776,
        "formatted": "1.0 TB"
      },
      "used": {
        "raw": 549755813888,
        "formatted": "512.0 GB"
      },
      "free": {
        "raw": 549755813888,
        "formatted": "512.0 GB"
      },
      "usage": 50,
      "remotePath": "/backup",
      "localPath": "/mnt/backup",
      "ipAddress": ["192.168.1.200"],
      "port": "2049",
      "lastUpdated": "2025-01-15T10:30:00Z"
    },
    {
      "id": "2",
      "center": "Main-Center",
      "os": "Windows",
      "type": "SMB",
      "size": {
        "raw": 2199023255552,
        "formatted": "2.0 TB"
      },
      "used": {
        "raw": 1099511627776,
        "formatted": "1.0 TB"
      },
      "free": {
        "raw": 1099511627776,
        "formatted": "1.0 TB"
      },
      "usage": 50,
      "remotePath": "backup",
      "localPath": "B:",
      "ipAddress": ["192.168.1.201"],
      "port": "445",
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "Repository information retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | string | 레포지토리 ID |
| `center` | string | 센터 이름 |
| `os` | string | 운영체제 |
| `type` | string | 레포지토리 타입 (`NFS` / `SMB`) |
| `size.raw` | number | 전체 크기 (bytes) |
| `size.formatted` | string | 전체 크기 (포맷) |
| `used.raw` | number | 사용 중인 용량 (bytes) |
| `used.formatted` | string | 사용 중인 용량 (포맷) |
| `free.raw` | number | 남은 용량 (bytes) |
| `free.formatted` | string | 남은 용량 (포맷) |
| `usage` | number | 사용률 (0-100) |
| `remotePath` | string | 원격 경로 |
| `localPath` | string | 로컬 경로 |
| `ipAddress` | string[] | 접속 IP 목록 |
| `port` | string | 포트 번호 |
| `lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**ZDM을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "ZDM_NOT_FOUND",
    "message": "ID가 '999'인 ZDM을 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
