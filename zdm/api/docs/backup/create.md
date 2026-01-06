---
layout: docs
title: POST /backups
section_title: ZDM API Documentation
navigation: api
---

새 백업 작업을 등록합니다.

---

## `POST /backups` {#create-backup}

> * 새 백업 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/backups</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 백업 작업 등록
curl -X POST "https://api.example.com/api/v1/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "server": "web-server-01",
    "type": "full",
    "partition": ["/dev/sda1"],
    "repository": {
      "id": 1,
      "type": "local",
      "path": "/backup/storage"
    },
    "jobName": "daily-backup-web",
    "user": "admin@example.com",
    "schedule": {
      "type": "daily",
      "description": "0 2 * * *"
    }
  }'

# 고급 옵션 포함 등록
curl -X POST "https://api.example.com/api/v1/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "server": "web-server-01",
    "type": "incremental",
    "partition": ["/dev/sda1", "/dev/sda2"],
    "repository": {
      "id": 1,
      "type": "local",
      "path": "/backup/storage"
    },
    "jobName": "incremental-backup",
    "user": "admin@example.com",
    "schedule": {
      "type": "hourly",
      "description": "0 * * * *"
    },
    "rotation": 7,
    "compression": "gzip",
    "networkLimit": 1000,
    "autoStart": "yes"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `center` | Body | string | Required | - | 센터 ID 또는 이름 | - |
| `server` | Body | string | Required | - | 서버 ID 또는 이름 | - |
| `type` | Body | string | Required | - | 백업 타입 | `full`, `incremental` |
| `partition` | Body | array | Required | - | 백업할 파티션 목록 | - |
| `repository` | Body | object | Required | - | 리포지토리 정보 | - |
| `repository.id` | Body | number | Required | - | 리포지토리 ID | - |
| `repository.type` | Body | string | Required | - | 리포지토리 타입 | - |
| `repository.path` | Body | string | Required | - | 리포지토리 경로 | - |
| `jobName` | Body | string | Required | - | 작업명 | - |
| `user` | Body | string | Required | - | 사용자 ID 또는 이메일 | - |
| `schedule` | Body | object | Required | - | 스케줄 정보 | - |
| `schedule.type` | Body | string | Required | - | 스케줄 타입 | - |
| `schedule.description` | Body | string | Required | - | 스케줄 설명 | - |
| `description` | Body | string | Optional | - | 작업 설명 | - |
| `rotation` | Body | number | Optional | - | 보존 주기 | - |
| `compression` | Body | string | Optional | - | 압축 설정 | `gzip`, `lz4` |
| `encryption` | Body | string | Optional | - | 암호화 설정 | - |
| `excludeDir` | Body | array | Optional | - | 제외할 디렉토리 | - |
| `excludePartition` | Body | array | Optional | - | 제외할 파티션 | - |
| `mailEvent` | Body | string | Optional | - | 메일 알림 설정 | - |
| `networkLimit` | Body | number | Optional | `0` | 네트워크 제한 | - |
| `autoStart` | Body | string | Optional | - | 자동 시작 여부 | `yes`, `no` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-backup-register",
  "data": {
    "results": [
      {
        "state": "success",
        "jobName": "daily-backup-web",
        "partition": "/dev/sda1",
        "jobMode": "full",
        "autoStart": "yes",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    }
  },
  "message": "백업 작업이 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
