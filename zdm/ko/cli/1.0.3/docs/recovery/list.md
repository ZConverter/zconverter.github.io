---
layout: docs
title: recovery list
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

Recovery 작업 목록 및 상세 정보를 조회합니다.

---

## `recovery list` {#recovery-list}

> * Recovery 작업의 목록을 조회하거나, 특정 작업의 상세 정보를 조회합니다.
> * 다양한 필터 옵션을 통해 원하는 조건의 Recovery 작업만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Recovery 작업 목록 조회
zdm-cli recovery list

# 특정 ID로 Recovery 작업 조회
zdm-cli recovery list --id 123

# 특정 이름으로 Recovery 작업 조회
zdm-cli recovery list --name "my-recovery"

# 상세 정보 포함 조회
zdm-cli recovery list --id 123 --detail

# 상태별 필터링
zdm-cli recovery list --status running

# 플랫폼별 필터링
zdm-cli recovery list --platform aws

# 백업 작업 이름으로 필터링
zdm-cli recovery list --backup-name "my-backup"

# Repository ID로 필터링
zdm-cli recovery list --repository-id 1

# 복합 조건 조회
zdm-cli recovery list --platform vmware --status completed --mode full

# JSON 형식 출력
zdm-cli recovery list --output json

# 테이블 형식 출력
zdm-cli recovery list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --status | | string | Optional | | 작업 상태 | {% include zdm/job-status.md %} |
| --mode | | string | Optional | | 작업 모드 | {% include zdm/job-modes.md recovery=true %} |
| --name | | string | Optional | | 작업 이름 | |
| --id | | number | Optional | | 작업 ID | |
| --partition | | string | Optional | | 작업 대상 partition (Linux) | |
| --drive | | string | Optional | | 작업 대상 drive (Windows) | |
| --platform | | string | Optional | | 작업 대상 플랫폼 | {% include zdm/platforms.md inline=true %} |
| --backup-name | -bn | string | Optional | | Recovery 작업시 사용한 Backup 작업 이름 | |
| --server | | string | Optional | | 작업 대상 Server | |
| --server-type | | string | Optional | | 작업 대상 Server Type | {% include zdm/server-modes.md %} |
| --repository-id | -ri | string | Optional | | 작업에 사용한 Repository ID | |
| --repository-path | -rp | string | Optional | | 작업에 사용한 Repository 경로 | |
| --repository-type | -rt | string | Optional | | 작업에 사용한 Repository 타입 | {% include zdm/repository-types.md %} |
| --detail | | boolean | Optional | | 상세 정보 조회 여부 | |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Info Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery info retrieved successfully
timestamp : 2025-01-01 10:15:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Recovery 1]
name              : recovery-ubuntu22
id                : 123
schedule.basic    : One-time execution
status(current)   : completed
source.name       : ubuntu22-source
source.os         : Ubuntu 22.04
target.name       : ubuntu22-target
target.os         : Ubuntu 22.04
start             : 2025-01-01T10:00:00Z
elapsed           : 00:15:30
end               : 2025-01-01T10:15:30Z
lastUpdated       : 2025-01-01T10:15:30Z

  [Recovery Job 1]
  partition           : /
  device              : /dev/sda1
  mode                : full
  backup.jobName      : backup-ubuntu22
  backup.fileName     : backup-2025-01-01.img
  backup.latest       : 2025-01-01T09:00:00Z
  repository.id       : 1
  repository.type     : nfs
  repository.path     : /mnt/backup
  lastUpdated         : 2025-01-01T10:15:30Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery info retrieved successfully",
  "success": true,
  "data": [
    {
      "job": {
        "info": {
          "name": "recovery-ubuntu22",
          "id": 123,
          "schedule": {
            "basic": {
              "type": "once",
              "description": "One-time execution"
            }
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:15:30",
              "end": "2025-01-01T10:15:30Z"
            }
          },
          "lastUpdated": "2025-01-01T10:15:30Z"
        },
        "detail": [
          {
            "partition": "/",
            "device": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "backup-ubuntu22",
              "fileName": "backup-2025-01-01.img",
              "latest": "2025-01-01T09:00:00Z"
            },
            "repository": {
              "id": "1",
              "type": "nfs",
              "path": "/mnt/backup"
            },
            "lastUpdated": "2025-01-01T10:15:30Z"
          }
        ]
      },
      "system": {
        "source": {
          "name": "ubuntu22-source",
          "os": "Ubuntu 22.04"
        },
        "target": {
          "name": "ubuntu22-target",
          "os": "Ubuntu 22.04"
        }
      }
    }
  ],
  "timestamp": "2025-01-01 10:15:30"
}
```

### 상세 출력(detail 옵션 사용)

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Info Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery info retrieved successfully
timestamp : 2025-01-01 10:15:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Recovery 1]
name                  : recovery-ubuntu22
id                    : 123
schedule.basic        : One-time execution
status(current)       : completed
platform              : aws
kernel                : 5.15.0-generic
networkSpeed          : 1000
script.path           : /scripts/post-recovery.sh
script.run            : after
afterReboot           : reboot
notification.mail     : admin@example.com
source.name           : ubuntu22-source
source.os             : Ubuntu 22.04
source.agent          : 3.0.1
source.ip.public      : 1.2.3.4
source.ip.private     : 10.0.0.1
source.license        : valid
target.name           : ubuntu22-target
target.os             : Ubuntu 22.04
target.agent          : 3.0.1
target.ip.public      : 5.6.7.8
target.ip.private     : 10.0.0.2
target.license        : valid
start                 : 2025-01-01T10:00:00Z
elapsed               : 00:15:30
end                   : 2025-01-01T10:15:30Z
lastUpdated           : 2025-01-01T10:15:30Z

  [Recovery Job 1]
  partition             : /
  device                : /dev/sda1
  mode                  : full
  backup.jobName        : backup-ubuntu22
  backup.fileName       : backup-2025-01-01.img
  backup.latest         : 2025-01-01T09:00:00Z
  repository.id         : 1
  repository.type       : nfs
  repository.path       : /mnt/backup
  option.overwrite      : allow
  option.fileSystem     : ext4
  lastUpdated           : 2025-01-01T10:15:30Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery info retrieved successfully",
  "success": true,
  "data": [
    {
      "job": {
        "info": {
          "name": "recovery-ubuntu22",
          "id": 123,
          "schedule": {
            "basic": {
              "type": "once",
              "description": "One-time execution"
            }
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:15:30",
              "end": "2025-01-01T10:15:30Z"
            }
          },
          "platform": "aws",
          "kernal": "5.15.0-generic",
          "networkSpeed": "1000",
          "script": {
            "path": "/scripts/post-recovery.sh",
            "run": "after"
          },
          "afterReboot": "reboot",
          "notification": {
            "mail": "admin@example.com"
          },
          "lastUpdated": "2025-01-01T10:15:30Z"
        },
        "detail": [
          {
            "partition": "/",
            "device": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "backup-ubuntu22",
              "fileName": "backup-2025-01-01.img",
              "latest": "2025-01-01T09:00:00Z"
            },
            "repository": {
              "id": "1",
              "type": "nfs",
              "path": "/mnt/backup"
            },
            "option": {
              "overwrite": "allow",
              "fileSystem": "ext4"
            },
            "lastUpdated": "2025-01-01T10:15:30Z"
          }
        ]
      },
      "system": {
        "source": {
          "name": "ubuntu22-source",
          "os": "Ubuntu 22.04",
          "agent": "3.0.1",
          "ip": {
            "public": "1.2.3.4",
            "private": ["10.0.0.1"]
          },
          "license": "valid"
        },
        "target": {
          "name": "ubuntu22-target",
          "os": "Ubuntu 22.04",
          "agent": "3.0.1",
          "ip": {
            "public": "5.6.7.8",
            "private": ["10.0.0.2"]
          },
          "license": "valid"
        }
      }
    }
  ],
  "timestamp": "2025-01-01 10:15:30"
}
```

</details>

---
