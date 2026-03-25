
특정 복제 작업을 조회합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `GET /replications/:identifier` {#get-replications-identifier}

> * 복제 ID 또는 작업 이름으로 특정 복제 작업 정보를 조회합니다.
> * identifier가 숫자인 경우 작업 ID로, 그 외에는 작업 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업 ID로 조회
curl -X GET "https://api.example.com/api/replications/1" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 조회
curl -X GET "https://api.example.com/api/replications/backup-replication-01" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/replications/1?detail=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복제 작업 ID (숫자) 또는 작업 이름 | - |
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 대상 서버 이름/ID 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/replication-job-status.md %} |
| `mode` | Query | string | Optional | - | 복제 모드 필터 | {% include zdm/replication-modes.md %} |
| `unit` | Query | string | Optional | - | 복제 단위 유형 필터 | {% include zdm/replication-unit-types.md %} |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |

<details markdown="1">
<summary><strong>V1 차이점</strong></summary>

| 파라미터 | V1 선택값 |
|----------|-----------|
| `mode` | {% include zdm/replication-v1-modes.md %} (`sync` 미지원) |
| `unit` | {% include zdm/replication-v1-unit-types.md %} (`server` 미지원) |

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>성공 응답 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "system": {
      "name": "center-01"
    },
    "job": {
      "info": {
        "id": 1,
        "name": "backup-replication-01",
        "unitType": "backup",
        "replicationMode": "full",
        "status": "success",
        "startTime": "2026-03-20 02:00:00",
        "endTime": "2026-03-20 02:30:00",
        "lastUpdated": "2026-03-20 02:30:00"
      },
      "backupJob": [
        {
          "name": "daily-backup",
          "id": 10
        }
      ],
      "repository": {
        "target": {
          "id": 1,
          "type": "nfs",
          "path": "/replication/target"
        }
      },
      "option": {
        "compression": "use",
        "encryption": "not use",
        "networkLimit": 0,
        "mailEvent": ""
      }
    }
  },
  "message": "Replication info",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 센터 이름 |
| `job.info.id` | number | 복제 작업 ID |
| `job.info.name` | string | 작업 이름 |
| `job.info.unitType` | string | 복제 단위 유형 ({% include zdm/replication-unit-types.md %}) |
| `job.info.replicationMode` | string | 복제 모드 ({% include zdm/replication-modes.md %}) |
| `job.info.status` | string | 작업 상태 |
| `job.info.startTime` | string | 작업 시작 시간 |
| `job.info.endTime` | string | 작업 종료 시간 |
| `job.info.lastUpdated` | string | 마지막 업데이트 시간 |
| `job.backupJob[].name` | string | 백업 작업 이름 (unitType=backup) |
| `job.backupJob[].id` | number | 백업 작업 ID (unitType=backup) |
| `job.server.source[].id` | number | 소스 서버 ID (unitType=server) |
| `job.server.source[].name` | string | 소스 서버 이름 (unitType=server) |
| `job.repository.source` | object | 소스 레포지토리 정보 (unitType=repository) |
| `job.repository.target` | object | 타겟 레포지토리 정보 |
| `job.option.compression` | string | 압축 사용 여부 |
| `job.option.encryption` | string | 암호화 사용 여부 |
| `job.option.networkLimit` | number | 네트워크 제한 속도 (0: 무제한) |
| `job.option.mailEvent` | string | 이벤트 알림 이메일 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복제 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Replication not found for ID '999'",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
