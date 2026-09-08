
OS Replication 목록 및 정보를 조회하는 명령어입니다.

---

## `os-replication list` {#os-replication-list}

> * OS Replication 작업의 목록 또는 특정 작업의 상세 정보를 조회합니다.
> * **v3.0.0 (BREAKING)** — `--server` 옵션이 제거되었습니다. OS Replication 작업 정보에는 서버 컬럼이 없어 이 옵션은 실제로는 Center 이름으로 거르는 필터였으므로, ID·이름을 모두 받는 `--center` 로 대체하세요. CLI 는 알 수 없는 옵션을 허용하지 않으므로 `--server` 를 그대로 둔 스크립트는 조용히 무시되지 않고 파싱 단계에서 즉시 실패합니다 (도움말이 출력되고 종료 코드 1).

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 OS Replication 목록 조회
zdm-cli os-replication list

# 작업 ID로 특정 작업 조회
zdm-cli os-replication list --id 1

# 타입으로 필터링
zdm-cli os-replication list --type upload

# 상태로 필터링
zdm-cli os-replication list --status running

# 상세 정보 포함 조회
zdm-cli os-replication list --id 1 --detail

# JSON 형식으로 출력
zdm-cli os-replication list --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | - | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --id | - | number | Optional | - | job ID (단건 조회) | - |
| --name | - | string | Optional | - | job name (단건 조회) | - |
| --type | - | string | Optional | - | 복제 타입 필터 | `upload`, `download` |
| --mode | - | string | Optional | - | 복제 모드 필터 | `full`, `increment` |
| --status | - | string | Optional | - | 작업 상태 필터 | {% include zdm/job-status.md %} |
| --detail | - | boolean | Optional | false | 상세 정보 포함 | - |
| --page | - | number | Optional | 1 | 페이지 번호 | - |
| --limit | - | number | Optional | 20 | 페이지당 항목 수 | - |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[OS Replication 1]
id              : 1
name            : upload-daily
system          : web01
replicationType : upload
status          : running
lastUpdated     : 2026-04-10 10:00:00

  [Upload Info]
  mode            : full
  folderName      : backup-folder
  networkLimit    : 0
  newly           : disabled

  [Schedule]
  type            : daily
  description     : Daily at 2AM
```

**JSON 형식**
```json
{
  "success": true,
  "data": [{
    "system": { "name": "web01" },
    "info": {
      "id": 1,
      "name": "upload-daily",
      "replicationType": "upload",
      "status": { "current": "running" },
      "lastUpdated": "2026-04-10 10:00:00"
    },
    "uploadInfo": { "mode": "full", "folderName": "backup-folder", "networkLimit": 0, "newly": "disabled" }
  }]
}
```

</details>

---
