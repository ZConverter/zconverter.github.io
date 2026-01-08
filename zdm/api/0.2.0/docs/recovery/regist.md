---
layout: docs
title: POST /recoveries
section_title: ZDM API Documentation
navigation: api-0.2.0
---

새로운 복구 작업을 등록합니다.

---

## `POST /recoveries` {#post-recoveries}

> * 새로운 복구 작업을 시스템에 등록합니다.
> * Source 서버의 백업 데이터를 Target 서버로 복구합니다.

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
    "center": "1",
    "source": "source-server",
    "target": "target-server",
    "platform": "vmware",
    "repository": {
      "type": "nfs",
      "path": "/backup/source-server"
    },
    "mode": "full",
    "jobName": "daily-recovery"
  }'

# 상세 설정 포함 복구 작업 등록
curl -X POST "https://api.example.com/api/v1/recoveries" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "source": "source-server",
    "target": "target-server",
    "platform": "aws",
    "repository": {
      "type": "smb",
      "path": "//192.168.1.100/backup"
    },
    "mode": "full",
    "afterReboot": "reboot",
    "overwrite": "allow",
    "jobList": [
      {
        "sourcePartition": "/",
        "targetPartition": "/dev/sda1"
      },
      {
        "sourcePartition": "/home",
        "targetPartition": "/dev/sdb1",
        "mode": "increment"
      }
    ]
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `source` | string | Required | 소스 서버 ID (숫자) 또는 서버 이름 | - |
| `target` | string | Required | 타겟 서버 ID (숫자) 또는 서버 이름 | - |
| `platform` | string | Required | 타겟 플랫폼 | {% include zdm/platforms.md inline=true %} |
| `repository` | object | Required | 레포지토리 정보 | - |
| `repository.type` | string | Required | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `repository.path` | string | Required | 레포지토리 경로 | - |
| `mode` | string | Required | 작업 모드 | {% include zdm/job-modes.md %} |
| `jobName` | string | Optional | 작업 이름 | - |
| `overwrite` | string | Optional | 덮어쓰기 허용 여부 | {% include zdm/overwrite-options.md api=true %} |
| `user` | string | Optional | 사용자 ID (숫자) 또는 이메일 | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `description` | string | Optional | 작업 설명 | - |
| `afterReboot` | string | Optional | 작업 후 부팅 방식 | {% include zdm/after-reboot.md %} |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한) | - |
| `excludePartition` | string | Optional | 제외 파티션 | - |
| `mailEvent` | string | Optional | 이벤트 알림 이메일 | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `scriptPath` | string | Optional | 실행할 스크립트 경로 | - |
| `scriptRun` | string | Optional | 스크립트 실행 타이밍 | {% include zdm/script-timing.md %} |
| `cloudAuth` | string | Optional | 클라우드 인증 정보 ID/Name | - |
| `listOnly` | boolean | Optional | 지정 항목만 작업 여부 | - |
| `jobList` | array | Optional | 개별 작업 설정 배열 | - |

**jobList 항목 구조:**

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `sourcePartition` | string | Required | 소스 파티션 |
| `targetPartition` | string | Required | 타겟 파티션 |
| `overwrite` | string | Optional | 덮어쓰기 허용 여부 |
| `backupFile` | string | Optional | 사용할 백업 파일 이름 |
| `mode` | string | Optional | 작업 모드 |
| `repository` | object | Optional | 레포지토리 정보 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "common": {
      "state": "success",
      "jobName": "daily-recovery",
      "autoStart": "not use",
      "platform": "vmware",
      "bootMode": "reboot",
      "schedule": {
        "basic": {
          "type": "daily",
          "description": "Every day at 10:00"
        }
      },
      "scriptPath": "/opt/scripts/post-recovery.sh",
      "scriptRunTiming": "after job"
    },
    "partitions": [
      {
        "partition": "/",
        "jobMode": "full",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLast": "true",
          "backupFile": "backup-2025-01-15.img",
          "backupJob": "daily-backup"
        },
        "repository": {
          "id": "1",
          "path": "/backup",
          "type": "nfs"
        }
      },
      {
        "partition": "/home",
        "jobMode": "increment",
        "overwrite": "allow",
        "fileSystem": "ext4",
        "backup": {
          "useLast": "true",
          "backupFile": "backup-home-2025-01-15.img",
          "backupJob": "daily-backup-home"
        },
        "repository": {
          "id": "1",
          "path": "/backup",
          "type": "nfs"
        }
      }
    ],
    "summary": {
      "total": 2,
      "successful": 2,
      "failed": 0
    }
  },
  "message": "Recovery jobs registered",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `common.state` | string | 등록 결과 (`success` / `fail`) |
| `common.jobName` | string | 등록된 작업 이름 |
| `common.autoStart` | string | 자동 시작 여부 |
| `common.platform` | string | 타겟 플랫폼 |
| `common.bootMode` | string | 작업 후 부팅 모드 (`reboot` / `shutdown` / `maintain`) |
| `common.schedule.basic` | object/string | 기본 스케줄 정보 (설정시에만 포함) |
| `common.scriptPath` | string | 스크립트 경로 (설정시에만 포함) |
| `common.scriptRunTiming` | string | 스크립트 실행 타이밍 (`before job` / `after job`, 설정시에만 포함) |
| `common.errorMessage` | string | 실패 시 오류 메시지 |
| `partitions[].partition` | string | 파티션/드라이브 명 |
| `partitions[].jobMode` | string | 파티션별 작업 모드 |
| `partitions[].overwrite` | string | 덮어쓰기 상태 |
| `partitions[].fileSystem` | string | 파일시스템 |
| `partitions[].backup.useLast` | string | 최신 백업 파일 사용 여부 |
| `partitions[].backup.backupFile` | string | 백업 파일 이름 |
| `partitions[].backup.backupJob` | string | 백업 작업 이름 |
| `partitions[].repository.id` | string | 레포지토리 ID |
| `partitions[].repository.path` | string | 레포지토리 경로 |
| `partitions[].repository.type` | string | 레포지토리 타입 |
| `summary.total` | number | 총 파티션 수 |
| `summary.successful` | number | 성공한 파티션 수 |
| `summary.failed` | number | 실패한 파티션 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "platform은 oci, ncp, gcp, aws, azure, vmware, scp, openstack, cloudstack, kt, nhn, nutanix, proxmox, kvm, hyperv, xenserver중 하나여야 합니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
