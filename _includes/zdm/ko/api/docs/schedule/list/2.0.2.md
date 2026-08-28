
등록된 전체 스케줄 목록을 조회합니다.

---

## `GET /schedules` {#get-schedules}

> * 시스템에 등록된 모든 스케줄 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 스케줄만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/schedules</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 스케줄 목록 조회 (필터 없음, 페이지네이션 미적용)
curl -X GET "https://api.example.com/api/schedules" \
  -H "Authorization: Bearer <token>"

# 타입별 조회
curl -X GET "https://api.example.com/api/schedules?type=daily" \
  -H "Authorization: Bearer <token>"

# 활성화 상태별 조회
curl -X GET "https://api.example.com/api/schedules?state=enabled" \
  -H "Authorization: Bearer <token>"

# 타입 + 정렬 (오름차순)
curl -X GET "https://api.example.com/api/schedules?type=daily&sort=asc" \
  -H "Authorization: Bearer <token>"

# 정확한 원문 타입 (공백/괄호 포함 → URL 인코딩 필요)
curl -X GET "https://api.example.com/api/schedules?type=Smart%20Custom%20%28Specific%20Month%20and%20Date%29" \
  -H "Authorization: Bearer <token>"

# 다중 센터 필터 (comma-separated; ID 또는 이름 혼용 가능)
curl -X GET "https://api.example.com/api/schedules?center=1,3,5" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 (2페이지, 페이지당 20개)
curl -X GET "https://api.example.com/api/schedules?page=2&limit=20" \
  -H "Authorization: Bearer <token>"

# 단일 ID 조회 필터
curl -X GET "https://api.example.com/api/schedules?id=15" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `id` | Query | number | Optional | - | 스케줄 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `type` | Query | string | Optional | - | 스케줄 타입 필터 | [선택값 참조](#type-선택값) |
| `state` | Query | string | Optional | - | 활성화 상태 필터 | {% include zdm/schedule-state.md %} |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

<details markdown="1" id="type-선택값">
<summary><strong>type 선택값</strong></summary>

{% include zdm/schedule-types.md %}

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": "1",
      "center": {
        "id": "1",
        "name": "Main Center"
      },
      "type": "daily",
      "state": "enabled",
      "jobName": "daily-backup",
      "lastRunTime": "2025-01-15 10:00:00",
      "description": "Every day at 10:00"
    }
  ],
  "message": "Schedule information list",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "id": "1",
      "center": {
        "id": "1",
        "name": "Main Center"
      },
      "type": "daily",
      "state": "enabled",
      "jobName": "daily-backup",
      "lastRunTime": "2025-01-15 10:00:00",
      "description": "Every day at 10:00"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Schedule information list",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>다양한 type 값 응답 (200 OK) - PascalCase 표시 + Unknown 폴백</summary>

> 응답의 `type`/`state`는 displayMappings에 따라 첫 글자 대문자 표기로 반환됩니다. DB 값이 매핑되지 않은 경우 `"Unknown"`이 반환됩니다.
> `description`은 시스템이 자동 생성하며 `[Basic]` 또는 `[Advanced]` 접두사로 시작합니다.

```json
{
  "requestID": "req-abc123",
  "message": "Schedule information list",
  "success": true,
  "data": [
    {
      "id": "1",
      "center": { "id": "1", "name": "Main Center" },
      "type": "Daily",
      "state": "Enabled",
      "jobName": "daily-backup",
      "lastRunTime": "2025-01-15 10:00:00",
      "description": "[Basic] Start working at 10:00 every day."
    },
    {
      "id": "2",
      "center": { "id": "1", "name": "Main Center" },
      "type": "Weekly",
      "state": "Enabled",
      "jobName": "weekly-backup",
      "lastRunTime": "2025-01-13 02:30:00",
      "description": "[Basic] Start working at 02:30 Monday, Wednesday every week."
    },
    {
      "id": "3",
      "center": { "id": "2", "name": "Branch Center" },
      "type": "Smart Monthly (Specific Date)",
      "state": "Disabled",
      "jobName": "monthly-report",
      "lastRunTime": "2025-01-01 00:00:00",
      "description": "[Basic] Start working at 00:00 on the 1 of every month."
    },
    {
      "id": "4",
      "center": { "id": "2", "name": "Branch Center" },
      "type": "Smart Custom (Specific Month and Date)",
      "state": "Enabled",
      "jobName": "quarterly-snapshot",
      "lastRunTime": "-",
      "description": "[Advanced] Start working at 03:00 on the 1, 15 of January, April, July, October"
    },
    {
      "id": "5",
      "center": { "id": "-", "name": "-" },
      "type": "Unknown",
      "state": "Unknown",
      "jobName": "legacy-job",
      "lastRunTime": "-",
      "description": "-"
    }
  ],
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>빈 결과 응답 (200 OK) - 페이지네이션 미적용</summary>

> 일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열을 반환합니다 (에러가 아님).

```json
{
  "requestID": "req-abc123",
  "message": "Schedule information list",
  "success": true,
  "data": [],
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary>빈 결과 응답 (200 OK) - 페이지네이션 적용</summary>

> `page` 또는 `limit`을 지정한 상태에서 결과가 0건이면 `data: []`와 빈 페이지네이션 메타가 함께 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "message": "Schedule information list",
  "success": true,
  "data": [],
  "pagination": {
    "currentPage": 2,
    "totalPages": 0,
    "totalItems": 0,
    "itemsPerPage": 20,
    "hasNextPage": false,
    "hasPreviousPage": true
  },
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

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
| `pagination.currentPage` | number | 현재 페이지 번호 (page/limit 사용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (page/limit 사용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (page/limit 사용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (page/limit 사용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (page/limit 사용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (page/limit 사용 시) |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "토큰이 만료되었습니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "유효하지 않은 'type' 값입니다.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
