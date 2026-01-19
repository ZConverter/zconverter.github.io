---
layout: docs
title: recovery monit
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

Recovery 작업의 실시간 진행 상태를 모니터링합니다.

---

## `recovery monit` {#recovery-monit}

> * Recovery 작업의 실시간 진행 상태 및 로그를 조회합니다.
> * 작업 ID/이름 또는 서버 ID/이름을 기준으로 모니터링할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery monit [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli recovery monit --job-id 123

# 작업 이름으로 모니터링
zdm-cli recovery monit --job-name "my-recovery"

# 작업 이름으로 상세 모니터링
zdm-cli recovery monit --job-name "MyRecovery" --detail

# 서버 ID로 모니터링
zdm-cli recovery monit --server-id 456

# 서버 이름으로 모니터링
zdm-cli recovery monit --server-name "MyServer"

# 서버 타입 지정 모니터링
zdm-cli recovery monit --server-name "MyServer" --server-type source

# 작업 ID와 모드로 필터링 모니터링
zdm-cli recovery monit --job-id 789 --mode full

# 상태로 필터링 모니터링
zdm-cli recovery monit --server-name "MyServer" --status processing

# 서버와 파티션으로 모니터링
zdm-cli recovery monit --server-name "DB-Server" --partition "/dev/sda1"

# 드라이브로 필터링 (Windows)
zdm-cli recovery monit --job-id 123 --drive "C:"

# JSON 형식 출력
zdm-cli recovery monit --job-id 123 --output json

# 테이블 형식 출력
zdm-cli recovery monit --server-id 456 --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --job-id | -ji | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --job-name | -jn | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --server-id | -si | number | Optional<span class="required-note">*</span> | - | 작업 대상 Server ID | - |
| --server-name | -sn | string | Optional<span class="required-note">*</span> | - | 작업 대상 Server Name | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md %} |
| --status | - | string | Optional | - | 작업 상태 | {% include zdm/job-status.md %} |
| --partition | - | string | Optional | - | 파티션 (Linux) | - |
| --drive | - | string | Optional | - | 드라이브 (Windows) | - |
| --server-type | -st | string | Optional | - | 서버 타입 | {% include zdm/server-modes.md %} |
| --detail | - | boolean | Optional | - | 상세 정보 조회 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> `job-id`/`job-name`과 `server-id`/`server-name`은 동시에 사용할 수 없습니다.<br>
> <span class="required-note">*</span> ID와 Name은 동시에 입력할 수 없습니다.<br>
> <span class="required-note">*</span> job과 server 파라미터는 동시에 사용할 수 없습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력 - 작업 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery monitoring info retrieved successfully
timestamp : 2025-01-01 10:10:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
Source:
name              : ubuntu22-source
Target:
name              : ubuntu22-target

[Job Information]
name              : recovery-ubuntu22

[Detail 1]
partition         : /
drive             : -
status            : running
percent           : 75%
message           : Restoring data...
start             : 2025-01-01T10:00:00Z
elapsed           : 00:10:30
end               : -

[Detail 2]
partition         : /boot
drive             : -
status            : completed
percent           : 100%
message           : Completed successfully
start             : 2025-01-01T10:00:00Z
elapsed           : 00:02:15
end               : 2025-01-01T10:02:15Z

[Job Logs]
1: 2025-01-01 10:00:00 - Starting recovery job
2: 2025-01-01 10:00:05 - Mounting repository
3: 2025-01-01 10:00:10 - Starting /boot partition recovery
4: 2025-01-01 10:02:15 - /boot partition recovery completed
5: 2025-01-01 10:02:20 - Starting / partition recovery

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery monitoring info retrieved successfully",
  "success": true,
  "data": {
    "system": {
      "source": {
        "name": "ubuntu22-source"
      },
      "target": {
        "name": "ubuntu22-target"
      }
    },
    "job": {
      "info": {
        "name": "recovery-ubuntu22"
      },
      "details": [
        {
          "partition": "/",
          "drive": null,
          "progressInfo": {
            "status": "running",
            "percent": "75%",
            "message": "Restoring data...",
            "start": "2025-01-01T10:00:00Z",
            "elapsed": "00:10:30",
            "end": null
          }
        },
        {
          "partition": "/boot",
          "drive": null,
          "progressInfo": {
            "status": "completed",
            "percent": "100%",
            "message": "Completed successfully",
            "start": "2025-01-01T10:00:00Z",
            "elapsed": "00:02:15",
            "end": "2025-01-01T10:02:15Z"
          }
        }
      ],
      "log": [
        "2025-01-01 10:00:00 - Starting recovery job",
        "2025-01-01 10:00:05 - Mounting repository",
        "2025-01-01 10:00:10 - Starting /boot partition recovery",
        "2025-01-01 10:02:15 - /boot partition recovery completed",
        "2025-01-01 10:02:20 - Starting / partition recovery"
      ]
    }
  },
  "timestamp": "2025-01-01 10:10:30"
}
```

### 기본 출력 - 서버 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery monitoring info retrieved successfully
timestamp : 2025-01-01 10:20:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
Source:
name              : ubuntu22-source
Target:
name              : ubuntu22-target

[Jobs Summary]
total             : 3
completed         : 1
inProgress        : 1
failed            : 0
pending           : 1
overallProgress   : 45%

[Job 1]
name              : recovery-job-1
  [Detail 1]
  partition         : /
  drive             : -
  status            : completed
  percent           : 100%
  message           : Completed successfully
  start             : 2025-01-01T09:00:00Z
  elapsed           : 00:15:00
  end               : 2025-01-01T09:15:00Z

[Job 2]
name              : recovery-job-2
  [Detail 1]
  partition         : /data
  drive             : -
  status            : running
  percent           : 35%
  message           : Restoring data...
  start             : 2025-01-01T10:00:00Z
  elapsed           : 00:20:00
  end               : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery monitoring info retrieved successfully",
  "success": true,
  "data": {
    "system": {
      "source": {
        "name": "ubuntu22-source"
      },
      "target": {
        "name": "ubuntu22-target"
      }
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "name": "recovery-job-1"
        },
        "details": [
          {
            "partition": "/",
            "progressInfo": {
              "status": "completed",
              "percent": "100%",
              "message": "Completed successfully",
              "start": "2025-01-01T09:00:00Z",
              "elapsed": "00:15:00",
              "end": "2025-01-01T09:15:00Z"
            }
          }
        ]
      },
      {
        "info": {
          "name": "recovery-job-2"
        },
        "details": [
          {
            "partition": "/data",
            "progressInfo": {
              "status": "running",
              "percent": "35%",
              "message": "Restoring data...",
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:20:00",
              "end": null
            }
          }
        ]
      }
    ]
  },
  "timestamp": "2025-01-01 10:20:00"
}
```

### 상세 출력(detail 옵션 사용) - 작업 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery monitoring info retrieved successfully
timestamp : 2025-01-01 10:10:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
Source:
name              : ubuntu22-source
os                : Ubuntu 22.04
agent             : 3.0.1
ip.public         : 1.2.3.4
ip.private        : 10.0.0.1
Target:
name              : ubuntu22-target
os                : Ubuntu 22.04
agent             : 3.0.1
ip.public         : 5.6.7.8
ip.private        : 10.0.0.2

[Job Information]
name              : recovery-ubuntu22
platform          : aws
mode              : full

[Detail 1]
partition         : /
drive             : -
device            : /dev/sda1
mode              : full
status            : running
percent           : 75%
message           : Restoring data...
start             : 2025-01-01T10:00:00Z
elapsed           : 00:10:30
end               : -
backup.jobName    : backup-ubuntu22
backup.fileName   : backup-2025-01-01.img
repository.id     : 1
repository.type   : nfs
repository.path   : /mnt/backup

[Detail 2]
partition         : /boot
drive             : -
device            : /dev/sda2
mode              : full
status            : completed
percent           : 100%
message           : Completed successfully
start             : 2025-01-01T10:00:00Z
elapsed           : 00:02:15
end               : 2025-01-01T10:02:15Z
backup.jobName    : backup-ubuntu22
backup.fileName   : backup-2025-01-01.img
repository.id     : 1
repository.type   : nfs
repository.path   : /mnt/backup

[Job Logs]
1: 2025-01-01 10:00:00 - Starting recovery job
2: 2025-01-01 10:00:05 - Mounting repository
3: 2025-01-01 10:00:10 - Starting /boot partition recovery
4: 2025-01-01 10:02:15 - /boot partition recovery completed
5: 2025-01-01 10:02:20 - Starting / partition recovery

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery monitoring info retrieved successfully",
  "success": true,
  "data": {
    "system": {
      "source": {
        "name": "ubuntu22-source",
        "os": "Ubuntu 22.04",
        "agent": "3.0.1",
        "ip": {
          "public": "1.2.3.4",
          "private": ["10.0.0.1"]
        }
      },
      "target": {
        "name": "ubuntu22-target",
        "os": "Ubuntu 22.04",
        "agent": "3.0.1",
        "ip": {
          "public": "5.6.7.8",
          "private": ["10.0.0.2"]
        }
      }
    },
    "job": {
      "info": {
        "name": "recovery-ubuntu22",
        "platform": "aws",
        "mode": "full"
      },
      "details": [
        {
          "partition": "/",
          "drive": null,
          "device": "/dev/sda1",
          "mode": "full",
          "backup": {
            "jobName": "backup-ubuntu22",
            "fileName": "backup-2025-01-01.img"
          },
          "repository": {
            "id": "1",
            "type": "nfs",
            "path": "/mnt/backup"
          },
          "progressInfo": {
            "status": "running",
            "percent": "75%",
            "message": "Restoring data...",
            "start": "2025-01-01T10:00:00Z",
            "elapsed": "00:10:30",
            "end": null
          }
        },
        {
          "partition": "/boot",
          "drive": null,
          "device": "/dev/sda2",
          "mode": "full",
          "backup": {
            "jobName": "backup-ubuntu22",
            "fileName": "backup-2025-01-01.img"
          },
          "repository": {
            "id": "1",
            "type": "nfs",
            "path": "/mnt/backup"
          },
          "progressInfo": {
            "status": "completed",
            "percent": "100%",
            "message": "Completed successfully",
            "start": "2025-01-01T10:00:00Z",
            "elapsed": "00:02:15",
            "end": "2025-01-01T10:02:15Z"
          }
        }
      ],
      "log": [
        "2025-01-01 10:00:00 - Starting recovery job",
        "2025-01-01 10:00:05 - Mounting repository",
        "2025-01-01 10:00:10 - Starting /boot partition recovery",
        "2025-01-01 10:02:15 - /boot partition recovery completed",
        "2025-01-01 10:02:20 - Starting / partition recovery"
      ]
    }
  },
  "timestamp": "2025-01-01 10:10:30"
}
```

### 상세 출력(detail 옵션 사용) - 서버 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery monitoring info retrieved successfully
timestamp : 2025-01-01 10:20:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
Source:
name              : ubuntu22-source
os                : Ubuntu 22.04
agent             : 3.0.1
ip.public         : 1.2.3.4
ip.private        : 10.0.0.1
Target:
name              : ubuntu22-target
os                : Ubuntu 22.04
agent             : 3.0.1
ip.public         : 5.6.7.8
ip.private        : 10.0.0.2

[Jobs Summary]
total             : 3
completed         : 1
inProgress        : 1
failed            : 0
pending           : 1
overallProgress   : 45%

[Job 1]
name              : recovery-job-1
platform          : aws
mode              : full
  [Detail 1]
  partition         : /
  drive             : -
  device            : /dev/sda1
  mode              : full
  status            : completed
  percent           : 100%
  message           : Completed successfully
  start             : 2025-01-01T09:00:00Z
  elapsed           : 00:15:00
  end               : 2025-01-01T09:15:00Z
  backup.jobName    : backup-ubuntu22
  backup.fileName   : backup-2025-01-01.img
  repository.id     : 1
  repository.type   : nfs
  repository.path   : /mnt/backup

[Job 2]
name              : recovery-job-2
platform          : aws
mode              : full
  [Detail 1]
  partition         : /data
  drive             : -
  device            : /dev/sdb1
  mode              : full
  status            : running
  percent           : 35%
  message           : Restoring data...
  start             : 2025-01-01T10:00:00Z
  elapsed           : 00:20:00
  end               : -
  backup.jobName    : backup-data
  backup.fileName   : backup-data-2025-01-01.img
  repository.id     : 1
  repository.type   : nfs
  repository.path   : /mnt/backup

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery monitoring info retrieved successfully",
  "success": true,
  "data": {
    "system": {
      "source": {
        "name": "ubuntu22-source",
        "os": "Ubuntu 22.04",
        "agent": "3.0.1",
        "ip": {
          "public": "1.2.3.4",
          "private": ["10.0.0.1"]
        }
      },
      "target": {
        "name": "ubuntu22-target",
        "os": "Ubuntu 22.04",
        "agent": "3.0.1",
        "ip": {
          "public": "5.6.7.8",
          "private": ["10.0.0.2"]
        }
      }
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "name": "recovery-job-1",
          "platform": "aws",
          "mode": "full"
        },
        "details": [
          {
            "partition": "/",
            "device": "/dev/sda1",
            "mode": "full",
            "backup": {
              "jobName": "backup-ubuntu22",
              "fileName": "backup-2025-01-01.img"
            },
            "repository": {
              "id": "1",
              "type": "nfs",
              "path": "/mnt/backup"
            },
            "progressInfo": {
              "status": "completed",
              "percent": "100%",
              "message": "Completed successfully",
              "start": "2025-01-01T09:00:00Z",
              "elapsed": "00:15:00",
              "end": "2025-01-01T09:15:00Z"
            }
          }
        ]
      },
      {
        "info": {
          "name": "recovery-job-2",
          "platform": "aws",
          "mode": "full"
        },
        "details": [
          {
            "partition": "/data",
            "device": "/dev/sdb1",
            "mode": "full",
            "backup": {
              "jobName": "backup-data",
              "fileName": "backup-data-2025-01-01.img"
            },
            "repository": {
              "id": "1",
              "type": "nfs",
              "path": "/mnt/backup"
            },
            "progressInfo": {
              "status": "running",
              "percent": "35%",
              "message": "Restoring data...",
              "start": "2025-01-01T10:00:00Z",
              "elapsed": "00:20:00",
              "end": null
            }
          }
        ]
      }
    ]
  },
  "timestamp": "2025-01-01 10:20:00"
}
```

</details>

---
