---
layout: docs
title: recovery regist
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
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
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --job-name "my-recovery-job"

# 오버라이트 허용 설정 (Linux 전용)
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "baremetal" --mode "full" --repository-id 1 --overwrite

# 스크립트 실행 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "vmware" --mode "full" --repository-id 1 --script-path "/tmp/test.sh" --script-run after

# 복구 완료 후 재부팅 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --after-reboot reboot

# 자동 시작 활성화
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --start

# 네트워크 제한 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --network-limit 1000

# 스케줄 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --schedule "schedule.json"

# 메일 알림 설정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --mail-event "admin@example.com"

# 클라우드 인증 정보 사용
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --cloud-auth "aws-credentials"

# 커스텀 작업 리스트 사용 (JSON 형식)
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --job-list '[{"sourcePartition":"/","targetPartition":"/","overwrite":true,"mode":"full","repository":{"id":1}}]'

# 특정 파티션만 작업 등록
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" --repository-id 1 --job-list '[{"sourcePartition":"/boot","targetPartition":"/boot"}]' --list-only
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | 작업 등록 Center | - |
| --source | - | string | Required | - | 작업 대상 Source 서버 | - |
| --target | - | string | Required | - | 작업 대상 Target 서버 | - |
| --platform | - | string | Required | - | Target 서버 플랫폼 | {% include zdm/platforms.md baremetal=true inline=true %} |
| --mode | - | string | Required | - | 작업 모드 | {% include zdm/job-modes.md recovery=true %} |
| --repository-id | -ri | number | Optional | config 설정값 | 작업시 사용할 Repository ID | - |
| --repository-type | -rt | string | Optional | - | 작업시 사용할 Repository 타입 | - |
| --repository-path | -rp | string | Optional | - | 작업시 사용할 Repository 경로 | - |
| --job-name | -jn | string | Optional | - | 작업 이름 | - |
| --user | -u | string | Optional | - | 사용자 ID 또는 메일 | - |
| --schedule | -sc | string | Optional | - | 작업에 사용할 Schedule (JSON 파일 경로 또는 JSON 문자열) | - |
| --exclude-partition | -exp | string | Optional | - | 작업 제외 partition | - |
| --mail-event | -me | string | Optional | - | 작업 이벤트 수신 메일 | - |
| --network-limit | -nl | number | Optional | 0 | 작업 Network 제한 속도 (Mbps) | - |
| --start | - | boolean | Optional | - | 작업 자동시작 여부 | - |
| --script-path | -sp | string | Optional | - | 실행할 스크립트 파일 경로 (사전에 ZDM에 업로드 필요) | - |
| --script-run | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --overwrite | - | boolean | Optional | false | 파티션 오버라이트 허용 여부 (Linux 전용) | - |
| --after-reboot | -ar | string | Optional | reboot | 복구 완료 후 동작 | {% include zdm/after-reboot.md %} |
| --cloud-auth | -ca | string | Optional | - | 클라우드 인증정보 ID 또는 Name | - |
| --list-only | -lo | boolean | Optional | - | jobList에 지정된 파티션만 작업 등록 | - |
| --job-list | -jl | string | Optional | - | 사용자 커스텀 작업 등록 (JSON 문자열 형태) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>jobList JSON 형식</strong></summary>

`--job-list` 옵션은 파티션별 세부 설정을 JSON 배열 형식으로 지정합니다.

**구조:**

```json
[
  {
    "sourcePartition": "/",
    "targetPartition": "/",
    "overwrite": true,
    "mode": "full",
    "backupFile": "backup-2025-01-01.img",
    "repository": {
      "id": 1,
      "path": "/mnt/backup"
    }
  }
]
```

**필드 설명:**

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| sourcePartition | string | Required | 작업 대상 Source 파티션 | - |
| targetPartition | string | Required | 작업 대상 Target 파티션 | - |
| overwrite | boolean | Optional | 파티션 오버라이트 허용 여부 (미지정시 공용값 사용) | `true`, `false` |
| mode | string | Optional | 작업 모드 (미지정시 공용값 사용) | {% include zdm/job-modes.md recovery=true %} |
| backupFile | string | Optional | 복구에 사용할 백업 파일 (미지정시 최신 백업 사용) | - |
| repository | object | Optional | 작업시 사용할 Repository (미지정시 공용값 사용) | - |
| repository.id | number | Optional | Repository ID | - |
| repository.path | string | Optional | Repository 경로 | - |

**사용 예시:**

```bash
# 단일 파티션 지정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" \
  --job-list '[{"sourcePartition":"/","targetPartition":"/"}]'

# 복수 파티션 지정 (각 파티션별 설정)
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" \
  --job-list '[{"sourcePartition":"/","targetPartition":"/","overwrite":true},{"sourcePartition":"/boot","targetPartition":"/boot","mode":"full"}]'

# 특정 백업 파일 지정
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" \
  --job-list '[{"sourcePartition":"/","targetPartition":"/","backupFile":"backup-2025-01-01.img"}]'

# 파티션별 다른 Repository 사용
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" \
  --job-list '[{"sourcePartition":"/","targetPartition":"/","repository":{"id":1}},{"sourcePartition":"/data","targetPartition":"/data","repository":{"id":2}}]'

# listOnly와 함께 사용 (지정된 파티션만 작업 등록)
zdm-cli recovery regist --source "ubuntu22" --target "rhel8" --platform "aws" --mode "full" \
  --job-list '[{"sourcePartition":"/boot","targetPartition":"/boot"}]' --list-only
```

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
sourcePartition   : /
targetPartition   : /dev/sda1
jobMode           : full
overwrite         : true
fileSystem        : ext4
backup.useLast    : true
backup.backupFile : backup-2025-01-01.img
backup.backupJob  : backup-ubuntu22
repository.id     : 1
repository.path   : /mnt/backup
repository.type   : nfs

[Partition 2]
sourcePartition   : /boot
targetPartition   : /dev/sda2
jobMode           : full
overwrite         : true
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
        "sourcePartition": "/",
        "targetPartition": "/dev/sda1",
        "jobMode": "full",
        "overwrite": true,
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
        "sourcePartition": "/boot",
        "targetPartition": "/dev/sda2",
        "jobMode": "full",
        "overwrite": true,
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

## 참조

<details markdown="1">
<summary><strong>플랫폼 목록</strong></summary>

{% include zdm/platforms.md baremetal=true desc=true %}

</details>

<details markdown="1">
<summary><strong>작업 모드</strong></summary>

{% include zdm/job-modes.md recovery=true desc=true %}

</details>

<details markdown="1">
<summary><strong>오버라이트 옵션</strong></summary>

{% include zdm/overwrite-options.md cli=true desc=true %}

</details>

<details markdown="1">
<summary><strong>복구 완료 후 동작</strong></summary>

{% include zdm/after-reboot.md desc=true %}

</details>

<details markdown="1">
<summary><strong>스크립트 실행 타이밍</strong></summary>

{% include zdm/script-timing.md desc=true %}

</details>

<details markdown="1">
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
