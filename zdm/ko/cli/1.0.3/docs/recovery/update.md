---
layout: docs
title: recovery update
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

기존 Recovery 작업 정보를 수정합니다.

---

## `recovery update` {#recovery-update}

> * 등록된 Recovery 작업의 설정을 변경합니다.
> * 작업 이름, 플랫폼, 스케줄, 스크립트 설정 등을 수정할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 작업 모드 변경
zdm-cli recovery update --id 123 --mode full

# 작업 이름으로 검색하여 이름 변경
zdm-cli recovery update --name "old-recovery" --change-name "new-recovery"

# 플랫폼 변경
zdm-cli recovery update --id 123 --platform aws

# 복구 완료 후 동작 변경
zdm-cli recovery update --id 123 --after-reboot reboot

# 네트워크 제한 설정
zdm-cli recovery update --id 123 --network-limit 1000

# 스크립트 설정 변경
zdm-cli recovery update --name "my-recovery" --script-path "/path/to/script.sh" --script-run before

# 스케줄 변경 (JSON 파일 사용)
zdm-cli recovery update --id 123 --schedule "schedule.json"

# 스케줄 변경 (JSON 문자열 사용)
zdm-cli recovery update --id 123 --schedule '{"type":"daily","time":"02:00"}'

# 메일 알림 수신자 변경
zdm-cli recovery update --id 123 --mail-event "admin@example.com"

# 작업 상태 변경
zdm-cli recovery update --id 123 --status stop

# 특정 파티션의 모드 변경
zdm-cli recovery update --id 123 --partition "/" --mode inc

# 복합 설정 변경
zdm-cli recovery update --id 123 --change-name "MyRecovery" --platform aws --after-reboot reboot --network-limit 500
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --change-name | -cn | string | Optional | - | 변경할 작업 이름 | - |
| --platform | -pf | string | Optional | - | 변경할 플랫폼 | {% include zdm/platforms.md inline=true baremetal=true %} |
| --schedule | -sc | string | Optional | - | 작업에 사용할 Schedule (JSON 파일 경로 또는 JSON 문자열) | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md %} |
| --after-reboot | -ar | string | Optional | - | 작업 완료 후 부팅 모드 | {% include zdm/after-reboot.md %} |
| --mail-event | -me | string | Optional | - | 작업 이벤트 수신 메일 | - |
| --network-limit | -nl | number | Optional | 0 | 작업 Network 제한 속도 (Mbps) | - |
| --script-path | -sp | string | Optional | - | 작업 스크립트 경로 | - |
| --script-run | -sr | string | Optional | - | 작업 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --status | - | string | Optional | - | 작업 상태 | {% include zdm/job-status-update.md %} |
| --partition | -pt | string | Optional | - | 변경할 작업 대상 파티션 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (--output text, 기본값):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Update Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery updated successfully
timestamp : 2025-01-01 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Job Information]
id                : 123
name              : new-recovery-name

[Update Summary]
state             : updated

[Common Fields Changed]
[Change 1]
field             : name
value             : old-recovery-name -> new-recovery-name

[Change 2]
field             : platform
value             : vmware -> aws

[Change 3]
field             : afterReboot
value             : shutdown -> reboot

[Partition-specific Changes]
[Partition 1]
partition         : /
field             : mode
value             : full -> inc

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 (--output json):**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery updated successfully",
  "success": true,
  "data": {
    "jobInfo": {
      "id": "123",
      "name": "new-recovery-name"
    },
    "summary": {
      "state": "updated",
      "commonUpdatedFields": [
        {
          "field": "name",
          "previous": "old-recovery-name",
          "new": "new-recovery-name"
        },
        {
          "field": "platform",
          "previous": "vmware",
          "new": "aws"
        },
        {
          "field": "afterReboot",
          "previous": "shutdown",
          "new": "reboot"
        }
      ],
      "eachUpdatedFields": [
        {
          "partition": "/",
          "summary": {
            "commonUpdatedFields": [
              {
                "field": "mode",
                "previous": "full",
                "new": "inc"
              }
            ]
          }
        }
      ]
    }
  },
  "timestamp": "2025-01-01 10:30:00"
}
```

</details>

---
