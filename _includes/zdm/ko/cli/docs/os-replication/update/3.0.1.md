
OS Replication 작업 설정을 변경하는 명령어입니다.

---

## `os-replication update` {#os-replication-update}

> * 기존 OS Replication 작업의 설정을 변경합니다.
> * `--schedule`, `--schedule-id`, `--schedule-file` 중 하나로 스케줄을 변경할 수 있습니다.

> **v2.0.2 신설**: schedule 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출. 이전엔 service 가 schedule 입력을 무시했으나 본 버전부터 정상 처리. basic schedule 만 지원 (smart 차단). jobMode `full` / `increment` 모두 허용 (sync 미지원). CLI 는 `formatChangeValue` 로 `Daily ([Basic] Start working at ...)` 한 줄 변환 표시.

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
zdm-cli os-replication update -c center01 --id 1 --status start

# 작업 중지
zdm-cli os-replication update -c center01 --name my-job --status stop

# 업로드 모드 변경
zdm-cli os-replication update -c center01 --id 1 --upload-mode increment

# 다운로드 네트워크 제한 설정
zdm-cli os-replication update -c center01 --id 1 --download-network-limit 500

# 스케줄 변경 (기존 스케줄 ID 재사용)
zdm-cli os-replication update -c center01 --id 1 --schedule-id 1234

# 스케줄 객체로 변경 (Daily 03:00 — basic only, smart 미지원)
zdm-cli os-replication update -c center01 --id 1 --schedule '{"type":3,"basic":{"time":"03:00"}}'

# 작업 이름 변경
zdm-cli os-replication update -c center01 --id 1 --cn new-job-name
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**센터 및 대상 지정**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | Center ID 또는 이름 | - |
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
| --upload-mode | - | string | Optional | - | 업로드 모드 | `full`, `increment` |
| --upload-folder-name | - | string | Optional | - | 업로드 폴더 이름 | - |
| --upload-newly | - | string | Optional | - | 신규 파일만 업로드 | `disabled`, `newly_only` |
| --upload-network-limit | - | number | Optional | - | 업로드 네트워크 제한 | - |
| --upload-file-filter | - | string | Optional | - | 업로드 파일 필터 | - |

**다운로드 설정**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --download-mode | - | string | Optional | - | 다운로드 모드 | `full`, `increment` |
| --download-network-limit | - | number | Optional | - | 다운로드 네트워크 제한 | - |

> **v2.0.2 변경 사항**: `--upload-mode` / `--download-mode` 의 모드 값이 `incremental` 에서 `increment` 로 변경되었습니다 (backup/recovery 와 통일). 이전 버전은 `incremental` 을 사용합니다.

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 (basic only) | - |
| --schedule-id | -sc-id | number | Optional | - | 기존 스케줄 ID (basic only) | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 (basic only) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> **v2.0.2 스케줄 정책**
> - basic schedule 만 지원 — smart 입력 시 `INVALID_SCHEDULE_JOB_MODE_FOR_BASIC` 응답
> - jobMode `full` / `increment` 모두 허용 (**sync 미지원** — replication 과 차이)
> - 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Replication Info]
id   : 1
name : upload-daily

[Updated Fields]
  upload-mode: full → increment
  status: stopped → start
  schedule: Daily ([Basic] Start working at 03:00 every day.) → Weekly ([Basic] Start working at 03:00 Monday, Wednesday every week.)
```

**Table 형식 (`--output table`)**

| field | previous | new |
|-------|----------|-----|
| upload-mode | full | increment |
| status | stopped | start |
| schedule | Daily (#5) | Weekly (#10) |

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "replicationInfo": { "id": 1, "name": "upload-daily" },
    "summary": {
      "updatedFields": [
        { "field": "upload-mode", "previous": "full", "new": "increment" },
        { "field": "status", "previous": "stopped", "new": "start" },
        {
          "field": "schedule",
          "previous": { "id": 5, "type": "Daily", "description": "[Basic] Start working at 03:00 every day." },
          "new": { "id": 10, "type": "Weekly", "description": "[Basic] Start working at 03:00 Monday, Wednesday every week." }
        }
      ]
    }
  }
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `replicationInfo.id` | number | 작업 ID |
| `replicationInfo.name` | string | 작업 이름 |
| `summary.updatedFields[].field` | string | 변경 필드명 |
| `summary.updatedFields[].previous` | string \| number \| object | 변경 전 값. `field` 가 `schedule` 인 경우 `{ id, type, description }` 객체 |
| `summary.updatedFields[].new` | string \| number \| object | 변경 후 값. `field` 가 `schedule` 인 경우 `{ id, type, description }` 객체 |

> **ScheduleChangeValue 구조** (`previous` / `new` 값, `field === "schedule"` 일 때):
> - `id` (number) — schedule ID
> - `type` (string) — displayMappings PascalCase 영문 (`Once`, `Daily`, `Weekly`, `Monthly (Specific Week and Day of the Week)`, `Monthly on Specific Date`, `Unknown`)
> - `description` (string) — `processScheduleInfo` 영문 (예: `[Basic] Start working at 03:00 every day.`)
>
> CLI text 모드에서는 `formatChangeValue` 가 `Daily ([Basic] Start working at 03:00 every day.)` 한 줄로 변환합니다. table 모드는 `Daily (#5)` 형식으로 표시합니다.

</details>

---
