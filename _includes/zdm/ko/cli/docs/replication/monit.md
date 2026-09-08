
Replication 작업을 모니터링하는 명령어입니다.

---

## `replication monit` {#replication-monit}

> * Replication 작업의 실시간 진행 상태를 모니터링합니다.
> * **v3.0.0 (BREAKING)** — `--server` 옵션이 제거되었습니다. Replication 작업 정보에는 서버 컬럼이 없어 이 옵션은 실제로는 Center 이름으로 거르는 필터였으므로, ID·이름을 모두 받는 `--center` 로 대체하세요. CLI 는 알 수 없는 옵션을 허용하지 않으므로 `--server` 를 그대로 둔 스크립트는 조용히 무시되지 않고 파싱 단계에서 즉시 실패합니다 (도움말이 출력되고 종료 코드 1).
> * **v3.0.0 (BREAKING)** — `--status` 옵션이 제거되었습니다. `replication monit` 은 경로 식별자로 작업 하나를 지목하는 단건 조회라 이 옵션은 목록을 거르는 필터가 아니라 조회한 작업의 상태 조건이었고, 어긋나면 결과가 비는 대신 404 였습니다. 조회한 작업의 상태는 응답의 `job.progress.status` 를 읽으세요. CLI 는 알 수 없는 옵션을 허용하지 않으므로 `--status` 를 그대로 둔 스크립트는 조용히 무시되지 않고 파싱 단계에서 즉시 실패합니다 (도움말이 출력되고 종료 코드 1).

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

# Center 이름으로 범위 지정
zdm-cli replication monit --center center01 --ji 123

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
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> \* `--job-id` 또는 `--job-name` 중 하나는 반드시 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
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
