
Backup 작업을 등록하는 명령어입니다.

---

## `backup regist` {#backup-regist}

> * 새로운 Backup 작업을 등록합니다. 서버의 전체 파티션 또는 특정 파티션에 대한 백업 작업을 설정할 수 있습니다.
> * `--mode smart` 지정 시 schedule 옵션(`--schedule`, `--schedule-id`, `--schedule-file`) 중 하나가 반드시 필요합니다.
> * `--schedule` 또는 `--schedule-file` 사용 시 JSON에 `basic` 키가 없으면 `type`을 제외한 필드가 자동으로 `basic`으로 래핑됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 Backup 등록 (압축: use, 암호화: not use 기본값)
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --center 9

# Center 이름으로 지정하여 등록
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --center srcconm

# 압축 없이 Backup 등록
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --compression "not use"

# 암호화 활성화하여 Backup 등록
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --encryption "use"

# 특정 파티션만 Backup 등록
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --partition "/,/home"

# 작업 이름 지정하여 등록
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --job-name "daily_backup"

# 스케줄 설정과 함께 등록 (기존 스케줄 ID)
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --schedule-id 1234

# smart 모드 등록 (스케줄 필수)
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode smart --schedule-id '{"type":7,"basic":100,"advanced":200}'

# 스케줄 JSON 직접 입력 (basic 자동 래핑)
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --schedule '{"type":3,"time":"12:00"}'

# 스케줄 파일 사용
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --schedule-file "/path/to/schedule.json"

# 제외 폴더 설정
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --exclude-dir "/tmp,/var/log"

# 제외 파티션 설정
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --exclude-partition "/dev"

# 자동 시작 설정
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --start

# 스크립트 실행 설정
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --script-path "/scripts/pre_backup.sh" --script-run before

# 파티션별 개별 설정 (JSON 형태)
zdm-cli backup regist --server ca-rocky810_172.25.0.48 --mode full --individual '[{"partition":"/","jobName":"root_backup"}]'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --server | - | string | Required | - | 작업 대상 Server | - |
| --mode | - | string | Required | - | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| --center | -c | string | Optional | config 설정값 | 작업 등록 Center | - |
| --repository-id | -ri | number | Optional | config 설정값 | 작업시 사용할 Repository ID | - |
| --repository-path | -rp | string | Optional | config 설정값 | 작업시 사용할 Repository Path (미입력 시 config 기본값 사용, 없으면 생략) | - |
| --partition | - | string | Optional | 전체 파티션 | 작업 대상 파티션 (콤마로 구분) | - |
| --job-name | -jn | string | Optional | - | 작업 이름 | - |
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 (`basic` 키 없으면 자동 래핑) | - |
| --schedule-id | -sc-id | string | Optional | - | 기존 스케줄 ID (smart 모드: `'{"type":TYPE,"basic":ID,"advanced":ID}'`) | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 (`basic` 키 없으면 자동 래핑) | - |
| --rotation | -rot | number | Optional | 1 | 작업 반복횟수 | - |
| --compression | -comp | string | Optional | use | 작업 압축 사용 여부 | `use`, `not use` |
| --encryption | -enc | string | Optional | not use | 작업 암호화 사용 여부 | `use`, `not use` |
| --exclude-dir | -exd | string | Optional | - | 작업 제외 폴더 | - |
| --exclude-partition | -exp | string | Optional | - | 작업 제외 partition | - |
| --network-limit | -nl | number | Optional | 0 | 작업 Network 제한 속도 | - |
| --start | - | boolean | Optional | false | 작업 자동시작 여부 | - |
| --script-path | -sp | string | Optional | - | 작업시 사용할 script full path | - |
| --script-run | -sr | string | Optional | - | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| --individual | -ind | string | Optional | - | 파티션별 개별 설정 (JSON 문자열) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>Individual JSON format (Full default value)</strong></summary>

```json
[
  {
    "partition": "/",
    "jobName": "root_backup",
    "mode": "full",
    "repository": {
      "id": 1,
      "path": "/backup/repo"
    },
    "compression": true,
    "encryption": false,
    "rotation": 1,
    "excludeDir": "/tmp,/var/log",
    "excludePartition": "/dev",
    "networkLimit": 100,
    "autoStart": true,
    "description": "Root partition backup"
  }
]
```

</details>

<details markdown="1" open>
<summary><strong>v2.0.2 변경 사항</strong></summary>

> **v2.0.2 변경 사항**: schedule 응답 객체에 `id` 필드 신규 추가 (text 양식 `id` 줄, table 양식 `Daily (#7)` 형식). type 은 displayMappings PascalCase 영문, description 은 `processScheduleInfo` 영문.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Registration Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-05-19 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Registration Summary]
total      : 2
successful : 2
failed     : 0

[Registration Details]

[Job 1]
state           : success
jobName         : root_backup
partition       : /
jobMode         : Full Backup
autoStart       : use
scriptPath      : -
scriptRunTiming : -

[Schedule - Basic]
id          : 7
type        : Daily
description : [Basic] Start working at 03:00 every day.

[Job 2]
state           : success
jobName         : home_backup
partition       : /home
jobMode         : Smart Backup
autoStart       : use
scriptPath      : -
scriptRunTiming : -

[Schedule - Basic]
id          : 13
type        : Smart Weekly (Specific Day of the Week)
description : [Basic] Start working every Monday at 10:00

[Schedule - Advanced]
id          : 14
type        : Smart Weekly (Specific Day of the Week)
description : [Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> schedule 미지정으로 등록된 작업은 `[Schedule - Basic]` 블록이 출력되지 않습니다. smart 모드가 아닌 경우 `[Schedule - Advanced]` 블록은 출력되지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Table format)</strong></summary>

`--output table` 사용 시 schedule 컬럼은 `type (#id)` 형식으로 표시됩니다.

```
┌────────────┬─────────────┬───────────┬────────────────┬────────────┬───────────────────────────────────────────────┐
│ state      │ jobName     │ partition │ jobMode        │ autoStart  │ schedule                                      │
├────────────┼─────────────┼───────────┼────────────────┼────────────┼───────────────────────────────────────────────┤
│ success    │ root_backup │ /         │ Full Backup    │ use        │ Daily (#7)                                    │
│ success    │ home_backup │ /home     │ Smart Backup   │ use        │ Smart Weekly (Specific Day of the Week) (#13) │
└────────────┴─────────────┴───────────┴────────────────┴────────────┴───────────────────────────────────────────────┘
```

> table 양식에서는 basic schedule 만 한 줄로 표시되며 (`type (#id)`), advanced 는 별도 컬럼으로 노출되지 않습니다. 상세는 text 또는 JSON 양식을 사용하세요.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (JSON format)</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Success",
  "success": true,
  "data": {
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "root_backup",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "use",
        "scriptPath": "-",
        "scriptRunTiming": "-",
        "schedule": {
          "basic": {
            "id": 7,
            "type": "Daily",
            "description": "[Basic] Start working at 03:00 every day."
          }
        }
      },
      {
        "state": "success",
        "jobName": "home_backup",
        "partition": "/home",
        "jobMode": "Smart Backup",
        "autoStart": "use",
        "scriptPath": "-",
        "scriptRunTiming": "-",
        "schedule": {
          "basic": {
            "id": 13,
            "type": "Smart Weekly (Specific Day of the Week)",
            "description": "[Basic] Start working every Monday at 10:00"
          },
          "advanced": {
            "id": 14,
            "type": "Smart Weekly (Specific Day of the Week)",
            "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
          }
        }
      }
    ]
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

> `schedule.advanced` 는 smart 모드(type 7~11)일 때만 응답에 포함되며, 미설정 시 필드 자체가 누락됩니다 (이전 양식의 `"-"` 문자열 표시는 폐기).

</details>

---
