---
layout: docs
title: Server Management
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/index"
      - title: "Overview"
        url: "/zdm/api/docs/overview"
      - title: "Authentication"
        url: "/zdm/api/docs/authentication"
      - title: "User Management"
        url: "/zdm/api/docs/users"
      - title: "Server Management"
        url: "/zdm/api/docs/servers"
        sublinks:
          - title: "서버 목록 조회"
            url: "/zdm/api/docs/servers#get-servers"
          - title: "특정 서버 조회"
            url: "/zdm/api/docs/servers#get-server"
          - title: "서버 파티션 조회"
            url: "/zdm/api/docs/servers#get-server-partitions"
          - title: "전체 파티션 조회"
            url: "/zdm/api/docs/servers#get-partitions"
      - title: "Schedule Management"
        url: "/zdm/api/docs/schedules"
      - title: "Backup Management"
        url: "/zdm/api/docs/backups"
      - title: "Recovery Management"
        url: "/zdm/api/docs/recoveries"
      - title: "File Management"
        url: "/zdm/api/docs/files"
      - title: "License Management"
        url: "/zdm/api/docs/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs/zdm-centers"
---

### GET `/servers` {#get-servers}

서버 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| mode | string | Optional | 시스템 모드 (source, target) |
| os | string | Optional | 운영체제 타입 (linux, windows) |
| connection | string | Optional | 연결 상태 (online, offline) |
| license | string | Optional | 라이선스 할당 상태 |
| network | boolean | Optional | 네트워크 정보 포함 여부 |
| disk | boolean | Optional | 디스크 정보 포함 여부 |
| partition | boolean | Optional | 파티션 정보 포함 여부 |
| repository | boolean | Optional | 리포지토리 정보 포함 여부 |
| detail | boolean | Optional | 상세 정보 포함 여부 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-server-list",
  "data": [
    {
      "id": "1",
      "name": "web-server-01",
      "agent": {
        "mode": "source",
        "version": "1.0.0"
      },
      "os": {
        "version": "Ubuntu 20.04"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.100"]
      },
      "license": {
        "id": "LICENSE-001"
      },
      "status": {
        "connect": "online"
      },
      "disk": [],
      "network": [],
      "partition": [],
      "repository": [],
      "lastUpdated": "2024-01-31T10:30:45.123Z"
    }
  ],
  "message": "서버 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### GET `/servers/:identifier` {#get-server}

특정 서버 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 서버 ID 또는 서버명 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

위의 GET `/servers`와 동일

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-server-detail",
  "data": {
    "id": "1",
    "name": "web-server-01",
    "agent": {
      "mode": "source",
      "version": "1.0.0"
    },
    "os": {
      "version": "Ubuntu 20.04"
    },
    "ip": {
      "public": "192.168.1.100",
      "private": ["10.0.0.100"]
    },
    "license": {
      "id": "LICENSE-001"
    },
    "status": {
      "connect": "online"
    },
    "lastUpdated": "2024-01-31T10:30:45.123Z"
  },
  "message": "서버 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### GET `/servers/:identifier/partitions` {#get-server-partitions}

특정 서버의 파티션 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 서버 ID 또는 서버명 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| detail | boolean | Optional | 상세 정보 포함 여부 |

</details>

---
### GET `/servers/partitions` {#get-partitions}

모든 서버의 파티션 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| serverName | string | Optional | 서버명 필터 |
| detail | boolean | Optional | 상세 정보 포함 여부 |

</details>
