---
layout: docs
title: Schedule Management
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
      - title: "Schedule Management"
        url: "/zdm/api/docs/schedules"
        sublinks:
          - title: "스케줄 목록 조회"
            url: "/zdm/api/docs/schedules#get-schedules"
          - title: "특정 스케줄 조회"
            url: "/zdm/api/docs/schedules#get-schedule"
          - title: "스케줄 생성"
            url: "/zdm/api/docs/schedules#create-schedule"
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

### GET `/schedules` {#get-schedules}

스케줄 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | string | Optional | 스케줄 ID 필터 |
| type | string | Optional | 스케줄 타입 필터 |
| state | string | Optional | 활성 상태 필터 |
| jobName | string | Optional | 작업명 필터 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-schedule-list",
  "data": [
    {
      "id": "1",
      "center": {
        "id": "CENTER-001",
        "name": "Main Center"
      },
      "type": "backup",
      "state": "active",
      "jobName": "daily-backup-job",
      "lastRunTime": "2024-01-31T02:00:00.000Z",
      "description": "Daily backup schedule"
    }
  ],
  "message": "스케줄 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### GET `/schedules/:identifier` {#get-schedule}

특정 스케줄 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 스케줄 ID 또는 작업명 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

위의 GET `/schedules`와 동일

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-schedule-detail",
  "data": {
    "id": "1",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "daily-backup-job",
    "lastRunTime": "2024-01-31T02:00:00.000Z",
    "description": "Daily backup schedule"
  },
  "message": "스케줄 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
### POST `/schedules` {#create-schedule}

새 스케줄을 생성합니다.

<details markdown="1" open>
<summary><strong>Request Body</strong></summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | 센터 ID 또는 이름 |
| user | string | Required | 사용자 ID 또는 이메일 |
| jobName | string | Required | 작업명 |
| type | number | Required | 스케줄 타입 (1: Smart, 2: Common) |
| basic | object | Required | 기본 스케줄 설정 |
| basic.type | string | Required | 기본 스케줄 타입 |
| basic.description | string | Required | 기본 스케줄 설명 |
| advanced | object | Optional | 고급 스케줄 설정 |
| advanced.type | string | Optional | 고급 스케줄 타입 |
| advanced.description | string | Optional | 고급 스케줄 설명 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-schedule-create",
  "data": {
    "id": "2",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "new-backup-job",
    "schedule": {
      "basic": "0 2 * * *",
      "advanced": "daily at 2:00 AM"
    }
  },
  "message": "스케줄이 성공적으로 생성되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>
