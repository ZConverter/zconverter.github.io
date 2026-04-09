
Replication 실행 히스토리를 조회하는 명령어입니다.

---

## `replication history` {#replication-history}

> * Replication 작업의 실행 이력을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication history [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Replication 히스토리 조회
zdm-cli replication history

# 작업 이름으로 필터링
zdm-cli replication history --job-name repl01

# 서버 및 결과로 필터링
zdm-cli replication history --server web01 --result success

# 오름차순 정렬
zdm-cli replication history --asc

# JSON 형식으로 출력
zdm-cli replication history --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --job-id | - | number | Optional | - | 작업 ID로 필터링 | - |
| --job-name | - | string | Optional | - | 작업 이름으로 필터링 | - |
| --server | - | string | Optional | - | 서버 이름으로 필터링 | - |
| --result | - | string | Optional | - | 결과 상태로 필터링 | success, failed |
| --asc | - | boolean | Optional | false | 오름차순 정렬 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication History Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Replication History 1]
id                   : 456
system.name          : web01
job.name             : repl_job_01
job.id               : 123
job.unitType         : backup
job.replicationMode  : full
job.sourcePath       : /data/source
job.targetPath       : /replication/target
result.status        : success
result.description   : Replication completed successfully
size.total           : 1073741824
size.replicated      : 1073741824
count.total          : 150
count.replicated     : 150
time.start           : 2025-01-15T10:00:00Z
time.end             : 2025-01-15T10:15:00Z
time.elapsed         : 00:15:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
