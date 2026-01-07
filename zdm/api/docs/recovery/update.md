---
layout: docs
title: PUT /recoveries/:identifier
section_title: ZDM API Documentation
navigation: api
---

특정 복구 작업의 설정을 수정합니다.

---

## `PUT /recoveries/:identifier` {#put-recoveries-identifier}

> * 복구 ID 또는 복구 이름으로 특정 복구 작업의 설정을 수정합니다.
> * 수정할 필드만 요청 본문에 포함하면 됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복구 작업 수정
curl -X PUT "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "changeName": "weekly-recovery",
    "mode": "increment",
    "afterReboot": "shutdown"
  }'

# 개별 파티션 모드 변경
curl -X PUT "https://api.example.com/api/v1/recoveries/daily-recovery" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "jobList": [
      {
        "partition": "/",
        "mode": "increment"
      }
    ]
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 ID (숫자) 또는 복구 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `changeName` | string | Optional | 변경할 작업 이름 | - |
| `platform` | string | Optional | 플랫폼 | {% include zdm/platforms.md inline=true %} |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `mode` | string | Optional | 작업 모드 (전체 적용) | {% include zdm/job-modes.md %} |
| `afterReboot` | string | Optional | 작업 후 부팅 방식 | {% include zdm/after-reboot.md %} |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0 이상) | - |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `state` | string | Optional | 작업 상태 | {% include zdm/job-status.md %} |
| `jobList` | array | Optional | 개별 작업 설정 배열 | - |

**jobList 항목 구조:**

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `partition` | string | Required | 대상 파티션 (식별용) |
| `mode` | string | Optional | 변경할 작업 모드 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": {
      "id": "1",
      "name": "weekly-recovery"
    },
    "summary": {
      "state": "success",
      "commonUpdatedFields": [
        {
          "field": "jobName",
          "previous": "daily-recovery",
          "new": "weekly-recovery"
        },
        {
          "field": "afterReboot",
          "previous": "reboot",
          "new": "shutdown"
        }
      ],
      "eachUpdatedFields": [
        {
          "partition": "/",
          "summary": {
            "state": "success",
            "commonUpdatedFields": [
              {
                "field": "mode",
                "previous": "full",
                "new": "increment"
              }
            ],
            "eachUpdatedFields": []
          }
        }
      ]
    }
  },
  "message": "Recovery job updated",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo.id` | string | 작업 ID |
| `jobInfo.name` | string | 작업 이름 |
| `jobInfo.errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 수정 결과 (`success` / `fail`) |
| `summary.commonUpdatedFields[].field` | string | 수정된 공통 필드명 |
| `summary.commonUpdatedFields[].previous` | any | 수정 전 값 |
| `summary.commonUpdatedFields[].new` | any | 수정 후 값 |
| `summary.eachUpdatedFields[].partition` | string | 파티션 (Linux) |
| `summary.eachUpdatedFields[].drive` | string | 드라이브 (Windows) |
| `summary.eachUpdatedFields[].summary` | object | 파티션별 수정 결과 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복구 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "RECOVERY_NOT_FOUND",
    "message": "ID가 '999'인 Recovery를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
