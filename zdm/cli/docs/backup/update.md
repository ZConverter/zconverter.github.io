---
layout: docs
title: backup update
section_title: ZDM CLI Documentation
navigation: cli
---

Backup 작업 정보를 수정하는 명령어입니다.

---

## `backup update` {#backup-update}

> * 기존 Backup 작업의 설정을 변경합니다. 작업 ID 또는 작업 이름으로 대상을 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 작업 모드 변경
zdm-cli backup update --id 123 --mode full

# 작업 이름과 설명 변경
zdm-cli backup update --name "backup" --changeName "MyBackup" --description "새 설명"

# 압축 및 암호화 활성화
zdm-cli backup update --id 456 --compression --encryption

# 반복횟수 및 네트워크 제한 설정
zdm-cli backup update --name "OldJob" --rotation 5 --networkLimit 1000

# Repository 변경
zdm-cli backup update --id 123 --repository-id 2

# 스케줄 변경 (JSON 파일 사용)
zdm-cli backup update --id 123 --schedule "/path/to/schedule.json"

# 스케줄 변경 (JSON 문자열 직접 입력)
zdm-cli backup update --id 123 --schedule '{"type":"daily","time":"02:00"}'

# 스크립트 설정 변경
zdm-cli backup update --id 123 --scriptPath "/scripts/new_script.sh" --scriptRun after

# 제외 폴더 변경
zdm-cli backup update --id 123 --excludeDir "/tmp,/var/cache"

# JSON 형식으로 출력
zdm-cli backup update --id 123 --mode increment --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| --status | - | string | Optional | - | 작업 상태 | - |
| --repository-id | -ri | number | Optional | - | Repository ID | - |
| --repository-path | -rp | string | Optional | - | Repository Path | - |
| --changeName | -chn | string | Optional | - | 변경할 작업 이름 | - |
| --schedule | -sc | string | Optional | - | 작업에 사용할 Schedule (JSON 파일 경로 또는 JSON 문자열) | - |
| --description | -desc | string | Optional | - | 작업 설명 | - |
| --rotation | -rot | number | Optional | 1 | 작업 반복횟수 | - |
| --compression | -comp | boolean | Optional | - | 작업 압축 | - |
| --encryption | -enc | boolean | Optional | - | 작업 암호화 | - |
| --excludeDir | -exd | string | Optional | - | 작업 제외 폴더 | - |
| --scriptPath | -sp | string | Optional | - | 작업시 사용할 script full path | - |
| --scriptRun | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --networkLimit | -nl | number | Optional | 0 | 작업 Network 제한 속도 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 최소 하나는 필수로 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Update Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Update Summary]
state : success

[Changed Fields]
[Change 1]
field : mode
value : increment -> full

[Change 2]
field : compression
value : false -> true

[Change 3]
field : networkLimit
value : 0 -> 1000

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
      "state": "success",
      "updatedFields": [
        {
          "field": "mode",
          "previous": "increment",
          "new": "full"
        },
        {
          "field": "compression",
          "previous": false,
          "new": true
        },
        {
          "field": "networkLimit",
          "previous": 0,
          "new": 1000
        }
      ]
    }
  },
  "timestamp": "2025-01-01 12:00:00"
}
```

</details>

---
