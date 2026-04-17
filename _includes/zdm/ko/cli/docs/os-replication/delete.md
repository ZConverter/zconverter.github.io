
OS Replication 작업을 삭제하는 명령어입니다.

---

## `os-replication delete` {#os-replication-delete}

> * OS Replication 작업과 관련 데이터(이력, 로그)를 삭제합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli os-replication delete -c center01 --id 1

# 이름으로 삭제
zdm-cli os-replication delete -c center01 --name my-job
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | Center ID 또는 이름 | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 정확히 하나를 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Deleted Job]
id   : 1
name : upload-daily

[Deleted Relations]
replicationInfo : 1
history         : 5
logEvent        : 12
```

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "deletedJob": { "id": 1, "name": "upload-daily" },
    "deletedRelations": { "replicationInfo": 1, "history": 5, "logEvent": 12 }
  }
}
```

</details>

---
