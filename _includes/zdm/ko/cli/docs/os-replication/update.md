
OS Replication 작업 설정을 변경하는 명령어입니다.

---

## `os-replication update` {#os-replication-update}

> * 기존 OS Replication 작업의 설정을 변경합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 시작
zdm-cli os-replication update --id 1 --status start

# 작업 중지
zdm-cli os-replication update --name my-job --status stop

# 업로드 모드 변경
zdm-cli os-replication update --id 1 --upload-mode incremental

# 다운로드 네트워크 제한 설정
zdm-cli os-replication update --id 1 --download-network-limit 500

# 스케줄 변경
zdm-cli os-replication update --id 1 --schedule-id 1234

# 작업 이름 변경
zdm-cli os-replication update --id 1 --cn new-job-name
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**대상 지정 (하나 필수)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |

> <span class="required-note">*</span> --id 또는 --name 중 최소 하나는 필수로 입력해야 합니다.

**공통**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --change-name | -cn | string | Optional | - | 변경할 작업 이름 | - |
| --status | - | string | Optional | - | 작업 상태 | `start`, `stop` |

**업로드 설정**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --upload-mode | - | string | Optional | - | 업로드 모드 | `full`, `incremental` |
| --upload-folder-name | - | string | Optional | - | 업로드 폴더 이름 | - |
| --upload-newly | - | string | Optional | - | 신규 파일만 업로드 | `disabled`, `newly_only` |
| --upload-network-limit | - | number | Optional | - | 업로드 네트워크 제한 | - |
| --upload-file-filter | - | string | Optional | - | 업로드 파일 필터 | - |

**다운로드 설정**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --download-mode | - | string | Optional | - | 다운로드 모드 | `full`, `incremental` |
| --download-network-limit | - | number | Optional | - | 다운로드 네트워크 제한 | - |

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 | - |
| --schedule-id | -sc-id | number | Optional | - | 기존 스케줄 ID | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Replication Info]
id   : 1
name : upload-daily

[Updated Fields]
  upload-mode: full → incremental
  status: stopped → start
```

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "replicationInfo": { "id": 1, "name": "upload-daily" },
    "summary": {
      "updatedFields": [
        { "field": "upload-mode", "previous": "full", "new": "incremental" },
        { "field": "status", "previous": "stopped", "new": "start" }
      ]
    }
  }
}
```

</details>

---
