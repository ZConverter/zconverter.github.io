---
layout: docs
title: GET /backups/images/server/:serverName
section_title: ZDM API Documentation
navigation: api-1.0.3
---

서버별 백업 이미지 목록을 조회합니다.

---

## `GET /backups/images/server/:serverName` {#get-backups-images-server}

> * 특정 서버의 백업 이미지 목록을 조회합니다.
> * 저장소 경로는 환경변수 `BACKUP_REPOSITORY_PATH`에서 가져옵니다. (기본값: `/ZConverter`)

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups/images/server/:serverName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 이름으로 조회
curl -X GET "https://api.example.com/api/v1/backups/images/server/source-centos7-bios (192.168.2.104)" \
  -H "Authorization: Bearer <token>"

# 서버 이름 + 작업 이름으로 조회
curl -X GET "https://api.example.com/api/v1/backups/images/server/source-centos7-bios (192.168.2.104)?jobName=source-centos7-bios_ROOT" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| `serverName` | Path | string | Required | - | zdm에 등록된 서버 전체 이름 |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "images": [
      {
        "name": "source-centos7-bios_ROOT_[2026-01-07_08_44].ZIA",
        "time": "2026-01-07 08:43:48",
        "type": "full",
        "compressed": true,
        "size": {
          "partition": {
            "raw": 2328637440,
            "formatted": "2.17 GB"
          },
          "image": {
            "raw": 831622708,
            "formatted": "793.17 MB"
          },
          "compressionRatio": "35.72%"
        },
        "server": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64",
        "partition": {
          "mountPoint": "/",
          "device": "/dev/mapper/centos-root",
          "filesystem": "xfs",
          "diskNumber": 0,
          "partitionNumber": 1
        }
      },
      {
        "name": "source-centos7-bios_boot_[2026-01-08_01_19].ZIA",
        "time": "2026-01-08 01:19:29",
        "type": "full",
        "compressed": true,
        "size": {
          "partition": {
            "raw": 157310976,
            "formatted": "150.04 MB"
          },
          "image": {
            "raw": 113541428,
            "formatted": "108.29 MB"
          },
          "compressionRatio": "72.18%"
        },
        "server": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64",
        "partition": {
          "mountPoint": "/boot",
          "device": "/dev/sda1",
          "filesystem": "xfs",
          "diskNumber": 0,
          "partitionNumber": 2
        }
      }
    ],
    "total": 2
  },
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `images` | array | 백업 이미지 목록 |
| `images[].name` | string | 백업 이름 |
| `images[].time` | string | 백업 시간 |
| `images[].type` | string | 백업 타입 (`full`, `increment`) |
| `images[].compressed` | boolean | 압축 여부 |
| `images[].size` | object | 크기 정보 |
| `images[].size.partition` | object | 파티션 크기 |
| `images[].size.partition.raw` | number | 파티션 크기 원본 값 (bytes) |
| `images[].size.partition.formatted` | string | 파티션 크기 포맷팅 값 (예: "2.17 GB") |
| `images[].size.image` | object | 이미지 크기 |
| `images[].size.image.raw` | number | 이미지 크기 원본 값 (bytes) |
| `images[].size.image.formatted` | string | 이미지 크기 포맷팅 값 (예: "793.17 MB") |
| `images[].size.compressionRatio` | string | 압축률 (이미지크기/파티션크기, 예: "35.72%") |
| `images[].server` | string | 서버 정보 (예: "source-centos7-bios (192.168.2.104)") |
| `images[].os` | string | 운영체제 버전 |
| `images[].partition` | object | 파티션 정보 |
| `images[].partition.mountPoint` | string | 마운트 포인트 |
| `images[].partition.device` | string | 디바이스 경로 |
| `images[].partition.filesystem` | string | 파일시스템 종류 |
| `images[].partition.diskNumber` | number | 디스크 번호 |
| `images[].partition.partitionNumber` | number | 파티션 번호 |
| `total` | number | 조회된 이미지 총 개수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**ZConLinuxGetHeader 실행 오류 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "백업 이미지 조회 실패: Command failed..."
  },
  "timestamp": "2026-01-09T10:30:00Z"
}
```

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "서버 이름(serverName)이 필요합니다."
  },
  "timestamp": "2026-01-09T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary><strong>환경변수</strong></summary>

| 변수명 | 기본값 | 설명 |
|--------|--------|------|
| `BACKUP_REPOSITORY_PATH` | `/ZConverter` | 백업 이미지 저장소 경로 |

</details>

---
