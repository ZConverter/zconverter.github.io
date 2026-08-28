
Replication 작업을 모니터링하는 명령어입니다.

---

## `replication monit` {#replication-monit}

> * Replication 작업의 실시간 진행 상태를 모니터링합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication monit [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli replication monit --ji 123

# 작업 이름으로 모니터링
zdm-cli replication monit --jn repl01

# 특정 Center의 작업 모니터링 (콤마 구분)
zdm-cli replication monit --center 9,10 --ji 123

# 서버 필터 추가
zdm-cli replication monit --ji 123 --server web01

# 상태 필터 추가
zdm-cli replication monit --jn repl01 --status run

# JSON 형식으로 출력
zdm-cli replication monit --ji 123 --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | - | string | Optional | - | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --job-id | --ji | number | Required* | - | 작업 ID | - |
| --job-name | --jn | string | Required* | - | 작업 이름 | - |
| --server | - | string | Optional | - | 대상 서버 이름 | - |
| --status | - | string | Optional | - | 상태 필터 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> \* `--job-id` 또는 `--job-name` 중 하나는 반드시 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Monit Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[System Information]
name : web01

[Job Information]
name    : repl_job_01
id      : 123
status  : run
step    : transferring
percent : 45%
message : Replicating data...
start   : 2025-01-15T10:00:00Z
elapsed : 00:05:00
end     : -

[Job Logs]
1: [2025-01-15 10:00:00] Replication started
2: [2025-01-15 10:02:30] Transferring data...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
