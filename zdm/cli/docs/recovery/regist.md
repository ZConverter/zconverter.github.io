---
layout: docs
title: recovery regist
section_title: ZDM CLI Documentation
navigation: cli
---

새로운 Recovery 작업을 등록합니다.

---

## `recovery regist` {#recovery-regist}

> * Source 서버에서 Target 서버로의 Recovery 작업을 등록합니다.
> * 백업 데이터를 기반으로 시스템을 복구하거나 마이그레이션합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 Recovery 작업 등록
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "openstack" --mode "full" --repository-id 1

# 작업 이름 지정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --jobName "my-recovery-job"

# 오버라이트 허용 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "baremetal" --mode "full" --repository-id 1 --overwrite allow

# 스크립트 실행 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "vmware" --mode "full" --repository-id 1 --scriptPath "/tmp/test.sh" --scriptRun after

# 복구 완료 후 재부팅 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --afterReboot reboot

# 자동 시작 활성화
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --start

# 네트워크 제한 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --networkLimit 1000

# 스케줄 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --schedule "schedule.json"

# 메일 알림 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --mailEvent "admin@example.com"

# 클라우드 인증 정보 사용
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --cloudAuth "aws-credentials"

# 커스텀 작업 리스트 사용 (JSON 형식)
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --jobList '[{"sourcePartition":"/","targetPartition":"/","overwrite":"allow","mode":"full","repository":{"id":1}}]'

# 특정 파티션만 작업 등록
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --jobList '[{"sourcePartition":"/boot","targetPartition":"/boot"}]' --listOnly
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | - | string | Optional | config 설정값 | 작업 등록 Center | - |
| --source | - | string | Required | - | 작업 대상 Source 서버 | - |
| --target | - | string | Required | - | 작업 대상 Target 서버 | - |
| --platform | - | string | Required | - | Target 서버 플랫폼 | {% include zdm/platforms.md inline=true baremetal=true %} |
| --mode | - | string | Required | - | 작업 모드 | {% include zdm/job-modes.md %} |
| --repository-id | -ri | number | Optional | config 설정값 | 작업시 사용할 Repository ID | - |
| --repository-path | -rp | string | Optional | - | 작업시 사용할 Repository 경로 | - |
| --jobName | -name | string | Optional | - | 작업 이름 | - |
| --user | - | string | Optional | - | 사용자 ID 또는 메일 | - |
| --schedule | -sc | string | Optional | - | 작업에 사용할 Schedule (JSON 파일 경로 또는 JSON 문자열) | - |
| --description | -desc | string | Optional | - | 작업 설명 | - |
| --excludePartition | -exp | string | Optional | - | 작업 제외 partition | - |
| --mailEvent | - | string | Optional | - | 작업 이벤트 수신 메일 | - |
| --networkLimit | -nl | number | Optional | 0 | 작업 Network 제한 속도 (Mbps) | - |
| --start | - | boolean | Optional | - | 작업 자동시작 여부 | - |
| --scriptPath | -sp | string | Optional | - | 실행할 스크립트 파일 경로 (사전에 ZDM에 업로드 필요) | - |
| --scriptRun | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --overwrite | - | string | Optional | - | 파티션 오버라이트 허용 여부 (Linux 전용) | {% include zdm/overwrite-options.md cli=true %} |
| --afterReboot | - | string | Optional | reboot | 복구 완료 후 동작 | {% include zdm/after-reboot.md %} |
| --cloudAuth | - | string | Optional | - | 클라우드 인증정보 ID 또는 Name | - |
| --listOnly | - | boolean | Optional | - | jobList에 지정된 파티션만 작업 등록 | - |
| --jobList | - | string | Optional | - | 사용자 커스텀 작업 등록 (JSON 문자열 형태) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (--output text, 기본값):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Registration Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery registered successfully
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Registration Summary]
total      : 2
successful : 2
failed     : 0

[Common Information]
state             : registered
jobName           : recovery-ubuntu22-to-rhel8
autoStart         : use
platform          : aws
bootMode          : uefi
scriptPath        : /scripts/post-recovery.sh
scriptRunTiming   : after
schedule.basic    : type: once, description: One-time execution

[Partition Details]

[Partition 1]
partition         : /
jobMode           : full
overwrite         : allow
fileSystem        : ext4
backup.useLast    : true
backup.backupFile : backup-2025-01-01.img
backup.backupJob  : backup-ubuntu22
repository.id     : 1
repository.path   : /mnt/backup
repository.type   : nfs

[Partition 2]
partition         : /boot
jobMode           : full
overwrite         : allow
fileSystem        : ext4
backup.useLast    : true
backup.backupFile : backup-boot-2025-01-01.img
backup.backupJob  : backup-ubuntu22
repository.id     : 1
repository.path   : /mnt/backup
repository.type   : nfs

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 (--output json):**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery registered successfully",
  "success": true,
  "data": {
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    },
    "common": {
      "state": "registered",
      "jobName": "recovery-ubuntu22-to-rhel8",
      "autoStart": "use",
      "platform": "aws",
      "bootMode": "uefi",
      "scriptPath": "/scripts/post-recovery.sh",
      "scriptRunTiming": "after",
      "schedule": {
        "basic": {
          "type": "once",
          "description": "One-time execution"
        }
      }
    },
    "partitions": [
      {
        "partition": "/",
        "jobMode": "full",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLast": "true",
          "backupFile": "backup-2025-01-01.img",
          "backupJob": "backup-ubuntu22"
        },
        "repository": {
          "id": "1",
          "path": "/mnt/backup",
          "type": "nfs"
        }
      },
      {
        "partition": "/boot",
        "jobMode": "full",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLast": "true",
          "backupFile": "backup-boot-2025-01-01.img",
          "backupJob": "backup-ubuntu22"
        },
        "repository": {
          "id": "1",
          "path": "/mnt/backup",
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
