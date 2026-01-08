---
layout: docs
title: GET /zdms/repositories
section_title: ZDM API Documentation
navigation: api-1.0.3
---

전체 ZDM 레포지토리 목록을 조회합니다.

---

## `GET /zdms/repositories` {#get-zdms-repositories}

> * 시스템에 등록된 모든 ZDM 레포지토리 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 레포지토리만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms/repositories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 레포지토리 조회
curl -X GET "https://api.example.com/api/v1/zdms/repositories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/zdms/repositories?type=nfs" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `center` | Query | string | Optional | - | 센터 이름 또는 ID 필터 | - |
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
    }
  ],
  "message": "Repository list retrieved",
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

---
