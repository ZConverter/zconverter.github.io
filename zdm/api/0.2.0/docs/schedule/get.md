---
layout: docs
title: GET /schedules/:identifier
section_title: ZDM API Documentation
navigation: api-0.2.0
---

특정 스케줄의 상세 정보를 조회합니다.

---

## `GET /schedules/:identifier` {#get-schedules-identifier}

> * 스케줄 ID로 특정 스케줄의 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/schedules/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 스케줄 ID로 조회
curl -X GET "https://api.example.com/api/v1/schedules/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "id": "1",
    "center": {
      "id": "1",
      "name": "Main Center"
    },
    "type": "daily",
    "state": "enabled",
    "jobName": "daily-backup",
    "lastRunTime": "2025-01-15T10:00:00Z",
    "description": "Every day at 10:00"
  },
  "message": "Schedule information retrieved",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | string | 스케줄 ID |
| `center.id` | string | 센터 ID |
| `center.name` | string | 센터 이름 |
| `type` | string | 스케줄 타입 |
| `state` | string | 활성화 상태 |
| `jobName` | string | 작업 이름 |
| `lastRunTime` | string | 마지막 실행 시간 |
| `description` | string | 스케줄 설명 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**스케줄을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "SCHEDULE_NOT_FOUND",
    "message": "ID가 '999'인 Schedule를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
