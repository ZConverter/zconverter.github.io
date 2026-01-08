---
layout: docs
title: schedule regist
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

Schedule JSON 파일을 ZDM 서버에 등록합니다.

---

## `schedule regist` {#schedule-regist}

> * `schedule create` 명령어로 생성한 JSON 파일을 ZDM 서버에 등록하는 명령어입니다.
> * JSON 파일 형식만 지원합니다.
> * Smart Schedule (Type 7~11)의 경우 Basic과 Advanced Schedule이 함께 등록됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Schedule 파일 등록
zdm-cli schedule regist -p /path/to/schedule.json

# 절대 경로 사용
zdm-cli schedule regist --path /home/user/schedules/daily-schedule.json

# 상대 경로 사용
zdm-cli schedule regist -p ./Basic_schedule-20250106120000.json

# JSON 형식으로 결과 출력
zdm-cli schedule regist -p /path/to/schedule.json --output json

# 테이블 형식으로 결과 출력
zdm-cli schedule regist -p /path/to/schedule.json --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --path | -p | string | Required | - | 등록할 Schedule File Path | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>입력 파일 형식</strong></summary>

**Basic Schedule (Type 0~6):**

```json
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

**Smart Schedule (Type 7~11):**

```json
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

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본) - Basic Schedule 등록 결과:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Registration Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Schedule registered successfully
timestamp : 2025-01-06 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Basic Schedule]
id          : 123
type        : daily
state       : enabled
description : Daily schedule

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Text 형식 - Smart Schedule 등록 결과:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Registration Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Schedule registered successfully
timestamp : 2025-01-06 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Basic Schedule]
id          : 124
type        : smart weekly on specific day
state       : enabled
description : Smart weekly basic schedule

[Advanced Schedule]
id          : 125
type        : smart weekly on specific day
state       : enabled
description : Smart weekly advanced schedule

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 - Basic Schedule 등록 결과:**

```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Schedule registered successfully",
  "success": true,
  "data": {
    "basic": {
      "id": 123,
      "type": "daily",
      "state": "enabled",
      "description": "Daily schedule"
    }
  },
  "timestamp": "2025-01-06 12:00:00"
}
```

**JSON 형식 - Smart Schedule 등록 결과:**

```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Schedule registered successfully",
  "success": true,
  "data": {
    "basic": {
      "id": 124,
      "type": "smart weekly on specific day",
      "state": "enabled",
      "description": "Smart weekly basic schedule"
    },
    "advanced": {
      "id": 125,
      "type": "smart weekly on specific day",
      "state": "enabled",
      "description": "Smart weekly advanced schedule"
    }
  },
  "timestamp": "2025-01-06 12:00:00"
}
```

</details>

---
