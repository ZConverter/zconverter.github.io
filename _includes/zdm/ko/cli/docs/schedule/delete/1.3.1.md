
ZDM 서버에 등록된 Schedule을 삭제합니다.

---

## `schedule delete` {#schedule-delete}

> * Schedule ID를 지정하여 등록된 Schedule을 삭제하는 명령어입니다.
> * 삭제된 Schedule의 ID, 이름, 타입, 설명이 결과로 출력됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Schedule ID로 삭제
zdm-cli schedule delete --id 123

# JSON 형식으로 결과 출력
zdm-cli schedule delete --id 123 --output json

# 테이블 형식으로 결과 출력
zdm-cli schedule delete --id 123 --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Required | - | 삭제할 Schedule ID | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Delete Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Schedule has been successfully deleted
timestamp : 2026-04-13 16:15:52

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

id          : 28466
name        : Schedule-28466
type        : Minutely
description : [Basic] Start working at 12:00 every 5 Minute.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "0e57462f-cfc1-4223-927e-28be37ae9b6f",
  "message": "Schedule has been successfully deleted",
  "success": true,
  "data": {
    "id": 28466,
    "name": "Schedule-28466",
    "type": 1,
    "description": "[Basic] Start working at 12:00 every 5 Minute."
  },
  "timestamp": "2026-04-13 16:15:52"
}
```

</details>

---
