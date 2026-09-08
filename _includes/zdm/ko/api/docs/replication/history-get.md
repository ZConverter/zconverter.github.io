
특정 복제 히스토리를 조회합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `GET /replications/histories/:identifier` {#get-replications-histories-identifier}

> * 히스토리 ID 또는 작업 이름으로 복제 히스토리를 조회합니다.
> * identifier가 숫자인 경우 작업 ID로, 그 외에는 작업 이름으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/replications/histories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 작업 ID로 조회
curl -X GET "https://api.example.com/api/replications/histories/10" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 조회
curl -X GET "https://api.example.com/api/replications/histories/backup-replication-01" \
  -H "Authorization: Bearer <token>"

# 작업 이름 + 필터 적용
curl -X GET "https://api.example.com/api/replications/histories/backup-replication-01?result=success" \
  -H "Authorization: Bearer <token>"

# center 로 좁혀서 조회 (다른 center 의 히스토리면 404)
curl -X GET "https://api.example.com/api/replications/histories/10?center=destconm" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 작업 ID (숫자) 또는 작업 이름 | - |
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 대상 서버 이름 필터 | - |
| `result` | Query | string | Optional | - | 작업 결과 필터 | {% include zdm/replication-history-result.md %} |
| `page` | Query | number | Optional | - | 값 검증만 하며 이 엔드포인트에서는 적용되지 않습니다 | - |
| `limit` | Query | number | Optional | - | 값 검증만 하며 이 엔드포인트에서는 적용되지 않습니다 | - |
| `center` | Query | string | Optional | - | center 식별자(ID/이름, 콤마 다중 지정 가능, 예: `destconm,9`). 조회 대상을 해당 center 로 좁힙니다 | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 (작업 이름 조회의 목록 응답에만 적용) | `asc`, `desc` |

> * `center` · `server` 는 **키를 보냈는데 값이 비어 있으면**(`?center=`) 400 입니다. 파라미터를 **생략**하는 것은 종전대로 "필터 없음" 이므로 동작 변화가 없습니다.
> * `center` 는 **ID 조회·작업 이름 조회 양쪽 모두**에 적용됩니다. 지목한 히스토리가 다른 center 의 것이면 200 이 아니라 **404** 입니다.
> * `jobId` · `jobName` · `server` · `result` 는 identifier 가 **숫자일 때도** 함께 걸립니다. ID 는 존재하지만 필터와 맞지 않으면 **404** 입니다 (예: 실패한 작업에 `?result=success`).
> * 존재하지 않는 center 를 지정하면(예: `?center=no-such-center`) 조회 없이 **404** 입니다. 목록 조회(`GET /replications/histories`)가 빈 배열을 200 으로 돌려주는 것과 다릅니다.
> * `page` · `limit` 은 이 엔드포인트에서 적용되지 않습니다. `sort` 는 작업 이름으로 조회할 때의 **목록 정렬**에만 쓰이고, ID 조회에서 어느 행이 선택되는지에는 영향을 주지 않습니다.
> * `center` · 필터를 **아무것도 지정하지 않은 요청의 동작은 종전과 같습니다.**

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>ID로 조회 시 (단건 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 1,
    "system": {
      "name": "center-01"
    },
    "job": {
      "name": "backup-replication-01",
      "id": 10,
      "sourcePath": "/backup/source",
      "targetPath": "/replication/target",
      "unitType": "repository",
      "replicationMode": "full"
    },
    "result": {
      "status": "COMPLETE",
      "description": "Replication completed successfully"
    },
    "size": {
      "total": 1073741824,
      "replicated": 1073741824
    },
    "count": {
      "total": 150,
      "replicated": 150
    },
    "time": {
      "start": "2026-03-20 02:00:00",
      "end": "2026-03-20 02:30:00",
      "elapsed": "00:30:00"
    }
  },
  "message": "Replication history retrieved",
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary>작업 이름으로 조회 시 (목록 응답)</summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "id": 1,
      "system": {
        "name": "center-01"
      },
      "job": {
        "name": "backup-replication-01",
        "id": 10,
        "sourcePath": "/backup/source",
        "targetPath": "/replication/target",
        "unitType": "repository",
        "replicationMode": "full"
      },
      "result": {
        "status": "COMPLETE",
        "description": "Replication completed successfully"
      },
      "size": {
        "total": 1073741824,
        "replicated": 1073741824
      },
      "count": {
        "total": 150,
        "replicated": 150
      },
      "time": {
        "start": "2026-03-20 02:00:00",
        "end": "2026-03-20 02:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "message": "Replication history retrieved",
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 히스토리 ID |
| `system.name` | string | 대상 센터 이름 |
| `job.name` | string | 복제 작업 이름 |
| `job.id` | number | 복제 작업 ID |
| `job.sourcePath` | string | 소스 경로 |
| `job.targetPath` | string | 타겟 경로 |
| `job.unitType` | string | 복제 단위 유형 |
| `job.replicationMode` | string | 복제 모드 |
| `result.status` | string | 작업 결과 상태 |
| `result.description` | string | 작업 결과 설명 |
| `size.total` | number | 전체 크기 (bytes) |
| `size.replicated` | number | 복제 완료 크기 (bytes) |
| `count.total` | number | 전체 파일 수 |
| `count.replicated` | number | 복제 완료 파일 수 |
| `time.start` | string | 작업 시작 시간 |
| `time.end` | string | 작업 종료 시간 |
| `time.elapsed` | string | 경과 시간 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**히스토리를 찾을 수 없음 (404 Not Found)**

지정한 ID 의 히스토리가 없거나, `jobId` · `jobName` · `server` · `result` 필터와 맞지 않는 경우 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "NOT_FOUND",
    "message": "Replication history not found (ID: 999)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**다른 center 의 히스토리 (404 Not Found)**

ID 로 조회했고 그 히스토리가 실제로 존재하지만 지정한 `center` 에 속하지 않는 경우, 메시지가 "없는 ID" 와 구분됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "NOT_FOUND",
    "message": "Replication history ID '10' does not belong to Center 'destconm'"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

> * 이 전용 메시지는 **숫자 identifier(ID) 조회에서만** 나옵니다. 작업 이름으로 조회한 경우는 아래의 `JobName` 문구로 응답합니다.
> * center 는 맞는데 `result` 등 다른 필터에서 걸러진 경우도 위의 `not found (ID: ...)` 문구입니다 — center 탓으로 표기하지 않습니다.

**작업 이름에 해당하는 히스토리 없음 (404 Not Found)**

작업 이름으로 조회했을 때 (지정한 `center` · 필터 조건까지 적용해) 한 건도 없으면 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "NOT_FOUND",
    "message": "Replication history not found (JobName: backup-replication-01)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

---
