---
layout: docs
title: POST /schedules
section_title: ZDM API Documentation
navigation: api
---

새 스케줄을 생성합니다.

---

## `POST /schedules` {#create-schedule}

> * 새 스케줄을 생성합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/schedules</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 스케줄 생성
curl -X POST "https://api.example.com/api/v1/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "user": "admin@example.com",
    "jobName": "daily-backup-job",
    "type": 1,
    "basic": {
      "type": "daily",
      "description": "0 2 * * *"
    }
  }'

# 고급 스케줄 포함 생성
curl -X POST "https://api.example.com/api/v1/schedules" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "user": "admin@example.com",
    "jobName": "weekly-backup-job",
    "type": 2,
    "basic": {
      "type": "weekly",
      "description": "0 2 * * 0"
    },
    "advanced": {
      "type": "custom",
      "description": "Every Sunday at 2:00 AM"
    }
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `center` | Body | string | Required | - | 센터 ID 또는 이름 | - |
| `user` | Body | string | Required | - | 사용자 ID 또는 이메일 | - |
| `jobName` | Body | string | Required | - | 작업명 | - |
| `type` | Body | number | Required | - | 스케줄 타입 | `1` (Smart), `2` (Common) |
| `basic` | Body | object | Required | - | 기본 스케줄 설정 | - |
| `basic.type` | Body | string | Required | - | 기본 스케줄 타입 | - |
| `basic.description` | Body | string | Required | - | 기본 스케줄 설명 | - |
| `advanced` | Body | object | Optional | - | 고급 스케줄 설정 | - |
| `advanced.type` | Body | string | Optional | - | 고급 스케줄 타입 | - |
| `advanced.description` | Body | string | Optional | - | 고급 스케줄 설명 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-schedule-create",
  "data": {
    "id": "2",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "new-backup-job",
    "schedule": {
      "basic": "0 2 * * *",
      "advanced": "daily at 2:00 AM"
    }
  },
  "message": "스케줄이 성공적으로 생성되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
