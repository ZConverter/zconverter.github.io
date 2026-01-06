---
layout: docs
title: POST /recoveries
section_title: ZDM API Documentation
navigation: api
---

새 복구 작업을 등록합니다.

---

## `POST /recoveries` {#create-recovery}

> * 새 복구 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/recoveries</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 복구 작업 등록
curl -X POST "https://api.example.com/api/v1/recoveries" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "source": "web-server-01",
    "target": "backup-server-01",
    "platform": "linux",
    "repository": {
      "id": 1,
      "type": "local",
      "path": "/backup/storage"
    },
    "mode": "full",
    "jobName": "system-recovery-job",
    "overwrite": "yes",
    "user": "admin@example.com",
    "schedule": {
      "type": "weekly",
      "description": "0 3 * * 0"
    }
  }'

# 고급 옵션 포함 등록
curl -X POST "https://api.example.com/api/v1/recoveries" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "CENTER-001",
    "source": "web-server-01",
    "target": "backup-server-01",
    "platform": "linux",
    "repository": {
      "id": 1,
      "type": "local",
      "path": "/backup/storage"
    },
    "mode": "incremental",
    "jobName": "incremental-recovery",
    "overwrite": "no",
    "user": "admin@example.com",
    "schedule": {
      "type": "daily",
      "description": "0 4 * * *"
    },
    "networkLimit": 500,
    "afterReboot": "shutdown",
    "autoStart": "yes"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `center` | Body | string | Required | - | 센터 ID 또는 이름 | - |
| `source` | Body | string | Required | - | 소스 서버 ID 또는 이름 | - |
| `target` | Body | string | Required | - | 타겟 서버 ID 또는 이름 | - |
| `platform` | Body | string | Required | - | 플랫폼 타입 | `linux`, `windows` |
| `repository` | Body | object | Required | - | 리포지토리 정보 | - |
| `repository.id` | Body | number | Required | - | 리포지토리 ID | - |
| `repository.type` | Body | string | Required | - | 리포지토리 타입 | - |
| `repository.path` | Body | string | Required | - | 리포지토리 경로 | - |
| `mode` | Body | string | Required | - | 복구 모드 | `full`, `incremental` |
| `jobName` | Body | string | Required | - | 작업명 | - |
| `overwrite` | Body | string | Required | - | 덮어쓰기 옵션 | `yes`, `no` |
| `user` | Body | string | Required | - | 사용자 ID 또는 이메일 | - |
| `schedule` | Body | object | Required | - | 스케줄 정보 | - |
| `schedule.type` | Body | string | Required | - | 스케줄 타입 | - |
| `schedule.description` | Body | string | Required | - | 스케줄 설명 | - |
| `description` | Body | string | Optional | - | 작업 설명 | - |
| `afterReboot` | Body | string | Optional | - | 재부팅 후 동작 | `shutdown`, `restart` |
| `networkLimit` | Body | number | Optional | `0` | 네트워크 제한 | - |
| `excludePartition` | Body | array | Optional | - | 제외할 파티션 | - |
| `mailEvent` | Body | string | Optional | - | 메일 알림 설정 | - |
| `autoStart` | Body | string | Optional | - | 자동 시작 여부 | `yes`, `no` |
| `scriptPath` | Body | string | Optional | - | 스크립트 경로 | - |
| `scriptRun` | Body | string | Optional | - | 스크립트 실행 여부 | - |
| `cloudAuth` | Body | number | Optional | - | 클라우드 인증 ID | - |
| `listOnly` | Body | boolean | Optional | - | 목록만 조회 여부 | - |
| `jobList` | Body | array | Optional | - | 작업 목록 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-register",
  "data": {
    "jobName": "system-recovery-job",
    "jobId": "REC-002",
    "schedule": {
      "basic": "0 3 * * 0",
      "advanced": "weekly on Sunday at 3:00 AM"
    },
    "status": "registered"
  },
  "message": "복구 작업이 성공적으로 등록되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
