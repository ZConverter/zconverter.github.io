---
layout: docs
title: Server Management
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "Overview & Authentication"
        url: "/zdm/api/docs_kr/overview"
      - title: "User Management"
        url: "/zdm/api/docs_kr/users"
      - title: "Server Management"
        url: "/zdm/api/docs_kr/servers"
      - title: "Schedule Management"
        url: "/zdm/api/docs_kr/schedules"
      - title: "Backup Management"
        url: "/zdm/api/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/api/docs_kr/recoveries"
      - title: "File Management"
        url: "/zdm/api/docs_kr/files"
      - title: "License Management"
        url: "/zdm/api/docs_kr/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

## Server Management

### GET `/servers`

서버 목록을 조회합니다.

**Query Parameters:**

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

**Response:**

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

### GET `/servers/:identifier`

특정 서버 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 서버 ID 또는 서버명 |

**Query Parameters:** (위의 GET `/servers`와 동일)

**Response:**

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

### GET `/servers/:identifier/partitions`

특정 서버의 파티션 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 서버 ID 또는 서버명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| detail | boolean | Optional | 상세 정보 포함 여부 |

### GET `/servers/partitions`

모든 서버의 파티션 정보를 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| serverName | string | Optional | 서버명 필터 |
| detail | boolean | Optional | 상세 정보 포함 여부 |
