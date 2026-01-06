---
layout: docs
title: PUT /backups/:identifier
section_title: ZDM API Documentation
navigation: api
---

백업 작업을 수정합니다.

---

## `PUT /backups/:identifier` {#update-backup}

> * 백업 작업을 수정합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/v1/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업명 변경
curl -X PUT "https://api.example.com/api/v1/backups/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "jobName": "updated-backup-job"
  }'

# 스케줄 변경
curl -X PUT "https://api.example.com/api/v1/backups/daily-backup-web" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "schedule": {
      "type": "weekly",
      "description": "0 2 * * 0"
    }
  }'

# 여러 옵션 동시 변경
curl -X PUT "https://api.example.com/api/v1/backups/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "incremental",
    "rotation": 14,
    "networkLimit": 500,
    "compression": "lz4"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 작업 ID 또는 작업명 | - |
| `jobName` | Body | string | Optional | - | 변경할 작업명 | - |
| `type` | Body | string | Optional | - | 백업 타입 | `full`, `incremental` |
| `schedule` | Body | object | Optional | - | 스케줄 정보 | - |
| `rotation` | Body | number | Optional | - | 보존 주기 | - |
| `compression` | Body | string | Optional | - | 압축 설정 | `gzip`, `lz4` |
| `networkLimit` | Body | number | Optional | - | 네트워크 제한 | - |
| `mailEvent` | Body | string | Optional | - | 메일 알림 설정 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-backup-update",
  "data": {
    "jobName": "updated-backup-job",
    "status": "updated"
  },
  "message": "백업 작업이 성공적으로 수정되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
