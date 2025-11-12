---
layout: docs
title: ZDM Center Management
section_title: ZDM API Documentation
navigation: api
---

### GET `/zdms` {#get-zdms}

ZDM 센터 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

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

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---
### GET `/zdms/:identifier` {#get-zdm}

특정 ZDM 센터 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM 센터 ID 또는 센터명 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

위의 GET `/zdms`와 동일

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---
### GET `/zdms/:identifier/repositories` {#get-zdm-repositories}

특정 ZDM 센터의 리포지토리 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM 센터 ID 또는 센터명 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| type | string | Optional | 리포지토리 타입 필터 |
| path | string | Optional | 경로 필터 |
| status | string | Optional | 상태 필터 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---
### GET `/zdms/repositories` {#get-repositories}

모든 ZDM 리포지토리 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| centerName | string | Optional | 센터명 필터 |
| type | string | Optional | 리포지토리 타입 필터 |
| path | string | Optional | 경로 필터 |
| status | string | Optional | 상태 필터 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>
