---
layout: docs
title: PUT /backups/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 백업 작업의 설정을 수정합니다.

---

## `PUT /backups/:identifier` {#put-backups-identifier}

> * 백업 ID 또는 백업 이름으로 특정 백업 작업의 설정을 수정합니다.
> * 수정할 필드만 요청 본문에 포함하면 됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 작업 수정
curl -X PUT "https://api.example.com/api/v1/backups/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "changeName": "weekly-backup",
    "mode": "increment",
    "rotation": 14,
    "compression": "use"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/v1/backups/daily-backup" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "schedule": {
      "type": 4,
      "basic": {
        "day": "1",
        "time": "03:00"
      }
    }
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `changeName` | string | Optional | 변경할 작업 이름 | - |
| `mode` | string | Optional | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `status` | string | Optional | 작업 상태 | {% include zdm/job-status.md %} |
| `description` | string | Optional | 작업 설명 | - |
| `rotation` | number | Optional | 작업 반복 횟수 | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string | Optional | 제외 디렉토리 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 기존 스케줄 ID | - |
| `repository` | object | Optional | 레포지토리 정보 | - |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

> 기존 스케줄 ID(숫자)를 사용하거나, 새 스케줄 객체를 생성할 수 있습니다.
> 스케줄 타입별 상세 구조는 [POST /schedules](../schedule/regist.md)를 참고하세요.

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `type` | number | Required | 스케줄 타입 (0~11) |
| `basic` | object/number | Required | 기본 스케줄 구조 또는 기존 스케줄 ID |
| `advanced` | object/number | Optional | 고급 스케줄 구조 (Smart 스케줄 type 7~11) |

**스케줄 타입별 basic/advanced 구조:**

| Type | 이름 | 구조 |
|------|------|------|
| 0 | once | `{ year, month, day, time }` |
| 1 | every minute | `{ time, interval: { minute } }` |
| 2 | hourly | `{ time, interval: { hour } }` |
| 3 | daily | `{ time }` |
| 4 | weekly | `{ day, time }` |
| 5 | monthly on specific week | `{ week, day, time }` |
| 6 | monthly on specific day | `{ day, time }` |
| 7~11 | smart schedules | basic + advanced 모두 필요 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": [
      {
        "id": "1",
        "name": "weekly-backup",
        "partition": "/"
      }
    ],
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "jobName",
          "previous": "daily-backup",
          "new": "weekly-backup"
        },
        {
          "field": "mode",
          "previous": "full",
          "new": "increment"
        },
        {
          "field": "rotation",
          "previous": 7,
          "new": 14
        },
        {
          "field": "compression",
          "previous": "not use",
          "new": "use"
        }
      ]
    }
  },
  "message": "Backup job updated",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo[].id` | string | 작업 ID |
| `jobInfo[].name` | string | 작업 이름 |
| `jobInfo[].partition` | string | 대상 파티션 |
| `jobInfo[].errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 수정 결과 (`success` / `fail`) |
| `summary.updatedFields[].field` | string | 수정된 필드명 |
| `summary.updatedFields[].previous` | any | 수정 전 값 |
| `summary.updatedFields[].new` | any | 수정 후 값 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**백업 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "BACKUP_NOT_FOUND",
    "message": "ID가 '999'인 Backup을 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
