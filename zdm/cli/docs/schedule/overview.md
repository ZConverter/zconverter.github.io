---
layout: docs
title: Schedule 개요
section_title: ZDM CLI Documentation
navigation: cli
---

스케줄 기능에 대한 개요입니다.

---

## 스케줄 타입

<details markdown="1" open>
<summary><strong>스케줄 타입 목록</strong></summary>

{% include zdm/schedule-types.md number=true category=true %}

</details>

---

## 스케줄 구조

<details markdown="1" open>
<summary><strong>Basic vs Smart Schedule</strong></summary>

- **Basic Schedule (Type 0~6):** `basic` 객체만 필요
- **Smart Schedule (Type 7~11):** `basic`과 `advanced` 객체 모두 필요

</details>

---

## 스케줄 JSON 예시

### Basic Schedule (Type 0~6)

<details markdown="1">
<summary><strong>(0) Once - 한 번 실행</strong></summary>

2025/04/29 12:00 한번 실행

```json
{
  "center": 6,
  "type": 0,
  "basic": {
    "year": 2025,
    "month": 4,
    "week": "",
    "day": "29",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(1) Every Minute - 매분 실행</strong></summary>

12:00 부터 5분마다 실행

```json
{
  "center": 6,
  "type": 1,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": "5"
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(2) Hourly - 매시간 실행</strong></summary>

12:00 부터 1시간마다 실행

```json
{
  "center": 6,
  "type": 2,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "",
    "time": "12:00",
    "interval": {
      "hour": "1",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(3) Daily - 매일 실행</strong></summary>

매일 12:00 실행

```json
{
  "center": 6,
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

</details>

<details markdown="1">
<summary><strong>(4) Weekly - 매주 실행</strong></summary>

매주 화요일 12:00 실행 (요일 복수선택 가능)

```json
{
  "center": 6,
  "type": 4,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "tue",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(5) Monthly on Specific Week - 매월 특정 주</strong></summary>

매달 1,3주 수요일 12:00 실행 (주 복수선택 가능)

```json
{
  "center": 6,
  "type": 5,
  "basic": {
    "year": "",
    "month": "",
    "week": "1,3",
    "day": "wed",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(6) Monthly on Specific Day - 매월 특정 일</strong></summary>

매달 10, 20일 12:00 실행 (날짜 복수선택 가능)

```json
{
  "center": 6,
  "type": 6,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "10, 20",
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

### Smart Schedule (Type 7~11)

<details markdown="1">
<summary><strong>(7) Smart Weekly By Weekday</strong></summary>

- **basic:** 매주 수요일 12:00 실행 (요일 복수선택 불가)
- **advanced:** 매주 월, 목, 금요일 12:00 실행 (요일 복수선택 가능)

```json
{
  "center": 6,
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
    "day": "mon, thu, fri",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(8) Smart Monthly By Week And Weekday</strong></summary>

- **basic:** 매달 2째주 월요일 12:00 실행 (주 복수선택 불가, 요일 복수선택 불가)
- **advanced:** 매달 1,3째주 화,목 12:00 실행 (주 복수선택 가능, 요일 복수선택 가능)

```json
{
  "center": 6,
  "type": 8,
  "basic": {
    "year": "",
    "month": "",
    "week": "2",
    "day": "mon",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  },
  "advanced": {
    "year": "",
    "month": "",
    "week": "1,3",
    "day": "tue, thu",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(9) Smart Monthly By Date</strong></summary>

- **basic:** 매달 15일 12:00 실행 (날짜 복수선택 불가)
- **advanced:** 매달 2, 25일 12:00 실행 (날짜 복수선택 가능)

```json
{
  "center": 6,
  "type": 9,
  "basic": {
    "year": "",
    "month": "",
    "week": "",
    "day": "15",
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
    "day": "2, 25",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(10) Smart Custom Monthly By Week And Day</strong></summary>

- **basic:** 매년 5월 2째주 토요일 12:00 실행 (월 복수선택 불가, 주 복수선택 불가,요일 복수선택 불가)
- **advanced:** 매년 1,6월 2,4째주 수, 일요일 12:00 실행 (월 복수선택 가능, 주 복수선택 가능,요일 복수선택 가능)

```json
{
  "center": 6,
  "type": 10,
  "basic": {
    "year": "",
    "month": "5",
    "week": "2",
    "day": "sat",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  },
  "advanced": {
    "year": "",
    "month": "1,6",
    "week": "2,4",
    "day": "wed, sun",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>(11) Smart Custom Monthly By Date</strong></summary>

- **basic:** 매년 4월 19일 12:00 실행 (월 복수선택 불가, 일 복수선택 불가)
- **advanced:** 매년 10, 11월 25, 28일 12:00 실행 (월 복수선택 가능, 일 복수선택 가능)

```json
{
  "center": 6,
  "type": 11,
  "basic": {
    "year": "",
    "month": "4",
    "week": "",
    "day": "19",
    "time": "12:00",
    "interval": {
      "hour": "",
      "minute": ""
    }
  },
  "advanced": {
    "year": "",
    "month": "10, 11",
    "week": "",
    "day": "25, 28",
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
