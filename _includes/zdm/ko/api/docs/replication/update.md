{% include zdm/base-path.html %}

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
  -H "Authorization: <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "changeName": "weekly-replication",
    "replicationMode": "increment",
    "compression": "use"
  }'

# 복제 작업 시작
curl -X PUT "https://api.example.com/api/replications/backup-replication-01" \
  -H "Authorization: <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "status": "start"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/replications/1" \
  -H "Authorization: <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "schedule": {
      "type": 4,
      "basic": {
        "day": "mon",
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
| `changeName` | string | Optional | 변경할 작업 이름. 같은 center 에 이미 있는 이름이면 400 `BAD_REQUEST` 입니다(v4.0.0) | - |
| `status` | string | Optional | 작업 상태 변경. 대소문자를 구분하지 않습니다 | `start`, `stop` |
| `replicationMode` | string | Optional | 복제 모드 | {% include zdm/replication-modes.md %} |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `schedule` | object \| number | Optional | 스케줄 객체 또는 기존 스케줄 ID. 복제는 type `0`~`6`(basic)만 지원합니다. 아래 "schedule 객체 구조" 참조 | - |

> **본문에서 뺀 필드 (v4.0.0)**: `transferType` · `targetRepository` · `exclude` · `multiString` 은 수정에서 처리하지 않던 필드입니다. 종전에는 받고도 반영하지 않은 채 200 과 빈 변경 내역(`updatedFields`)을 돌려줬습니다. 이제 요청 본문 스키마에서 빠졌으며, 보내도 오류 없이 무시되고 응답은 같습니다. 수정으로 바꿀 수 있는 항목은 아래 표의 필드뿐입니다.

<details markdown="1">
<summary><strong>V1 차이점</strong></summary>

| 항목 | V1 |
|------|-----|
| `center` | 본문에 없음. 작업 이름으로 지정하면 center 로 좁히지 못하므로, 같은 이름의 작업이 여러 center 에 있으면 409 입니다(아래 에러 응답) |
| `replicationMode` | {% include zdm/replication-v1-modes.md %} (`sync` 미지원) |

> V1에서는 `changeName`, `status`, `replicationMode`, `compression`, `encryption`, `mailEvent`, `networkLimit`, `schedule` 필드를 사용합니다. 본문 스키마가 `targetRepository` 를 받지만 수정에 반영하는 처리는 없습니다.
>
> **V1 `schedule` 반영 (v4.0.0)**: 종전 V1 은 `schedule` 을 받고도 버렸습니다(200 이지만 저장되지 않음). 이제 V2 와 같이 반영됩니다. 숫자는 기존 스케줄 ID 를 참조하고(없으면 오류), 객체는 같은 트랜잭션 안에서 등록합니다. 스케줄이 실제로 바뀌면 `summary.updatedFields[]` 에 `schedule` 항목이 들어갑니다. `schedule` 을 함께 보내던 V1 호출은 그 값이 적용되는지 확인하세요.

</details>

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

{% include zdm/schedule-object.md smart=false %}

- 숫자 ID 는 **복사 없이 그 스케줄을 참조**하며, 작업의 스케줄이 실제로 그 ID 로 바뀝니다. 객체는 작업의 스케줄로 등록(upsert)됩니다.
- 존재하지 않는 ID 는 404 `SCHEDULE-ERROR-01` 입니다.
- 지정한 스케줄이 작업이 속한 center 의 것이 아니면 403 `CENTER-ERROR-01` 입니다(`Schedule ID '<id>' does not belong to center <center>`). `nCenterID = 0` 도 하나의 center 로 비교합니다. 객체 안 숫자 ID 는 행 type 이 요청 `type` 과 다르면 400 `JOB-ERROR-108` 이며, 검사 순서는 존재(404) → center(403) → type(400)입니다.
- Smart 스케줄(type 7~11)은 400 `JOB-ERROR-101` 로 거부됩니다.

**Smart 스케줄 거부 예시 (400 Bad Request)**

```json
{
  "center": "1",
  "schedule": {
    "type": 7,
    "basic": { "day": "mon", "time": "10:00" }
  }
}
```

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-101",
    "message": "For full/increment job types, schedule must contain only basic."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

> **상태 변경 항목 (v4.0.0)**: `status` 를 보내면 `updatedFields[]` 에 `{ field: "status", previous, new }` 가 들어갑니다. `previous` 는 조회 응답의 `job.info.status.current` 와 같은 상태 값이고, `new` 는 요청 본문의 `status` 값 그대로(`start`/`stop`)입니다. V1·V2 모두 같습니다.
>
> **v2.0.2 신설**: schedule 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출. 이전엔 service 가 schedule 입력을 무시했으나 본 버전부터 정상 처리.

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**성공 응답 (200 OK) — 상태 변경**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "replicationInfo": {
      "id": 1,
      "name": "backup-replication-01"
    },
    "summary": {
      "updatedFields": [
        {
          "field": "status",
          "previous": "Registered",
          "new": "start"
        }
      ]
    }
  },
  "message": "Replication job updated",
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**성공 응답 (200 OK) — schedule 변경 (v2.0.2)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-03-20T10:30:00.000+09:00"
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
| `summary.updatedFields[]` (`field: "status"`) | object | `previous` 는 조회 응답과 같은 상태 값(예: `Registered`), `new` 는 요청 값 그대로(`start`/`stop`) |
| `summary.updatedFields[].previous` | string \| number \| ScheduleChangeValue | 수정 전 값. 일반 필드는 `string \| number`, **`schedule` 필드는 `{ id, type, description }` 객체** (v2.0.2 신설) |
| `summary.updatedFields[].new` | string \| number \| ScheduleChangeValue | 수정 후 값. 일반 필드는 `string \| number`, **`schedule` 필드는 `{ id, type, description }` 객체** (v2.0.2 신설) |

**ScheduleChangeValue 구조** (v2.0.2 신규 — `field === "schedule"` 인 경우):

{% include zdm/schedule-change-value.md %}

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복제 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "NOT_FOUND",
    "message": "Replication not found (identifier: 999, center: 1)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

V1 의 메시지에는 `center` 가 붙지 않습니다(`Replication not found (identifier: 999)`).

**이미 있는 이름으로 변경 (400 Bad Request)**

`changeName` 이 같은 center 에 이미 있는 작업 이름이면 반환됩니다(V1 · V2 공통, v4.0.0). 종전에는 같은 이름의 작업이 둘이 됐습니다. 등록할 때의 이름 중복 오류와 같은 코드입니다. 다른 이름을 지정하세요.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "BAD_REQUEST",
    "message": "Replication jobName already exists in the source center (jobName: weekly-replication, centerID: 1)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**같은 이름의 작업이 여러 개 — V1 이름 수정 (409 Conflict)**

V1 에서 작업 **이름**으로 수정할 때, 같은 이름의 작업이 둘 이상이면(다른 center 에 같은 이름이 있는 경우) 아무것도 수정하지 않고 거부합니다(v4.0.0). 메시지에 걸린 작업 ID 가 실리므로 **ID 로 다시 요청**하세요. V2 는 본문 `center` 로 범위를 좁히므로 해당하지 않습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CONFLICT",
    "message": "Multiple replication jobs named 'backup-replication-01' exist (ids: 3, 7). Update by job id instead."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

---
