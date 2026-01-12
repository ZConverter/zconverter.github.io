---
layout: docs
title: GET /servers
section_title: ZDM API Documentation
navigation: api-1.0.3
---

등록된 전체 서버 목록을 조회합니다.

---

## `GET /servers` {#get-servers}

> * 시스템에 등록된 모든 서버 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 서버만 조회할 수 있습니다.
> * 추가 정보(disk, network, partition, repository)를 선택적으로 포함할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/servers</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 서버 목록 조회
curl -X GET "https://api.example.com/api/v1/servers" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/servers?mode=source&os=lin&connection=connect" \
  -H "Authorization: Bearer <token>"

# 추가 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/servers?disk=true&network=true&detail=true" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/v1/servers?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `mode` | Query | string | Optional | - | 서버 모드 필터 | {% include zdm/server-modes.md %} |
| `os` | Query | string | Optional | - | 운영체제 타입 필터 | {% include zdm/os-types.md cloud=true %} |
| `connection` | Query | string | Optional | - | 연결 상태 필터 | {% include zdm/connection-status.md %} |
| `license` | Query | string | Optional | - | 라이선스 할당 상태 필터 | {% include zdm/license-assign-status.md %} |
| `disk` | Query | boolean | Optional | `false` | 디스크 정보 포함 여부 | `true`, `false` |
| `network` | Query | boolean | Optional | `false` | 네트워크 정보 포함 여부 | `true`, `false` |
| `partition` | Query | boolean | Optional | `false` | 파티션 정보 포함 여부 | `true`, `false` |
| `repository` | Query | boolean | Optional | `false` | 레포지토리 정보 포함 여부 | `true`, `false` |
| `detail` | Query | boolean | Optional | `false` | 상세 정보(리소스 등) 포함 여부 | `true`, `false` |
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1", "10.0.0.2"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "Server information list",
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1", "10.0.0.2"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "lastUpdated": "2025-01-15T10:30:00Z"
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
  "message": "Server information list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>상세 정보 포함 응답 (detail=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source",
        "version": "3.2.1"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "resources": {
        "model": "PowerEdge R740",
        "type": "Physical",
        "manufacturer": "Dell Inc.",
        "kernel": "5.15.0-generic",
        "cpu": "Intel Xeon Gold 6248R",
        "cpuCount": "48",
        "memory": "137438953472 (128.0 GB)"
      },
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "Server information list",
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "disk": [
        {
          "caption": "Samsung SSD 970",
          "device": "/dev/sda",
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
  "message": "Server information list",
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
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
  "message": "Server information list",
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "partition": [
        {
          "system": "server-01",
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
  "message": "Server information list",
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
      "id": "1",
      "name": "server-01",
      "agent": {
        "mode": "Source"
      },
      "os": {
        "version": "Ubuntu 22.04 LTS"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.1"]
      },
      "license": {
        "id": "5"
      },
      "status": {
        "connect": "connect"
      },
      "repository": [
        {
          "id": "1",
          "os": "Linux",
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
          "type": "NFS",
          "localPath": "/mnt/backup",
          "remotePath": "/backup",
          "remoteUser": "admin",
          "ipAddress": ["192.168.1.200"],
          "port": "2049",
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-15T10:30:00Z"
    }
  ],
  "message": "Server information list",
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
| `id` | string | 서버 ID |
| `name` | string | 서버 이름 |
| `agent.mode` | string | 에이전트 모드 (`Source` / `Target`) |
| `os.version` | string | 운영체제 버전 |
| `ip.public` | string | 공인 IP 주소 |
| `ip.private` | string[] | 사설 IP 주소 목록 |
| `license.id` | string | 할당된 라이선스 ID |
| `status.connect` | string | 연결 상태 (`connect` / `disconnect`) |
| `lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>상세 필드 (detail=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `agent.version` | string | 에이전트 버전 |
| `resources.model` | string | 서버 모델명 |
| `resources.type` | string | 시스템 타입 |
| `resources.manufacturer` | string | 제조사 |
| `resources.kernel` | string | 커널 버전 |
| `resources.cpu` | string | CPU 이름 |
| `resources.cpuCount` | string | CPU 코어 수 |
| `resources.memory` | string | 총 메모리 크기 |

</details>

<details markdown="1">
<summary>디스크 필드 (disk=true)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `disk[].caption` | string | 디스크 이름 |
| `disk[].device` | string | 디바이스 경로 |
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
| `partition[].system` | string | 서버 이름 |
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
| `repository[].os` | string | 운영체제 |
| `repository[].size.raw` | number | 전체 크기 (bytes) |
| `repository[].size.formatted` | string | 전체 크기 (포맷) |
| `repository[].used.raw` | number | 사용 중인 용량 (bytes) |
| `repository[].used.formatted` | string | 사용 중인 용량 (포맷) |
| `repository[].free.raw` | number | 남은 용량 (bytes) |
| `repository[].free.formatted` | string | 남은 용량 (포맷) |
| `repository[].usage` | number | 사용률 (0-100) |
| `repository[].type` | string | 레포지토리 타입 (`NFS` / `SMB`) |
| `repository[].localPath` | string | 로컬 경로 |
| `repository[].remotePath` | string | 원격 경로 |
| `repository[].remoteUser` | string | 접속 사용자 |
| `repository[].ipAddress` | string[] | 접속 IP 목록 |
| `repository[].port` | string | 포트 번호 |
| `repository[].lastUpdated` | string | 마지막 업데이트 시간 |

</details>

<details markdown="1">
<summary>페이지네이션 필드 (page, limit 파라미터 사용 시)</summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

</details>

---
