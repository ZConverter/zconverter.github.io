---
layout: docs
title: GET /recoveries/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 복구 작업의 상세 정보를 조회합니다.

---

## `GET /recoveries/:identifier` {#get-recoveries-identifier}

> * 복구 ID 또는 복구 이름으로 특정 복구 작업의 정보를 조회합니다.
> * identifier가 숫자인 경우 복구 ID로, 그 외에는 복구 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복구 ID로 조회
curl -X GET "https://api.example.com/api/recoveries/1" \
  -H "Authorization: Bearer <token>"

# 복구 이름으로 조회
curl -X GET "https://api.example.com/api/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/recoveries/1?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 ID (숫자) 또는 복구 이름 | - |
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

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 - Linux (detail=false)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
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
  },
  "message": "Recovery job retrieved",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>기본 응답 - Windows (detail=false)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
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
        },
        {
          "from": "D:",
          "to": "D:",
          "targetDevice": "\\Device\\Harddisk0\\Partition3",
          "mode": "full",
          "backup": {
            "jobName": "windows-backup",
            "fileName": "backup-2025-01-12-D.img",
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
  },
  "message": "Recovery job retrieved",
  "timestamp": "2025-01-12 03:00:00"
}
```

</details>

<details markdown="1">
<summary>상세 응답 (detail=true)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
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
  },
  "message": "Recovery job retrieved",
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

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복구 작업을 찾을 수 없음 (404 Not Found)**

지정한 ID 또는 Name의 복구 작업이 존재하지 않는 경우 반환됩니다.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Recovery 작업을 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**필터 조건 불일치 (404 Not Found)**

복구 작업은 존재하지만, 지정한 필터 조건과 일치하는 결과가 없는 경우 반환됩니다.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Name이 'daily-recovery'인 Recovery 작업은 존재하지만, 지정된 필터 조건과 일치하는 결과가 없습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
