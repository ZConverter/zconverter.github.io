---
layout: docs
title: GET /backups/images/server/:serverName
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

서버별 백업 이미지 목록을 조회합니다.

---

## `GET /backups/images/server/:serverName` {#get-backups-images-server}

> * 특정 서버의 백업 이미지 목록을 조회합니다.
> * 저장소 경로는 환경변수 `BACKUP_REPOSITORY_PATH`에서 가져옵니다. (기본값: `/ZConverter`)
> * 만약 백업이미지가 존재하는데 검색시 []가 나오는 경우 `BACKUP_REPOSITORY_PATH`의 값을 backup이미지가 저장되는 디렉토리의 전체경로로 수정해주세요.
> * 고아 이미지 지원
  - 서버 정보가 삭제되어도 백업 이미지가 존재하면 조회 가능합니다.
  - 이 경우 OS 타입을 `UNKNOWN`으로 처리하여 `partition` 형식으로 응답합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/images/server/:serverName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 이름으로 조회
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 필터 (정확히 일치)
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?jobName=source-centos7-bios_ROOT" \
  -H "Authorization: Bearer <token>"

# Linux 파티션 필터
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?partition=/" \
  -H "Authorization: Bearer <token>"

# Windows 드라이브 필터
curl -X GET "https://api.example.com/api/backups/images/server/SOURCE-2012 (192.168.0.179)?drive=C" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?page=1&limit=10" \
  -H "Authorization: Bearer <token>"

# 필터 조합
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?jobName=source-centos7-bios_ROOT&partition=/&page=1&limit=10" \
  -H "Authorization: Bearer <token>"

# Center 및 Repository 필터
curl -X GET "https://api.example.com/api/backups/images/server/source-amazon2023-bios_(192.168.2.99)?center=6&repositoryId=13" \
  -H "Authorization: Bearer <token>"

# Repository Path 필터
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?repositoryPath=/ZConverter" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| `serverName` | Path | string | Required | - | ZDM에 등록된 서버 이름 ( source server )  |
| `center` | Query | string | Optional | - | Center ID 또는 이름으로 필터 |
| `repositoryId` | Query | number | Optional | - | Repository ID로 필터 |
| `repositoryPath` | Query | string | Optional | - | Repository 경로로 필터 (예: `/ZConverter`) |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 (정확히 일치) |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (Linux: `/`, `/boot` / Windows: `C`, `C:` 콜론 자동 제거) |
| `drive` | Query | string | Optional | - | Windows 드라이브 필터 (예: `C`, `C:`) |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 |

**필터링 동작:**
- `center`: 특정 Center의 백업 이미지만 조회 (미지정 시 모든 Center)
- `repositoryId`: 특정 Repository에 저장된 백업 이미지만 조회 (미지정 시 모든 Repository)
- `jobName`: 작업 이름과 정확히 일치하는 경우만 반환
- `partition`: Linux/Windows 모두 지원. 정확히 일치하는 경우만 반환 (Windows: `C:` → `C`로 콜론 자동 제거)
- `drive`: Windows 서버의 드라이브 문자와 정확히 일치하는 경우만 반환 (`C`, `C:` 모두 허용)

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "image": {
        "name": "source-centos7-bios_ROOT_[2026-01-07_08_44].ZIA",
        "jobName": "source-centos7-bios_ROOT",
        "type": "full",
        "size": {
          "raw": 831622708,
          "formatted": "793.17 MB"
        },
        "createdAt": "2026-01-07 08:43:48",
        "compression": {
          "enabled": true,
          "ratio": "35.72%"
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        }
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/",
        "device": "/dev/mapper/centos-root",
        "size": {
          "raw": 2328637440,
          "formatted": "2.17 GB"
        },
        "filesystem": "xfs"
      }
    },
    {
      "image": {
        "name": "source-centos7-bios_boot_[2026-01-08_01_19].ZIA",
        "jobName": "source-centos7-bios_boot",
        "type": "full",
        "size": {
          "raw": 113541428,
          "formatted": "108.29 MB"
        },
        "createdAt": "2026-01-08 01:19:29",
        "compression": {
          "enabled": true,
          "ratio": "72.18%"
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        }
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/boot",
        "device": "/dev/sda1",
        "size": {
          "raw": 157310976,
          "formatted": "150.04 MB"
        },
        "filesystem": "xfs"
      }
    }
  ],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>Windows 서버 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "image": {
        "name": "SOURCE-2012_C.ZIA",
        "jobName": "SOURCE-2012_C",
        "type": "full",
        "size": {
          "raw": 8416938102,
          "formatted": "7.84 GB"
        },
        "createdAt": "2025-12-22 16:30:01",
        "compression": {
          "enabled": true,
          "ratio": "45.46%"
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        }
      },
      "server": {
        "name": "SOURCE-2012 (192.168.0.179)",
        "os": "Windows Server 2012 R2 Standard[64bit]"
      },
      "drive": {
        "letter": "C:",
        "size": {
          "raw": 18513952768,
          "formatted": "17.24 GB"
        },
        "filesystem": ""
      }
    }
  ],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-24 08:00:00"
}
```

</details>

<details markdown="1" open>
<summary>페이지네이션 적용 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "image": {
        "name": "source-centos7-bios_ROOT_[2026-01-07_08_44].ZIA",
        "jobName": "source-centos7-bios_ROOT",
        "type": "full",
        "size": {
          "raw": 831622708,
          "formatted": "793.17 MB"
        },
        "createdAt": "2026-01-07 08:43:48",
        "compression": {
          "enabled": true,
          "ratio": "35.72%"
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        }
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/",
        "device": "/dev/mapper/centos-root",
        "size": {
          "raw": 2328637440,
          "formatted": "2.17 GB"
        },
        "filesystem": "xfs"
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 2,
    "totalItems": 15,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>이미지 없음 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

**공통 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data` | array | 백업 이미지 목록 |
| `data[].image` | object | 이미지 정보 |
| `data[].image.name` | string | 백업 이미지 이름 |
| `data[].image.jobName` | string | 백업 작업 이름 |
| `data[].image.type` | string | 백업 타입 (`full`, `increment`) |
| `data[].image.size` | object | 이미지 크기 정보 |
| `data[].image.size.raw` | number | 이미지 크기 원본 값 (bytes) |
| `data[].image.size.formatted` | string | 이미지 크기 포맷팅 값 (예: "793.17 MB") |
| `data[].image.createdAt` | string | 백업 이미지 생성 시간 |
| `data[].image.compression` | object | 압축 정보 |
| `data[].image.compression.enabled` | boolean | 압축 여부 |
| `data[].image.compression.ratio` | string | 압축률 (이미지크기/파티션크기, 예: "35.72%") |
| `data[].image.repository` | object | Repository 정보 |
| `data[].image.repository.id` | number | Repository ID |
| `data[].image.repository.path` | string | Repository 경로 (예: "/ZConverter") |
| `data[].server` | object | 서버 정보 |
| `data[].server.name` | string | 백업 대상 서버 이름 |
| `data[].server.os` | string | 서버 운영체제 |

**Linux 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].partition` | object | 파티션 정보 (Linux) |
| `data[].partition.mountPoint` | string | 마운트 포인트 (예: "/", "/boot") |
| `data[].partition.device` | string | 디바이스 경로 (예: "/dev/mapper/centos-root") |
| `data[].partition.size` | object | 파티션 크기 정보 |
| `data[].partition.size.raw` | number | 파티션 크기 원본 값 (bytes) |
| `data[].partition.size.formatted` | string | 파티션 크기 포맷팅 값 (예: "2.17 GB") |
| `data[].partition.filesystem` | string | 파일시스템 종류 (예: "xfs", "ext4") |

**Windows 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].drive` | object | 드라이브 정보 (Windows) |
| `data[].drive.letter` | string | 드라이브 문자 (예: "C:", "D:") |
| `data[].drive.size` | object | 드라이브 크기 정보 |
| `data[].drive.size.raw` | number | 드라이브 크기 원본 값 (bytes) |
| `data[].drive.size.formatted` | string | 드라이브 크기 포맷팅 값 (예: "17.24 GB") |
| `data[].drive.filesystem` | string | 파일시스템 종류 (예: "NTFS") |

**페이지네이션 필드** (page, limit 파라미터 사용 시)

| 필드 | 타입 | 설명 |
|------|------|------|
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**Center 미존재 (404 Not Found)**

요청한 Center를 찾을 수 없는 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "요청한 Center '6'을(를) 찾을 수 없습니다",
  "timestamp": "2026-01-28 08:42:51"
}
```

**Repository 미존재 (404 Not Found)**

요청한 Repository를 찾을 수 없는 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "요청한 Repository ID 14를 찾을 수 없습니다",
  "timestamp": "2026-01-28 08:42:51"
}
```

등록된 Repository가 하나도 없는 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "등록된 Repository가 없습니다",
  "timestamp": "2026-01-28 08:42:51"
}
```

**서버 미존재 (404 Not Found)**

이미지가 없고 서버도 존재하지 않는 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "서버 'invalid-server'을(를) 찾을 수 없습니다",
  "timestamp": "2026-01-09 10:30:00"
}
```

**백업 이미지 미존재 (404 Not Found)**

백업 이미지가 존재하지 않는 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "백업 이미지가 존재하지 않음 (Center: CenterName, Repository ID: 13)",
  "timestamp": "2026-01-28 08:42:51"
}
```

**작업 시간 초과 (500 Internal Server Error)**

백업 이미지 조회 작업이 10초 내에 완료되지 않은 경우:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "백업 이미지 조회 작업 시간 초과 (10초 경과, Center: CenterName, Repository ID: 13)",
  "timestamp": "2026-01-28 08:42:51"
}
```

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "서버 이름(serverName)이 필요합니다.",
  "timestamp": "2026-01-09 10:30:00"
}
```

</details>

---
