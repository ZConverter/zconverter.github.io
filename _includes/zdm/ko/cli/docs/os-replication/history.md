
OS Replication 실행 이력을 조회하는 명령어입니다.

---

## `os-replication history` {#os-replication-history}

> * OS Replication 작업의 실행 이력을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication history [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 실행 이력 조회
zdm-cli os-replication history

# 이력 ID로 단건 조회
zdm-cli os-replication history --id 1

# 작업 ID로 필터링
zdm-cli os-replication history --ji 123

# 결과로 필터링
zdm-cli os-replication history --result success

# JSON 형식으로 출력
zdm-cli os-replication history --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional | - | 이력 ID (단건 조회) | - |
| --job-id | -ji | number | Optional | - | 작업 ID 필터 | - |
| --job-name | -jn | string | Optional | - | 작업 이름 필터 | - |
| --server | - | string | Optional | - | 서버 필터 | - |
| --result | - | string | Optional | - | 결과 필터 | `success`, `failed` |
| --page | - | number | Optional | 1 | 페이지 번호 | - |
| --limit | - | number | Optional | 20 | 페이지당 항목 수 | - |
| --asc | - | boolean | Optional | - | 오름차순 정렬 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[History 1]
id          : 101
system      : web01
jobName     : upload-daily
jobId       : 1
unitType    : upload
mode        : full
result      : success
description : Upload completed successfully
start       : 2026-04-10 02:00:00
end         : 2026-04-10 02:15:30
elapsed     : 00:15:30
```

</details>

---
