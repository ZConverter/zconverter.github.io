---
layout: docs
title: GET /recoveries
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

등록된 전체 복구 작업 목록을 조회합니다.

---

## `GET /recoveries` {#get-recoveries}

> * 시스템에 등록된 모든 복구 작업 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 복구 작업만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 복구 작업 목록 조회
curl -X GET "https://api.example.com/api/recoveries" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/recoveries?mode=full&status=complete" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/recoveries?detail=true" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/recoveries?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 작업 대상 서버 이름/ID 필터 | - |
| `serverType` | Query | string | Optional | - | 서버 타입 필터 | {% include zdm/server-modes.md %} |
| `mode` | Query | string | Optional | - | 작업 모드 필터 | {% include zdm/job-modes.md %} |
| `partition` | Query | string | Optional | - | 파티션 필터 (Linux) | - |
| `drive` | Query | string | Optional | - | 드라이브 필터 (Windows) | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/job-status.md %} |
| `repositoryID` | Query | number | Optional | - | 레포지토리 ID 필터 | - |
| `repositoryType` | Query | string | Optional | - | 레포지토리 타입 필터 | {% include zdm/repository-types.md %} |
| `repositoryPath` | Query | string | Optional | - | 레포지토리 경로 필터 | - |
| `platform` | Query | string | Optional | - | 플랫폼 필터 | {% include zdm/platforms.md inline=true %} |
| `backupName` | Query | string | Optional | - | 백업 작업 이름 필터 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 - Linux (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "source": {
          "id": "1",
          "name": "source-server",
          "os": "Ubuntu 22.04"
        },
        "target": {
          "id": "2",
          "name": "target-server",
          "os": "Ubuntu 22.04"
        }
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-recovery",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 10:00"
            }
          },
          "status": {
            "current": "Complete",
            "time": {
              "start": "2025-01-15 10:00:00",
              "elapsed": "00:30:00",
              "end": "2025-01-15 10:30:00"
            }
          },
          "lastUpdated": "2025-01-15 10:30:00"
        },
        "detail": [
          {
            "from": "/",
            "to": "/",
            "targetDevice": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "daily-backup",
              "fileName": "backup-2025-01-15.img",
              "latest": "use"
            },
            "repository": {
              "id": "1",
              "path": "/backup",
              "type": "nfs"
            },
            "lastUpdated": "2025-01-15 10:30:00"
          }
        ]
      }
    }
  ],
  "message": "Recovery job list",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>기본 응답 - Windows (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "source": {
          "id": "3",
          "name": "win-source-server",
          "os": "Windows Server 2019"
        },
        "target": {
          "id": "4",
          "name": "win-target-server",
          "os": "Windows Server 2019"
        }
      },
      "job": {
        "info": {
          "id": "2",
          "name": "windows-recovery",
          "schedule": {
            "basic": {
              "id": "2",
              "type": "weekly",
              "description": "Every Sunday at 02:00"
            }
          },
          "status": {
            "current": "Complete",
            "time": {
              "start": "2025-01-12 02:00:00",
              "elapsed": "01:00:00",
              "end": "2025-01-12 03:00:00"
            }
          },
          "lastUpdated": "2025-01-12 03:00:00"
        },
        "detail": [
          {
            "from": "C:",
            "to": "C:",
            "targetDevice": "\\Device\\Harddisk0\\Partition2",
            "mode": "full",
            "backup": {
              "jobName": "windows-backup",
              "fileName": "backup-2025-01-12.img",
              "latest": "use"
            },
            "repository": {
              "id": "2",
              "path": "\\\\nas\\backup",
              "type": "cifs"
            },
            "lastUpdated": "2025-01-12 03:00:00"
          }
        ]
      }
    }
  ],
  "message": "Recovery job list",
  "timestamp": "2025-01-12 03:00:00"
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
        "source": {
          "id": "1",
          "name": "source-server",
          "os": "Ubuntu 22.04"
        },
        "target": {
          "id": "2",
          "name": "target-server",
          "os": "Ubuntu 22.04"
        }
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-recovery",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 10:00"
            }
          },
          "status": {
            "current": "Complete",
            "time": {
              "start": "2025-01-15 10:00:00",
              "elapsed": "00:30:00",
              "end": "2025-01-15 10:30:00"
            }
          },
          "lastUpdated": "2025-01-15 10:30:00"
        },
        "detail": [
          {
            "from": "/",
            "to": "/",
            "targetDevice": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "daily-backup",
              "fileName": "backup-2025-01-15.img",
              "latest": "use"
            },
            "repository": {
              "id": "1",
              "path": "/backup",
              "type": "nfs"
            },
            "lastUpdated": "2025-01-15 10:30:00"
          }
        ]
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
  "message": "Recovery job list",
  "timestamp": "2025-01-15 10:30:00"
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
        "source": {
          "id": "1",
          "name": "source-server",
          "os": "Ubuntu 22.04",
          "agent": "3.2.1",
          "ip": {
            "public": "203.0.113.10",
            "private": ["192.168.1.10"]
          },
          "license": "100"
        },
        "target": {
          "id": "2",
          "name": "target-server",
          "os": "Ubuntu 22.04",
          "agent": "3.2.1",
          "ip": {
            "public": "203.0.113.20",
            "private": ["192.168.1.20"]
          },
          "license": "100"
        }
      },
      "job": {
        "info": {
          "id": "1",
          "name": "daily-recovery",
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Every day at 10:00"
            }
          },
          "status": {
            "current": "Complete",
            "time": {
              "start": "2025-01-15 10:00:00",
              "elapsed": "00:30:00",
              "end": "2025-01-15 10:30:00"
            }
          },
          "lastUpdated": "2025-01-15 10:30:00",
          "platform": "vmware",
          "kernal": "5.15.0-generic",
          "networkSpeed": "0",
          "script": {
            "path": "",
            "run": ""
          },
          "afterReboot": "reboot",
          "notification": {
            "mail": "admin@example.com"
          }
        },
        "detail": [
          {
            "from": "/",
            "to": "/",
            "targetDevice": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "daily-backup",
              "fileName": "backup-2025-01-15.img",
              "latest": "use"
            },
            "repository": {
              "id": "1",
              "path": "/backup",
              "type": "nfs"
            },
            "lastUpdated": "2025-01-15 10:30:00",
            "option": {
              "overwrite": "Overwritten",
              "fileSystem": "ext4"
            }
          }
        ]
      }
    }
  ],
  "message": "Recovery job list",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `system.source.id` | string | - | 소스 서버 ID |
| `system.source.name` | string | - | 소스 서버 이름 |
| `system.source.os` | string | - | 소스 서버 OS |
| `system.source.agent` | string | detail | 소스 에이전트 버전 |
| `system.source.ip.public` | string | detail | 소스 공인 IP |
| `system.source.ip.private` | string[] | detail | 소스 사설 IP 목록 |
| `system.source.license` | string | detail | 소스 라이선스 ID |
| `system.target.id` | string | - | 타겟 서버 ID |
| `system.target.name` | string | - | 타겟 서버 이름 |
| `system.target.os` | string | - | 타겟 서버 OS |
| `system.target.agent` | string | detail | 타겟 에이전트 버전 |
| `system.target.ip.public` | string | detail | 타겟 공인 IP |
| `system.target.ip.private` | string[] | detail | 타겟 사설 IP 목록 |
| `system.target.license` | string | detail | 타겟 라이선스 ID |
| `job.info.id` | string | - | 복구 작업 ID |
| `job.info.name` | string | - | 복구 작업 이름 |
| `job.info.schedule.basic` | object/string | - | 기본 스케줄 정보 |
| `job.info.status.current` | string | - | 현재 작업 상태 (PascalCase: Preparing, Processing, Complete, Scheduled, Registered, Canceling, Canceled, Error) |
| `job.info.status.time.start` | string | - | 작업 시작 시간 |
| `job.info.status.time.elapsed` | string | - | 경과 시간 |
| `job.info.status.time.end` | string | - | 작업 종료 시간 |
| `job.info.lastUpdated` | string | - | 정보 업데이트 시간 |
| `job.info.platform` | string | detail | 타겟 플랫폼 |
| `job.info.kernal` | string | detail | 소스 커널 버전 |
| `job.info.networkSpeed` | string | detail | 네트워크 속도 제한 |
| `job.info.script.path` | string | detail | 스크립트 경로 |
| `job.info.script.run` | string | detail | 스크립트 실행 타이밍 |
| `job.info.afterReboot` | string | detail | 작업 후 부팅 모드 |
| `job.info.notification.mail` | string | detail | 알림 이메일 |
| `job.detail[].from` | string | - | 소스 파티션/드라이브 |
| `job.detail[].to` | string | - | 타겟 파티션/드라이브 |
| `job.detail[].targetDevice` | string | - | 타겟 디바이스 경로 |
| `job.detail[].mode` | string | - | 작업 모드 |
| `job.detail[].backup.jobName` | string | - | 백업 작업 이름 |
| `job.detail[].backup.fileName` | string | - | 백업 파일 이름 |
| `job.detail[].backup.latest` | string | - | 최신 백업 파일 사용 여부 |
| `job.detail[].repository.id` | string | - | 레포지토리 ID |
| `job.detail[].repository.path` | string | - | 레포지토리 경로 |
| `job.detail[].repository.type` | string | - | 레포지토리 타입 |
| `job.detail[].lastUpdated` | string | - | 상세 정보 업데이트 시간 |
| `job.detail[].option.overwrite` | string | detail | 덮어쓰기 상태 |
| `job.detail[].option.fileSystem` | string | detail | 파일시스템 (Linux) |
| `pagination.currentPage` | number | page/limit | 현재 페이지 번호 |
| `pagination.totalPages` | number | page/limit | 전체 페이지 수 |
| `pagination.totalItems` | number | page/limit | 전체 항목 수 |
| `pagination.itemsPerPage` | number | page/limit | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | page/limit | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | page/limit | 이전 페이지 존재 여부 |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "토큰이 만료되었습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "유효하지 않은 'mode' 값입니다. 허용된 값: full, increment",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
