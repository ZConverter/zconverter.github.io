---
layout: docs
title: License Management
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/docs_kr"
      - title: "Overview"
        url: "/zdm/api/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/api/docs_kr/authentication"
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
        sublinks:
          - title: "라이선스 목록 조회"
            url: "/zdm/api/docs_kr/licenses#get-licenses"
          - title: "특정 라이선스 조회"
            url: "/zdm/api/docs_kr/licenses#get-license"
          - title: "키로 라이선스 조회"
            url: "/zdm/api/docs_kr/licenses#get-license-by-key"
          - title: "라이선스 생성"
            url: "/zdm/api/docs_kr/licenses#create-license"
          - title: "라이선스 할당"
            url: "/zdm/api/docs_kr/licenses#assign-license"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

### GET `/licenses` {#get-licenses}

라이선스 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| category | string | Optional | 라이선스 카테고리 필터 |
| exp | string | Optional | 만료일 필터 (YYYY-MM-DD) |
| created | string | Optional | 생성일 필터 (YYYY-MM-DD) |
| status | string | Optional | 상태 필터 (active, expired, expiring) |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-list",
  "data": [
    {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise",
      "copies": {
        "total": 100,
        "used": 75,
        "available": 25,
        "usage": "75%"
      },
      "description": "Enterprise backup solution license",
      "dates": {
        "created": "2024-01-01T00:00:00.000Z",
        "expires": "2024-12-31T23:59:59.000Z",
        "daysRemaining": 334
      }
    }
  ],
  "message": "라이선스 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### GET `/licenses/:identifier` {#get-license}

특정 라이선스 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 라이선스 ID 또는 이름 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

위의 GET `/licenses`와 동일

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-detail",
  "data": {
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": {
      "total": 100,
      "used": 75,
      "available": 25,
      "usage": "75%"
    },
    "description": "Enterprise backup solution license",
    "dates": {
      "created": "2024-01-01T00:00:00.000Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    },
    "assignedServers": [
      {
        "serverId": "SRV-001",
        "serverName": "web-server-01",
        "assignedAt": "2024-01-15T10:00:00.000Z"
      }
    ]
  },
  "message": "라이선스 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### GET `/licenses/key/:key` {#get-license-by-key}

키로 라이선스 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| key | string | Required | 라이선스 키 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-by-key",
  "data": {
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "isValid": true,
    "status": "active",
    "copies": {
      "total": 100,
      "used": 75,
      "available": 25,
      "usage": "75%"
    },
    "dates": {
      "created": "2024-01-01T00:00:00.000Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "라이선스 키 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### POST `/licenses` {#create-license}

새 라이선스를 등록합니다.

<details markdown="1" open>
<summary><strong>Request Body</strong></summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | Required | 라이선스명 |
| licenseKey | string | Required | 라이선스 키 |
| category | string | Required | 라이선스 카테고리 |
| copies | number | Required | 총 라이선스 수 |
| expirationDate | string | Required | 만료일 (YYYY-MM-DD) |
| description | string | Optional | 설명 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-register",
  "data": {
    "id": "2",
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": {
      "total": 100,
      "used": 0,
      "available": 100,
      "usage": "0%"
    },
    "description": "Enterprise backup solution license",
    "dates": {
      "created": "2024-01-31T10:30:45.123Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "라이선스가 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### PUT `/licenses/assign` {#assign-license}

라이선스를 서버에 할당합니다.

<details markdown="1" open>
<summary><strong>Request Body</strong></summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| licenseKey | string | Required | 라이선스 키 |
| serverId | string | Required | 서버 ID 또는 서버명 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-license-assign",
  "data": {
    "license": {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise"
    },
    "server": {
      "id": "1",
      "name": "web-server-01"
    },
    "assignment": {
      "assignedAt": "2024-01-31T10:30:45.123Z",
      "status": "active"
    },
    "usage": {
      "total": 100,
      "used": 76,
      "available": 24,
      "percentage": "76%"
    }
  },
  "message": "라이선스가 성공적으로 할당되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>
