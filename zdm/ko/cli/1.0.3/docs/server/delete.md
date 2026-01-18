---
layout: docs
title: server delete
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

Server를 삭제합니다.

---

## `server delete` {#server-delete}

> * 등록된 Server를 삭제합니다.
> * Server ID 또는 Server 이름을 통해 삭제할 Server를 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli server delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 Server 삭제
zdm-cli server delete --id 123

# 이름으로 Server 삭제
zdm-cli server delete --name "my-server"

# JSON 형식으로 결과 출력
zdm-cli server delete --id 123 --output json

# 테이블 형식으로 결과 출력
zdm-cli server delete --name "my-server" --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --name | - | string | Optional<span class="required-note">*</span> | - | 삭제할 Server 이름 | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 삭제할 Server ID | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 하나만 필수로 입력해야 합니다. 두 옵션을 동시에 사용할 수 없습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (--output text, 기본값):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Server Delete Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Server deleted successfully
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Deleted Server]
id        : 123
name      : my-server

[Summary]
state     : deleted
message   : Server has been successfully deleted

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 (--output json):**

```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Server deleted successfully",
  "success": true,
  "data": {
    "deletedServer": {
      "id": 123,
      "name": "my-server"
    },
    "summary": {
      "state": "deleted",
      "message": "Server has been successfully deleted"
    }
  },
  "timestamp": "2025-01-06 10:30:00"
}
```

**Table 형식 (--output table):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Server Delete Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: table]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Server deleted successfully
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Deleted Server]
┌─────────┬─────┬───────────┬─────────┬─────────────────────────────────────┐
│ (index) │ id  │ name      │ state   │ message                             │
├─────────┼─────┼───────────┼─────────┼─────────────────────────────────────┤
│ 0       │ 123 │ my-server │ deleted │ Server has been successfully deleted│
└─────────┴─────┴───────────┴─────────┴─────────────────────────────────────┘
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---

## 참조

<details markdown="1">
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
