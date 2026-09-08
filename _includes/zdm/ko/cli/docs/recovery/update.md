
기존 Recovery 작업 정보를 수정합니다.

---

## `recovery update` {#recovery-update}

> * 등록된 Recovery 작업의 설정을 변경합니다.
> * 작업 이름, 플랫폼, 스케줄, 스크립트 설정 등을 수정할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Center 지정 + ID로 작업 모드 변경
zdm-cli recovery update --center 9 --id 123 --mode full

# 작업 이름으로 검색하여 이름 변경
zdm-cli recovery update --center 9 --name "old-recovery" --change-name "new-recovery"

# 플랫폼 변경
zdm-cli recovery update --center 9 --id 123 --platform aws

# 복구 완료 후 동작 변경
zdm-cli recovery update --center 9 --id 123 --after-reboot reboot

# 네트워크 제한 설정
zdm-cli recovery update --center 9 --id 123 --network-limit 1000

# 스크립트 설정 변경
zdm-cli recovery update --center 9 --name "my-recovery" --script-path "/path/to/script.sh" --script-run before

# 스케줄 변경 (기존 스케줄 ID 사용)
zdm-cli recovery update --center 9 --id 123 --schedule-id 1234

# 스케줄 변경 (JSON 파일 사용)
zdm-cli recovery update --center 9 --id 123 --schedule-file "schedule.json"

# 스케줄 변경 (JSON 문자열 사용) — type 은 정수 0 ~ 6 (Recovery 는 basic only)
# 예: type 3 = Daily, type 4 = Weekly. 상세는 recovery regist 문서의 schedule 동봉 예시 참조
zdm-cli recovery update --center 9 --id 123 --schedule '{"type":3,"basic":{"time":"03:00"}}'

# 메일 알림 수신자 변경
zdm-cli recovery update --center 9 --id 123 --mail-event "admin@example.com"

# 작업 상태 변경
zdm-cli recovery update --center 9 --id 123 --status stop

# 특정 파티션의 모드 변경
zdm-cli recovery update --center 9 --id 123 --backup-file "server01_ROOT_0262.ZIA" --mode inc

# 복합 설정 변경
zdm-cli recovery update --center 9 --id 123 --change-name "MyRecovery" --platform aws --after-reboot reboot --network-limit 500
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | 작업 대상 Center | - |
| --id | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --name | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --change-name | -cn | string | Optional | - | 변경할 작업 이름 | - |
| --platform | -pf | string | Optional | - | 변경할 플랫폼 | {% include zdm/platforms.md baremetal=true inline=true %} |
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 | - |
| --schedule-id | -sc-id | number | Optional | - | 기존 스케줄 ID | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 | - |
| --mode | - | string | Optional | - | 작업 모드 | {% include zdm/job-modes.md recovery=true %} |
| --after-reboot | -ar | string | Optional | - | 작업 완료 후 부팅 모드 | `reboot`, `shutdown`, `none` |
| --mail-event | -me | string | Optional | - | 작업 이벤트 수신 메일 | - |
| --network-limit | -nl | number | Optional | 0 | 작업 Network 제한 속도 (Mbps) | - |
| --script-path | -sp | string | Optional | - | 작업 스크립트 경로 | - |
| --script-run | -sr | string | Optional | - | 작업 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --status | - | string | Optional | - | 작업 상태. `start` 는 대상 서버가 사용 중이면 `JOB-ERROR-64` (409) 로 거부됩니다 (`stop` 은 영향 없음) | `start`, `stop` |
| --backup-file | -bf | string | Optional | - | 수정할 항목을 지목할 backup image 파일 이름 | - |
| --target-partition | -tp | string | Optional | - | 같은 이미지가 여러 파티션에 복구된 경우 그중 하나로 좁힘 (Linux `/data`, Windows `C:`) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --name 중 하나는 필수로 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

> **v2.0.2 변경 사항**:
> - Schedule(Basic) 변경 detail 의 `previous`/`new` 가 `{ id, type, description }` 객체로 확장. 이전 schedule 없음은 `null` 로 표시. CLI 는 `formatChangeValue` 로 한 줄 변환 (`- -> Daily ([Basic] Start working at 03:00 every day.)` 형식).
> - Job Status 변경 detail 의 `previous` 가 DB raw enum 이 아닌 UI 와 동일한 calculated 결과 (`Registered` / `Processing` / `Scheduled` / `Complete` 등). `new` 는 요청 입력값 (`start` / `stop`) 그대로.

**Text 형식 (--output text, 기본값):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Update Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery updated successfully
timestamp : 2025-01-01 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Job Information]
id                : 123
name              : new-recovery-name

[Update Summary]
state             : success

[Common Fields Changed]
[Change 1]
field : Recovery Mode
value : full -> increment

[Change 2]
field : After Reboot
value : shutdown -> reboot

[Change 3]
field : Schedule(Basic)
value : - -> Daily ([Basic] Start working at 03:00 every day.)

[Change 4]
field : Job Status
value : Registered -> start

[Partition-specific Changes]
[Partition 1]
partition : /
[Change 1]
field : Recovery Mode
value : increment -> full

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> `Schedule(Basic)` 변경 detail 은 `formatChangeValue` 가 객체를 한 줄로 변환합니다. `previous` 가 `null` 이면 `-`, 그렇지 않으면 `<type> (<description>)` 형식. (Recovery 는 `basic` 만 지원 — `Schedule(Advanced)` 필드는 발생하지 않음)
> `Job Status` 변경 detail 의 `previous` 는 UI 와 동일한 calculated 값 (`Registered` / `Processing` / `Scheduled` / `Complete` 등) 으로 표시됩니다.

**Table 형식 (--output table):**

table 출력은 commonUpdatedFields / eachUpdatedFields 를 각각 행 단위 표로 표시하며, `previous`/`new` 컬럼은 `formatChangeValue` 결과를 표시합니다. Schedule(Basic) / Job Status 도 동일하게 한 줄 변환되어 셀에 들어갑니다.

**JSON 형식 (--output json):**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery updated successfully",
  "success": true,
  "data": {
    "jobInfo": {
      "id": "123",
      "name": "new-recovery-name"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "Recovery Mode",
          "previous": "full",
          "new": "increment"
        },
        {
          "field": "After Reboot",
          "previous": "shutdown",
          "new": "reboot"
        },
        {
          "field": "Schedule(Basic)",
          "previous": null,
          "new": {
            "id": 7,
            "type": "Daily",
            "description": "[Basic] Start working at 03:00 every day."
          }
        },
        {
          "field": "Job Status",
          "previous": "Registered",
          "new": "start"
        }
      ],
      "eachUpdatedFields": [
        {
          "partition": "/",
          "summary": {
            "state": "success",
            "commonUpdatedFields": [
              {
                "field": "Recovery Mode",
                "previous": "increment",
                "new": "full"
              }
            ],
            "eachUpdatedFields": []
          }
        }
      ]
    }
  },
  "timestamp": "2025-01-01T10:30:00.000+09:00"
}
```

> JSON 응답은 서버 응답을 그대로 직렬화합니다 (text/table 양식은 CLI 측에서 `formatChangeValue` 로 한 줄 변환).
> `Schedule(Basic)` 의 `previous`/`new` 가 `null` 인 경우는 이전 schedule 이 없었거나 (id ≤ 0) 모드 전환으로 schedule 이 reset 된 경우입니다.
> `Job Status` 의 `previous` 는 UI 와 동일한 calculated 값 (`"Registered"` / `"Processing"` / `"Scheduled"` / `"Complete"` 등) 이고, `new` 는 요청 body 의 `status` 입력값 (`"start"` / `"stop"`) 그대로입니다.

</details>

---
