{% include zdm/base-path.html %}

OS Replication 작업을 등록하는 명령어입니다.

---

## `os-replication regist` {#os-replication-regist}

> * OS Replication 작업을 신규 등록합니다.
> * Cloud Auth Key, ZOS Repository, Repository가 사전에 등록되어 있어야 합니다.
> * `--schedule`, `--schedule-id`, `--schedule-file` 중 하나로 스케줄을 설정할 수 있습니다.

> **v2.0.2 신설**: 이전엔 os-replication 의 schedule 처리가 미구현이었으나 본 버전부터 schedule 입력 시 처리 + 응답에 `schedule: { id, type, description }` 객체 노출. basic schedule 만 지원합니다. jobMode `full` / `increment` 모두 허용합니다 (sync 미지원).

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Upload 타입 Replication 등록
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full

# Download 타입 Replication 등록 (자동 시작)
zdm-cli os-replication regist --rt download --ck 1 --zri 1 --ri 1 --mode full --start

# 폴더 이름 및 네트워크 제한 설정
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --fn my-folder --nl 1000

# 스케줄 설정과 함께 등록 (기존 스케줄 ID 재사용)
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --schedule-id 1234

# 스케줄 JSON 으로 신규 등록 (Daily 02:00, basic 자동 래핑)
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --schedule '{"type":3,"time":"02:00"}'

# 신규 파일만 업로드 설정
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --upload-newly newly_only
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**필수**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --replication-type | -rt | string | Required | - | 복제 타입 | `upload`, `download` |
| --cloud-key-id | -ck | number | Required | - | 클라우드 인증 키 ID | - |
| --zos-repository-id | -zri | number | Required | - | ZOS Repository ID | - |
| --repository-id | -ri | number | Required | - | Repository ID | - |
| --mode | - | string | Required | - | 복제 모드 | `full`, `increment` |

> **v2.0.2 변경 사항**: 모드 값이 `incremental` 에서 `increment` 로 변경되었습니다 (backup/recovery 와 통일). 이전 버전은 `incremental` 을 사용합니다.

**선택**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | Center ID or name | - |
| --job-name | -jn | string | Optional | - | 작업 이름 | - |
| --repository-path | -rp | string | Optional | - | Repository 경로 | - |
| --folder-name | -fn | string | Optional | - | 폴더 이름 | - |
| --network-limit | -nl | number | Optional | 0 | 네트워크 속도 제한 (0: 무제한) | - |
| --file-filter | -ff | string | Optional | - | 파일 필터 패턴 | - |
| --start | - | boolean | Optional | - | 자동 시작 | - |

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 (`basic` 키 없으면 자동 래핑) | - |
| --schedule-id | -sc-id | number | Optional | - | 기존 스케줄 ID (복사하지 않고 그대로 참조). 작업과 같은 center 의 스케줄이어야 하고 기본 유형(type 0~6)만 받습니다 | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 (`basic` 키 없으면 자동 래핑) | - |

> 이 작업은 Basic 스케줄(type 0~6)만 받습니다. Smart(type 7~11)를 지정하면 `JOB-ERROR-103` 로 거부됩니다. jobMode `full` / `increment` 모두 허용합니다 (**sync 미지원** — replication 과 차이). 응답에는 `schedule: { id, type, description }` 객체가 포함됩니다. 자동 래핑과 JSON 형식은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참고하세요.

**업로드/다운로드 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --upload-newly | - | string | Optional | disabled | 신규 파일만 업로드 (upload 타입) | `disabled`, `newly_only` |
| --download-type | - | string | Optional | all | 다운로드 타입 (download 타입) | `all`, `folder` |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Registration Summary]
total      : 1
successful : 1
failed     : 0

[Job 1]
state           : success
jobName         : daily-osrepl
unitType        : upload
replicationMode : increment
autoStart       : use

[Schedule]
id          : 7
type        : Daily
description : [Basic] Start working at 03:00 every day.
```

> schedule 미지정 시 `[Schedule]` 블록은 출력되지 않습니다.

**Table 형식 (`--output table`)**

| state | jobName | unitType | replicationMode | autoStart | schedule |
|-------|---------|----------|-----------------|-----------|----------|
| success | daily-osrepl | upload | increment | use | Daily (#7) |

> schedule 미지정 시 `schedule` 컬럼은 비어 있습니다.

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "results": [{
      "state": "success",
      "jobName": "daily-osrepl",
      "unitType": "upload",
      "replicationMode": "increment",
      "autoStart": "use",
      "schedule": {
        "id": 7,
        "type": "Daily",
        "description": "[Basic] Start working at 03:00 every day."
      }
    }],
    "summary": { "total": 1, "successful": 1, "failed": 0 }
  }
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `results[].state` | string | 처리 결과 (`success` / `failed`) |
| `results[].jobName` | string | 등록된 작업 이름 |
| `results[].unitType` | string | 복제 방식 (`upload` / `download`) |
| `results[].replicationMode` | string | 복제 모드 (`full` / `increment`) |
| `results[].autoStart` | string | 자동 시작 여부 (`use` / `not use`) |
| `results[].schedule` | object | (Optional) 등록된 스케줄 정보. 미지정 시 응답에 포함되지 않음 |
| `results[].schedule.id` | number | 등록된 schedule ID |
| `results[].schedule.type` | string | 영문 타입 이름 (예: `Once`, `Daily`, `Weekly`. 전체 이름은 [스케줄 개요]({{ base_path }}/docs/schedule/overview) 참고). 조회 실패 시 `Unknown` |
| `results[].schedule.description` | string | 영문 설명 (예: `[Basic] Start working at 03:00 every day.`). 조회 실패 시 `Schedule lookup failed` |
| `summary.total` | number | 요청 건수 |
| `summary.successful` | number | 성공 건수 |
| `summary.failed` | number | 실패 건수 |

</details>

---
