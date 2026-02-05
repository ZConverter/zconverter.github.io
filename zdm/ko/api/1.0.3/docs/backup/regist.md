---
layout: docs
title: POST /backups
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

새로운 백업 작업을 등록합니다.

---

## `POST /backups` {#post-backups}

> * 새로운 백업 작업을 시스템에 등록합니다.
> * 여러 파티션에 대해 개별 설정으로 등록할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/backups</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 백업 작업 등록
curl -X POST "https://api.example.com/api/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "server": "server-01",
    "type": "full",
    "partition": ["/", "/home"],
    "repository": {
      "type": "nfs",
      "path": "/backup/server-01"
    },
    "jobName": "daily-backup",
    "rotation": 7
  }'

# 스케줄 포함 백업 작업 등록
curl -X POST "https://api.example.com/api/backups" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "server": "server-01",
    "type": "smart",
    "partition": ["/"],
    "repository": {
      "type": "smb",
      "path": "//192.168.1.100/backup"
    },
    "schedule": {
      "type": 3,
      "basic": {
        "time": "02:00"
      }
    },
    "compression": "use",
    "encryption": "use"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string \| number | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `server` | string \| number | Required | 서버 ID (숫자) 또는 서버 이름 | - |
| `type` | string | Required | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `partition` | array | Required | 작업 대상 파티션 배열 (전체 작업시 빈 배열 `[]`) | - |
| `repository` | object | Required | 레포지토리 정보 | - |
| `repository.type` | string | Required | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `repository.path` | string | Required | 레포지토리 경로 | - |
| `jobName` | string | Optional | 작업 이름 | - |
| `user` | string \| number | Optional | 사용자 ID (숫자) 또는 이메일 | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `rotation` | number | Optional | `1` | 작업 반복 횟수 (1~30) | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string | Optional | 작업에서 제외힐 디렉토리 목록 | - |
| `excludePartition` | string | Optional | 작업에서 제외할 파티션 목록 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한, 그외: 해당 속도로 제한) | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `individual` | array | Optional | 개별 작업 설정 배열 | - |

</details>

<details markdown="1">
<summary><strong>individual 객체 구조</strong></summary>

> 파티션별로 개별 설정을 적용할 수 있습니다. 지정하지 않은 필드는 상위 요청의 기본값을 사용합니다.

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `partition` | string | Required | 작업 대상 파티션 | - |
| `center` | string \| number | Optional | 센터 ID 또는 이름 (미입력시 기본 center 사용) | - |
| `server` | string \| number | Optional | 서버 ID 또는 이름 (미입력시 기본 server 사용) | - |
| `type` | string | Optional | 작업 모드 | {% include zdm/job-modes.md backup=true %} |
| `repository` | object | Optional | 레포지토리 정보 | - |
| `jobName` | string | Optional | 작업 이름. 명시적으로 지정 시 파티션 suffix 없이 그대로 사용. 미지정 시 자동 생성 | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `description` | string | Optional | 작업 설명 | - |
| `rotation` | number | Optional | 작업 반복 횟수 (1~30) | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `encryption` | string | Optional | 암호화 사용 여부 | {% include zdm/use-options.md %} |
| `excludeDir` | string/array | Optional | 제외 디렉토리 | - |
| `excludePartition` | string/array | Optional | 제외 파티션 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `networkLimit` | number | Optional | 네트워크 제한 속도 | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |

**사용 예시:**

```json
{
  "center": "1",
  "server": "main-server",
  "type": "full",
  "partition": ["/", "/data", "/var"],
  "repository": { "type": "nfs", "path": "/backup" },
  "individual": [
    {
      "partition": "/data",
      "center": "2",
      "server": "backup-server",
      "rotation": 14
    },
    {
      "partition": "/var",
      "compression": "use",
      "encryption": "use"
    }
  ]
}
```

위 예시에서:
- `/` 파티션: 기본 설정 사용 (center=1, server=main-server)
- `/data` 파티션: center=2, server=backup-server, rotation=14 적용
- `/var` 파티션: 압축/암호화만 개별 적용, 나머지는 기본값 사용

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

**성공 응답 (201 Created)**

```json
{
  "requestID": "46f53c9a-86f7-4c8f-9947-1e3ac642e27f",
  "message": "Backup job registration completed",
  "success": true,
  "data": {
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "backupTest_ROOT",
        "partition": "/",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "type": "Monthly on Specific Date",
            "description": "[Basic] Start working at 12:00 25, 28 every month."
          }
        }
      },
      {
        "state": "success",
        "jobName": "backupTest_boot_efi",
        "partition": "/boot/efi",
        "jobMode": "Full Backup",
        "autoStart": "not use",
        "schedule": {
          "basic": {
            "type": "Monthly on Specific Date",
            "description": "[Basic] Start working at 12:00 25, 28 every month."
          }
        }
      }
    ]
  },
  "timestamp": "2026-01-17 21:03:52"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `summary.total` | number | 총 작업 수 |
| `summary.successful` | number | 성공한 작업 수 |
| `summary.failed` | number | 실패한 작업 수 |
| `results[].state` | string | 등록 결과 (`success` / `fail`) |
| `results[].jobName` | string | 작업 이름 |
| `results[].partition` | string | 대상 파티션 |
| `results[].jobMode` | string | 작업 모드 (`Full Backup`, `Incremental Backup`, `Smart Backup`) |
| `results[].autoStart` | string | 자동 시작 여부 (`use` / `not use`) |
| `results[].schedule` | object | 스케줄 정보 (설정시에만 포함) |
| `results[].schedule.basic` | object | 기본 스케줄 정보 |
| `results[].schedule.basic.type` | string | 스케줄 타입 이름 (예: `Daily`, `Monthly on Specific Date`) |
| `results[].schedule.basic.description` | string | 스케줄 설명 (예: `[Basic] Start working at 12:00 25, 28 every month.`) |
| `results[].schedule.advanced` | object | 고급 스케줄 정보 (Smart 스케줄 type 7~11 설정시에만 포함) |
| `results[].schedule.advanced.type` | string | 고급 스케줄 타입 이름 |
| `results[].schedule.advanced.description` | string | 고급 스케줄 설명 |
| `results[].scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `results[].scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `results[].errorMessage` | string | 실패 시 오류 메시지 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "type은 full, increment, smart중 하나여야 합니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**작업 이름 중복 (409 Conflict)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "JOB_NAME_ALREADY_EXISTS",
  "timestamp": "2026-02-05 10:30:00"
}
```

> `individual.jobName`을 명시적으로 지정했으나 동일한 이름의 작업이 이미 존재하는 경우 발생합니다.

</details>

---
