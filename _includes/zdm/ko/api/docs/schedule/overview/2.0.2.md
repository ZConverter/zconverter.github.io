
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

## 예시 모음 (보강)

### 타입별 `basic` 객체 필수 필드 (JSON 골격)

<details markdown="1" open>
<summary><strong>type 0 ~ 11 basic 필드 구성</strong></summary>

각 타입의 `basic` 객체에 **반드시 포함되어야 하는 키**의 골격입니다. 값은 예시이며, 누락 시 zod 스키마에서 `xxx is required` 에러가 발생합니다.

```jsonc
// type 0 (Once) — 단발성 실행
{ "year": "2026", "month": "1", "day": "20", "time": "14:30" }

// type 1 (Every Minute) — 분 간격
{ "time": "00:00", "interval": { "minute": "5" } }

// type 2 (Hourly) — 시간 간격
{ "time": "00:30", "interval": { "hour": "2" } }

// type 3 (Daily) — 매일
{ "time": "03:00" }

// type 4 (Weekly) — 매주 특정 요일 (복수 허용)
{ "day": "mon, tue", "time": "02:00" }

// type 5 (Monthly Week+Day) — 매월 특정 주 + 요일 (복수 허용)
{ "week": "2", "day": "tue, wed", "time": "04:00" }

// type 6 (Monthly on Specific Date) — 매월 특정 날짜 (복수 허용)
{ "day": "15, 20", "time": "05:00" }

// type 7 (Smart Weekly) — 매주 특정 요일 (basic: 단일 요일만)
{ "day": "mon", "time": "01:00" }

// type 8 (Smart Monthly Week+Day) — basic: 단일 주 + 단일 요일
{ "week": "1", "day": "mon", "time": "02:00" }

// type 9 (Smart Monthly Date) — basic: 단일 날짜
{ "day": "1", "time": "03:00" }

// type 10 (Smart Custom Month/Week/Day) — basic: 단일 월/주/요일
{ "month": "1", "week": "1", "day": "mon", "time": "04:00" }

// type 11 (Smart Custom Month/Date) — basic: 단일 월 + 단일 날짜
{ "month": "3", "day": "1", "time": "05:00" }
```

</details>

### Smart 타입 `advanced` 객체 필수 필드 (JSON 골격)

<details markdown="1" open>
<summary><strong>type 7 ~ 11 advanced 필드 구성 (복수 값 허용)</strong></summary>

```jsonc
// type 7 advanced — 복수 요일
{ "day": "tue, fri", "time": "13:00" }

// type 8 advanced — 복수 주 + 복수 요일
{ "week": "2, 3", "day": "mon, thu", "time": "14:00" }

// type 9 advanced — 복수 날짜
{ "day": "15, 19", "time": "15:00" }

// type 10 advanced — 복수 월/주/요일
{ "month": "1,4,7,10", "week": "2,4", "day": "wed, fri", "time": "16:00" }

// type 11 advanced — 복수 월 + 복수 날짜
{ "month": "3,6,9,12", "day": "15,20,25", "time": "17:00" }
```

> `basic`과 `advanced`의 키 구성은 동일합니다. 다만 `advanced`는 위 필드들에 **콤마로 구분된 복수 값**을 허용합니다.

</details>

### 요일 입력 ↔ DB 저장 형식 (binary) 변환

<details markdown="1" open>
<summary><strong>요일 표기 변환 예시</strong></summary>

사용자가 보낸 `day` 필드(요일형, type 4/5/7/8/10)는 `mon,tue,wed,thu,fri,sat,sun` 순서의 7자리 `0|1|...` 패턴으로 저장됩니다 (출력 끝에 `|` 포함).

| 입력 (요청 body의 `day`) | DB 저장(`sDayweek`) | 응답 description 내 표기 |
|--------------------------|----------------------|---------------------------|
| `"mon"`                  | `1\|0\|0\|0\|0\|0\|0\|` | `Monday` |
| `"fri"`                  | `0\|0\|0\|0\|1\|0\|0\|` | `Friday` |
| `"sun"`                  | `0\|0\|0\|0\|0\|0\|1\|` | `Sunday` |
| `"mon, fri"`             | `1\|0\|0\|0\|1\|0\|0\|` | `Monday, Friday` |
| `"tue,wed,thu"` (공백 없음) | `0\|1\|1\|1\|0\|0\|0\|` | `Tuesday, Wednesday, Thursday` |
| `"sat, sun"`             | `0\|0\|0\|0\|0\|1\|1\|` | `Saturday, Sunday` |

> 콤마 주변 공백은 무시됩니다. `"mon, tue"`와 `"mon,tue"`는 동일하게 처리됩니다 (대소문자도 무시 — 내부적으로 `toLowerCase()` 후 trim).

</details>

<details markdown="1">
<summary><strong>날짜·주차·월 binary 변환 예시</strong></summary>

| 필드 | 길이 | 입력 예시 | DB 저장 예시 |
|------|------|-----------|---------------|
| `day` (날짜형, type 0/6/9/11) | 31 슬롯 | `"1"` | `1\|0\|0\|0\|0\|...\|0\|` (31개) |
| `day` (날짜형) | 31 슬롯 | `"15, 20"` | `0\|...\|0\|1\|0\|0\|0\|0\|1\|0\|...\|` (15·20 위치에 1) |
| `week` | 5 슬롯 | `"1"` | `1\|0\|0\|0\|0\|` |
| `week` | 5 슬롯 | `"2, 4"` | `0\|1\|0\|1\|0\|` |
| `month` | 12 슬롯 | `"1,4,7,10"` | `1\|0\|0\|1\|0\|0\|1\|0\|0\|1\|0\|0\|` |

</details>

### 타입별 응답 `description` 매핑

<details markdown="1" open>
<summary><strong>type 별 description 변환 예시 (응답 본문 문구)</strong></summary>

응답의 `description` 필드는 코드에서 type별 영문 템플릿으로 생성되며, `[Basic]`/`[Advanced]` prefix가 붙습니다. Smart 타입은 mode 정보를 등록 시점에 명시 전달합니다.

| type | 예시 입력 | 응답 `description` |
|------|-----------|---------------------|
| 0 | `{year:"2026", month:"01", day:"20", time:"14:30"}` | `[Basic] Start working on 20/01/2026 14:30.` |
| 1 | `{time:"00:00", interval:{minute:"5"}}` | `[Basic] Start working at 00:00 every 5 Minute.` |
| 2 | `{time:"00:30", interval:{hour:"2"}}` | `[Basic] Start working at 00:30 every 2 Hour.` |
| 3 | `{time:"03:00"}` | `[Basic] Start working at 03:00 every day.` |
| 4 | `{day:"mon, tue", time:"02:00"}` | `[Basic] Start working at 02:00 Monday, Tuesday every week.` |
| 5 | `{week:"2", day:"tue, wed", time:"04:00"}` | `[Basic] Start working at 04:00 Second Week / Tuesday, Wednesday every month.` |
| 6 | `{day:"15, 20", time:"05:00"}` | `[Basic] Start working at 05:00 15, 20 every month.` |
| 7 (basic) | `{day:"mon", time:"01:00"}` | `[Basic] Start working every Monday at 01:00` |
| 7 (advanced) | `{day:"tue, fri", time:"13:00"}` | `[Advanced] Start working every Tuesday, Friday at 13:00` |
| 8 (basic) | `{week:"1", day:"mon", time:"02:00"}` | `[Basic] Start working at 02:00 on Monday First Week of every month.` |
| 8 (advanced) | `{week:"2, 3", day:"mon, thu", time:"14:00"}` | `[Advanced] Start working at 14:00 on the Monday, Thursday of the Second Week, Third Week of every month.` |
| 9 (basic) | `{day:"1", time:"03:00"}` | `[Basic] Start working at 03:00 on the 1 of every month.` |
| 9 (advanced) | `{day:"15, 19", time:"15:00"}` | `[Advanced] Start working at 15:00 on the 15, 19 of every month.` |
| 10 (basic) | `{month:"1", week:"1", day:"mon", time:"04:00"}` | `[Basic] Start working at 04:00 on the First Week Monday of January` |
| 10 (advanced) | `{month:"1,4,7,10", week:"2,4", day:"wed, fri", time:"16:00"}` | `[Advanced] Start working at 16:00 on the Second Week, Fourth Week / Wednesday, Friday of January, April, July, October` |
| 11 (basic) | `{month:"3", day:"1", time:"05:00"}` | `[Basic] Start working on March 1 at 05:00` |
| 11 (advanced) | `{month:"3,6,9,12", day:"15,20,25", time:"17:00"}` | `[Advanced] Start working at 17:00 on the 15, 20, 25 of March, June, September, December` |

> 주차 표기는 `1→First`, `2→Second`, `3→Third`, `4→Fourth`, `5→Last`로 변환됩니다. 월 표기는 영문 풀네임(`January` ~ `December`).

</details>

### 요청 ↔ 응답 종합 예시

<details markdown="1" open>
<summary><strong>일반 스케줄 (type 3 — Daily) 등록 요청·응답</strong></summary>

**요청 — `POST /schedules`**

```json
{
  "center": "6",
  "type": 3,
  "basic": {
    "time": "03:00"
  }
}
```

**정상 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": 3,
      "state": 1,
      "description": "[Basic] Start working at 03:00 every day."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>일반 스케줄 (type 5 — Monthly Week + Day) 등록 요청·응답</strong></summary>

**요청**

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

**정상 응답**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "12",
      "type": 5,
      "state": 1,
      "description": "[Basic] Start working at 04:00 Second Week / Tuesday, Wednesday every month."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>Smart 스케줄 (type 7 — Smart Weekly) 등록 요청·응답</strong></summary>

**요청**

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

**정상 응답 (Smart 스케줄: `basic`/`advanced` 모두 반환)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "21",
      "type": 7,
      "state": 1,
      "description": "[Basic] Start working every Monday at 01:00"
    },
    "advanced": {
      "id": "22",
      "type": 7,
      "state": 1,
      "description": "[Advanced] Start working every Tuesday, Friday at 13:00"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>Smart 스케줄 (type 11 — Smart Custom Month + Date) 등록 요청·응답</strong></summary>

**요청**

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

**정상 응답**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "31",
      "type": 11,
      "state": 1,
      "description": "[Basic] Start working on March 1 at 05:00"
    },
    "advanced": {
      "id": "32",
      "type": 11,
      "state": 1,
      "description": "[Advanced] Start working at 17:00 on the 15, 20, 25 of March, June, September, December"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

### 검증 실패 응답 예시

<details markdown="1" open>
<summary><strong>대표 에러 응답 (요청 ↔ 응답)</strong></summary>

**Smart 타입(7)에 basic.day로 복수 요일 입력 (409 Conflict)**

```json
// 요청
{
  "center": "6",
  "type": 7,
  "basic": { "day": "mon, tue", "time": "01:00" },
  "advanced": { "day": "wed, fri", "time": "13:00" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Weekly (Specific Day of the Week) type schedule does not allow multiple weekday selections in basic. (Currently selected weekdays: mon, tue)",
  "timestamp": "2026-05-19 10:30:00"
}
```

**Smart 타입(8)에 basic.week로 복수 주 입력 (409 Conflict)**

```json
// 요청
{
  "center": "6",
  "type": 8,
  "basic": { "week": "1, 2", "day": "mon", "time": "02:00" },
  "advanced": { "week": "3, 4", "day": "mon, thu", "time": "14:00" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Monthly (Specific Week and Day of the Week) type schedule does not allow multiple week selections in basic. (Currently selected weeks: 1, 2)",
  "timestamp": "2026-05-19 10:30:00"
}
```

**Smart 타입(11)에 basic.month로 복수 월 입력 (409 Conflict)**

```json
// 요청
{
  "center": "6",
  "type": 11,
  "basic": { "month": "1, 3", "day": "1", "time": "05:00" },
  "advanced": { "month": "3,6,9,12", "day": "15,20,25", "time": "17:00" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Custom (Specific Month and Date) type schedule does not allow multiple month selections in basic. (Currently selected months: 1, 3)",
  "timestamp": "2026-05-19 10:30:00"
}
```

**type 7에 `time` 필드 누락 (400 Bad Request — zod 스키마 검증 단계)**

```json
// 요청
{
  "center": "6",
  "type": 7,
  "basic": { "day": "mon" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "basic schedule validation failed (type: 7): time: time is required",
  "timestamp": "2026-05-19 10:30:00"
}
```

**type 11에 basic.month 누락 (400 Bad Request — zod 스키마 검증 단계)**

```json
// 요청
{
  "center": "6",
  "type": 11,
  "basic": { "day": "1", "time": "05:00" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "basic schedule validation failed (type: 11): month: month is required",
  "timestamp": "2026-05-19 10:30:00"
}
```

**요일 형식 오류 — 잘못된 요일 표기 (422 Unprocessable Entity)**

```json
// 요청 (type 4, `day`에 `monday` 같은 풀네임 사용)
{
  "center": "6",
  "type": 4,
  "basic": { "day": "monday", "time": "02:00" }
}
```

```json
// 응답
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Invalid day value. (day must be one of: mon, tue, wed, thu, fri, sat, sun)",
  "timestamp": "2026-05-19 10:30:00"
}
```

</details>

---
