
Replication 작업을 삭제하는 명령어입니다.

---

## `replication delete` {#replication-delete}

> * Replication 작업을 삭제합니다.
> * `--center` 파라미터가 필수이며, 작업 ID 또는 이름으로 삭제 대상을 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli replication delete -c srcconm --id 123

# 이름으로 삭제
zdm-cli replication delete -c 9 --name repl01

# JSON 형식으로 출력
zdm-cli replication delete -c srcconm --id 123 --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | Center ID 또는 이름 | - |
| --name | - | string | Required* | - | 삭제할 작업 이름 | - |
| --id | - | number | Required* | - | 삭제할 작업 ID | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> \* `--name` 또는 `--id` 중 하나는 반드시 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Delete Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Replication deleted successfully
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

=== Delete Result ===
deletedJob.id           : 123
deletedJob.name         : repl01
replicationInfo deleted : true
history deleted         : true
logEvent deleted        : true

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
