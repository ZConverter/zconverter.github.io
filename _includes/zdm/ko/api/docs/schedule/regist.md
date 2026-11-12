{% include zdm/base-path.html %}

새로운 스케줄을 등록합니다.

---

## `POST /schedules` {#post-schedules}

> * 새로운 스케줄을 시스템에 등록합니다.
> * 스케줄 타입에 따라 다른 구조의 basic/advanced 객체가 필요합니다.
> * Smart 스케줄 (type 7~11)의 경우 basic과 advanced 모두 필요합니다.
> * 타입별 구조, 필드 규칙, 타입별 요청 예시(type 0~11)는 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참조하세요.

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

> 스케줄 타입별 `basic`/`advanced` 구조는 [스케줄 개요]({{ base_path }}/docs/schedule/overview#스케줄-타입별-구조-및-설명)를 참조하세요.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**일반 스케줄 등록 성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "basic": {
      "id": "1",
      "type": 3,
      "state": 1,
      "description": "[Basic] Start working at 10:00 every day."
    }
  },
  "message": "Schedule data regist result",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**Smart 스케줄 등록 성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
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

**유효성 검사 실패 (422 Unprocessable Entity)**

```json
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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**basic 스케줄 데이터 누락 (400 Bad Request)**

`basic` 은 요청 형식 검사에서는 선택 항목이지만, 누락되면 등록 단계에서 거부됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-02",
    "message": "basic schedule data is required"
  },
  "timestamp": "2026-05-15T10:30:00.000+09:00"
}
```

**Smart 스케줄에 advanced 누락 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "SCHEDULE-ERROR-02",
    "message": "Smart Schedule requires advanced data."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-ERROR-01",
    "message": "Zdm with ID '999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

그 밖의 검증 오류(`SCHEDULE-ERROR-16` 시간 형식, `SCHEDULE-ERROR-19` 날짜 범위, `SCHEDULE-ERROR-22` 요일 형식, `SCHEDULE-ERROR-23`·`27`·`31` Smart basic 복수 선택, `SCHEDULE-ERROR-30` 월 범위 등)의 요청·응답 예시는 [스케줄 개요]({{ base_path }}/docs/schedule/overview#검증-실패-응답-예시)를 참조하세요.

</details>

---
