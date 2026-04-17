
새로운 복제 작업을 등록합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `POST /replications` {#post-replications}

> * 새로운 복제 작업을 시스템에 등록합니다.
> * 복제 단위 유형(backup, repository, server)에 따라 필수 필드가 달라집니다.
> * v2.0.0부터 `sourceRepository`, `targetRepository`, `sourceServer`, `backup` 필드를 단일 문자열(comma-separated)로 단순화했습니다. 다중 값은 콤마로 구분하며, 각 값은 ID 또는 이름/경로를 혼용할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/replications</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# backup 단위 복제 등록
curl -X POST "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceCenter": "1",
    "targetCenter": "2",
    "replicationUnitType": "backup",
    "replicationMode": "full",
    "backup": "daily-backup",
    "targetRepository": "/replication/target",
    "compression": "use",
    "autoStart": "not use"
  }'

# repository 단위 복제 등록 (다중 소스)
curl -X POST "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceCenter": "1",
    "targetCenter": "2",
    "replicationUnitType": "repository",
    "replicationMode": "incremental",
    "sourceRepository": "39,40",
    "targetRepository": "41",
    "networkLimit": 1024
  }'

# server 단위 복제 등록 (스케줄 포함)
curl -X POST "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceCenter": "1",
    "targetCenter": "2",
    "replicationUnitType": "server",
    "replicationMode": "sync",
    "sourceServer": "web-server-01",
    "targetRepository": "/replication/server",
    "schedule": {
      "type": 3,
      "basic": {
        "time": "02:00"
      }
    },
    "autoStart": "use"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `sourceCenter` | string \| number | Required | 소스 센터 ID 또는 이름 | - |
| `targetCenter` | string \| number | Required | 타겟 센터 ID 또는 이름 | - |
| `replicationUnitType` | string | Required | 복제 단위 유형 | {% include zdm/replication-unit-types.md %} |
| `replicationMode` | string | Optional | 복제 모드 | {% include zdm/replication-modes.md %} |
| `jobName` | string | Optional | 작업 이름 | - |
| `ip` | string | Optional | 타겟 IP 주소 | - |
| `port` | number | Optional | 타겟 포트 | - |
| `compression` | string | Optional | 압축 사용 여부 | {% include zdm/use-options.md %} |
| `networkLimit` | number | Optional | 네트워크 제한 속도 (0: 무제한) | - |
| `schedule` | object/number | Optional | 스케줄 객체 또는 스케줄 ID | - |
| `autoStart` | string | Optional | 자동 시작 여부 | {% include zdm/use-options.md %} |
| `targetRepository` | string | Required | 타겟 레포지토리 (단일 ID 또는 경로, 예: `"41"` / `"/replication/target"`) | - |
| `sourceRepository` | string | Conditional | 소스 레포지토리 (unitType=repository 시 필수, comma-separated ID/경로 다중 가능, 예: `"39,40"`) | - |
| `sourceServer` | string | Conditional | 소스 서버 (unitType=server 시 필수, comma-separated ID/이름 다중 가능, 예: `"1,web-server-01"`) | - |
| `backup` | string | Conditional | 백업 작업 (unitType=backup 시 필수, comma-separated ID/작업이름 다중 가능, 예: `"1,daily-backup"`) | - |

> **v1.3.x → v2.0.0 마이그레이션**:
> - `sourceRepository: [{ id: 1 }, { path: "/p2" }]` → `sourceRepository: "1,/p2"`
> - `targetRepository: { id: 41 }` → `targetRepository: "41"`
> - `sourceServer: [{ name: "web-01" }]` → `sourceServer: "web-01"`
> - `backupJobName: ["daily-backup"]` → `backup: "daily-backup"` (필드명도 변경)

<details markdown="1">
<summary><strong>V1 요청 본문 차이점</strong></summary>

> V1에서도 동일하게 `sourceRepository`/`targetRepository`를 단일 문자열로 단순화했습니다.

| 항목 | V2 | V1 |
|------|----|----|
| `replicationUnitType` | {% include zdm/replication-unit-types.md %} | {% include zdm/replication-v1-unit-types.md %} |
| `replicationMode` | {% include zdm/replication-modes.md %} | {% include zdm/replication-v1-modes.md %} |
| 소스 참조 (image) | `backup`: string (다중) | `backupName`: string, `transferBackupName`: string |
| 소스 레포지토리 | `sourceRepository`: string (다중) | `sourceRepository`: string (단일) |
| 소스 서버 | `sourceServer`: string (다중) | 미지원 |

**V1 요청 본문 필드:**

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `replicationUnitType` | string | Required | 복제 단위 유형 | {% include zdm/replication-v1-unit-types.md %} |
| `replicationMode` | string | Optional | 복제 모드 | {% include zdm/replication-v1-modes.md %} |
| `backupName` | string | Conditional | 백업 이름 (unitType=image 시 필수) | - |
| `transferBackupName` | string | Conditional | 전송 백업 이름 (unitType=image 시 필수) | - |
| `sourceRepository` | string | Conditional | 소스 레포지토리 (unitType=repository 시 필수, 단일 ID 또는 경로, 예: `"39"`) | - |
| `targetRepository` | string | Required | 타겟 레포지토리 (단일 ID 또는 경로, 예: `"41"`) | - |

> 그 외 공통 필드 (`sourceCenter`, `targetCenter`, `jobName`, `ip`, `port`, `compression`, `networkLimit`, `schedule`, `autoStart`)는 V2와 동일합니다.

**V1 요청 예시:**

```bash
# image 단위 복제 등록 (V1)
curl -X POST "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceCenter": "1",
    "targetCenter": "2",
    "replicationUnitType": "image",
    "replicationMode": "full",
    "backupName": "daily-backup",
    "transferBackupName": "daily-backup-transfer",
    "targetRepository": "/replication/target",
    "compression": "use"
  }'

# repository 단위 복제 등록 (V1)
curl -X POST "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceCenter": "1",
    "targetCenter": "2",
    "replicationUnitType": "repository",
    "replicationMode": "incremental",
    "sourceRepository": "39",
    "targetRepository": "//192.168.1.100/replication"
  }'
```

</details>

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

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "backup-replication-01",
        "unitType": "backup",
        "replicationMode": "full",
        "autoStart": "not use",
        "schedule": {
          "type": "Daily",
          "time": "02:00"
        }
      }
    ]
  },
  "message": "Replication job registration completed",
  "timestamp": "2026-04-17 10:30:00"
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
| `results[].unitType` | string | 복제 단위 유형 |
| `results[].replicationMode` | string | 복제 모드 |
| `results[].autoStart` | string | 자동 시작 여부 |
| `results[].schedule` | object | 스케줄 정보 (설정시에만 포함) |
| `results[].errorMessage` | string | 실패 시 오류 메시지 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "replicationUnitType은 backup, repository, server 중 하나여야 합니다",
  "timestamp": "2026-04-17 10:30:00"
}
```

**작업 이름 중복 (409 Conflict)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "JOB_NAME_ALREADY_EXISTS",
  "timestamp": "2026-04-17 10:30:00"
}
```

</details>

---
