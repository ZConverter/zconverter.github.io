---
layout: docs
title: backup list
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

Backup 목록 및 정보를 조회하는 명령어입니다.

---

## `backup list` {#backup-list}

> * Backup 작업의 목록 또는 특정 작업의 상세 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Backup 목록 조회
zdm-cli backup list

# 특정 서버의 Backup 목록 조회
zdm-cli backup list --server "web01"

# 작업 ID로 특정 Backup 조회
zdm-cli backup list --id 123

# 작업 이름으로 특정 Backup 조회
zdm-cli backup list --name "MyBackup"

# 특정 모드의 Backup 목록 조회
zdm-cli backup list --mode full

# 특정 상태의 Backup 목록 조회
zdm-cli backup list --status run

# 상세 정보 포함 조회
zdm-cli backup list --id 123 --detail

# Repository 경로로 필터링
zdm-cli backup list --repository-path "/backup/repo"

# JSON 형식으로 출력
zdm-cli backup list --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --server | - | string | Optional | - | 작업 대상 Server | - |
| --name | - | string | Optional | - | 작업 이름 | - |
| --id | - | number | Optional | - | 작업 ID | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| --status | - | string | Optional | - | 작업 상태 | {% include zdm/job-status.md %} |
| --repository-path | -rp | string | Optional | - | 작업에 사용한 repository path | - |
| --repository-type | -rt | string | Optional | - | 작업에 사용한 repository type | {% include zdm/repository-types.md %} |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Info Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Backup 1]
name             : backup_job_01
id               : 123
mode             : full
partition        : /
status(current)  : complete
schedule.basic   : id: 1, type: daily, description: Daily backup at 2AM
schedule.advanced: -
system.name      : web01
system.os        : Linux
repository.path  : /backup/repo
repository.type  : nfs
start            : 2025-01-01T10:00:00Z
elapsed          : 00:30:00
end              : 2025-01-01T10:30:00Z
lastUpdated      : 2025-01-01T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": [
    {
      "job": {
        "info": {
          "name": "backup_job_01",
          "id": "123",
          "mode": "full",
          "partition": "/",
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:30:00",
              "end": "2025-01-01T10:30:00Z"
            }
          },
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Daily backup at 2AM"
            },
            "advanced": "-"
          }
        },
        "lastUpdated": "2025-01-01T10:30:00Z"
      },
      "system": {
        "name": "web01",
        "os": "Linux"
      },
      "repository": {
        "path": "/backup/repo",
        "type": "nfs"
      }
    }
  ],
  "timestamp": "2025-01-01 12:00:00"
}
```

### 상세 출력(detail 옵션 사용)

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Info Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Backup 1]
name                  : backup_job_01
id                    : 123
mode                  : full
partition             : /
status(current)       : complete
schedule.basic        : id: 1, type: daily, description: Daily backup at 2AM
schedule.advanced     : -
system.name           : web01
system.os             : Linux
system.agent          : 3.0.1
system.ip.public      : 1.2.3.4
system.ip.private     : 10.0.0.1
repository.id         : 1
repository.path       : /backup/repo
repository.type       : nfs
option.compression    : enabled
option.encryption     : AES-256
option.retention      : 30 days
notification.mail     : admin@example.com
start                 : 2025-01-01T10:00:00Z
elapsed               : 00:30:00
end                   : 2025-01-01T10:30:00Z
lastUpdated           : 2025-01-01T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": [
    {
      "job": {
        "info": {
          "name": "backup_job_01",
          "id": "123",
          "mode": "full",
          "partition": "/",
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:30:00",
              "end": "2025-01-01T10:30:00Z"
            }
          },
          "schedule": {
            "basic": {
              "id": "1",
              "type": "daily",
              "description": "Daily backup at 2AM"
            },
            "advanced": "-"
          },
          "option": {
            "compression": "enabled",
            "encryption": "AES-256",
            "retention": "30 days"
          },
          "notification": {
            "mail": "admin@example.com"
          }
        },
        "lastUpdated": "2025-01-01T10:30:00Z"
      },
      "system": {
        "name": "web01",
        "os": "Linux",
        "agent": "3.0.1",
        "ip": {
          "public": "1.2.3.4",
          "private": ["10.0.0.1"]
        }
      },
      "repository": {
        "id": "1",
        "path": "/backup/repo",
        "type": "nfs"
      }
    }
  ],
  "timestamp": "2025-01-01 12:00:00"
}
```

</details>

---
