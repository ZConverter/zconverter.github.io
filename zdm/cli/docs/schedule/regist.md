---
layout: docs
title: schedule create
section_title: ZDM CLI Documentation
navigation: cli
---

Schedule Data를 생성하여 JSON 파일로 저장합니다.

---

## `schedule create` {#schedule-create}

> * Schedule 정보를 생성하고 JSON 파일로 저장하는 명령어입니다.
> * 생성된 파일은 `schedule regist` 명령어를 통해 ZDM 서버에 등록할 수 있습니다.
> * Schedule Type에 따라 Basic Schedule 또는 Basic + Advanced Schedule을 생성합니다.

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

# 사용자 지정 경로에 저장
zdm-cli schedule create -t 3 --basic-time 12:00 -p /custom/path/schedule.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --type | -t | number | Required | - | Schedule Type | {% include zdm/schedule-types.md inline=true %} |
| --path | -p | string | Optional | - | 생성된 Schedule File 저장 Path | - |
| --center | -c | string | Optional | - | Schedule 등록 Center | - |
| --user | -u | string | Optional | - | Schedule 등록 User | - |
| --basic-year | -by | string | Optional | - | Basic Schedule - 년도 설정 | - |
| --basic-month | -bm | string | Optional | - | Basic Schedule - 월 설정 | - |
| --basic-week | -bw | string | Optional | - | Basic Schedule - 주 설정 | - |
| --basic-day | -bd | string | Optional | - | Basic Schedule - 일 설정 | - |
| --basic-time | -bt | string | Optional | - | Basic Schedule - 시간 설정 (HH:MM) | - |
| --basic-interval-hour | -bih | string | Optional | - | Basic Schedule - 간격 시간 | - |
| --basic-interval-minute | -bim | string | Optional | - | Basic Schedule - 간격 분 | - |
| --advanced-year | -ay | string | Optional | - | Advanced Schedule - 년도 설정 (Smart Schedule용, Type 7~11) | - |
| --advanced-month | -am | string | Optional | - | Advanced Schedule - 월 설정 (Smart Schedule용) | - |
| --advanced-week | -aw | string | Optional | - | Advanced Schedule - 주 설정 (Smart Schedule용) | - |
| --advanced-day | -ad | string | Optional | - | Advanced Schedule - 일 설정 (Smart Schedule용) | - |
| --advanced-time | -at | string | Optional | - | Advanced Schedule - 시간 설정 (Smart Schedule용, HH:MM) | - |
| --advanced-interval-hour | -aih | string | Optional | - | Advanced Schedule - 간격 시간 (Smart Schedule용) | - |
| --advanced-interval-minute | -aim | string | Optional | - | Advanced Schedule - 간격 분 (Smart Schedule용) | - |

</details>

<details markdown="1" open>
<summary><strong>Schedule Types</strong></summary>

{% include zdm/schedule-types.md number=true %}

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Creation Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[info]

saved to  : /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

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

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```
saved to  : /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

{
  "center": "zdm-center-id",
  "type": 3,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

**Smart Schedule (Type 7~11) Text 형식 출력 예시:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Creation Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[info]

saved to  : /home/user/.zconverter/zdm-cli/schedule/Advanced_schedule-20250106120000.json

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

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Smart Schedule (Type 7~11) JSON 형식 출력 예시:**

```
saved to  : /home/user/.zconverter/zdm-cli/schedule/Advanced_schedule-20250106120000.json

{
  "center": "zdm-center-id",
  "type": 7,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "wed",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  },
  "advanced": {
    "year": "",
    "month": "",
    "week": "",
    "day": "mon,thu,fri",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

---
