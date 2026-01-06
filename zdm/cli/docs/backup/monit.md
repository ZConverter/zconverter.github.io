---
layout: docs
title: backup monit
section_title: ZDM CLI Documentation
navigation: cli
---

Backup 작업의 진행 상황을 모니터링하는 명령어입니다.

---

## `backup monit` {#backup-monit}

> * Backup 작업의 실시간 진행 상황을 모니터링합니다. 작업 기준 또는 서버 기준으로 모니터링할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup monit [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli backup monit --job-id 123

# 작업 이름으로 상세 모니터링
zdm-cli backup monit --job-name "MyBackup" --detail

# 서버 ID로 모니터링
zdm-cli backup monit --server-id 456

# 서버 이름으로 상태 필터링 모니터링
zdm-cli backup monit --server-name "MyServer" --status running

# 작업 ID와 모드로 필터링 모니터링
zdm-cli backup monit --job-id 789 --mode full

# 서버와 저장소 경로로 모니터링
zdm-cli backup monit --server-name "DB-Server" --repository-path "/backup/db"

# JSON 형식으로 출력
zdm-cli backup monit --job-id 123 --output json

# Table 형식으로 출력
zdm-cli backup monit --server-id 456 --output table
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
| --mode | - | string | Optional | - | 작업 모드 | full, increment, smart |
| --status | - | string | Optional | - | 작업 상태 | - |
| --repository-path | -rp | string | Optional | - | Repository Path | - |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --output | -o | string | Optional | text | 출력 형식 | text, json, table |

> <span class="required-note">*</span> `job-id/job-name` 또는 `server-id/server-name` 중 하나는 필수로 입력해야 합니다.<br>
> <span class="required-note">*</span> ID와 Name은 동시에 입력할 수 없습니다.<br>
> <span class="required-note">*</span> job과 server 파라미터는 동시에 사용할 수 없습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력 - 작업 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 10:15:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
name : web01

[Job Information]
name      : backup_job_01
partition : /
drive     : sda1
status    : running
percent   : 45%
message   : Backing up files...
start     : 2025-01-01T10:00:00Z
elapsed   : 00:15:00
end       : -

[Job Logs]
1: 2025-01-01T10:00:00Z - Backup started
2: 2025-01-01T10:05:00Z - Scanning files...
3: 2025-01-01T10:10:00Z - Transferring data...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": {
    "system": {
      "name": "web01"
    },
    "job": {
      "info": {
        "name": "backup_job_01",
        "partition": "/",
        "drive": "sda1"
      },
      "progressInfo": {
        "status": "running",
        "percent": "45%",
        "message": "Backing up files...",
        "start": "2025-01-01T10:00:00Z",
        "elapsed": "00:15:00",
        "end": null
      },
      "log": [
        "2025-01-01T10:00:00Z - Backup started",
        "2025-01-01T10:05:00Z - Scanning files...",
        "2025-01-01T10:10:00Z - Transferring data..."
      ]
    }
  },
  "timestamp": "2025-01-01 10:15:00"
}
```

### 기본 출력 - 서버 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
name : web01

[Jobs Summary]
total           : 3
completed       : 1
inProgress      : 1
failed          : 0
pending         : 1
overallProgress : 45%

[Job 1]
name      : backup_root
partition : /
drive     : sda1
status    : complete
percent   : 100%
message   : Backup completed successfully
start     : 2025-01-01T09:00:00Z
elapsed   : -
end       : 2025-01-01T09:30:00Z

[Job 2]
name      : backup_home
partition : /home
drive     : sda2
status    : running
percent   : 60%
message   : Backing up files...
start     : 2025-01-01T09:30:00Z
elapsed   : -
end       : -

[Job 3]
name      : backup_var
partition : /var
drive     : sda3
status    : pending
percent   : 0%
message   : Waiting in queue
start     : -
elapsed   : -
end       : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": {
    "system": {
      "name": "web01"
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
          "name": "backup_root",
          "partition": "/",
          "drive": "sda1"
        },
        "progressInfo": {
          "status": "complete",
          "percent": "100%",
          "message": "Backup completed successfully",
          "start": "2025-01-01T09:00:00Z",
          "end": "2025-01-01T09:30:00Z"
        }
      },
      {
        "info": {
          "name": "backup_home",
          "partition": "/home",
          "drive": "sda2"
        },
        "progressInfo": {
          "status": "running",
          "percent": "60%",
          "message": "Backing up files...",
          "start": "2025-01-01T09:30:00Z",
          "end": null
        }
      },
      {
        "info": {
          "name": "backup_var",
          "partition": "/var",
          "drive": "sda3"
        },
        "progressInfo": {
          "status": "pending",
          "percent": "0%",
          "message": "Waiting in queue",
          "start": null,
          "end": null
        }
      }
    ]
  },
  "timestamp": "2025-01-01 10:00:00"
}
```

### 상세 출력(detail 옵션 사용) - 작업 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 10:15:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
name       : web01
os         : Linux
agent      : 3.0.1
ip.public  : 1.2.3.4
ip.private : 10.0.0.1

[Job Information]
name            : backup_job_01
partition       : /
drive           : sda1
mode            : full
status          : running
percent         : 45%
message         : Backing up files...
start           : 2025-01-01T10:00:00Z
elapsed         : 00:15:00
end             : -
repository.id   : 1
repository.path : /backup/repo
repository.type : nfs

[Job Logs]
1: 2025-01-01T10:00:00Z - Backup started
2: 2025-01-01T10:05:00Z - Scanning files...
3: 2025-01-01T10:10:00Z - Transferring data...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": {
    "system": {
      "name": "web01",
      "os": "Linux",
      "agent": "3.0.1",
      "ip": {
        "public": "1.2.3.4",
        "private": ["10.0.0.1"]
      }
    },
    "job": {
      "info": {
        "name": "backup_job_01",
        "partition": "/",
        "drive": "sda1",
        "mode": "full"
      },
      "progressInfo": {
        "status": "running",
        "percent": "45%",
        "message": "Backing up files...",
        "start": "2025-01-01T10:00:00Z",
        "elapsed": "00:15:00",
        "end": null
      },
      "repository": {
        "id": "1",
        "path": "/backup/repo",
        "type": "nfs"
      },
      "log": [
        "2025-01-01T10:00:00Z - Backup started",
        "2025-01-01T10:05:00Z - Scanning files...",
        "2025-01-01T10:10:00Z - Transferring data..."
      ]
    }
  },
  "timestamp": "2025-01-01 10:15:00"
}
```

### 상세 출력(detail 옵션 사용) - 서버 기준

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Monit Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
name       : web01
os         : Linux
agent      : 3.0.1
ip.public  : 1.2.3.4
ip.private : 10.0.0.1

[Jobs Summary]
total           : 3
completed       : 1
inProgress      : 1
failed          : 0
pending         : 1
overallProgress : 45%

[Job 1]
name            : backup_root
partition       : /
drive           : sda1
mode            : full
status          : complete
percent         : 100%
message         : Backup completed successfully
start           : 2025-01-01T09:00:00Z
elapsed         : 00:30:00
end             : 2025-01-01T09:30:00Z
repository.id   : 1
repository.path : /backup/repo
repository.type : nfs

[Job 2]
name            : backup_home
partition       : /home
drive           : sda2
mode            : full
status          : running
percent         : 60%
message         : Backing up files...
start           : 2025-01-01T09:30:00Z
elapsed         : 00:30:00
end             : -
repository.id   : 1
repository.path : /backup/repo
repository.type : nfs

[Job 3]
name            : backup_var
partition       : /var
drive           : sda3
mode            : full
status          : pending
percent         : 0%
message         : Waiting in queue
start           : -
elapsed         : -
end             : -
repository.id   : 1
repository.path : /backup/repo
repository.type : nfs

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": {
    "system": {
      "name": "web01",
      "os": "Linux",
      "agent": "3.0.1",
      "ip": {
        "public": "1.2.3.4",
        "private": ["10.0.0.1"]
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
          "name": "backup_root",
          "partition": "/",
          "drive": "sda1",
          "mode": "full"
        },
        "progressInfo": {
          "status": "complete",
          "percent": "100%",
          "message": "Backup completed successfully",
          "start": "2025-01-01T09:00:00Z",
          "elapsed": "00:30:00",
          "end": "2025-01-01T09:30:00Z"
        },
        "repository": {
          "id": "1",
          "path": "/backup/repo",
          "type": "nfs"
        }
      },
      {
        "info": {
          "name": "backup_home",
          "partition": "/home",
          "drive": "sda2",
          "mode": "full"
        },
        "progressInfo": {
          "status": "running",
          "percent": "60%",
          "message": "Backing up files...",
          "start": "2025-01-01T09:30:00Z",
          "elapsed": "00:30:00",
          "end": null
        },
        "repository": {
          "id": "1",
          "path": "/backup/repo",
          "type": "nfs"
        }
      },
      {
        "info": {
          "name": "backup_var",
          "partition": "/var",
          "drive": "sda3",
          "mode": "full"
        },
        "progressInfo": {
          "status": "pending",
          "percent": "0%",
          "message": "Waiting in queue",
          "start": null,
          "elapsed": null,
          "end": null
        },
        "repository": {
          "id": "1",
          "path": "/backup/repo",
          "type": "nfs"
        }
      }
    ]
  },
  "timestamp": "2025-01-01 10:00:00"
}
```

</details>

---
