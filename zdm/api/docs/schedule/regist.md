---
layout: docs
title: POST /schedules
section_title: ZDM API Documentation
navigation: api
---

새로운 스케줄을 등록합니다.

---

## `POST /schedules` {#post-schedules}

> * 새로운 스케줄을 시스템에 등록합니다.
> * 스케줄 타입에 따라 다른 구조의 basic/advanced 객체가 필요합니다.
> * Smart 스케줄 (type 7~11)의 경우 basic과 advanced 모두 필요합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/schedules</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 일반 Daily 스케줄 등록
curl -X POST "https://api.example.com/api/v1/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "daily-backup",
    "type": 3,
    "basic": {
      "time": "10:00"
    }
  }'

# Smart Weekly 스케줄 등록 (type 7)
curl -X POST "https://api.example.com/api/v1/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-weekly-backup",
    "type": 7,
    "basic": {
      "day": "1",
      "time": "10:00"
    },
    "advanced": {
      "day": "2,3,4,5",
      "time": "12:00"
    }
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 |
| `user` | string | Optional | 사용자 이름 또는 ID |
| `jobName` | string | Optional | 작업 이름 |
| `type` | number | Required | 스케줄 타입 (0 ~ 11) |
| `basic` | object | Optional | 기본 스케줄 구조 |
| `advanced` | object | Optional | 고급 스케줄 구조 (Smart 스케줄용) |

</details>

<details markdown="1" open>
<summary><strong>스케줄 타입별 구조</strong></summary>

| Type | 이름 | basic 구조 | 비고 |
|------|------|------------|------|
| 0 | once | `{ year, month, day, time }` | 일회성 |
| 1 | every minute | `{ time, interval: { minute } }` | 분 간격 |
| 2 | hourly | `{ time, interval: { hour } }` | 시간 간격 |
| 3 | daily | `{ time }` | 매일 |
| 4 | weekly | `{ day, time }` | 매주 |
| 5 | monthly on specific week | `{ week, day, time }` | 매월 특정 주 |
| 6 | monthly on specific day | `{ day, time }` | 매월 특정 일 |
| 7 | smart weekly on specific day | `{ day, time }` | basic/advanced 모두 필요 |
| 8 | smart monthly on specific week and day | `{ week, day, time }` | basic/advanced 모두 필요 |
| 9 | smart monthly on specific date | `{ day, time }` | basic/advanced 모두 필요 |
| 10 | smart custom monthly on specific month, week and day | `{ month, week, day, time }` | basic/advanced 모두 필요 |
| 11 | smart custom monthly on specific month and date | `{ month, day, time }` | basic/advanced 모두 필요 |

</details>

<details markdown="1" open>
<summary><strong>구조 필드 설명</strong></summary>

| 필드 | 타입 | 설명 | 유효값 |
|------|------|------|--------|
| `year` | string | 연도 | `"2025"` 형식 |
| `month` | string | 월 | `"1"` ~ `"12"` (복수: `"1,6,12"`) |
| `week` | string | 주차 | `"1"` ~ `"5"` (복수: `"1,3"`) |
| `day` | string | 요일(type 4,5,7,8,10) 또는 날짜(type 0,6,9,11) | 요일: `"0"`(일) ~ `"6"`(토), 날짜: `"1"` ~ `"31"` (복수: `"1,2,3"`) |
| `time` | string | 시간 | `"HH:MM"` 형식 (예: `"10:00"`) |
| `interval.minute` | string | 분 간격 | `"1"` ~ `"59"` |
| `interval.hour` | string | 시간 간격 | `"1"` ~ `"23"` |

</details>

<details markdown="1">
<summary><strong>타입별 상세 예시</strong></summary>

**Type 0: once (일회성)**
```json
{
  "type": 0,
  "basic": {
    "year": "2025",
    "month": "6",
    "day": "15",
    "time": "14:30"
  }
}
```

**Type 1: every minute (분 간격)**
```json
{
  "type": 1,
  "basic": {
    "time": "09:00",
    "interval": {
      "minute": "30"
    }
  }
}
```

**Type 2: hourly (시간 간격)**
```json
{
  "type": 2,
  "basic": {
    "time": "00:00",
    "interval": {
      "hour": "6"
    }
  }
}
```

**Type 3: daily (매일)**
```json
{
  "type": 3,
  "basic": {
    "time": "10:00"
  }
}
```

**Type 4: weekly (매주)**
```json
{
  "type": 4,
  "basic": {
    "day": "1,3,5",
    "time": "09:00"
  }
}
```
> day 값: 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)

**Type 5: monthly on specific week (매월 특정 주)**
```json
{
  "type": 5,
  "basic": {
    "week": "1",
    "day": "1",
    "time": "10:00"
  }
}
```
> 매월 첫째 주 월요일 10시

**Type 6: monthly on specific day (매월 특정 일)**
```json
{
  "type": 6,
  "basic": {
    "day": "1,15",
    "time": "10:00"
  }
}
```
> 매월 1일, 15일 10시

**Type 7: smart weekly on specific day**
```json
{
  "type": 7,
  "basic": {
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "day": "2,3,4,5",
    "time": "12:00"
  }
}
```
> basic: 매주 월요일 10시 (Full 백업)
> advanced: 매주 화~금 12시 (Increment 백업)

**Type 8: smart monthly on specific week and day**
```json
{
  "type": 8,
  "basic": {
    "week": "1",
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "week": "2,3,4",
    "day": "1",
    "time": "12:00"
  }
}
```
> basic: 매월 첫째 주 월요일 10시 (Full 백업)
> advanced: 매월 2~4째 주 월요일 12시 (Increment 백업)

**Type 9: smart monthly on specific date**
```json
{
  "type": 9,
  "basic": {
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "day": "8,15,22",
    "time": "12:00"
  }
}
```
> basic: 매월 1일 10시 (Full 백업)
> advanced: 매월 8일, 15일, 22일 12시 (Increment 백업)

**Type 10: smart custom monthly on specific month, week and day**
```json
{
  "type": 10,
  "basic": {
    "month": "1,4,7,10",
    "week": "1",
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "month": "2,3,5,6,8,9,11,12",
    "week": "1",
    "day": "1",
    "time": "12:00"
  }
}
```
> basic: 1,4,7,10월 첫째 주 월요일 10시 (Full 백업)
> advanced: 나머지 월 첫째 주 월요일 12시 (Increment 백업)

**Type 11: smart custom monthly on specific month and date**
```json
{
  "type": 11,
  "basic": {
    "month": "1,7",
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "month": "2,3,4,5,6,8,9,10,11,12",
    "day": "1",
    "time": "12:00"
  }
}
```
> basic: 1월, 7월 1일 10시 (Full 백업)
> advanced: 나머지 월 1일 12시 (Increment 백업)

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**일반 스케줄 등록 성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": "daily",
      "state": "enabled",
      "description": "Every day at 10:00"
    }
  },
  "message": "Schedule registered successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**Smart 스케줄 등록 성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": "smart weekly on specific day",
      "state": "enabled",
      "description": "Every Monday at 10:00 (Full)"
    },
    "advanced": {
      "id": "2",
      "type": "smart weekly on specific day",
      "state": "enabled",
      "description": "Every Tuesday, Wednesday, Thursday, Friday at 12:00 (Increment)"
    }
  },
  "message": "Schedule registered successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `basic.id` | string | 기본 스케줄 ID |
| `basic.type` | string | 스케줄 타입 |
| `basic.state` | string | 활성화 상태 |
| `basic.description` | string | 스케줄 설명 |
| `advanced.id` | string | 고급 스케줄 ID (Smart 스케줄만) |
| `advanced.type` | string | 스케줄 타입 (Smart 스케줄만) |
| `advanced.state` | string | 활성화 상태 (Smart 스케줄만) |
| `advanced.description` | string | 스케줄 설명 (Smart 스케줄만) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "유효한 스케줄 타입이 아닙니다. (0 ~ 11 만 가능)"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "CENTER_NOT_FOUND",
    "message": "ID가 '999'인 Center를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
