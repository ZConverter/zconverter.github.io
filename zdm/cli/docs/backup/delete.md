---
layout: docs
title: backup delete
section_title: ZDM CLI Documentation
navigation: cli
---

Backup 작업 정보를 삭제하는 명령어입니다.

---

## `backup delete` {#backup-delete}

> * Backup 작업의 목록(정보)을 삭제합니다. 
> * 작업 ID 또는 작업 이름으로 대상을 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 삭제
zdm-cli backup delete --id 123

# 작업 이름으로 삭제
zdm-cli backup delete --name "MyBackup"

# JSON 형식으로 결과 출력
zdm-cli backup delete --id 123 --output json

# Table 형식으로 결과 출력
zdm-cli backup delete --name "OldBackup" --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --output | -o | string | Optional | text | 출력 형식 | text, json, table |

> <span class="required-note">*</span> --id 또는 --name 중 하나만 필수로 입력해야 합니다. 두 옵션을 동시에 사용할 수 없습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Delete Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-01 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

=== Delete Summary ===
state              : success
basicInfoDeleted   : true
detailInfoDeleted  : true
historyDataDeleted : true
logDataDeleted     : true

=== Job Details ===
name               : backup_job_01
partition          : /
basicInfo deleted  : Yes
detailInfo deleted : Yes
historyData deleted: Yes
logData deleted    : Yes
name               : backup_job_02
partition          : /home
basicInfo deleted  : Yes
detailInfo deleted : Yes
historyData deleted: Yes
logData deleted    : Yes

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
      "affectedComponents": {
        "basicInfoDeleted": true,
        "detailInfoDeleted": true,
        "historyDataDeleted": true,
        "logDataDeleted": true
      }
    },
    "jobInfo": [
      {
        "name": "backup_job_01",
        "partition": "/",
        "deletedComponents": {
          "basicInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        },
        "errorMessage": null
      },
      {
        "name": "backup_job_02",
        "partition": "/home",
        "deletedComponents": {
          "basicInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        },
        "errorMessage": null
      }
    ]
  },
  "timestamp": "2025-01-01 12:00:00"
}
```

</details>

---
