---
layout: docs
title: Schedule 개요
section_title: ZDM API Documentation
navigation: api-1.0.3
---

스케줄 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [스케줄 타입별 구조](#스케줄-타입별-구조)
- [구조 필드 설명](#구조-필드-설명)
- [타입별 상세 예시](#타입별-상세-예시)

</details>

---

## 스케줄 타입별 구조

<details markdown="1" open>
<summary><strong>타입별 basic/advanced 구조</strong></summary>

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

---

## 구조 필드 설명

<details markdown="1" open>
<summary><strong>필드 상세</strong></summary>

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

---

## 타입별 상세 예시

<details markdown="1" open>
<summary><strong>Type 0 ~ 6: 일반 스케줄</strong></summary>

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

</details>

<details markdown="1" open>
<summary><strong>Type 7 ~ 11: Smart 스케줄</strong></summary>

> Smart 스케줄은 `basic`과 `advanced` 모두 필요합니다.
> - `basic`: Full 백업 스케줄
> - `advanced`: Increment 백업 스케줄

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

---
