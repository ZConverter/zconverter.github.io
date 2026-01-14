---
layout: docs
title: POST /schedules
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

새로운 스케줄을 등록합니다.

---

## `POST /schedules` {#post-schedules}

> * 새로운 스케줄을 시스템에 등록합니다.
> * 스케줄 타입에 따라 다른 구조의 basic/advanced 객체가 필요합니다.
> * Smart 스케줄 (type 7~11)의 경우 basic과 advanced 모두 필요합니다.
> * 스케줄 타입별 구조 및 상세 예시는 [스케줄 개요](overview.md)를 참조하세요.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/schedules</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 일반 Daily 스케줄 등록 (center를 문자열로 전달)
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

# 일반 Daily 스케줄 등록 (center를 숫자로 전달)
curl -X POST "https://api.example.com/api/v1/schedules" \
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
curl -X POST "https://api.example.com/api/v1/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": 1,
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
| `center` | string \| number | Required | 센터 ID (숫자) 또는 센터 이름 |
| `user` | string \| number | Optional | 사용자 이메일 또는 사용자 등록 ID (숫자만) |
| `jobName` | string | Optional | 작업 이름 |
| `type` | number | Required | 스케줄 타입 (0 ~ 11) |
| `basic` | object | Optional | 기본 스케줄 구조 |
| `advanced` | object | Optional | 고급 스케줄 구조 (Smart 스케줄용) |

> 스케줄 타입별 `basic`/`advanced` 구조는 [스케줄 개요](overview.md#스케줄-타입별-구조)를 참조하세요.

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
