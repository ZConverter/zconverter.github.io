---
layout: page
title: ZDM API RESTful Documentation
---
## Table of Contents

1. [Overview](#overview)
2. [Authentication](#authentication)
3. [Standard API Response Format](#standard-api-response-format)
4. [Authentication Endpoints](#authentication-endpoints)
   - [POST /auth/issue](#post-authissue) - 토큰 발급
5. [User Management](#user-management)
   - [GET /users](#get-users) - 사용자 목록 조회
   - [GET /users/:identifier](#get-usersidentifier) - 특정 사용자 조회
   - [PUT /users/:identifier](#put-usersidentifier) - 사용자 정보 업데이트
6. [Server Management](#server-management)
   - [GET /servers](#get-servers) - 서버 목록 조회
   - [GET /servers/:identifier](#get-serversidentifier) - 특정 서버 조회
   - [GET /servers/:identifier/partitions](#get-serversidentifierpartitions) - 특정 서버 파티션 조회
   - [GET /servers/partitions](#get-serverspartitions) - 모든 서버 파티션 조회
7. [Schedule Management](#schedule-management)
   - [GET /schedules](#get-schedules) - 스케줄 목록 조회
   - [GET /schedules/:identifier](#get-schedulesidentifier) - 특정 스케줄 조회
   - [POST /schedules](#post-schedules) - 스케줄 생성
8. [Backup Management](#backup-management)
   - [GET /backups](#get-backups) - 백업 목록 조회
   - [GET /backups/:identifier](#get-backupsidentifier) - 특정 백업 조회
   - [POST /backups](#post-backups) - 백업 작업 등록
   - [PUT /backups/:identifier](#put-backupsidentifier) - 백업 작업 수정
   - [DELETE /backups/:identifier](#delete-backupsidentifier) - 백업 작업 삭제
   - [GET /backups/monitoring/job/:identifier](#get-backupsmonitoringjobidentifier) - 백업 작업 모니터링
   - [GET /backups/monitoring/system/:identifier](#get-backupsmonitoringsystemidentifier) - 백업 시스템 모니터링
9. [Recovery Management](#recovery-management)
   - [GET /recoveries](#get-recoveries) - 복구 목록 조회
   - [GET /recoveries/:identifier](#get-recoveriesidentifier) - 특정 복구 조회
   - [POST /recoveries](#post-recoveries) - 복구 작업 등록
   - [PUT /recoveries/:identifier](#put-recoveriesidentifier) - 복구 작업 수정
   - [DELETE /recoveries/:identifier](#delete-recoveriesidentifier) - 복구 작업 삭제
   - [GET /recoveries/monitoring/job/:identifier](#get-recoveriesmonitoringjobidentifier) - 복구 작업 모니터링
   - [GET /recoveries/monitoring/system/:identifier](#get-recoveriesmonitoringsystemidentifier) - 복구 시스템 모니터링
10. [File Management](#file-management)
    - [POST /files/upload](#post-filesupload) - 파일 업로드
    - [GET /files/list](#get-fileslist) - 업로드된 파일 목록 조회
    - [GET /files/download/:fileName](#get-filesdownloadfilename) - 파일 다운로드
11. [License Management](#license-management)
    - [GET /licenses](#get-licenses) - 라이선스 목록 조회
    - [GET /licenses/:identifier](#get-licensesidentifier) - 특정 라이선스 조회
    - [GET /licenses/key/:key](#get-licenseskeykey) - 키로 라이선스 조회
    - [POST /licenses](#post-licenses) - 라이선스 등록
    - [PUT /licenses/assign](#put-licensesassign) - 라이선스 할당
12. [ZDM Center Management](#zdm-center-management)
    - [GET /zdms](#get-zdms) - ZDM 센터 목록 조회
    - [GET /zdms/:identifier](#get-zdmsidentifier) - 특정 ZDM 센터 조회
    - [GET /zdms/:identifier/repositories](#get-zdmsidentifierrepositories) - ZDM 센터 리포지토리 조회
    - [GET /zdms/repositories](#get-zdmsrepositories) - 모든 ZDM 리포지토리 조회
13. [Common Patterns](#common-patterns)

## Overview

ZDM-API는 백업, 복구, 시스템 관리를 위한 REST API 서버입니다. 토큰 인증을 기반으로 하며, 도메인 주도 설계 아키텍처를 따릅니다.

**Base URL**: `/api/v1`

## Authentication

모든 보호된 엔드포인트는 토큰이 필요합니다:

```text
Authorization: Bearer <token>
```

## Standard API Response Format

모든 API 응답은 다음 표준 형식을 따릅니다:

**Success Response:**

```json
{
  "success": true,
  "requestID": "string",
  "data": {},
  "message": "string",
  "timestamp": "string",
  "meta": {}
}
```

**Error Response:**

```json
{
  "success": false,
  "requestID": "string",
  "error": "string",
  "timestamp": "string",
  "detail": {}
}
```

**Pagination Response:**

```json
{
  "success": true,
  "requestID": "string",
  "data": [],
  "message": "string",
  "timestamp": "string",
  "meta": {
    "currentPage": 1,
    "totalPages": 10,
    "totalItems": 100,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  }
}
```

---

## Authentication Endpoints

### POST `/auth/issue`

토큰을 발급합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Required | 사용자 이메일 |
| password | string | Required | 사용자 비밀번호 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-123",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expiresAt": "2024-12-31T23:59:59.000Z"
  },
  "message": "토큰이 성공적으로 발급되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Status Codes:**

- `201` - 토큰 발급 성공
- `400` - 잘못된 요청 데이터
- `401` - 인증 실패

---

## User Management

### GET `/users`

사용자 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-456",
  "data": [
    {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "개발자"
    }
  ],
  "message": "사용자 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/users/:identifier`

특정 사용자 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-789",
  "data": {
    "id": "1",
    "email": "user@example.com",
    "userName": "홍길동",
    "company": "ZDM Corp",
    "country": "KR",
    "position": "개발자"
  },
  "message": "사용자 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/users/:identifier`

사용자 정보를 업데이트합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| userName | string | Optional | 사용자명 |
| password | string | Optional | 비밀번호 |
| pwData | string | Optional | 비밀번호 데이터 |
| position | string | Optional | 직책 |
| company | string | Optional | 회사명 |
| country | string | Optional | 국가 코드 (2자리, 예: KR, US) |

**Response:**

```json
{
  "success": true,
  "requestID": "req-user-update",
  "data": {
    "userInfo": {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "Senior Developer"
    },
    "summary": {
      "state": "success",
      "message": "사용자 정보가 성공적으로 업데이트되었습니다",
      "updatedFieldsCount": 1,
      "updatedFields": [
        {
          "field": "직책",
          "previous": "개발자",
          "new": "Senior Developer"
        }
      ]
    }
  },
  "message": "사용자 정보가 성공적으로 업데이트되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**특징:**

- 변경 이력 추적: 수정된 각 필드의 이전 값과 새 값을 추적
- 보안 필드 마스킹: password, pwData 필드는 응답에서 `********`로 표시
- 부분 업데이트: 제공된 필드만 업데이트

**Status Codes:**

- `200` - 업데이트 성공
- `400` - 잘못된 요청 데이터
- `404` - 사용자를 찾을 수 없음
- `500` - 서버 오류

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

---

## Recovery Management

### GET `/recoveries`

복구 작업 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| status | string | Optional | 작업 상태 필터 |
| platform | string | Optional | 플랫폼 타입 필터 |
| mode | string | Optional | 복구 모드 필터 |
| partition | string | Optional | 파티션 필터 |
| drive | string | Optional | 드라이브 필터 |
| backupName | string | Optional | 백업명 필터 |
| repositoryID | string | Optional | 리포지토리 ID 필터 |
| repositoryType | string | Optional | 리포지토리 타입 필터 |
| repositoryPath | string | Optional | 리포지토리 경로 필터 |
| detail | boolean | Optional | 상세 정보 포함 여부 |
| server | string | Optional | 서버명 필터 |
| serverType | string | Optional | 서버 타입 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-list",
  "data": [
    {
      "system": {
        "source": {
          "id": "SRV-001",
          "name": "web-server-01",
          "os": "Ubuntu 20.04"
        },
        "target": {
          "id": "SRV-002",
          "name": "backup-server-01",
          "os": "Ubuntu 20.04"
        }
      },
      "job": {
        "info": {
          "id": "REC-001",
          "name": "system-recovery-job",
          "schedule": {
            "basic": "0 3 * * 0"
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2024-01-31T03:00:00.000Z",
              "elapsed": "2h 15m",
              "end": "2024-01-31T05:15:00.000Z"
            }
          },
          "lastUpdated": "2024-01-31T05:15:00.000Z"
        },
        "detail": []
      }
    }
  ],
  "message": "복구 작업 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/recoveries/:identifier`

특정 복구 작업 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 복구 작업 ID 또는 작업명 |

**Query Parameters:** (위의 GET `/recoveries`와 동일)

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-detail",
  "data": {
    "system": {
      "source": {
        "id": "SRV-001",
        "name": "web-server-01",
        "os": "Ubuntu 20.04"
      },
      "target": {
        "id": "SRV-002",
        "name": "backup-server-01",
        "os": "Ubuntu 20.04"
      }
    },
    "job": {
      "info": {
        "id": "REC-001",
        "name": "system-recovery-job",
        "schedule": {
          "basic": "0 3 * * 0"
        },
        "status": {
          "current": "completed",
          "time": {
            "start": "2024-01-31T03:00:00.000Z",
            "elapsed": "2h 15m",
            "end": "2024-01-31T05:15:00.000Z"
          }
        },
        "lastUpdated": "2024-01-31T05:15:00.000Z"
      },
      "detail": []
    }
  },
  "message": "복구 작업 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/recoveries`

새 복구 작업을 등록합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | 센터 ID 또는 이름 |
| source | string | Required | 소스 서버 ID 또는 이름 |
| target | string | Required | 타겟 서버 ID 또는 이름 |
| platform | string | Required | 플랫폼 타입 |
| repository | object | Required | 리포지토리 정보 |
| repository.id | number | Required | 리포지토리 ID |
| repository.type | string | Required | 리포지토리 타입 |
| repository.path | string | Required | 리포지토리 경로 |
| mode | string | Required | 복구 모드 |
| jobName | string | Required | 작업명 |
| overwrite | string | Required | 덮어쓰기 옵션 |
| user | string | Required | 사용자 ID 또는 이메일 |
| schedule | object | Required | 스케줄 정보 |
| schedule.type | string | Required | 스케줄 타입 |
| schedule.description | string | Required | 스케줄 설명 |
| description | string | Optional | 작업 설명 |
| afterReboot | string | Optional | 재부팅 후 동작 |
| networkLimit | number | Optional | 네트워크 제한 |
| excludePartition | array | Optional | 제외할 파티션 |
| mailEvent | string | Optional | 메일 알림 설정 |
| autoStart | string | Optional | 자동 시작 여부 |
| scriptPath | string | Optional | 스크립트 경로 |
| scriptRun | string | Optional | 스크립트 실행 여부 |
| cloudAuth | number | Optional | 클라우드 인증 ID |
| listOnly | boolean | Optional | 목록만 조회 여부 |
| jobList | array | Optional | 작업 목록 |
| jobList[].sourcePartition | string | Required | 소스 파티션 |
| jobList[].targetPartition | string | Required | 타겟 파티션 |
| jobList[].overwrite | string | Required | 덮어쓰기 옵션 |
| jobList[].isOverwrite | boolean | Required | 덮어쓰기 여부 |
| jobList[].backupFile | string | Required | 백업 파일명 |
| jobList[].mode | string | Required | 복구 모드 |
| jobList[].repository | object | Required | 리포지토리 정보 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-register",
  "data": {
    "jobName": "system-recovery-job",
    "jobId": "REC-002",
    "schedule": {
      "basic": "0 3 * * 0",
      "advanced": "weekly on Sunday at 3:00 AM"
    },
    "status": "registered"
  },
  "message": "복구 작업이 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/recoveries/:identifier`

복구 작업을 수정합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 복구 작업 ID 또는 작업명 |

**Request Body:** (POST `/recoveries`와 동일)

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-update",
  "data": {
    "jobName": "updated-recovery-job",
    "status": "updated"
  },
  "message": "복구 작업이 성공적으로 수정되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### DELETE `/recoveries/:identifier`

복구 작업을 삭제합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 복구 작업 ID 또는 작업명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| force | boolean | Optional | 강제 삭제 여부 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-delete",
  "data": {
    "jobInfo": [
      {
        "name": "system-recovery-job",
        "partition": "/, /test/, /de",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "state": "success",
      "affectedComponents": {
        "basicInfoDeleted": 1,
        "additionalInfoDeleted": 1,
        "detailInfoDeleted": 2,
        "historyDataDeleted": 5,
        "logDataDeleted": 3
      }
    }
  },
  "message": "복구 작업이 성공적으로 삭제되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Response Fields:**

- `jobInfo`: 삭제된 작업 정보 배열
  - `name`: 작업명
  - `partition`: 관련 파티션 목록 (쉼표로 구분, 예: "/, /test/, /de")
  - `deletedComponents`: 삭제된 컴포넌트 상태
    - `basicInfo`: 기본 정보 삭제 여부
    - `additionalInfo`: 추가 정보 삭제 여부
    - `detailInfo`: 상세 정보 삭제 여부
    - `historyData`: 히스토리 데이터 삭제 여부
    - `logData`: 로그 데이터 삭제 여부
  - `errorMessage`: 오류 메시지 (실패 시에만)
- `summary`: 삭제 요약 정보
  - `state`: 전체 작업 상태 ("success" | "fail")
  - `affectedComponents`: 실제 삭제된 레코드 개수
    - `basicInfoDeleted`: 삭제된 기본 정보 레코드 수 (일반적으로 1)
    - `additionalInfoDeleted`: 삭제된 추가 정보 레코드 수 (일반적으로 1)
    - `detailInfoDeleted`: 삭제된 상세 정보 레코드 수 (파티션 개수만큼 가능)
    - `historyDataDeleted`: 삭제된 히스토리 레코드 수
    - `logDataDeleted`: 삭제된 로그 레코드 수

**Status Codes:**

- `200` - 삭제 성공
- `400` - 잘못된 요청
- `404` - 작업을 찾을 수 없음
- `500` - 서버 오류

### GET `/recoveries/monitoring/job/:identifier`

특정 복구 작업의 모니터링 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 복구 작업 ID 또는 작업명 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-recovery-monitoring",
  "data": {
    "system": {
      "source": "web-server-01",
      "target": "backup-server-01"
    },
    "job": {
      "info": {
        "name": "system-recovery-job",
        "mode": "full",
        "partition": "/dev/sda1"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "60",
        "message": "Restoring system files",
        "start": "2024-01-31T03:00:00.000Z",
        "elapsed": "1h 30m",
        "end": null
      },
      "log": [
        "2024-01-31 03:00:00 - Recovery started",
        "2024-01-31 03:30:00 - Restoring partition data",
        "2024-01-31 04:30:00 - 60% completed"
      ]
    }
  },
  "message": "복구 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/recoveries/monitoring/system/:identifier`

특정 시스템의 복구 모니터링 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 시스템 ID 또는 시스템명 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-system-recovery-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "jobs": [
      {
        "name": "system-recovery-job",
        "status": "PROCESSING",
        "progress": "60%",
        "startTime": "2024-01-31T03:00:00.000Z"
      }
    ]
  },
  "message": "시스템 복구 모니터링 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

---

## File Management

### POST `/files/upload`

파일을 업로드합니다.

**Request:** Multipart form data

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| file | file | Required | 업로드할 파일 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-file-upload",
  "data": {
    "file": {
      "originalName": "document.pdf",
      "fileName": "20240131_103045_document.pdf",
      "path": "/uploads/2024/01/31/20240131_103045_document.pdf",
      "size": 1048576,
      "mimeType": "application/pdf",
      "uploadedAt": "2024-01-31T10:30:45.123Z"
    }
  },
  "message": "파일이 성공적으로 업로드되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**특징:**

- Multipart form data 형식으로 파일 전송
- 최대 파일 크기: 10MB
- 최대 파일 개수: 5개
- 한글 파일명 지원
- 고유한 파일명 자동 생성 (타임스탬프 + 랜덤 숫자)

**Status Codes:**

- `201` - 업로드 성공
- `400` - 잘못된 요청 (파일 크기 초과, 파일 개수 초과 등)
- `500` - 서버 오류

### GET `/files/download/:fileName`

파일을 다운로드합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| fileName | string | Required | 다운로드할 파일명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| download | boolean | Optional | 강제 다운로드 모드 |
| preview | boolean | Optional | 미리보기 모드 |
| range | string | Optional | 부분 다운로드 범위 (bytes=0-1023) |

**Response:** 파일 스트림 또는 에러 응답

**성공 시:** 파일이 직접 다운로드됩니다.

**실패 시 (파일 없음):**

```json
{
  "success": false,
  "requestID": "req-file-download",
  "error": "FILE_NOT_FOUND",
  "timestamp": "2024-01-31T10:30:45.123Z",
  "detail": {
    "fileName": "nonexistent.pdf",
    "message": "요청한 파일을 찾을 수 없습니다"
  }
}
```

**특징:**

- Content-Disposition 헤더를 통한 파일명 전달
- 한글 파일명 지원 (UTF-8 인코딩)
- MIME 타입 자동 감지

**Status Codes:**

- `200` - 다운로드 성공
- `404` - 파일을 찾을 수 없음
- `500` - 서버 오류

### GET `/files/list`

업로드된 파일 목록을 조회합니다.

**Response:**

```json
{
  "success": true,
  "requestID": "req-file-list",
  "data": {
    "files": [
      {
        "fileName": "file-1706688645123-987654321-document.pdf",
        "fileOriginName": "document.pdf",
        "size": "1.5 MB",
        "uploadDate": "2024-01-31 10:30:45"
      },
      {
        "fileName": "file-1706602245456-123456789-report.xlsx",
        "fileOriginName": "report.xlsx",
        "size": "512.3 KB",
        "uploadDate": "2024-01-30 14:15:22"
      }
    ],
    "totalCount": 2
  },
  "message": "File list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Response Fields:**

- `fileName`: 서버에 저장된 실제 파일명 (타임스탬프 포함)
- `fileOriginName`: 원본 파일명
- `size`: 파일 크기 (MB/KB 단위로 변환)
- `uploadDate`: 업로드 일시
- `totalCount`: 총 파일 개수

**Status Codes:**

- `200` - 조회 성공
- `500` - 서버 오류

---

## License Management

### GET `/licenses`

라이선스 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| category | string | Optional | 라이선스 카테고리 필터 |
| exp | string | Optional | 만료일 필터 (YYYY-MM-DD) |
| created | string | Optional | 생성일 필터 (YYYY-MM-DD) |
| status | string | Optional | 상태 필터 (active, expired, expiring) |

**Response:**

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

### GET `/licenses/:identifier`

특정 라이선스 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 라이선스 ID 또는 이름 |

**Query Parameters:** (위의 GET `/licenses`와 동일)

**Response:**

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

### GET `/licenses/key/:key`

키로 라이선스 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| key | string | Required | 라이선스 키 |

**Response:**

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

### POST `/licenses`

새 라이선스를 등록합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | Required | 라이선스명 |
| licenseKey | string | Required | 라이선스 키 |
| category | string | Required | 라이선스 카테고리 |
| copies | number | Required | 총 라이선스 수 |
| expirationDate | string | Required | 만료일 (YYYY-MM-DD) |
| description | string | Optional | 설명 |

**Response:**

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

**Status Codes:**

- `201` - 등록 성공
- `400` - 잘못된 요청 데이터 (유효하지 않은 라이선스 키, 중복 등)
- `409` - 라이선스 키 충돌
- `500` - 서버 오류

### PUT `/licenses/assign`

라이선스를 서버에 할당합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| licenseKey | string | Required | 라이선스 키 |
| serverId | string | Required | 서버 ID 또는 서버명 |

**Response:**

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

**Status Codes:**

- `200` - 할당 성공
- `400` - 잘못된 요청 데이터
- `404` - 라이선스 또는 서버를 찾을 수 없음
- `409` - 이미 할당된 라이선스 또는 사용 가능한 라이선스 부족
- `500` - 서버 오류

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

---

## Common Patterns

### Error Response Format

모든 에러 응답은 다음 형식을 따릅니다:

```json
{
  "error": {
    "code": "string",
    "message": "string",
    "details": {}
  }
}
```

### Status Codes

- `200` - 성공
- `201` - 생성 성공
- `400` - 잘못된 요청
- `401` - 인증 실패
- `403` - 권한 부족
- `404` - 리소스 없음
- `409` - 충돌
- `500` - 서버 오류

### Identifier Pattern

대부분의 엔드포인트는 유연한 식별자 해석을 지원합니다:

- **숫자 값**: ID로 처리
- **문자열 값**: Name/Email 등으로 처리

### Pagination

목록 조회 엔드포인트는 표준 페이지네이션을 지원합니다:

```json
{
  "data": [],
  "pagination": {
    "page": "number",
    "limit": "number",
    "total": "number",
    "totalPages": "number"
  }
}
```
