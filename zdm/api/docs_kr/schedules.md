---
layout: page
title: Schedule Management
---

## Schedule Management

### GET `/schedules`

스케줄 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | string | Optional | 스케줄 ID 필터 |
| type | string | Optional | 스케줄 타입 필터 |
| state | string | Optional | 활성 상태 필터 |
| jobName | string | Optional | 작업명 필터 |

**Response:**

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

### GET `/schedules/:identifier`

특정 스케줄 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 스케줄 ID 또는 작업명 |

**Query Parameters:** (위의 GET `/schedules`와 동일)

**Response:**

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

### POST `/schedules`

새 스케줄을 생성합니다.

**Request Body:**

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

**Response:**

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
