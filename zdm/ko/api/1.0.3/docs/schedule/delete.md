---
layout: docs
title: DELETE /schedules/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 스케줄을 삭제합니다.

---

## `DELETE /schedules/:identifier` {#delete-schedules-identifier}

> * 스케줄 ID로 특정 스케줄을 삭제합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/schedules/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 스케줄 ID로 삭제
curl -X DELETE "https://api.example.com/api/schedules/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 스케줄 ID (숫자만 허용) | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "id": 1,
    "name": "daily-backup"
  },
  "message": "Schedule이 성공적으로 삭제되었습니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `data.id` | number | 삭제된 스케줄 ID |
| `data.name` | string | 삭제된 스케줄 이름 (작업명) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**스케줄을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Schedule을 찾을 수 없습니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

**잘못된 파라미터 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "identifier는 숫자(Schedule ID)만 허용됩니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

</details>

---
