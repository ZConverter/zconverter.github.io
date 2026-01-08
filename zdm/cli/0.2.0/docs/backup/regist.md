---
layout: docs
title: backup regist
section_title: ZDM CLI Documentation
navigation: cli-0.2.0
---

Backup 작업을 등록하는 명령어입니다.

---

## `backup regist` {#backup-regist}

> * 새로운 Backup 작업을 등록합니다. 서버의 전체 파티션 또는 특정 파티션에 대한 백업 작업을 설정할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 Backup 등록 (압축 활성화, 암호화 비활성화)
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1

# 압축 없이 Backup 등록
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --no-compression

# 암호화 활성화하여 Backup 등록
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --encryption

# 특정 파티션만 Backup 등록
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --partition "/,/home"

# 작업 이름 지정하여 등록
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --jobName "daily_backup"

# 스케줄 설정과 함께 등록
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --schedule "schedule_id"

# 제외 폴더 설정
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --excludeDir "/tmp,/var/log"

# 자동 시작 설정
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --start

# 스크립트 실행 설정
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --scriptPath "/scripts/pre_backup.sh" --scriptRun before

# 파티션별 개별 설정 (JSON 형태)
zdm-cli backup regist --server "web01" --mode "full" --repository-id 1 --individual '[{"partition":"/","jobName":"root_backup"}]'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --server | - | string | Required | - | 작업 대상 Server | - |
| --mode | - | string | Required | - | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| --center | - | string | Optional | config 설정값 | 작업 등록 Center | - |
| --repository-id | -ri | number | Optional | config 설정값 | 작업시 사용할 Repository ID | - |
| --repository-path | -rp | string | Optional | - | 작업시 사용할 Repository Path | - |
| --partition | - | string | Optional | 전체 파티션 | 작업 대상 파티션 (콤마로 구분) | - |
| --jobName | -name | string | Optional | - | 작업 이름 | - |
| --schedule | -sc | string | Optional | - | 작업에 사용할 Schedule | - |
| --description | -desc | string | Optional | - | 작업 설명 | - |
| --rotation | -rot | number | Optional | 1 | 작업 반복횟수 | - |
| --no-compression | -ncomp | boolean | Optional | false | 작업 압축 안함 | - |
| --encryption | -enc | boolean | Optional | false | 작업 암호화 | - |
| --excludeDir | -exd | string | Optional | - | 작업 제외 폴더 | - |
| --excludePartition | -exp | string | Optional | - | 작업 제외 partition | - |
| --networkLimit | -nl | number | Optional | 0 | 작업 Network 제한 속도 | - |
| --start | - | boolean | Optional | false | 작업 자동시작 여부 | - |
| --scriptPath | -sp | string | Optional | - | 작업시 사용할 script full path | - |
| --scriptRun | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --individual | -ind | string | Optional | - | 파티션별 개별 설정 (JSON 문자열) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>Individual JSON format (Full default value)</strong></summary>

```json
[
  {
    "partition": "/",
    "jobName": "root_backup",
    "mode": "full",
    "repository": {
      "id": 1,
      "path": "/backup/repo"
    },
    "compression": true,
    "encryption": false,
    "rotation": 1,
    "excludeDir": "/tmp,/var/log",
    "excludePartition": "/dev",
    "mailEvent": "admin@example.com",
    "networkLimit": 100,
    "autoStart": true,
    "description": "Root partition backup"
  }
]
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Registration Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Registration Summary]
total      : 2
successful : 2
failed     : 0

[Registration Details]

[Job 1]
state           : success
jobName         : root_backup
partition       : /
jobMode         : full
autoStart       : use
scriptPath      : -
scriptRunTiming : -
schedule.basic  : type: daily, description: Daily backup at 2AM
schedule.advanced: -

[Job 2]
state           : success
jobName         : home_backup
partition       : /home
jobMode         : full
autoStart       : use
scriptPath      : -
scriptRunTiming : -
schedule.basic  : -
schedule.advanced: -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (JSON format)</strong></summary>

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": {
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "root_backup",
        "partition": "/",
        "jobMode": "full",
        "autoStart": "use",
        "scriptPath": "-",
        "scriptRunTiming": "-",
        "schedule": {
          "basic": {
            "type": "daily",
            "description": "Daily backup at 2AM"
          },
          "advanced": "-"
        }
      },
      {
        "state": "success",
        "jobName": "home_backup",
        "partition": "/home",
        "jobMode": "full",
        "autoStart": "use",
        "scriptPath": "-",
        "scriptRunTiming": "-",
        "schedule": {
          "basic": "-",
          "advanced": "-"
        }
      }
    ]
  },
  "timestamp": "2025-01-01 12:00:00"
}
```

</details>

---
