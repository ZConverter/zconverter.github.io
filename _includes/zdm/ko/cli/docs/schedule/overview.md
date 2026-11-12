{% include zdm/base-path.html %}
스케줄 관리 기능에 대한 개요입니다. 작업(Job)에 연결할 스케줄을 생성, 검증, 등록, 조회, 삭제할 수 있습니다.

필드 형식, 요일·날짜 표기, Smart 스케줄의 `basic` 제한 같은 스케줄 객체의 규칙은 API 문서의 [스케줄 개요](/zdm/ko/api/4.0.0/docs/schedule/overview)와 같습니다. 이 페이지는 CLI 에서 스케줄을 다루는 방법만 설명합니다.

## 하위 명령어

<details markdown="1" open>
<summary><strong>schedule 하위 명령어 목록</strong></summary>

| 명령어 | 설명 |
|--------|------|
| `schedule create` | Schedule 생성 및 자동 등록 |
| `schedule verify` | Schedule JSON 파일 검증 |
| `schedule regist` | Schedule 파일을 ZDM 서버에 등록 |
| `schedule list` | Schedule 목록 조회 |
| `schedule delete` | Schedule 삭제 |

</details>

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
- **Smart Schedule (Type 7~11):** `basic`과 `advanced` 객체 모두 필요. `basic` 에는 단일 값만 넣을 수 있고 `advanced` 에는 복수 값을 넣을 수 있습니다. Smart 스케줄은 Backup 작업(`--mode smart`)에서만 쓸 수 있습니다.

</details>

---

## JSON 작성 규칙

<details markdown="1" open>
<summary><strong>스케줄 JSON 형식</strong></summary>

- `type` 은 숫자(0~11)로 적습니다. 타입 이름 문자열은 입력에 쓰지 않습니다.
- `year`, `month`, `week`, `day`, `time`, `interval.hour`, `interval.minute` 의 값은 모두 **문자열**입니다. `"year": 2026` 처럼 숫자로 적으면 서버가 등록을 거부하므로 `"year": "2026"` 으로 적습니다.
- 타입에 필요한 필드만 적으면 됩니다. 필요 없는 필드는 생략하거나 빈 문자열(`""`)로 둡니다.
- 복수 값은 쉼표로 구분합니다 (예: `"mon, tue"`, `"1,3"`).

</details>

<details markdown="1" open>
<summary><strong>basic 자동 래핑</strong></summary>

`--schedule` 또는 `--schedule-file` 의 JSON 에 `basic` 키가 없으면, CLI 가 `type` 을 제외한 나머지 필드를 `basic` 으로 감싸서 보냅니다. Backup, Recovery, Replication, OS Replication 모두 같습니다.

```json
{ "type": 3, "time": "12:00" }
```

위 입력은 다음과 같이 전송됩니다.

```json
{ "type": 3, "basic": { "time": "12:00" } }
```

- `--schedule-id` 에는 적용되지 않습니다.
- Backup 을 `--mode smart` 로 지정한 경우에는 감싸지 않으므로 `basic` 과 `advanced` 를 직접 적어야 합니다.

</details>

---

## 작업에 스케줄 붙이기

<details markdown="1" open>
<summary><strong>작업별 스케줄 옵션</strong></summary>

작업 등록·수정 명령에서 `--schedule`(JSON 문자열), `--schedule-file`(JSON 파일 경로), `--schedule-id`(이미 등록된 스케줄 ID) 중 **하나만** 지정할 수 있습니다. 둘 이상 지정하면 오류가 납니다.

| 작업 | `--schedule-id` 타입 | 사용할 수 있는 타입 | 숫자 ID 처리 | Smart 입력 시 |
|------|---------------------|--------------------|--------------|---------------|
| [Backup]({{ base_path }}/docs/backup/regist) | string | 0~11 | 복사 (새 ID 로 스케줄 생성) | 허용. `--mode smart` 필요 |
| [Recovery]({{ base_path }}/docs/recovery/regist) | number | 0~6 | 참조 (복사하지 않음) | 거부 (`JOB-ERROR-101`) |
| [Replication]({{ base_path }}/docs/replication/regist) | number | 0~6 | 참조 (복사하지 않음) | 등록 `JOB-ERROR-103`, 수정 `JOB-ERROR-101` |
| [OS Replication]({{ base_path }}/docs/os-replication/regist) | number | 0~6 | 참조 (복사하지 않음) | 등록 `JOB-ERROR-103`, 수정 `JOB-ERROR-101` |

- **복사:** 입력한 ID 의 스케줄 내용을 복사해 새 스케줄을 만들고 작업에 연결합니다. 작업이 쓰는 스케줄 ID 는 입력한 ID 와 다릅니다.
- **참조:** 입력한 ID 의 스케줄을 그대로 작업에 연결합니다. 여러 작업이 같은 스케줄을 공유할 수 있습니다.
- Backup 에서 Smart 스케줄을 ID 로 지정할 때는 `--mode smart` 와 함께 `--schedule-id '{"type":7,"basic":100,"advanced":200}'` 형식의 JSON 을 씁니다. `backup update` 도 `--mode smart` 가 있어야 이 형식으로 동작합니다.
- 존재하지 않는 스케줄 ID 를 지정하면 모든 작업에서 404 `SCHEDULE-ERROR-01` 이 반환됩니다.
- Backup 은 `--mode smart` 일 때 세 옵션 중 하나가 반드시 필요합니다.

작업의 스케줄 처리 규칙과 응답 형식은 API 문서의 [스케줄 개요](/zdm/ko/api/4.0.0/docs/schedule/overview)와 각 작업 페이지를 참고하세요.

</details>

---

## 스케줄 JSON 예시

아래 예시는 `schedule regist` 에 넘기는 파일 형식입니다. 작업의 `--schedule` 옵션에는 `center` 를 빼고 `type` 과 `basic`(Smart 는 `advanced` 포함)만 넣습니다.

### Basic Schedule (Type 0~6)

<details markdown="1">
<summary><strong>(0) Once - 한 번 실행</strong></summary>

2026/01/20 14:30 한 번 실행

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
<summary><strong>(1) Every Minute - 매분 실행</strong></summary>

00:00 부터 5분마다 실행

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
<summary><strong>(2) Hourly - 매시간 실행</strong></summary>

00:30 부터 2시간마다 실행

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
<summary><strong>(3) Daily - 매일 실행</strong></summary>

매일 03:00 실행

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
<summary><strong>(4) Weekly - 매주 실행</strong></summary>

매주 월요일, 화요일 02:00 실행 (요일 복수선택 가능)

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
<summary><strong>(5) Monthly on Specific Week - 매월 특정 주</strong></summary>

매월 둘째 주 화요일, 수요일 04:00 실행 (주·요일 복수선택 가능)

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
<summary><strong>(6) Monthly on Specific Day - 매월 특정 일</strong></summary>

매월 15일, 20일 05:00 실행 (날짜 복수선택 가능)

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

---

### Smart Schedule (Type 7~11)

Smart 스케줄은 `basic`(Full 백업)과 `advanced`(Increment 백업)가 모두 필요하며, `basic` 에는 단일 값만 넣을 수 있습니다.

<details markdown="1">
<summary><strong>(7) Smart Weekly By Weekday</strong></summary>

- **basic:** 매주 월요일 01:00 실행 (요일 복수선택 불가)
- **advanced:** 매주 화요일, 금요일 13:00 실행 (요일 복수선택 가능)

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
<summary><strong>(8) Smart Monthly By Week And Weekday</strong></summary>

- **basic:** 매월 첫째 주 월요일 02:00 실행 (주·요일 복수선택 불가)
- **advanced:** 매월 2, 3째 주 월요일, 목요일 14:00 실행 (주·요일 복수선택 가능)

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
<summary><strong>(9) Smart Monthly By Date</strong></summary>

- **basic:** 매월 1일 03:00 실행 (날짜 복수선택 불가)
- **advanced:** 매월 15일, 19일 15:00 실행 (날짜 복수선택 가능)

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
<summary><strong>(10) Smart Custom Monthly By Week And Day</strong></summary>

- **basic:** 1월 첫째 주 월요일 04:00 실행 (월·주·요일 복수선택 불가)
- **advanced:** 1, 4, 7, 10월 2, 4째 주 수요일, 금요일 16:00 실행 (월·주·요일 복수선택 가능)

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
<summary><strong>(11) Smart Custom Monthly By Date</strong></summary>

- **basic:** 3월 1일 05:00 실행 (월·날짜 복수선택 불가)
- **advanced:** 3, 6, 9, 12월 15일, 20일, 25일 17:00 실행 (월·날짜 복수선택 가능)

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

---
