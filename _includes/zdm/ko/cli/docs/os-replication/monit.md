
OS Replication 작업 실행 상태를 모니터링하는 명령어입니다.

---

## `os-replication monit` {#os-replication-monit}

> * 현재 실행 중인 OS Replication 작업의 진행 상태를 확인합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication monit [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli os-replication monit --ji 1

# 작업 이름으로 모니터링
zdm-cli os-replication monit --jn my-job

# JSON 형식으로 출력
zdm-cli os-replication monit --ji 1 --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --job-id | -ji | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --job-name | -jn | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --job-id 또는 --job-name 중 하나는 필수로 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[System]
name : web01

[Job Info]
id   : 1
name : upload-daily

[Progress]
status  : Processing
step    : Uploading files
percent : 45
message : Uploading backup-2026-04-10.tar.gz

[Time]
start   : 2026-04-10 02:00:00
end     : -
elapsed : 00:05:23

[Log]
  [2026-04-10 02:00:00] Upload started
  [2026-04-10 02:03:15] Processing file: backup-2026-04-10.tar.gz
```

</details>

---
