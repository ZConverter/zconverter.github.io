---
layout: docs
title: PUT /recoveries/:identifier
section_title: ZDM API Documentation
navigation: api
---

복구 작업을 수정합니다.

---

## `PUT /recoveries/:identifier` {#update-recovery}

> * 복구 작업을 수정합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업명 변경
curl -X PUT "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "jobName": "updated-recovery-job"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/v1/recoveries/system-recovery-job" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "schedule": {
      "type": "daily",
      "description": "0 4 * * *"
    }
  }'

# 여러 옵션 동시 변경
curl -X PUT "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "mode": "incremental",
    "networkLimit": 500,
    "afterReboot": "restart"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 작업 ID 또는 작업명 | - |
| `jobName` | Body | string | Optional | - | 변경할 작업명 | - |
| `mode` | Body | string | Optional | - | 복구 모드 | `full`, `incremental` |
| `schedule` | Body | object | Optional | - | 스케줄 정보 | - |
| `overwrite` | Body | string | Optional | - | 덮어쓰기 옵션 | `yes`, `no` |
| `networkLimit` | Body | number | Optional | - | 네트워크 제한 | - |
| `afterReboot` | Body | string | Optional | - | 재부팅 후 동작 | `shutdown`, `restart` |
| `mailEvent` | Body | string | Optional | - | 메일 알림 설정 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-update",
  "data": {
    "jobName": "updated-recovery-job",
    "status": "updated"
  },
  "message": "복구 작업이 성공적으로 수정되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
