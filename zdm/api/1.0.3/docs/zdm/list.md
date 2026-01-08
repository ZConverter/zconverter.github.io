---
layout: docs
title: GET /zdms
section_title: ZDM API Documentation
navigation: api-1.0.3
---

등록된 전체 ZDM(센터) 목록을 조회합니다.

---

## `GET /zdms` {#get-zdms}

> * 시스템에 등록된 모든 ZDM(센터) 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 ZDM만 조회할 수 있습니다.
> * 추가 정보(network, disk, partition, repository)를 선택적으로 포함할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 ZDM 목록 조회
curl -X GET "https://api.example.com/api/v1/zdms" \
  -H "Authorization: Bearer <token>"

# 연결 상태별 조회
curl -X GET "https://api.example.com/api/v1/zdms?connection=connect" \
  -H "Authorization: Bearer <token>"

# 추가 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/zdms?detail=true&repository=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `connection` | Query | string | Optional | - | 연결 상태 필터 | {% include zdm/connection-status.md %} |
| `activation` | Query | string | Optional | - | 활성화 상태 필터 | {% include zdm/zdm-activation.md %} |
| `network` | Query | boolean | Optional | `false` | 네트워크 정보 포함 여부 | `true`, `false` |
| `disk` | Query | boolean | Optional | `false` | 디스크 정보 포함 여부 | `true`, `false` |
| `partition` | Query | boolean | Optional | `false` | 파티션 정보 포함 여부 | `true`, `false` |
| `repository` | Query | boolean | Optional | `false` | 레포지토리 정보 포함 여부 | `true`, `false` |
| `zosRepository` | Query | boolean | Optional | `false` | ZOS 레포지토리 정보 포함 여부 | `true`, `false` |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1", "10.0.0.2"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>디스크 정보 포함 응답 (disk=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "disk": [
        {
          "diskCaption": "Samsung SSD 970",
          "diskType": "SSD",
          "diskSize": {
            "raw": 512110190592,
            "formatted": "477.0 GB"
          },
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>네트워크 정보 포함 응답 (network=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "network": [
        {
          "name": "eth0",
          "ipAddress": "192.168.1.100",
          "subNet": "255.255.255.0",
          "gateWay": "192.168.1.1",
          "macAddress": "00:1A:2B:3C:4D:5E",
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>파티션 정보 포함 응답 (partition=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "partition": [
        {
          "letter": "/",
          "device": "/dev/sda1",
          "size": {
            "raw": 107374182400,
            "formatted": "100.0 GB"
          },
          "used": {
            "raw": 53687091200,
            "formatted": "50.0 GB"
          },
          "free": {
            "raw": 53687091200,
            "formatted": "50.0 GB"
          },
          "usage": 50,
          "fileSystem": "ext4",
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>레포지토리 정보 포함 응답 (repository=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "repository": [
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
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>ZOS 레포지토리 정보 포함 응답 (zosRepository=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "name": {
        "center": "Main-Center",
        "host": "zdm-host-01"
      },
      "id": {
        "center": "1",
        "install": "INST-001",
        "machine": "550e8400-e29b-41d4-a716-446655440000"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "status": {
        "connect": "connect",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "zosRepository": [
        {
          "id": "1",
          "centerName": "Main-Center",
          "size": "500GB",
          "platform": "AWS",
          "cloudKeyId": "1",
          "bucketName": "zdm-backup-bucket",
          "created": "2025-01-01T00:00:00Z",
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "ZDM information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

<details markdown="1" open>
<summary>기본 필드</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `name.center` | string | ZDM 센터 이름 |
| `name.host` | string | ZDM 호스트 이름 |
| `id.center` | string | ZDM 센터 ID |
| `id.install` | string | ZDM 설치 ID |
| `id.machine` | string | ZDM 머신 ID (UUID) |
| `os.version` | string | 운영체제 버전 |
| `ip.public` | string | 공인 IP 주소 |
| `ip.private` | string[] | 사설 IP 주소 목록 |
| `status.connect` | string | 연결 상태 (`connect` / `disconnect`) |
| `status.activate` | string | 활성화 상태 (`ok` / `fail`) |
| `path.logFile` | string | 로그 파일 경로 |
| `path.install` | string | 설치 경로 |
| `lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>디스크 필드 (disk=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `disk[].diskCaption` | string | 디스크 이름 |
| `disk[].diskType` | string | 디스크 타입 |
| `disk[].diskSize.raw` | number | 디스크 크기 (bytes) |
| `disk[].diskSize.formatted` | string | 디스크 크기 (포맷) |
| `disk[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>네트워크 필드 (network=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `network[].name` | string | 네트워크 인터페이스 이름 |
| `network[].ipAddress` | string | IP 주소 |
| `network[].subNet` | string | 서브넷 마스크 |
| `network[].gateWay` | string | 게이트웨이 |
| `network[].macAddress` | string | MAC 주소 |
| `network[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>파티션 필드 (partition=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `partition[].letter` | string | 마운트 포인트(Linux) / 드라이브 문자(Windows) |
| `partition[].device` | string | 디바이스 경로 |
| `partition[].size.raw` | number | 전체 크기 (bytes) |
| `partition[].size.formatted` | string | 전체 크기 (포맷) |
| `partition[].used.raw` | number | 사용 중인 용량 (bytes) |
| `partition[].used.formatted` | string | 사용 중인 용량 (포맷) |
| `partition[].free.raw` | number | 남은 용량 (bytes) |
| `partition[].free.formatted` | string | 남은 용량 (포맷) |
| `partition[].usage` | number | 사용률 (0-100) |
| `partition[].fileSystem` | string | 파일 시스템 |
| `partition[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>레포지토리 필드 (repository=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `repository[].id` | string | 레포지토리 ID |
| `repository[].center` | string | 센터 이름 |
| `repository[].os` | string | 운영체제 |
| `repository[].type` | string | 레포지토리 타입 (`NFS` / `SMB`) |
| `repository[].size.raw` | number | 전체 크기 (bytes) |
| `repository[].size.formatted` | string | 전체 크기 (포맷) |
| `repository[].used.raw` | number | 사용 중인 용량 (bytes) |
| `repository[].used.formatted` | string | 사용 중인 용량 (포맷) |
| `repository[].free.raw` | number | 남은 용량 (bytes) |
| `repository[].free.formatted` | string | 남은 용량 (포맷) |
| `repository[].usage` | number | 사용률 (0-100) |
| `repository[].remotePath` | string | 원격 경로 |
| `repository[].localPath` | string | 로컬 경로 |
| `repository[].ipAddress` | string[] | 접속 IP 목록 |
| `repository[].port` | string | 포트 번호 |
| `repository[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>ZOS 레포지토리 필드 (zosRepository=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `zosRepository[].id` | string | ZOS 레포지토리 ID |
| `zosRepository[].centerName` | string | 센터 이름 |
| `zosRepository[].size` | string | 크기 |
| `zosRepository[].platform` | string | 클라우드 플랫폼 |
| `zosRepository[].cloudKeyId` | string | 클라우드 키 ID |
| `zosRepository[].bucketName` | string | 버킷 이름 |
| `zosRepository[].created` | string | 생성 시간 |
| `zosRepository[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

</details>

---
