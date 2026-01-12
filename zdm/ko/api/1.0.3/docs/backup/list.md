---
layout: docs
title: GET /backups
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

등록된 전체 백업 작업 목록을 조회합니다.

---

## `GET /backups` {#get-backups}

> * 시스템에 등록된 모든 백업 작업 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 백업 작업만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/backups</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 백업 작업 목록 조회
curl -X GET "https://api.example.com/api/v1/backups" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/backups?mode=full&status=complete" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/backups?detail=true" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/v1/backups?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `serverName` | Query | string | Optional | - | 작업 대상 서버 이름 필터 | - |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md backup=true %} |
| `partition` | Query | string | Optional | - | 작업 대상 파티션 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/job-status.md %} |
| `repositoryID` | Query | number | Optional | - | 레포지토리 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "id": "1",
        "name": "server-01",
        "os": "Linux"
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-backup",
          "mode": "full",
          "partition": "/",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 02:00"
            },
            "advanced": "-"
          },
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-15T02:00:00Z",
              "elapsed": "00:30:00",
              "end": "2025-01-15T02:30:00Z"
            }
          }
        },
        "lastUpdated": "2025-01-15T02:30:00Z"
      },
      "repository": {
        "id": "1",
        "type": "nfs",
        "path": "/backup/server-01"
      }
    }
  ],
  "message": "Backup job list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "id": "1",
        "name": "server-01",
        "os": "Linux"
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-backup",
          "mode": "full",
          "partition": "/",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 02:00"
            },
            "advanced": "-"
          },
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-15T02:00:00Z",
              "elapsed": "00:30:00",
              "end": "2025-01-15T02:30:00Z"
            }
          }
        },
        "lastUpdated": "2025-01-15T02:30:00Z"
      },
      "repository": {
        "id": "1",
        "type": "nfs",
        "path": "/backup/server-01"
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Backup job list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1">
<summary>상세 응답 (detail=true)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "id": "1",
        "name": "server-01",
        "os": "Linux",
        "agent": "3.2.1",
        "ip": {
          "public": "203.0.113.10",
          "private": ["192.168.1.10", "10.0.0.10"]
        },
        "license": "100"
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-backup",
          "mode": "full",
          "partition": "/",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 02:00"
            },
            "advanced": "-"
          },
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-15T02:00:00Z",
              "elapsed": "00:30:00",
              "end": "2025-01-15T02:30:00Z"
            }
          },
          "options": {
            "compression": "use",
            "encryption": "not use",
            "rotation": "7",
            "excludeDir": "/tmp,/var/cache",
            "networkSpeed": "0",
            "notification": {
              "mail": "admin@example.com"
            }
          }
        },
        "lastUpdated": "2025-01-15T02:30:00Z"
      },
      "repository": {
        "id": "1",
        "type": "nfs",
        "path": "/backup/server-01"
      }
    }
  ],
  "message": "Backup job list",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `system.id` | string | - | 대상 서버 ID |
| `system.name` | string | - | 대상 서버 이름 |
| `system.os` | string | - | 대상 서버 OS |
| `system.agent` | string | detail | 에이전트 버전 |
| `system.ip.public` | string | detail | 공인 IP 주소 |
| `system.ip.private` | string[] | detail | 사설 IP 주소 목록 |
| `system.license` | string | detail | 라이선스 ID |
| `job.info.id` | string | - | 백업 작업 ID |
| `job.info.name` | string | - | 작업 이름 |
| `job.info.mode` | string | - | 작업 모드 (`full`, `increment`, `smart`) |
| `job.info.partition` | string | - | 대상 파티션/드라이브 |
| `job.info.schedule` | object | - | 스케줄 정보 (스케줄 설정시에만 포함) |
| `job.info.schedule.basic` | object/string | - | 기본 스케줄 정보 |
| `job.info.schedule.advanced` | object/string | - | 고급 스케줄 정보 (Smart 스케줄만) |
| `job.info.status.current` | string | - | 현재 작업 상태 |
| `job.info.status.time.start` | string | - | 작업 시작 시간 |
| `job.info.status.time.elapsed` | string | - | 경과 시간 |
| `job.info.status.time.end` | string | - | 작업 종료 시간 |
| `job.info.options.compression` | string | detail | 압축 사용 여부 ({% include zdm/use-options.md %}) |
| `job.info.options.encryption` | string | detail | 암호화 사용 여부 ({% include zdm/use-options.md %}) |
| `job.info.options.rotation` | string | detail | 보관 주기 |
| `job.info.options.excludeDir` | string | detail | 제외 디렉토리 |
| `job.info.options.networkSpeed` | string | detail | 네트워크 제한 속도 |
| `job.info.options.notification.mail` | string | detail | 알림 이메일 |
| `job.lastUpdated` | string | - | 정보 업데이트 시간 |
| `repository.id` | string | - | 레포지토리 ID |
| `repository.type` | string | - | 레포지토리 타입 |
| `repository.path` | string | - | 레포지토리 경로 |
| `pagination.currentPage` | number | page/limit | 현재 페이지 번호 |
| `pagination.totalPages` | number | page/limit | 전체 페이지 수 |
| `pagination.totalItems` | number | page/limit | 전체 항목 수 |
| `pagination.itemsPerPage` | number | page/limit | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | page/limit | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | page/limit | 이전 페이지 존재 여부 |

</details>

---
