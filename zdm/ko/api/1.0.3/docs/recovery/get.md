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
  <code>GET /api/v1/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복구 ID로 조회
curl -X GET "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>"

# 복구 이름으로 조회
curl -X GET "https://api.example.com/api/v1/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/v1/recoveries/1?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 ID (숫자) 또는 복구 이름 | - |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (detail=false)</summary>

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
          "current": "complete",
          "time": {
            "start": "2025-01-15T10:00:00Z",
            "elapsed": "00:30:00",
            "end": "2025-01-15T10:30:00Z"
          }
        },
        "lastUpdated": "2025-01-15T10:30:00Z"
      },
      "detail": [
        {
          "partition": "/",
          "device": "/dev/sda1",
          "mode": "full",
          "backup": {
            "jobName": "daily-backup",
            "fileName": "backup-2025-01-15.img",
            "latest": "true"
          },
          "repository": {
            "id": "1",
            "path": "/backup",
            "type": "nfs"
          },
          "lastUpdated": "2025-01-15T10:30:00Z"
        }
      ]
    }
  },
  "message": "Recovery job retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
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
          "current": "complete",
          "time": {
            "start": "2025-01-15T10:00:00Z",
            "elapsed": "00:30:00",
            "end": "2025-01-15T10:30:00Z"
          }
        },
        "lastUpdated": "2025-01-15T10:30:00Z",
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
          "partition": "/",
          "device": "/dev/sda1",
          "mode": "full",
          "backup": {
            "jobName": "daily-backup",
            "fileName": "backup-2025-01-15.img",
            "latest": "true"
          },
          "repository": {
            "id": "1",
            "path": "/backup",
            "type": "nfs"
          },
          "lastUpdated": "2025-01-15T10:30:00Z",
          "option": {
            "overwrite": "allow",
            "fileSystem": "ext4"
          }
        }
      ]
    }
  },
  "message": "Recovery job retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
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
| `job.info.status.current` | string | - | 현재 작업 상태 |
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
| `job.detail[].partition` | string | - | 대상 파티션 (Linux) |
| `job.detail[].drive` | string | - | 대상 드라이브 (Windows) |
| `job.detail[].device` | string | - | 디바이스 경로 |
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

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "RECOVERY_NOT_FOUND",
    "message": "ID가 '999'인 Recovery를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
