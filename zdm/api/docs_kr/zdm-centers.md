---
layout: docs
title: ZDM Center Management
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

## ZDM Center Management

### GET `/zdms`

ZDM 센터 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| connection | string | Optional | 연결 상태 필터 (online, offline) |
| activation | string | Optional | 활성화 상태 필터 (active, inactive) |
| network | boolean | Optional | 네트워크 정보 포함 여부 |
| disk | boolean | Optional | 디스크 정보 포함 여부 |
| partition | boolean | Optional | 파티션 정보 포함 여부 |
| repository | boolean | Optional | 리포지토리 정보 포함 여부 |
| zosRepository | boolean | Optional | zOS 리포지토리 정보 포함 여부 |
| detail | boolean | Optional | 상세 정보 포함 여부 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-zdm-list",
  "data": [
    {
      "name": {
        "center": "Main-ZDM-Center",
        "host": "zdm-center-01"
      },
      "id": {
        "center": "ZDM-001",
        "install": "INSTALL-2024-001"
      },
      "os": {
        "version": "Windows Server 2019"
      },
      "ip": {
        "public": "192.168.1.10",
        "private": ["10.0.0.10", "172.16.0.10"]
      },
      "status": {
        "connect": "online",
        "activate": "active"
      },
      "path": {
        "logFile": "C:\\ZDM\\logs\\zdm.log",
        "install": "C:\\ZDM"
      },
      "disk": [],
      "partition": [],
      "drive": [],
      "network": [],
      "repository": [],
      "zosRepository": [],
      "lastUpdated": "2024-01-31T10:30:45.123Z"
    }
  ],
  "message": "ZDM 센터 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/:identifier`

특정 ZDM 센터 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM 센터 ID 또는 센터명 |

**Query Parameters:** (위의 GET `/zdms`와 동일)

**Response:**

```json
{
  "success": true,
  "requestID": "req-zdm-detail",
  "data": {
    "name": {
      "center": "Main-ZDM-Center",
      "host": "zdm-center-01"
    },
    "id": {
      "center": "ZDM-001",
      "install": "INSTALL-2024-001"
    },
    "os": {
      "version": "Windows Server 2019"
    },
    "ip": {
      "public": "192.168.1.10",
      "private": ["10.0.0.10", "172.16.0.10"]
    },
    "status": {
      "connect": "online",
      "activate": "active"
    },
    "path": {
      "logFile": "C:\\ZDM\\logs\\zdm.log",
      "install": "C:\\ZDM"
    },
    "lastUpdated": "2024-01-31T10:30:45.123Z"
  },
  "message": "ZDM 센터 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/:identifier/repositories`

특정 ZDM 센터의 리포지토리 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM 센터 ID 또는 센터명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| type | string | Optional | 리포지토리 타입 필터 |
| path | string | Optional | 경로 필터 |
| status | string | Optional | 상태 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-zdm-repositories",
  "data": [
    {
      "id": "REPO-001",
      "name": "Primary Repository",
      "type": "local",
      "path": "C:\\ZDM\\Repository",
      "status": "online",
      "capacity": {
        "total": "1TB",
        "used": "256GB",
        "available": "768GB",
        "usage": "25%"
      }
    }
  ],
  "message": "ZDM 센터 리포지토리 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/repositories`

모든 ZDM 리포지토리 정보를 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| centerName | string | Optional | 센터명 필터 |
| type | string | Optional | 리포지토리 타입 필터 |
| path | string | Optional | 경로 필터 |
| status | string | Optional | 상태 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-all-repositories",
  "data": [
    {
      "center": {
        "id": "ZDM-001",
        "name": "Main-ZDM-Center"
      },
      "repository": {
        "id": "REPO-001",
        "name": "Primary Repository",
        "type": "local",
        "path": "C:\\ZDM\\Repository",
        "status": "online",
        "capacity": {
          "total": "1TB",
          "used": "256GB",
          "available": "768GB",
          "usage": "25%"
        }
      }
    }
  ],
  "message": "모든 ZDM 리포지토리 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```
