
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
| `status` | Query | string | Optional | - | 작업 상태 필터. 응답 `job.info.status.current` 와 같은 상태 값이며 대소문자를 구분하지 않습니다. 작업은 있으나 상태가 다르면 404 입니다(아래 에러 응답 참고) | {% include zdm/replication-job-status.md %} |
| `mode` | Query | string | Optional | - | 복제 모드 필터 | {% include zdm/replication-modes.md %} |
| `unit` | Query | string | Optional | - | 복제 단위 유형 필터 | {% include zdm/replication-unit-types.md %} |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `center` | Query | string | Optional | - | center 식별자(ID/이름, 콤마 다중 지정 가능). 지정한 center 에 속한 작업만 조회합니다. 존재하지 않는 center 이거나 그 center 에 작업이 없으면 404 입니다 | - |

> * 단건 조회에서도 `status` 를 적용합니다. 작업은 존재하지만 현재 상태가 `status` 와 다르면 404 `NOT_FOUND` 이며, 메시지의 `exists, but` 로 작업 미존재와 구분할 수 있습니다.
> * `center` · `server` 는 **키를 보냈는데 값이 비어 있으면**(`?center=`) 400 입니다. 파라미터를 **생략**하는 것은 종전대로 "필터 없음" 이므로 동작 변화가 없습니다.

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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "system": {
      "name": "center-01"
    },
    "job": {
      "info": {
        "id": "1",
        "name": "backup-replication-01",
        "unitType": "Backup Policy",
        "replicationMode": "Full",
        "status": {
          "current": "Complete",
          "time": {
            "start": "2026-03-20 02:00:00",
            "elapsed": "00:30:00",
            "end": "2026-03-20 02:30:00"
          }
        },
        "lastUpdated": "2026-03-20 02:30:00"
      },
      "backupJob": [
        {
          "name": "daily-backup",
          "id": "10"
        }
      ],
      "repository": {
        "target": {
          "id": "1",
          "type": "NFS",
          "path": "/replication/target",
          "ip": "192.168.1.100",
          "port": 2049
        }
      },
      "option": {
        "compression": "Use",
        "encryption": "Not Use",
        "networkLimit": 0,
        "mailEvent": ""
      }
    }
  },
  "message": "Replication info",
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 센터 이름 |
| `job.info.id` | string | 복제 작업 ID (문자열로 반환) |
| `job.info.name` | string | 작업 이름 |
| `job.info.unitType` | string | 복제 단위 유형 표시값 (`Backup Policy`/`Repository`/`Server`/`Unknown`) |
| `job.info.replicationMode` | string | 복제 모드 표시값 (`Full`/`Incremental`/`Sync`/`Unknown`) |
| `job.info.status.current` | string | 작업 상태. `?status=` 필터 값과 같은 어휘입니다 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`) |
| `job.info.status.time.start` | string | 작업 시작 시간 (`YYYY-MM-DD HH:mm:ss` 또는 `-`) |
| `job.info.status.time.elapsed` | string | 경과 시간 (`HH:MM:SS` 또는 `-`) |
| `job.info.status.time.end` | string | 작업 종료 시간 (`YYYY-MM-DD HH:mm:ss` 또는 `-`) |
| `job.info.lastUpdated` | string | 마지막 업데이트 시간 |
| `job.backupJob[].name` | string | 백업 작업 이름 (unitType=backup) |
| `job.backupJob[].id` | string | 백업 작업 ID (unitType=backup, 문자열) |
| `job.server.source[].id` | string | 소스 서버 ID (unitType=server, 문자열) |
| `job.server.source[].name` | string | 소스 서버 이름 (unitType=server) |
| `job.repository.source` | object | 소스 레포지토리 정보 (unitType=repository) — `{id, path}` 만 반환 |
| `job.repository.target` | object | 타겟 레포지토리 정보 (`{id, type, path, ip, port}`) |
| `job.repository.target.ip` | string | 타겟 레포지토리 IP (기본 `-`) |
| `job.repository.target.port` | number | 타겟 레포지토리 포트 (기본 `0`) |
| `job.option.compression` | string | 압축 사용 여부 (`Use`/`Not Use`/`Unknown`) |
| `job.option.encryption` | string | 암호화 사용 여부 (`Use`/`Not Use`/`Unknown`) |
| `job.option.networkLimit` | number | 네트워크 제한 속도 (0: 무제한) |
| `job.option.mailEvent` | string | 이벤트 알림 이메일 |

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
    "message": "Replication not found (identifier: 999)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**작업은 있으나 `status` 가 맞지 않음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "NOT_FOUND",
    "message": "Replication job with ID '1' exists, but no results match the specified filter conditions."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

작업 이름으로 조회하면 메시지는 `Replication job with Name '<이름>' exists, ...` 입니다.

</details>

---
