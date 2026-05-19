
새로운 스케줄을 등록합니다.

---

## `POST /schedules` {#post-schedules}

> * 새로운 스케줄을 시스템에 등록합니다.
> * 스케줄 타입에 따라 다른 구조의 basic/advanced 객체가 필요합니다.
> * Smart 스케줄 (type 7~11)의 경우 basic과 advanced 모두 필요합니다.
> * 스케줄 타입별 구조 및 상세 예시는 [스케줄 개요](../overview)를 참조하세요.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/schedules</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 일반 Daily 스케줄 등록 (center를 문자열로 전달)
curl -X POST "https://api.example.com/api/schedules" \
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

# 일반 Daily 스케줄 등록 (center를 숫자로 전달)
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": 1,
    "user": 5,
    "jobName": "daily-backup",
    "type": 3,
    "basic": {
      "time": "10:00"
    }
  }'

# Smart Weekly 스케줄 등록 (type 7)
# basic.day는 단일 요일만 허용 (복수 선택 불가)
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": 1,
    "jobName": "smart-weekly-backup",
    "type": 7,
    "basic": {
      "day": "mon",
      "time": "10:00"
    },
    "advanced": {
      "day": "tue, wed, thu, fri",
      "time": "12:00"
    }
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string \| number | Required | 센터 ID (숫자) 또는 센터 이름 |
| `user` | string \| number | Optional | 사용자 이메일 또는 사용자 등록 ID (숫자만) |
| `jobName` | string | Optional | 스케줄을 할당할 작업 이름 |
| `type` | number | Required | 스케줄 타입 (0 ~ 11) |
| `basic` | object | Optional | 기본 스케줄 구조 |
| `advanced` | object | Optional | 고급 스케줄 구조 (Smart 스케줄용, backup 작업 전용) |

> 스케줄 타입별 `basic`/`advanced` 구조는 [스케줄 개요](../overview#스케줄-타입별-구조-및-설명)를 참조하세요.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**일반 스케줄 등록 성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": 3,
      "state": 1,
      "description": "[Basic] Start working at 10:00 every day."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

**Smart 스케줄 등록 성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": 7,
      "state": 1,
      "description": "[Basic] Start working every Monday at 10:00"
    },
    "advanced": {
      "id": "2",
      "type": 7,
      "state": 1,
      "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `basic.id` | string | 기본 스케줄 ID |
| `basic.type` | number | 스케줄 타입 (0~11 enum 정수) |
| `basic.state` | number | 활성화 상태 (0=disabled, 1=enabled) |
| `basic.description` | string | 스케줄 설명 |
| `advanced.id` | string | 고급 스케줄 ID (Smart 스케줄만) |
| `advanced.type` | number | 스케줄 타입 (Smart 스케줄만, 0~11 enum 정수) |
| `advanced.state` | number | 활성화 상태 (Smart 스케줄만, 0=disabled, 1=enabled) |
| `advanced.description` | string | 스케줄 설명 (Smart 스케줄만) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "유효한 스케줄 타입이 아닙니다. (0 ~ 11 만 가능)",
  "timestamp": "2025-01-15 10:30:00"
}
```

**basic 스케줄 데이터 누락 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "basic schedule data is required",
  "timestamp": "2026-05-15 10:30:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Center를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**Smart 스케줄 basic 필드 복수 선택 오류 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Weekly (Specific Day of the Week) 타입의 스케줄은 basic 부분에서 여러 요일을 선택할 수 없습니다. ( 현재 선택된 요일: mon, tue )",
  "timestamp": "2025-01-15 10:30:00"
}
```

**시간 형식 오류 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "time은 'HH:mm' (00:00 ~ 23:59)이어야 합니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>타입별 요청/응답 예시 (Type 0 ~ 11)</strong></summary>

각 `type` 값마다 `basic`(및 Smart 타입의 경우 `advanced`)에 필요한 필드가 달라집니다. 아래 예시는 모두 `validateScheduleByType` zod 스키마 및 `ScheduleVerifyService`의 추가 검증을 통과하는 실 사용 가능한 입력입니다. 응답의 `description`은 코드의 `processScheduleInfo()` 출력과 동일합니다. (`schedule-formatter.utils.ts:100-177`)

> 공통 입력 형식
> - 요일(`day` of weekday-based types)은 문자열 `mon`/`tue`/`wed`/`thu`/`fri`/`sat`/`sun` (콤마 구분, 공백 허용). 응답의 `description`에는 영문 풀네임(`Monday`, `Tuesday`, …)으로 표현됩니다.
> - 날짜(`day` of date-based types)는 1~31 범위의 정수를 문자열로 표현(예: `"15"`, `"1,15"`).
> - 주차(`week`)는 1~5 범위(`"1"` ~ `"5"`), 월(`month`)은 1~12 범위(`"1,7,12"` 등) 문자열입니다.

---

**Type 0 — Once (특정 일자에 한 번)**

요청 body:

```json
{
  "center": "1",
  "jobName": "once-backup",
  "type": 0,
  "basic": {
    "year": "2025",
    "month": "12",
    "day": "31",
    "time": "23:30"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "once-backup",
    "type": 0,
    "basic": { "year": "2025", "month": "12", "day": "31", "time": "23:30" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "1",
      "type": 0,
      "state": 1,
      "description": "[Basic] Start working on 31/12/2025 23:30."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 1 — Every Minute (기준 시간부터 N분 주기)**

요청 body:

```json
{
  "center": "1",
  "jobName": "every-5min",
  "type": 1,
  "basic": {
    "time": "10:00",
    "interval": { "minute": "5" }
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "every-5min",
    "type": 1,
    "basic": { "time": "10:00", "interval": { "minute": "5" } }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "2",
      "type": 1,
      "state": 1,
      "description": "[Basic] Start working at 10:00 every 5 Minute."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 2 — Hourly (기준 시간부터 N시간 주기)**

요청 body:

```json
{
  "center": "1",
  "jobName": "hourly-backup",
  "type": 2,
  "basic": {
    "time": "09:00",
    "interval": { "hour": "2" }
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "hourly-backup",
    "type": 2,
    "basic": { "time": "09:00", "interval": { "hour": "2" } }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "3",
      "type": 2,
      "state": 1,
      "description": "[Basic] Start working at 09:00 every 2 Hour."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 3 — Daily (매일 특정 시각)**

요청 body:

```json
{
  "center": "1",
  "jobName": "daily-backup",
  "type": 3,
  "basic": { "time": "10:00" }
}
```

> 동일한 예시가 상단 "요청 예시" 블록에도 있습니다. 응답은 다음과 같습니다.

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "4",
      "type": 3,
      "state": 1,
      "description": "[Basic] Start working at 10:00 every day."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 4 — Weekly (매주 선택 요일)**

요청 body:

```json
{
  "center": "1",
  "jobName": "weekly-backup",
  "type": 4,
  "basic": {
    "day": "mon,tue,wed,thu,fri",
    "time": "10:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "weekly-backup",
    "type": 4,
    "basic": { "day": "mon,tue,wed,thu,fri", "time": "10:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "5",
      "type": 4,
      "state": 1,
      "description": "[Basic] Start working at 10:00 Monday, Tuesday, Wednesday, Thursday, Friday every week."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 5 — Monthly (특정 주차 + 특정 요일)**

요청 body:

```json
{
  "center": "1",
  "jobName": "monthly-by-week",
  "type": 5,
  "basic": {
    "week": "1,3",
    "day": "mon,fri",
    "time": "10:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "monthly-by-week",
    "type": 5,
    "basic": { "week": "1,3", "day": "mon,fri", "time": "10:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "6",
      "type": 5,
      "state": 1,
      "description": "[Basic] Start working at 10:00 First Week, Third Week / Monday, Friday every month."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 6 — Monthly (특정 일자)**

요청 body:

```json
{
  "center": "1",
  "jobName": "monthly-by-date",
  "type": 6,
  "basic": {
    "day": "1,15",
    "time": "10:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "monthly-by-date",
    "type": 6,
    "basic": { "day": "1,15", "time": "10:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "7",
      "type": 6,
      "state": 1,
      "description": "[Basic] Start working at 10:00 1, 15 every month."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 7 — Smart Weekly (basic 단일 요일 / advanced 복수 요일)**

> Smart 스케줄(type 7~11)은 `basic`과 `advanced`가 모두 필요합니다. `basic`의 요일(day)은 **단일 값만** 허용되며, 다중 선택 시 409(SCHEDULE-ERROR-23)가 발생합니다.

요청 body:

```json
{
  "center": "1",
  "jobName": "smart-weekly-backup",
  "type": 7,
  "basic": {
    "day": "mon",
    "time": "10:00"
  },
  "advanced": {
    "day": "tue, wed, thu, fri",
    "time": "12:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-weekly-backup",
    "type": 7,
    "basic": { "day": "mon", "time": "10:00" },
    "advanced": { "day": "tue, wed, thu, fri", "time": "12:00" }
  }'
```

응답 (200 OK) — `SmartScheduleCreateResponseDTO`:

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "8",
      "type": 7,
      "state": 1,
      "description": "[Basic] Start working every Monday at 10:00"
    },
    "advanced": {
      "id": "9",
      "type": 7,
      "state": 1,
      "description": "[Advanced] Start working every Tuesday, Wednesday, Thursday, Friday at 12:00"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 8 — Smart Monthly (특정 주차 + 특정 요일)**

> basic은 주차(`week`)와 요일(`day`) 모두 단일 값만 허용됩니다.

요청 body:

```json
{
  "center": "1",
  "jobName": "smart-monthly-week-day",
  "type": 8,
  "basic": {
    "week": "1",
    "day": "mon",
    "time": "10:00"
  },
  "advanced": {
    "week": "2,4",
    "day": "tue,wed",
    "time": "12:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-monthly-week-day",
    "type": 8,
    "basic": { "week": "1", "day": "mon", "time": "10:00" },
    "advanced": { "week": "2,4", "day": "tue,wed", "time": "12:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "10",
      "type": 8,
      "state": 1,
      "description": "[Basic] Start working at 10:00 on Monday First Week of every month."
    },
    "advanced": {
      "id": "11",
      "type": 8,
      "state": 1,
      "description": "[Advanced] Start working at 12:00 on the Tuesday, Wednesday of the Second Week, Fourth Week of every month."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 9 — Smart Monthly (특정 일자)**

> basic은 일자(`day`)가 단일 값만 허용됩니다.

요청 body:

```json
{
  "center": "1",
  "jobName": "smart-monthly-date",
  "type": 9,
  "basic": {
    "day": "1",
    "time": "10:00"
  },
  "advanced": {
    "day": "10,20,30",
    "time": "12:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-monthly-date",
    "type": 9,
    "basic": { "day": "1", "time": "10:00" },
    "advanced": { "day": "10,20,30", "time": "12:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "12",
      "type": 9,
      "state": 1,
      "description": "[Basic] Start working at 10:00 on the 1 of every month."
    },
    "advanced": {
      "id": "13",
      "type": 9,
      "state": 1,
      "description": "[Advanced] Start working at 12:00 on the 10, 20, 30 of every month."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 10 — Smart Custom (특정 월 + 주차 + 요일)**

> basic은 `month`, `week`, `day` 모두 단일 값만 허용됩니다.

요청 body:

```json
{
  "center": "1",
  "jobName": "smart-custom-month-week-day",
  "type": 10,
  "basic": {
    "month": "1",
    "week": "1",
    "day": "mon",
    "time": "10:00"
  },
  "advanced": {
    "month": "3,6,9,12",
    "week": "1,3",
    "day": "tue,thu",
    "time": "12:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-custom-month-week-day",
    "type": 10,
    "basic": { "month": "1", "week": "1", "day": "mon", "time": "10:00" },
    "advanced": { "month": "3,6,9,12", "week": "1,3", "day": "tue,thu", "time": "12:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "14",
      "type": 10,
      "state": 1,
      "description": "[Basic] Start working at 10:00 on the First Week Monday of January"
    },
    "advanced": {
      "id": "15",
      "type": 10,
      "state": 1,
      "description": "[Advanced] Start working at 12:00 on the First Week, Third Week / Tuesday, Thursday of March, June, September, December"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

---

**Type 11 — Smart Custom (특정 월 + 일자)**

> basic은 `month`와 `day` 모두 단일 값만 허용됩니다. (월·일 순서 자체에 대한 별도 검증 로직은 존재하지 않으며, 각 값은 1~12 / 1~31 범위 안이면 모두 허용됩니다.)

요청 body:

```json
{
  "center": "1",
  "jobName": "smart-custom-month-date",
  "type": 11,
  "basic": {
    "month": "6",
    "day": "15",
    "time": "10:00"
  },
  "advanced": {
    "month": "3,9",
    "day": "1,15,30",
    "time": "12:00"
  }
}
```

curl 예시:

```bash
curl -X POST "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "jobName": "smart-custom-month-date",
    "type": 11,
    "basic": { "month": "6", "day": "15", "time": "10:00" },
    "advanced": { "month": "3,9", "day": "1,15,30", "time": "12:00" }
  }'
```

응답 (200 OK):

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "basic": {
      "id": "16",
      "type": 11,
      "state": 1,
      "description": "[Basic] Start working on June 15 at 10:00"
    },
    "advanced": {
      "id": "17",
      "type": 11,
      "state": 1,
      "description": "[Advanced] Start working at 12:00 on the 1, 15, 30 of March, September"
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>추가 검증 실패 예시 (분기별)</strong></summary>

아래 예시는 코드 경로별 실제 응답을 반영합니다. (`Request body validation failed.` 케이스에는 `detail.validationErrors`가 함께 반환되며, 각 항목의 key는 점(`.`) 구분자로 정규화된 zod path입니다.)

---

**1) `basic` 누락 (400 Bad Request, SCHEDULE-ERROR-02)**

요청 body (예: type 3 Daily인데 basic 자체 누락):

```json
{
  "center": "1",
  "type": 3
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "basic schedule data is required",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 코드 위치: `schedule-regist.service.ts:154-160`. zod 자체는 `basic`이 옵셔널이지만 서비스 가드에서 throw.

---

**2) Smart 스케줄(type 7~11)에 `advanced` 누락 (400 Bad Request, SCHEDULE-ERROR-02)**

요청 body:

```json
{
  "center": "1",
  "type": 7,
  "basic": { "day": "mon", "time": "10:00" }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Schedule requires advanced data.",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 코드 위치: `schedule-regist.service.ts:181-186`.

---

**3) Smart 스케줄 basic에 다중 요일 사용 (409 Conflict, SCHEDULE-ERROR-23)**

요청 body (type 7 basic에 두 요일 지정):

```json
{
  "center": "1",
  "type": 7,
  "basic": { "day": "mon,tue", "time": "10:00" },
  "advanced": { "day": "wed,thu", "time": "12:00" }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Smart Weekly (Specific Day of the Week) type schedule does not allow multiple weekday selections in basic. (Currently selected weekdays: Monday, Tuesday)",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 코드 위치: `schedule-verify.service.ts:908-920` (`validateDayWeek` multiple=false). 출력의 요일 이름은 `formatDayWeekFromBinary`가 영문 풀네임(`Monday`, `Tuesday`, …)으로 변환합니다.

---

**4) Type 7에서 `time` 누락 (422 Unprocessable Entity, DTO-VALIDATION-01)**

요청 body:

```json
{
  "center": "1",
  "type": 7,
  "basic": { "day": "mon" },
  "advanced": { "day": "tue,wed", "time": "12:00" }
}
```

응답 (zod 단계에서 차단 → `Request body validation failed.` + `detail.validationErrors`):

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed.",
  "timestamp": "2025-01-15 10:30:00",
  "detail": {
    "validationErrors": {
      "basic": ["basic schedule validation failed (type: 7): time: time is required"]
    }
  }
}
```

> 코드 위치: zod 미들웨어(`src/middlewares/validation/zod-validation.middleware.ts:43-51`) + `scheduleRegistBodySchema.superRefine`(`schedule-regist-body.schema.ts:39-53`)에서 type별 schema(`smartWeeklyByWeekdaySchema`) 검증 실패가 issue로 들어감.
> 참고: `time` 형식 자체가 잘못된 경우(예: `"25:99"`)는 zod의 `min(1)`만 통과하므로 서비스 단계의 400 `SCHEDULE-ERROR-16`(`time must be in 'HH:mm' format (00:00 ~ 23:59).`)으로 처리됩니다.

---

**5) Type 11 `month` / `day` 범위 위반 (400 Bad Request)**

> 본 엔드포인트는 코드상 `month`와 `day`의 **순서 (예: month=1 + day=31에 대한 31일 존재 여부)** 검증을 따로 하지 않습니다. 다만 각 값의 범위는 검증합니다.

요청 body (month=13 — 1~12 범위 초과):

```json
{
  "center": "1",
  "type": 11,
  "basic": { "month": "13", "day": "15", "time": "10:00" },
  "advanced": { "month": "3", "day": "1", "time": "12:00" }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "month must be between 1 and 12.",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 코드 위치: `schedule-verify.service.ts:683-701`(`validateMonthCondition` → `MONTH_OUT_OF_RANGE` 400, SCHEDULE-ERROR-30). `day`가 32 이상이면 `DAY_OUT_OF_RANGE`(400, SCHEDULE-ERROR-19)가 동일 형식으로 반환됩니다.

---

**6) DTO 검증 실패 — `type` 범위 초과 (422 Unprocessable Entity, DTO-VALIDATION-01)**

요청 body:

```json
{
  "center": "1",
  "type": 99,
  "basic": { "time": "10:00" }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Request body validation failed.",
  "timestamp": "2025-01-15 10:30:00",
  "detail": {
    "validationErrors": {
      "type": ["invalid schedule type (must be 0 ~ 11)"]
    }
  }
}
```

> 코드 위치: `schedule-regist-body.schema.ts:32` (`z.coerce.number().int().min(0).max(11)`).

---

**7) Center NOT_FOUND (404 Not Found, ZDM-ERROR-01)**

요청 body (`center`가 시스템에 없는 ID):

```json
{
  "center": "999",
  "type": 3,
  "basic": { "time": "10:00" }
}
```

응답:

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Zdm with ID '999' not found",
  "timestamp": "2025-01-15 10:30:00"
}
```

> 코드 위치: `src/domain/zdm/services/zdm-get.service.ts:357` — `customMessage: "Zdm with ID '${value}' not found"`. 메시지는 영문이며 도메인 명칭은 `Zdm`입니다.

---

**8) 요일 형식 일관성 확인 — 요청은 `mon`/`tue` 문자열, 응답은 영문 풀네임**

요청 body (Weekly, type 4 — 요청은 `"mon,tue,wed,thu,fri"`):

```json
{
  "center": "1",
  "type": 4,
  "basic": { "day": "mon,tue,wed,thu,fri", "time": "10:00" }
}
```

응답의 `description`(영문 풀네임으로 일관 표기):

```text
[Basic] Start working at 10:00 Monday, Tuesday, Wednesday, Thursday, Friday every week.
```

> 변환 규칙: `dayWeekProcessing()`(`schedule-binary.utils.ts:47-71`)이 요일 약자를 binary 패턴(`0|1|0|...`)으로 변환 → `parseWeekdayPattern()`(`schedule-formatter.utils.ts:13-26`)이 binary를 다시 영문 풀네임으로 복원하여 description에 표기.

</details>

---
