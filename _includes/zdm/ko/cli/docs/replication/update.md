{% include zdm/base-path.html %}

Replication 작업을 수정하는 명령어입니다.

---

## `replication update` {#replication-update}

> * Replication 작업의 설정을 수정합니다.
> * 작업 ID 또는 이름으로 대상을 지정합니다.
> * `--center` 파라미터는 지원하지 않습니다.

> **v2.0.2 신설**: schedule 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출. 이전엔 service 가 schedule 입력을 무시했으나 본 버전부터 정상 처리. CLI 는 `Daily ([Basic] Start working at ...) -> Weekly ([Basic] Start working at ...)` 한 줄로 표시합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Replication 모드 변경
zdm-cli replication update --id 123 --mode increment

# 작업 시작
zdm-cli replication update --name repl01 --status start

# 작업 중지
zdm-cli replication update --id 123 --status stop

# 작업 이름 변경
zdm-cli replication update --id 123 --cn new-repl-name

# 압축 및 네트워크 제한 설정
zdm-cli replication update --id 123 --comp --nl 1000

# 이벤트 메일 설정
zdm-cli replication update --id 123 --me admin@example.com

# 스케줄 설정 (기존 스케줄 ID)
zdm-cli replication update --id 123 --schedule-id 1234

# 스케줄 JSON 직접 입력 (Daily 03:00, basic 자동 래핑)
zdm-cli replication update --id 123 --schedule '{"type":3,"time":"03:00"}'

# JSON 형식으로 출력
zdm-cli replication update --id 123 --mode full --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**대상 지정 (하나 필수)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Required* | - | 작업 ID | - |
| --name | - | string | Required* | - | 작업 이름 | - |

> \* `--id` 또는 `--name` 중 하나는 반드시 입력해야 합니다.

**작업 정보**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --change-name | --cn | string | Optional | - | 새 작업 이름 | - |
| --status | - | string | Optional | - | 작업 상태 변경 | `start`, `stop` |
| --mode | - | string | Optional | - | Replication 모드 | `full`, `increment`, `sync` |

**작업 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --compression | --comp | boolean | Optional | - | 압축 사용 여부 | - |
| --network-limit | --nl | number | Optional | - | 네트워크 속도 제한 | - |
| --mail-event | --me | string | Optional | - | 이벤트 메일 수신 주소 | - |

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | - | string | Optional | - | 스케줄 JSON 문자열 (`basic` 키 없으면 자동 래핑) | - |
| --schedule-id | - | number | Optional | - | 기존 스케줄 ID (복사하지 않고 그대로 참조). 작업과 같은 center 의 스케줄이어야 하고 기본 유형(type 0~6)만 받습니다 | - |
| --schedule-file | - | string | Optional | - | 스케줄 JSON 파일 경로 (`basic` 키 없으면 자동 래핑) | - |

> 이 작업은 Basic 스케줄(type 0~6)만 받습니다. Smart(type 7~11)를 지정하면 `JOB-ERROR-101` 로 거부됩니다. jobMode `full` / `increment` / `sync` 모두 허용합니다. 변경 시 응답 `updatedFields[]` 에 `{ field: "schedule", previous: {...}, new: {...} }` 객체로 노출됩니다. 자동 래핑과 JSON 형식은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참고하세요.

**출력**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Update Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Replication updated successfully
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Replication Info]
id   : 123
name : repl01

[Changed Fields]
[Change 1]
field : replicationMode
value : increment -> full

[Change 2]
field : schedule
value : Daily ([Basic] Start working at 03:00 every day.) -> Weekly ([Basic] Start working at 03:00 Monday, Wednesday every week.)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> `schedule` 필드 변경은 `<type> (<description>) -> <type> (<description>)` 한 줄로 출력됩니다 (v2.0.2 신설).

**Table 형식 (--output table)**

```
+----+-----------------+-----------------------------------------------------------------+-----------------------------------------------------------------+
| #  | field           | previous                                                        | new                                                             |
+----+-----------------+-----------------------------------------------------------------+-----------------------------------------------------------------+
| 1  | replicationMode | increment                                                       | full                                                            |
| 2  | schedule        | Daily ([Basic] Start working at 03:00 every day.)               | Weekly ([Basic] Start working at 03:00 Monday, Wednesday ...)   |
+----+-----------------+-----------------------------------------------------------------+-----------------------------------------------------------------+
```

**JSON 형식 (--output json)**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Replication updated successfully",
  "success": true,
  "data": {
    "replicationInfo": {
      "id": 123,
      "name": "repl01"
    },
    "summary": {
      "updatedFields": [
        {
          "field": "replicationMode",
          "previous": "increment",
          "new": "full"
        },
        {
          "field": "schedule",
          "previous": { "id": 5,  "type": "Daily",  "description": "[Basic] Start working at 03:00 every day." },
          "new":      { "id": 10, "type": "Weekly", "description": "[Basic] Start working at 03:00 Monday, Wednesday every week." }
        }
      ]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

> `schedule` 필드 변경 시 `previous` / `new` 가 `{ id, type, description }` 객체 형식으로 노출됩니다 (v2.0.2 신설). 일반 필드는 단순 `string | number` 값입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `replicationInfo.id` | number | 작업 ID |
| `replicationInfo.name` | string | 작업 이름 |
| `summary.updatedFields[].field` | string | 수정된 필드명 |
| `summary.updatedFields[].previous` | string \| number \| ScheduleChangeValue | 수정 전 값. 일반 필드는 `string \| number`, `schedule` 필드는 `{ id, type, description }` 객체 (v2.0.2 신설) |
| `summary.updatedFields[].new` | string \| number \| ScheduleChangeValue | 수정 후 값. 일반 필드는 `string \| number`, `schedule` 필드는 `{ id, type, description }` 객체 (v2.0.2 신설) |

**ScheduleChangeValue 구조** (`field` 가 `schedule` 인 경우):

{% include zdm/schedule-change-value.md %}

</details>

---
