---
layout: docs
# title: Backup Management
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
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

## Backup Management

### GET `/backups`

백업 작업 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| mode | string | Optional | 백업 모드 필터 |
| partition | string | Optional | 파티션 필터 |
| status | string | Optional | 작업 상태 필터 |
| repositoryID | string | Optional | 리포지토리 ID 필터 |
| repositoryType | string | Optional | 리포지토리 타입 필터 |
| repositoryPath | string | Optional | 리포지토리 경로 필터 |
| serverName | string | Optional | 서버명 필터 |
| serverType | string | Optional | 서버 타입 필터 |
| detail | boolean | Optional | 상세 정보 포함 여부 |
| active | boolean | Optional | 활성 작업만 조회 |
| history | boolean | Optional | 히스토리 포함 |
| logs | boolean | Optional | 로그 포함 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-list",
  "data": [
    {
      "system": {
        "id": "SRV-001",
        "name": "web-server-01",
        "os": "Ubuntu 20.04"
      },
      "job": {
        "info": {
          "id": "JOB-001",
          "name": "daily-backup-web",
          "mode": "full",
          "partition": "/dev/sda1",
          "schedule": {
            "basic": "0 2 * * *",
            "advanced": "daily at 2:00 AM"
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2024-01-31T02:00:00.000Z",
              "elapsed": "45m 30s",
              "end": "2024-01-31T02:45:30.000Z"
            }
          }
        },
        "lastUpdated": "2024-01-31T02:45:30.000Z"
      },
      "repository": {
        "id": "REPO-001",
        "type": "local",
        "path": "/backup/storage"
      }
    }
  ],
  "message": "백업 작업 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/:identifier`

특정 백업 작업 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 백업 작업 ID 또는 작업명 |

**Query Parameters:** (위의 GET `/backups`와 동일)

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-detail",
  "data": {
    "system": {
      "id": "SRV-001",
      "name": "web-server-01",
      "os": "Ubuntu 20.04"
    },
    "job": {
      "info": {
        "id": "JOB-001",
        "name": "daily-backup-web",
        "mode": "full",
        "partition": "/dev/sda1",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "status": {
          "current": "completed",
          "time": {
            "start": "2024-01-31T02:00:00.000Z",
            "elapsed": "45m 30s",
            "end": "2024-01-31T02:45:30.000Z"
          }
        }
      },
      "lastUpdated": "2024-01-31T02:45:30.000Z"
    },
    "repository": {
      "id": "REPO-001",
      "type": "local",
      "path": "/backup/storage"
    }
  },
  "message": "백업 작업 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/backups`

새 백업 작업을 등록합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | 센터 ID 또는 이름 |
| server | string | Required | 서버 ID 또는 이름 |
| type | string | Required | 백업 타입 |
| partition | array | Required | 백업할 파티션 목록 |
| repository | object | Required | 리포지토리 정보 |
| repository.id | number | Required | 리포지토리 ID |
| repository.type | string | Required | 리포지토리 타입 |
| repository.path | string | Required | 리포지토리 경로 |
| jobName | string | Required | 작업명 |
| user | string | Required | 사용자 ID 또는 이메일 |
| schedule | object | Required | 스케줄 정보 |
| schedule.type | string | Required | 스케줄 타입 |
| schedule.description | string | Required | 스케줄 설명 |
| description | string | Optional | 작업 설명 |
| rotation | number | Optional | 보존 주기 |
| compression | string | Optional | 압축 설정 |
| encryption | string | Optional | 암호화 설정 |
| excludeDir | array | Optional | 제외할 디렉토리 |
| excludePartition | array | Optional | 제외할 파티션 |
| mailEvent | string | Optional | 메일 알림 설정 |
| networkLimit | number | Optional | 네트워크 제한 |
| autoStart | string | Optional | 자동 시작 여부 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-register",
  "data": {
    "results": [
      {
        "state": "success",
        "jobName": "daily-backup-web",
        "partition": "/dev/sda1",
        "jobMode": "full",
        "autoStart": "yes",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    }
  },
  "message": "백업 작업이 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/backups/:identifier`

백업 작업을 수정합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 백업 작업 ID 또는 작업명 |

**Request Body:** (POST `/backups`와 동일)

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-update",
  "data": {
    "jobName": "updated-backup-job",
    "status": "updated"
  },
  "message": "백업 작업이 성공적으로 수정되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### DELETE `/backups/:identifier`

백업 작업을 삭제합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 백업 작업 ID 또는 작업명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| force | boolean | Optional | 강제 삭제 여부 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-delete",
  "data": {
    "deletedJobName": "daily-backup-web",
    "deletedAt": "2024-01-31T10:30:45.123Z"
  },
  "message": "백업 작업이 성공적으로 삭제되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/monitoring/job/:identifier`

특정 백업 작업의 모니터링 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 백업 작업 ID 또는 작업명 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "job": {
      "info": {
        "name": "daily-backup-web",
        "partition": "/dev/sda1",
        "drive": "C:"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "75",
        "message": "Backing up system files",
        "start": "2024-01-31T02:00:00.000Z",
        "elapsed": "30m 15s",
        "end": null
      },
      "log": [
        "2024-01-31 02:00:00 - Backup started",
        "2024-01-31 02:15:00 - Processing system files",
        "2024-01-31 02:30:00 - 75% completed"
      ]
    }
  },
  "message": "백업 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/monitoring/system/:identifier`

특정 시스템의 백업 모니터링 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 시스템 ID 또는 시스템명 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-system-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "jobs": [
      {
        "name": "daily-backup-web",
        "status": "PROCESSING",
        "progress": "75%",
        "startTime": "2024-01-31T02:00:00.000Z"
      }
    ]
  },
  "message": "시스템 백업 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```
