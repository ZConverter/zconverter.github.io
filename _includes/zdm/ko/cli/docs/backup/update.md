
Backup 작업 정보를 수정하는 명령어입니다.

---

## `backup update` {#backup-update}

> * 기존 Backup 작업의 설정을 변경합니다. 작업 ID 또는 작업 이름으로 대상을 지정합니다.
> * `--schedule` 또는 `--schedule-file` 사용 시 JSON에 `basic` 키가 없으면 `type`을 제외한 필드가 자동으로 `basic`으로 래핑됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 작업 모드 변경
zdm-cli backup update --id 123 --mode full

# Center 지정하여 작업 모드 변경
zdm-cli backup update --id 123 --mode full --center 9

# 작업 이름 변경
zdm-cli backup update --name "backup" --change-name "MyBackup"

# 압축 및 암호화 설정
zdm-cli backup update --id 456 --compression "use" --encryption "use"

# 반복횟수 및 네트워크 제한 설정
zdm-cli backup update --name "OldJob" --rotation 5 --network-limit 1000

# Repository 변경
zdm-cli backup update --id 123 --repository-id 2

# 스케줄 변경 (기존 스케줄 ID 사용)
zdm-cli backup update --id 123 --schedule-id 1234

# 스케줄 변경 (JSON 파일 사용)
zdm-cli backup update --id 123 --schedule-file "/path/to/schedule.json"

# 스케줄 변경 (JSON 문자열 직접 입력, basic 자동 래핑)
zdm-cli backup update --id 123 --schedule '{"type":3,"time":"02:00"}'

# smart 모드 스케줄 변경 (JSON 형식 schedule-id)
zdm-cli backup update --id 123 --schedule-id '{"type":7,"basic":100,"advanced":200}'

# 스크립트 설정 변경
zdm-cli backup update --id 123 --script-path "/scripts/new_script.sh" --script-run after

# 제외 폴더 변경
zdm-cli backup update --id 123 --exclude-dir "/tmp,/var/cache"

# 작업 시작
zdm-cli backup update --id 123 --status start

# 작업 중지
zdm-cli backup update --id 123 --status stop

# JSON 형식으로 출력
zdm-cli backup update --id 123 --mode increment --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | 작업 대상 Center | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| --status | - | string | Optional | - | 작업 상태 | `start`, `stop` |
| --repository-id | -ri | number | Optional | - | Repository ID | - |
| --repository-path | -rp | string | Optional | - | Repository Path | - |
| --change-name | -cn | string | Optional | - | 변경할 작업 이름 | - |
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 (`basic` 키 없으면 자동 래핑) | - |
| --schedule-id | -sc-id | string | Optional | - | 기존 스케줄 ID (smart 모드: `'{"type":TYPE,"basic":ID,"advanced":ID}'`) | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 (`basic` 키 없으면 자동 래핑) | - |
| --rotation | -rot | number | Optional | - | 작업 반복횟수 | - |
| --compression | -comp | string | Optional | - | 작업 압축 사용 여부 | `use`, `not use` |
| --encryption | -enc | string | Optional | - | 작업 암호화 사용 여부 | `use`, `not use` |
| --exclude-dir | -exd | string | Optional | - | 작업 제외 폴더 | - |
| --script-path | -sp | string | Optional | - | 작업시 사용할 script full path | - |
| --script-run | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --network-limit | -nl | number | Optional | - | 작업 Network 제한 속도 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 최소 하나는 필수로 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>스케줄 등록/수정 정책 (v2.0.0)</strong></summary>

`--schedule`, `--schedule-id`, `--schedule-file` 옵션으로 스케줄을 변경할 때 아래 규칙에 따라 동작합니다.

| 시나리오 | 동작 |
|---------|------|
| 기존 스케줄 없음 | 신규 스케줄 등록 |
| 모드 동일(F/I→F/I, Smart→Smart) + 기존 스케줄 있음 | 기존 스케줄의 데이터만 입력값으로 갱신 (스케줄 ID 보존) |
| 모드 전환(F/I↔Smart) | 신규 스케줄 등록 (기존 스케줄 참조 해제, advanced 자동 초기화) |
| 입력이 스케줄 ID(숫자) + 기존 스케줄 있음 | 입력 ID의 스케줄 데이터를 기존 스케줄에 복사하여 갱신 (ID 보존) |

</details>

<details markdown="1" open>
<summary><strong>v2.0.2 변경 사항</strong></summary>

> **v2.0.2 변경 사항**:
> - Schedule 변경 detail 의 `previous`/`new` 가 `{ id, type, description }` 객체로 확장. CLI 는 `formatChangeValue` 로 `Daily ([Basic] Start working at ...)` 한 줄 변환 표시.
> - Job Status 변경 detail 의 `previous` 가 DB raw 가 아닌 UI 와 동일한 calculated 결과 (`Registered` / `Processing` / `Scheduled` / `Complete` 등).
> - notices 신규 필드 — schedule 자동 복제 등 안내.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Update Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-05-19 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Update Summary]
state : success

[Changed Fields]
[Change 1]
field : Schedule
value : Daily ([Basic] Start working at 03:00 every day.) -> Weekly ([Basic] Start working at 03:00 Monday, Wednesday every week.)

[Change 2]
field : Job Status
value : Registered -> start

[Change 3]
field : mode
value : increment -> full

[Change 4]
field : compression
value : not use -> use

[Change 5]
field : networkLimit
value : 0 -> 1000

[Notices]
- Schedule was duplicated (1 schedule = 1 job principle). Source schedule ID: 5, new schedule ID: 10.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> `[Notices]` 블록은 schedule 자동 복제 등 부가 안내가 있을 때만 출력됩니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Table format)</strong></summary>

`--output table` 사용 시 변경 필드는 표 형태로 표시되며, Schedule/Job Status 의 previous/new 컬럼은 `formatChangeValue` 결과로 출력됩니다.

```
┌───┬────────────┬─────────────────────────────────────────────────────────────────────┬───────────────────────────────────────────────────────────────────────────────────┐
│ # │ field      │ previous                                                            │ new                                                                               │
├───┼────────────┼─────────────────────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────────────┤
│ 1 │ Schedule   │ Daily ([Basic] Start working at 03:00 every day.)                   │ Weekly ([Basic] Start working at 03:00 Monday, Wednesday every week.)             │
│ 2 │ Job Status │ Registered                                                          │ start                                                                             │
│ 3 │ mode       │ increment                                                           │ full                                                                              │
│ 4 │ rotation   │ 7                                                                   │ 14                                                                                │
└───┴────────────┴─────────────────────────────────────────────────────────────────────┴───────────────────────────────────────────────────────────────────────────────────┘
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (JSON format)</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Success",
  "success": true,
  "data": {
    "jobInfo": [
      {
        "id": "123",
        "name": "weekly-backup",
        "partition": "/"
      }
    ],
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "Schedule",
          "previous": { "id": 5, "type": "Daily", "description": "[Basic] Start working at 03:00 every day." },
          "new":      { "id": 10, "type": "Weekly", "description": "[Basic] Start working at 03:00 Monday, Wednesday every week." }
        },
        {
          "field": "Job Status",
          "previous": "Registered",
          "new": "start"
        },
        {
          "field": "mode",
          "previous": "increment",
          "new": "full"
        },
        {
          "field": "compression",
          "previous": "not use",
          "new": "use"
        },
        {
          "field": "networkLimit",
          "previous": 0,
          "new": 1000
        }
      ]
    },
    "notices": [
      "Schedule was duplicated (1 schedule = 1 job principle). Source schedule ID: 5, new schedule ID: 10."
    ]
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

> `Schedule` / `Schedule(Basic)` / `Schedule(Advanced)` 필드의 `previous` / `new` 는 v2.0.2 부터 `{ id, type, description }` 객체로 확장됩니다. CLI text/table 양식은 이를 `formatChangeValue` 로 `type (description)` 한 줄로 변환합니다. `notices` 는 schedule 자동 복제 등 부가 안내가 있을 때만 응답에 포함됩니다.

</details>

---
