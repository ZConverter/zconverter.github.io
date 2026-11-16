{% include zdm/base-path.html %}

Schedule Data를 생성하여 JSON 파일로 저장하고 ZDM 서버에 자동으로 등록합니다.

---

## `schedule create` {#schedule-create}

> * Schedule 정보를 생성하고 JSON 파일로 저장한 후, ZDM 서버에 자동으로 등록하는 명령어입니다.
> * Schedule Type에 따라 Basic Schedule 또는 Basic + Advanced Schedule을 생성합니다. 타입별 구조와 작업에 붙이는 방법은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참고하세요.
> * 생성된 파일은 로컬에 저장되며, 서버 등록 결과(ID, 타입, 상태, 설명)가 함께 출력됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule create [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# [Type 0]: Once - 2025/04/29 12:00 한번 실행
zdm-cli schedule create -t 0 --basic-year 2025 --basic-month 4 --basic-day 29 --basic-time 12:00

# [Type 1]: Every Minute - 12:00부터 5분마다 실행
zdm-cli schedule create -t 1 --basic-time 12:00 --basic-interval-minute 5

# [Type 2]: Hourly - 12:00부터 1시간마다 실행
zdm-cli schedule create -t 2 --basic-time 12:00 --basic-interval-hour 1

# [Type 3]: Daily - 매일 12:00 실행
zdm-cli schedule create -t 3 --basic-time 12:00

# [Type 4]: Weekly - 매주 화요일 12:00 실행
zdm-cli schedule create -t 4 --basic-day tue --basic-time 12:00

# [Type 5]: Monthly Week - 매달 1,3주 수요일 12:00 실행
zdm-cli schedule create -t 5 --basic-week "1,3" --basic-day wed --basic-time 12:00

# [Type 6]: Monthly Day - 매달 10,20일 12:00 실행
zdm-cli schedule create -t 6 --basic-day "10,20" --basic-time 12:00

# [Type 7]: Smart Weekly - Basic: 매주 수요일, Advanced: 매주 월,목,금요일
zdm-cli schedule create -t 7 --basic-day wed --basic-time 12:00 --advanced-day "mon,thu,fri" --advanced-time 12:00

# [Type 8]: Smart Monthly Week - Basic: 매달 2째주 월요일, Advanced: 매달 1,3째주 화,목요일
zdm-cli schedule create -t 8 --basic-week 2 --basic-day mon --basic-time 12:00 --advanced-week "1,3" --advanced-day "tue,thu" --advanced-time 12:00

# [Type 9]: Smart Monthly Date - Basic: 매달 15일, Advanced: 매달 2,25일
zdm-cli schedule create -t 9 --basic-day 15 --basic-time 12:00 --advanced-day "2,25" --advanced-time 12:00

# [Type 10]: Smart Custom Monthly Week - Basic: 매년 5월 2째주 토요일, Advanced: 매년 1,6월 2,4째주 수,일요일
zdm-cli schedule create -t 10 --basic-month 5 --basic-week 2 --basic-day sat --basic-time 12:00 --advanced-month "1,6" --advanced-week "2,4" --advanced-day "wed,sun" --advanced-time 12:00

# [Type 11]: Smart Custom Monthly Date - Basic: 매년 4월 19일, Advanced: 매년 10,11월 25,28일
zdm-cli schedule create -t 11 --basic-month 4 --basic-day 19 --basic-time 12:00 --advanced-month "10,11" --advanced-day "25,28" --advanced-time 12:00

# [Type 12]: Yearly (날짜 기준) - 매년 3,6,9,12월 말일 23:00
zdm-cli schedule create -t 12 --basic-month "3,6,9,12" --basic-day last --basic-time 23:00

# [Type 12]: Yearly (요일 기준) - 매년 6,12월 마지막 주 일요일 04:00 (--basic-week 를 주면 요일 기준)
zdm-cli schedule create -t 12 --basic-month "6,12" --basic-week 5 --basic-day sun --basic-time 04:00

# 누락된 옵션을 단계별 질문으로 입력
zdm-cli schedule create --interactive

# 사용자 지정 경로에 저장
zdm-cli schedule create -t 3 --basic-time 12:00 -p /custom/path/schedule.json

# 센터 지정하여 생성 및 등록
zdm-cli schedule create -t 3 --basic-time "02:00" --center 9
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --type | -t | number | Required | - | Schedule Type | {% include zdm/schedule-types.md inline=true %} |
| --interactive | -i | boolean | Optional | false | 누락된 옵션을 단계별 질문으로 입력받습니다. Type 12 는 먼저 "Select yearly schedule basis" 에서 날짜 기준(date)과 요일 기준(weekday)을 고릅니다 | - |
| --path | -p | string | Optional | - | 생성된 Schedule File 저장 Path | - |
| --center | -c | string | Optional | - | Schedule 등록 Center ID 또는 Name | - |
| --user | -u | string | Optional | - | Schedule 등록 User ID 또는 Email | - |
| --basic-year | -by | string | Optional | - | Basic Schedule - 년도 설정 | - |
| --basic-month | -bm | string | Optional | - | Basic Schedule - 월 설정 (Type 12: 쉼표로 구분한 1~12) | - |
| --basic-week | -bw | string | Optional | - | Basic Schedule - 주 설정 (1~5, 5 = 마지막 주). Type 12 에서 지정하면 요일 기준이 됩니다 | - |
| --basic-day | -bd | string | Optional | - | Basic Schedule - 일 설정 (Type 6, 9, 11, 12: 1~31 또는 `last`, 31 = 말일. 요일 지정 타입: mon~sun) | - |
| --basic-time | -bt | string | Optional | - | Basic Schedule - 시간 설정 (HH:MM) | - |
| --basic-interval-hour | -bih | string | Optional | - | Basic Schedule - 간격 시간 | - |
| --basic-interval-minute | -bim | string | Optional | - | Basic Schedule - 간격 분 | - |
| --advanced-year | -ay | string | Optional | - | Advanced Schedule - 년도 설정 (Smart Schedule용, Type 7~11) | - |
| --advanced-month | -am | string | Optional | - | Advanced Schedule - 월 설정 (Smart Schedule용) | - |
| --advanced-week | -aw | string | Optional | - | Advanced Schedule - 주 설정 (Smart Schedule용) | - |
| --advanced-day | -ad | string | Optional | - | Advanced Schedule - 일 설정 (Smart Schedule용. Type 9, 11: 1~31 또는 `last`, 31 = 말일) | - |
| --advanced-time | -at | string | Optional | - | Advanced Schedule - 시간 설정 (Smart Schedule용, HH:MM) | - |
| --advanced-interval-hour | -aih | string | Optional | - | Advanced Schedule - 간격 시간 (Smart Schedule용) | - |
| --advanced-interval-minute | -aim | string | Optional | - | Advanced Schedule - 간격 분 (Smart Schedule용) | - |

</details>

<details markdown="1" open>
<summary><strong>Schedule Types</strong></summary>

{% include zdm/schedule-types.md number=true %}

</details>

<details markdown="1" open>
<summary><strong>Type 12 (매년) 와 Day 값</strong></summary>

- Type 12 는 일반 스케줄이며, CLI 타입 이름은 소문자 `yearly` 입니다. `-t` 에는 숫자 `12` 를 씁니다.
- 날짜 기준: `--basic-month`, `--basic-day`, `--basic-time` 을 줍니다. 주(week) 값은 보내지 않습니다.
- 요일 기준: 위 옵션에 `--basic-week` 를 더하면 월 · 주 · 요일(`mon`~`sun`) · 시간 형태가 됩니다.
- Day 값: Type 6, 9, 11, 12 의 일은 `1`~`31` 또는 `last` 입니다. `31` 은 그 달의 말일입니다.
- Week 값: `1`~`5` 이고 `5` 는 마지막 주입니다.
- `-t` 는 정수 0~12 만 받습니다. `-t 3.5` 처럼 정수가 아닌 값은 거부됩니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본) - Basic Schedule:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Creation & Registration Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[info]

saved to  : /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

center                  : zdm-center-id
type                    : 3
basic.year              : -
basic.month             : -
basic.week              : -
basic.day               : -
basic.time              : 12:00
basic.interval.hour     : -
basic.interval.minute   : -

[Server Registration]
basic.id          : 123456
basic.type        : daily
basic.state       : Enabled
basic.description : [Basic] Start working at 12:00 every day.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Text 형식 - Smart Schedule (Type 7~11):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Creation & Registration Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[info]

saved to  : /home/user/.zconverter/zdm-cli-data/schedule/Advanced_schedule-20250106120000.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

center                  : zdm-center-id
type                    : 7
basic.year              : -
basic.month             : -
basic.week              : -
basic.day               : wed
basic.time              : 12:00
basic.interval.hour     : -
basic.interval.minute   : -
advanced.year           : -
advanced.month          : -
advanced.week           : -
advanced.day            : mon,thu,fri
advanced.time           : 12:00
advanced.interval.hour  : -
advanced.interval.minute: -

[Server Registration]
basic.id          : 123457
basic.type        : Smart Weekly (Specific Day of the Week)
basic.state       : Enabled
basic.description : [Basic] Start working every Wednesday at 12:00

advanced.id          : 123458
advanced.type        : Smart Weekly (Specific Day of the Week)
advanced.state       : Enabled
advanced.description : [Advanced] Start working every Monday, Thursday, Friday at 12:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
