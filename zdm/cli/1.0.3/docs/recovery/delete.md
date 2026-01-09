---
layout: docs
title: recovery delete
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

Recovery 작업을 삭제합니다.

---

## `recovery delete` {#recovery-delete}

> * 등록된 Recovery 작업을 삭제합니다.
> * 작업 ID 또는 작업 이름을 통해 삭제할 작업을 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 Recovery 작업 삭제
zdm-cli recovery delete --id 123

# 이름으로 Recovery 작업 삭제
zdm-cli recovery delete --name "my-recovery-job"

# JSON 형식으로 결과 출력
zdm-cli recovery delete --id 123 --output json

# 테이블 형식으로 결과 출력
zdm-cli recovery delete --name "my-recovery" --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 하나만 필수로 입력해야 합니다. 두 옵션을 동시에 사용할 수 없습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (--output text, 기본값):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Delete Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery deleted successfully
timestamp : 2025-01-01 11:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Delete Summary]
state                 : deleted
basicInfoDeleted      : true
additionalInfoDeleted : true
detailInfoDeleted     : true
historyDataDeleted    : true
logDataDeleted        : true

[Job Details]
name                  : recovery-ubuntu22
partition             : /
basicInfo deleted     : Yes
additionalInfo deleted: Yes
detailInfo deleted    : Yes
historyData deleted   : Yes
logData deleted       : Yes
name                  : recovery-ubuntu22
partition             : /boot
basicInfo deleted     : Yes
additionalInfo deleted: Yes
detailInfo deleted    : Yes
historyData deleted   : Yes
logData deleted       : Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 (--output json):**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Recovery deleted successfully",
  "success": true,
  "data": {
    "summary": {
      "state": "deleted",
      "affectedComponents": {
        "basicInfoDeleted": true,
        "additionalInfoDeleted": true,
        "detailInfoDeleted": true,
        "historyDataDeleted": true,
        "logDataDeleted": true
      }
    },
    "jobInfo": [
      {
        "name": "recovery-ubuntu22",
        "partition": "/",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        }
      },
      {
        "name": "recovery-ubuntu22",
        "partition": "/boot",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        }
      }
    ]
  },
  "timestamp": "2025-01-01 11:00:00"
}
```

</details>

---

## 참조

<details markdown="1">
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
