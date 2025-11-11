---
layout: docs
# title: Recovery Management
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
        sublinks:
          - title: "복구 목록 조회"
            url: "/zdm/api/docs_kr/recoveries#get-recoveries"
          - title: "특정 복구 조회"
            url: "/zdm/api/docs_kr/recoveries#get-recovery"
          - title: "복구 생성"
            url: "/zdm/api/docs_kr/recoveries#create-recovery"
          - title: "복구 수정"
            url: "/zdm/api/docs_kr/recoveries#update-recovery"
          - title: "복구 삭제"
            url: "/zdm/api/docs_kr/recoveries#delete-recovery"
          - title: "복구 작업 모니터링"
            url: "/zdm/api/docs_kr/recoveries#monitor-recovery-job"
          - title: "시스템 모니터링"
            url: "/zdm/api/docs_kr/recoveries#monitor-recovery-system"
      - title: "File Management"
        url: "/zdm/api/docs_kr/files"
      - title: "License Management"
        url: "/zdm/api/docs_kr/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

## Recovery Management

### GET `/recoveries` {#get-recoveries}

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

### GET `/recoveries/:identifier` {#get-recovery}

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

### POST `/recoveries` {#create-recovery}

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

### PUT `/recoveries/:identifier` {#update-recovery}

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

### DELETE `/recoveries/:identifier` {#delete-recovery}

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

### GET `/recoveries/monitoring/job/:identifier` {#monitor-recovery-job}

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

### GET `/recoveries/monitoring/system/:identifier` {#monitor-recovery-system}

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
