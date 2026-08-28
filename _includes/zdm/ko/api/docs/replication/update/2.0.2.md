
특정 복제 작업의 설정을 수정합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `PUT /replications/:identifier` {#put-replications-identifier}

> * 복제 ID 또는 작업 이름으로 특정 복제 작업의 설정을 수정합니다.
> * 수정할 필드만 요청 본문에 포함하면 됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복제 작업 이름 변경 및 모드 수정
curl -X PUT "https://api.example.com/api/replications/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "changeName": "weekly-replication",
    "replicationMode": "increment",
    "compression": "use"
  }'

# 복제 작업 시작
curl -X PUT "https://api.example.com/api/replications/backup-replication-01" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "status": "start"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/replications/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
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
| `identifier` | Path | string | Required | - | 복제 작업 ID (숫자) 또는 작업 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string \| number | Required | 작업 소속 센터 ID 또는 이름 (소유 검증용) | - |
| `changeName` | string | Optional | 변경할 작업 이름 | - |
| `status` | string | Optional | 작업 상태 변경 | `start`, `stop` |
| `replicationMode` | string | Optional | 복제 모드 | {% include zdm/replication-modes.md %} |
| `transferType` | string | Optional | 전송 유형 | {% include zdm/transfer-types.md %} |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 기존 스케줄 ID | - |
| `targetRepository` | object | Optional | 타겟 레포지토리 정보 | - |
| `exclude` | string | Optional | 제외 패턴 | - |
| `multiString` | string | Optional | 추가 설정 문자열 | - |

<details markdown="1">
<summary><strong>V1 차이점</strong></summary>

| 항목 | V1 |
|------|-----|
| `replicationMode` | {% include zdm/replication-v1-modes.md %} (`sync` 미지원) |
| `transferType` | 미지원 |
| `exclude` | 미지원 |
| `multiString` | 미지원 |

> V1에서는 `changeName`, `status`, `compression`, `encryption`, `mailEvent`, `networkLimit`, `schedule`, `targetRepository` 필드만 사용 가능합니다.

</details>

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

> 기존 스케줄 ID(숫자)를 사용하거나, 새 스케줄 객체를 생성할 수 있습니다.
> 스케줄 타입별 상세 구조는 [POST /schedules](../schedule/regist)를 참고하세요.

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `type` | number | Required | 스케줄 타입 (0~11) |
| `basic` | object/number | Required | 기본 스케줄 구조 또는 기존 스케줄 ID |
| `advanced` | object/number | Optional | 고급 스케줄 구조 (Smart 스케줄 type 7~11) |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

> **v2.0.2 신설**: schedule 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출. 이전엔 service 가 schedule 입력을 무시했으나 본 버전부터 정상 처리.

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "replicationInfo": {
      "id": 1,
      "name": "weekly-replication"
    },
    "summary": {
      "updatedFields": [
        {
          "field": "jobName",
          "previous": "backup-replication-01",
          "new": "weekly-replication"
        },
        {
          "field": "replicationMode",
          "previous": "full",
          "new": "increment"
        },
        {
          "field": "compression",
          "previous": "not use",
          "new": "use"
        }
      ]
    }
  },
  "message": "Replication job updated",
  "timestamp": "2026-03-20 10:30:00"
}
```

**성공 응답 (200 OK) — schedule 변경 (v2.0.2)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "replicationInfo": {
      "id": "1",
      "name": "daily-repl"
    },
    "summary": {
      "updatedFields": [
        {
          "field": "schedule",
          "previous": { "id": 5,  "type": "Daily",  "description": "[Basic] Start working at 03:00 every day." },
          "new":      { "id": 10, "type": "Weekly", "description": "[Basic] Start working at 03:00 Monday, Wednesday every week." }
        }
      ]
    }
  },
  "message": "Replication job updated",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `replicationInfo.id` | number | 작업 ID |
| `replicationInfo.name` | string | 작업 이름 |
| `summary.updatedFields[].field` | string | 수정된 필드명 |
| `summary.updatedFields[].previous` | string \| number \| ScheduleChangeValue | 수정 전 값. 일반 필드는 `string \| number`, **`schedule` 필드는 `{ id, type, description }` 객체** (v2.0.2 신설) |
| `summary.updatedFields[].new` | string \| number \| ScheduleChangeValue | 수정 후 값. 일반 필드는 `string \| number`, **`schedule` 필드는 `{ id, type, description }` 객체** (v2.0.2 신설) |

**ScheduleChangeValue 구조** (v2.0.2 신규 — `field === "schedule"` 인 경우):

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | schedule ID |
| `type` | string | schedule 타입 (displayMappings PascalCase 영문 — 예: `"Once"`, `"Every Minute"`, `"Hourly"`, `"Daily"`, `"Weekly"`, `"Monthly (Specific Week and Day of the Week)"`, `"Monthly on Specific Date"`, `"Smart Weekly (Specific Day of the Week)"`, 그 외 SMART_* 값들, 조회 실패 시 `"Unknown"`) |
| `description` | string | schedule 영문 설명 (`processScheduleInfo` 결과 — 예: `"[Basic] Start working at 03:00 every day."`, `"[Basic] Start working at 03:00 Monday, Wednesday every week."`, `"[Basic] Start working at 03:00 on the 1, 15 of every month."`, `"[Basic] Start working at 00:00 every 2 Hour."`, 조회 실패 시 `"Schedule lookup failed"`) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복제 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Replication not found (identifier: 999, center: 1)",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
