{% include zdm/base-path.html %}

스케줄 객체의 구조와 필드 규칙을 설명하는 레퍼런스입니다. 백업·복구·복제·OS 복제 작업의 `schedule` 필드와 `POST /schedules` 요청 본문은 모두 이 구조를 따릅니다.

- 스케줄을 단독으로 등록하는 방법은 [POST /schedules]({{ base_path }}/docs/schedule/regist)를 참고하세요.
- `type` 은 숫자(`0`~`11`)로 지정합니다.

---

## 스케줄 타입별 구조 및 설명

<details markdown="1" open>
<summary><strong>타입별 basic/advanced 구조</strong></summary>

| Type | 이름 | basic 구조 | 비고 |
|------|------|------------|------|
{% for item in site.data.zdm.common.enums.schedule-types -%}
| {{ item.number }} | {{ item.value }} | `{{ item.basic }}` | {% if item.category == "Smart" %}- basic/advanced 모두 필요<br> - {% endif %}{{ item.description }} |
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
| `interval.minute` | string | 분 간격 (type 1) | 숫자 문자열 (예: `"5"`) |
| `interval.hour` | string | 시간 간격 (type 2) | 숫자 문자열 (예: `"2"`) |

값은 모두 문자열로 보냅니다. 숫자(`2026`)로 보내면 검증 단계에서 거부됩니다.

</details>

---

## 스케줄 객체의 구성

<details markdown="1" open>
<summary><strong>type / basic / advanced</strong></summary>

| 필드 | 설명 |
|------|------|
| `type` | 스케줄 타입 번호 (`0`~`11`) |
| `basic` | 기본 스케줄. 스케줄 객체 또는 기존 스케줄 ID. 모든 타입에서 필요 |
| `advanced` | 추가 스케줄. Smart 타입(`7`~`11`)에서만 사용하며 이 경우 `basic` 과 함께 필요 |

- 일반 스케줄(type `0`~`6`)은 `basic` 만 사용합니다. Full·Increment 작업에 쓰입니다.
- Smart 스케줄(type `7`~`11`)에서 `basic` 은 Full 백업, `advanced` 는 Increment 백업 일정입니다. Smart 는 백업 작업(`smart` 모드)에서만 사용할 수 있습니다.
- 복구·복제·OS 복제 작업은 일반 스케줄(type `0`~`6`)만 받습니다.

</details>

---

## 숫자 ID 로 지정할 때 도메인별 처리

<details markdown="1" open>
<summary><strong>도메인별 처리 표</strong></summary>

작업 등록·수정 요청의 `schedule` 에 이미 등록된 스케줄의 ID(숫자)를 넣을 수 있습니다. 처리 방식은 작업 종류에 따라 다릅니다.

| 작업 | `schedule: <ID>` (최상위 숫자) | 객체 안 `basic` / `advanced` 자리의 숫자 |
|------|------|------|
| 백업 (등록·수정) | 그 스케줄을 **복사**해 새 스케줄 ID 로 작업에 연결합니다. 응답의 스케줄 ID 는 입력한 ID 와 다릅니다 | 그 스케줄 내용을 복사해 사용합니다 |
| 복구 (등록·수정) | 복사 없이 그 스케줄을 **참조**합니다. 작업의 스케줄 ID 가 입력한 ID 가 됩니다 | 그 스케줄 내용을 복사해 새 스케줄로 저장합니다 |
| 복제 (등록·수정) | 복사 없이 **참조**합니다 | 복구와 같습니다 |
| OS 복제 (등록·수정) | 복사 없이 **참조**합니다 | 복구와 같습니다 |

- 최상위 숫자 하나는 일반 스케줄(Full·Increment, basic)을 지정할 때 사용합니다.
- Smart 스케줄을 ID 로 지정하려면 객체 형식으로 보냅니다: `{ "type": 7, "basic": <basic 용 스케줄 ID>, "advanced": <advanced 용 스케줄 ID> }`
- 존재하지 않는 ID 는 모든 작업에서 404 `SCHEDULE-ERROR-01` 로 거부됩니다.
- ID 로 지정한 스케줄은 작업의 center 에 속해야 합니다. 등록은 요청 `center`, 수정은 작업이 속한 center 가 기준이며 `nCenterID = 0` 도 하나의 center 로 비교합니다. 다르면 403 `CENTER-ERROR-01` 입니다(`Schedule ID '<id>' does not belong to center <center>`). 최상위 숫자와 객체 안 `basic` / `advanced` 자리의 숫자 모두 해당합니다.
- 객체 안 `basic` / `advanced` 자리의 숫자는 그 행의 type 이 요청 `type` 과 같아야 합니다. 다르면 400 `JOB-ERROR-108` 입니다(`Schedule ID '<id>' is type <n>, but the request type is <m>.`). 참조할 행의 type 은 `GET /schedules/<id>` 로 확인하세요.
- 검사 순서는 존재(404 `SCHEDULE-ERROR-01`) → center(403 `CENTER-ERROR-01`) → type(400 `JOB-ERROR-108`) → Smart 자리(400 `JOB-ERROR-108`)입니다.

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
  "error": {
    "code": "SCHEDULE-ERROR-23",
    "message": "Smart Weekly (Specific Day of the Week) type schedule does not allow multiple weekday selections in basic. (Currently selected weekdays: mon, tue)"
  }
}
```

</details>


---

## 타입별 요청 예시 (type 0 ~ 11)

각 예시는 `POST /schedules` 요청 본문입니다. 작업 등록·수정의 `schedule` 객체에서는 `center` 를 빼고 같은 `type`/`basic`/`advanced` 구성을 씁니다.

{% assign schedule_types = site.data.zdm.common.enums.schedule-types %}

<details markdown="1" open>
<summary><strong>Type 0 ~ 6: 일반 스케줄</strong></summary>

<details markdown="1">
<summary><strong>Type 0 - {{ schedule_types[0].description }}</strong></summary>

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
<summary><strong>Type 1 - {{ schedule_types[1].description }}</strong></summary>

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
<summary><strong>Type 2 - {{ schedule_types[2].description }}</strong></summary>

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
<summary><strong>Type 3 - {{ schedule_types[3].description }}</strong></summary>

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
<summary><strong>Type 4 - {{ schedule_types[4].description }}</strong></summary>

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
<summary><strong>Type 5 - {{ schedule_types[5].description }}</strong></summary>

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
<summary><strong>Type 6 - {{ schedule_types[6].description }}</strong></summary>

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
<summary><strong>Type 7 - {{ schedule_types[7].description }}</strong></summary>

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
<summary><strong>Type 8 - {{ schedule_types[8].description }}</strong></summary>

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
<summary><strong>Type 9 - {{ schedule_types[9].description }}</strong></summary>

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
<summary><strong>Type 10 - {{ schedule_types[10].description }}</strong></summary>

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
<summary><strong>Type 11 - {{ schedule_types[11].description }}</strong></summary>

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

## 예시 모음

### 요일 입력 ↔ DB 저장 형식 (binary) 변환

<details markdown="1" open>
<summary><strong>요일 표기 변환 예시</strong></summary>

사용자가 보낸 `day` 필드(요일형, type 4/5/7/8/10)는 `mon,tue,wed,thu,fri,sat,sun` 순서의 7자리 `0|1|...` 패턴으로 저장됩니다 (끝에 `|` 포함).

| 입력 (요청 body의 `day`) | 저장 형식 | 응답 description 내 표기 |
|--------------------------|----------------------|---------------------------|
| `"mon"`                  | `1\|0\|0\|0\|0\|0\|0\|` | `Monday` |
| `"fri"`                  | `0\|0\|0\|0\|1\|0\|0\|` | `Friday` |
| `"sun"`                  | `0\|0\|0\|0\|0\|0\|1\|` | `Sunday` |
| `"mon, fri"`             | `1\|0\|0\|0\|1\|0\|0\|` | `Monday, Friday` |
| `"tue,wed,thu"` (공백 없음) | `0\|1\|1\|1\|0\|0\|0\|` | `Tuesday, Wednesday, Thursday` |
| `"sat, sun"`             | `0\|0\|0\|0\|0\|1\|1\|` | `Saturday, Sunday` |

> 콤마 주변 공백은 무시됩니다. `"mon, tue"`와 `"mon,tue"`는 동일하게 처리됩니다 (대소문자도 구분하지 않습니다).

</details>

<details markdown="1">
<summary><strong>날짜·주차·월 binary 변환 예시</strong></summary>

| 필드 | 길이 | 입력 예시 | 저장 예시 |
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

응답의 `description` 필드는 서버가 type 별 영문 문구로 생성하며 `[Basic]`/`[Advanced]` 접두어가 붙습니다.

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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-23",
    "message": "Smart Weekly (Specific Day of the Week) type schedule does not allow multiple weekday selections in basic. (Currently selected weekdays: mon, tue)"
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-27",
    "message": "Smart Monthly (Specific Week and Day of the Week) type schedule does not allow multiple week selections in basic. (Currently selected weeks: 1, 2)"
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-31",
    "message": "Smart Custom (Specific Month and Date) type schedule does not allow multiple month selections in basic. (Currently selected months: 1, 3)"
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**type 7에 `time` 필드 누락 (422 Unprocessable Entity — 요청 형식 검증 단계)**

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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "basic": ["basic schedule validation failed (type: 7): time: time is required"]
    }
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**type 11에 basic.month 누락 (422 Unprocessable Entity — 요청 형식 검증 단계)**

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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "basic": ["basic schedule validation failed (type: 11): month: month is required"]
    }
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-22",
    "message": "Invalid day value. (day must be one of: mon, tue, wed, thu, fri, sat, sun)"
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**`type` 범위 초과 (422 Unprocessable Entity)**

```json
// 요청
{
  "center": "6",
  "type": 99,
  "basic": { "time": "10:00" }
}
```

```json
// 응답
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "type": ["invalid schedule type (must be 0 ~ 11)"]
    }
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

**type 11 에 범위를 벗어난 월 (400 Bad Request)**

```json
// 요청
{
  "center": "6",
  "type": 11,
  "basic": { "month": "13", "day": "15", "time": "10:00" },
  "advanced": { "month": "3", "day": "1", "time": "12:00" }
}
```

```json
// 응답
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-30",
    "message": "month must be between 1 and 12."
  },
  "timestamp": "2026-05-19T10:30:00.000+09:00"
}
```

날짜(`day`)가 범위를 벗어나면 `SCHEDULE-ERROR-19`(400), `time` 형식이 `HH:mm` 이 아니면 `SCHEDULE-ERROR-16`(400)이 같은 형식으로 반환됩니다. 월과 일의 조합(예: 2월 30일)은 검사하지 않으며 각 값이 범위 안이면 허용됩니다.

</details>

---
