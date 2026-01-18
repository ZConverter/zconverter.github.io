---
layout: docs
title: Schedule 개요
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

스케줄 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [스케줄 타입별 구조 및 설명](#스케줄-타입별-구조-및-설명)
- [구조 필드 설명](#구조-필드-설명)
- [Smart 스케줄 basic 필드 제한사항](#smart-스케줄-basic-필드-제한사항)
- [타입별 상세 예시](#타입별-상세-예시)

</details>

---

## 스케줄 타입별 구조 및 설명

<details markdown="1" open>
<summary><strong>타입별 basic/advanced 구조</strong></summary>

| Type | 이름 | basic 구조 | 비고 |
|------|------|------------|------|
{% for item in site.data.zdm.api.v1_0_3.schedule-types -%}
| {{ item.type }} | {{ item.name }} | `{{ item.basic }}` | {% if item.smart %}- basic/advanced 모두 필요<br> - {% endif %}{{ item.desc }} |
{% endfor %}

</details>

---

## 구조 필드 설명

<details markdown="1" open>
<summary><strong>필드 상세</strong></summary>

| 필드 | 타입 | 설명 | 유효값 |
|------|------|------|--------|
| `year` | string | 연도 | `"2026"` 형식 |
| `month` | string | 월 | `"1"` ~ `"12"` (복수: `"1,6,12"`) |
| `week` | string | 주차 | `"1"` ~ `"5"` (복수: `"1,3"`) |
| `day` | string | 요일(type 4,5,7,8,10) 또는 날짜(type 0,6,9,11) | 요일: `"mon"`, `"tue"`, `"wed"`, `"thu"`, `"fri"`, `"sat"`, `"sun"` (복수: `"mon, tue, wed"`), 날짜: `"1"` ~ `"31"` (복수: `"1,15,20"`) |
| `time` | string | 시간 | `"HH:mm"` 형식 (`"00:00"` ~ `"23:59"`) |
| `interval.minute` | string | 분 간격 | `"1" 이상` |
| `interval.hour` | string | 시간 간격 | `"1" 이상` |

</details>

---

## Smart 스케줄 basic 필드 제한사항

<details markdown="1" open>
<summary><strong>basic 필드 복수 선택 제한</strong></summary>

Smart 스케줄 (type 7~11)의 **basic** 부분에서는 각 필드에 **단일 값**만 허용됩니다.
**advanced** 부분에서는 복수 선택이 가능합니다.

| Type | basic 제한사항 |
|------|---------------|
| 7 | `day`: 단일 요일만 선택 가능 |
| 8 | `week`: 단일 주차만, `day`: 단일 요일만 선택 가능 |
| 9 | `day`: 단일 날짜만 선택 가능 |
| 10 | `month`: 단일 월만, `week`: 단일 주차만, `day`: 단일 요일만 선택 가능 |
| 11 | `month`: 단일 월만, `day`: 단일 날짜만 선택 가능 |

**에러 예시 (type 7에서 basic.day에 복수 요일 입력시):**
```json
{
  "success": false,
  "error": "Smart Weekly (Specific Day of the Week) 타입의 스케줄은 basic 부분에서 여러 요일을 선택할 수 없습니다. ( 현재 선택된 요일: mon, tue )"
}
```

</details>

---

## 타입별 상세 예시

{% assign schedule_types = site.data.zdm.api.v1_0_3.schedule-types %}

<details markdown="1" open>
<summary><strong>Type 0 ~ 6: 일반 스케줄</strong></summary>

<details markdown="1">
<summary><strong>Type 0 - {{ schedule_types[0].desc }}</strong></summary>

- 2026년 1월 20일 14:30에 한번 실행

```json
{
  "center": "6",
  "type": 0,
  "basic": {
    "year": "2026",
    "month": "01",
    "day": "20",
    "time": "14:30"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 1 - {{ schedule_types[1].desc }}</strong></summary>

- 00:00부터 5분 마다 실행

```json
{
  "center": "6",
  "type": 1,
  "basic": {
    "time": "00:00",
    "interval": {
      "minute": "5"
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 2 - {{ schedule_types[2].desc }}</strong></summary>

- 00:30부터 2시간 마다 실행

```json
{
  "center": "6",
  "type": 2,
  "basic": {
    "time": "00:30",
    "interval": {
      "hour": "2"
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 3 - {{ schedule_types[3].desc }}</strong></summary>

- 매일 03:00에 실행

```json
{
  "center": "6",
  "type": 3,
  "basic": {
    "time": "03:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 4 - {{ schedule_types[4].desc }}</strong></summary>

- 매주 월요일, 화요일 02:00에 실행

```json
{
  "center": "6",
  "type": 4,
  "basic": {
    "day": "mon, tue",
    "time": "02:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 5 - {{ schedule_types[5].desc }}</strong></summary>

- 매월 둘째 주 화요일, 수요일 04:00에 실행

```json
{
  "center": "6",
  "type": 5,
  "basic": {
    "week": "2",
    "day": "tue, wed",
    "time": "04:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 6 - {{ schedule_types[6].desc }}</strong></summary>

- 매월 15일, 20일 05:00에 실행

```json
{
  "center": "6",
  "type": 6,
  "basic": {
    "day": "15, 20",
    "time": "05:00"
  }
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>Type 7 ~ 11: Smart 스케줄</strong></summary>

> Smart 스케줄은 `basic`과 `advanced` 모두 필요합니다.
> - `basic`: Full 백업 스케줄 (**단일 값만 허용**)
> - `advanced`: Increment 백업 스케줄 (복수 값 허용)

<details markdown="1">
<summary><strong>Type 7 - {{ schedule_types[7].desc }}</strong></summary>

- `basic`: 매주 월요일 01:00에 실행 (Full 백업) - 단일 요일만 가능
- `advanced`: 매주 화요일, 금요일 13:00에 실행 (Increment 백업)

```json
{
  "center": "6",
  "type": 7,
  "basic": {
    "day": "mon",
    "time": "01:00"
  },
  "advanced": {
    "day": "tue, fri",
    "time": "13:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 8 - {{ schedule_types[8].desc }}</strong></summary>

- `basic`: 매월 첫째 주 월요일 02:00에 실행 (Full 백업) - 단일 주/요일만 가능
- `advanced`: 매월 2, 3째 주 월요일, 목요일 14:00에 실행 (Increment 백업)

```json
{
  "center": "6",
  "type": 8,
  "basic": {
    "week": "1",
    "day": "mon",
    "time": "02:00"
  },
  "advanced": {
    "week": "2, 3",
    "day": "mon, thu",
    "time": "14:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 9 - {{ schedule_types[9].desc }}</strong></summary>

- `basic`: 매월 1일 03:00에 실행 (Full 백업) - 단일 날짜만 가능
- `advanced`: 매월 15일, 19일 15:00에 실행 (Increment 백업)

```json
{
  "center": "6",
  "type": 9,
  "basic": {
    "day": "1",
    "time": "03:00"
  },
  "advanced": {
    "day": "15, 19",
    "time": "15:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 10 - {{ schedule_types[10].desc }}</strong></summary>

- `basic`: 1월 첫째 주 월요일 04:00에 실행 (Full 백업) - 단일 월/주/요일만 가능
- `advanced`: 1, 4, 7, 10월 2, 4째 주 수요일, 금요일 16:00에 실행 (Increment 백업)

```json
{
  "center": "6",
  "type": 10,
  "basic": {
    "month": "1",
    "week": "1",
    "day": "mon",
    "time": "04:00"
  },
  "advanced": {
    "month": "1,4,7,10",
    "week": "2,4",
    "day": "wed, fri",
    "time": "16:00"
  }
}
```

</details>

<details markdown="1">
<summary><strong>Type 11 - {{ schedule_types[11].desc }}</strong></summary>

- `basic`: 3월 1일 05:00에 실행 (Full 백업) - 단일 월/날짜만 가능
- `advanced`: 3, 6, 9, 12월 15일, 20일, 25일 17:00에 실행 (Increment 백업)

```json
{
  "center": "6",
  "type": 11,
  "basic": {
    "month": "3",
    "day": "1",
    "time": "05:00"
  },
  "advanced": {
    "month": "3,6,9,12",
    "day": "15,20,25",
    "time": "17:00"
  }
}
```

</details>

</details>

---
