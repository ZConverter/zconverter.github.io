
특정 복제 작업을 삭제합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `DELETE /replications/:identifier` {#delete-replications-identifier}

> * 복제 ID 또는 작업 이름으로 특정 복제 작업을 삭제합니다.
> * 삭제 시 관련된 모든 데이터(복제 정보, 히스토리, 로그)가 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복제 ID로 삭제
curl -X DELETE "https://api.example.com/api/replications/1" \
  -H "Authorization: <token>"

# 작업 이름으로 삭제
curl -X DELETE "https://api.example.com/api/replications/backup-replication-01?center=1" \
  -H "Authorization: <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복제 작업 ID (숫자) 또는 작업 이름 | - |
| `center` | Query | string | Conditional | - | 센터 식별자(ID/이름) **정확히 1개**. **`identifier`가 작업 이름인 경우 필수** (silent cross-center 삭제 방지) | - |

> * 삭제는 대상이 모호하면 안 되므로 `center` 는 **정확히 1개만** 허용합니다. `?center=1,zdm-b` 처럼 여러 개를 지정하면 400 입니다.
> * `?center=` 처럼 **키는 보냈는데 값이 비어 있으면** 400 입니다. 파라미터를 **생략**하는 것은 종전대로 "센터 지정 없음" 입니다.
> * 이전에도 같은 규칙이었으나 검증 위치가 서비스 계층에서 **요청 스키마로 옮겨져 에러 형식이 바뀌었습니다.**

<details markdown="1">
<summary><strong>V1 차이점</strong></summary>

* V1 은 작업 이름으로 삭제할 때 `center` 가 필수가 아닙니다. 다만 같은 이름의 작업이 둘 이상이면 아무것도 지우지 않고 409 `CONFLICT` 로 거부합니다(아래 에러 응답).
* V1 삭제도 `center` 를 받습니다(v4.0.0). 종전 V1 삭제에는 `center` 가 없었습니다. 작업 이름으로 지우면 그 center 안에서만 찾고, 작업 ID 로 지우면 작업이 그 center 에 속해야 합니다. 속하지 않으면 404 입니다.
* 쿼리 검사가 V2 와 같아졌습니다(v4.0.0). 선언되지 않은 쿼리 키, `?center=` 처럼 값이 빈 `center`, 2개 이상의 `center` 는 400 `DTO-VALIDATION-03` 입니다. 종전 V1 은 쿼리를 검사하지 않고 무시했습니다.
* 삭제되는 이력 · 로그는 지우는 작업이 속한 center 의 것뿐입니다. 종전에는 다른 center 의 같은 이름 작업 이력 · 로그도 지워졌습니다.

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

> **v2.0.2 변경 사항**: 응답 양식이 backup/recovery 와 통일되었습니다. 기존 `deletedJob` / `deletedRelations` 키는 제거되고 `jobInfo[]` + `summary` 구조로 교체되었습니다. 이전 양식은 [v2.0.1](/zdm/ko/api/2.0.0/docs/replication/delete) 문서를 참고하세요.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "jobInfo": [
      {
        "name": "backup-replication-01",
        "deletedComponents": {
          "basicInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        }
      }
    ],
    "summary": {
      "state": "success",
      "affectedComponents": {
        "basicInfoDeleted": 1,
        "detailInfoDeleted": 1,
        "historyDataDeleted": 5,
        "logDataDeleted": 12
      }
    }
  },
  "message": "Replication job deleted",
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo[].name` | string | 삭제된 작업 이름 |
| `jobInfo[].deletedComponents.basicInfo` | boolean | 기본 정보(메인 테이블) 삭제 여부 — atomic transaction 이라 성공 시 항상 `true` |
| `jobInfo[].deletedComponents.detailInfo` | boolean | 복제 작업 상세 정보 삭제 여부 |
| `jobInfo[].deletedComponents.historyData` | boolean | 히스토리 데이터 삭제 여부 |
| `jobInfo[].deletedComponents.logData` | boolean | 로그 데이터 삭제 여부 |
| `summary.state` | string | 삭제 결과 — atomic 이라 응답 본문 만들어지면 항상 `"success"` (실패 시 throw → 404/500) |
| `summary.affectedComponents.basicInfoDeleted` | number | 삭제된 기본 정보 수 (Main, 항상 1) |
| `summary.affectedComponents.detailInfoDeleted` | number | 삭제된 상세 정보 수 (Info affectedRows) |
| `summary.affectedComponents.historyDataDeleted` | number | 삭제된 히스토리 수 |
| `summary.affectedComponents.logDataDeleted` | number | 삭제된 로그 이벤트 수 |

> **참고**: `partition` 키와 `errorMessage` 키는 응답에 부재합니다 (replication 은 partition 개념 없음, atomic 이라 실패 시 throw).

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
    "message": "Replication not found (identifier: 999, center: 1)"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

`center` 를 지정하지 않은 V1 요청의 메시지에는 `center` 가 붙지 않습니다(`Replication not found (identifier: 999)`). ID 로 지우면서 지정한 `center` 가 작업의 center 와 다를 때도 같은 404 입니다.

**같은 이름의 작업이 여러 개 — V1 이름 삭제 (409 Conflict)**

V1 에서 작업 **이름**으로 삭제하면서 `center` 를 생략했는데 같은 이름의 작업이 둘 이상이면 아무것도 삭제하지 않고 거부합니다(v4.0.0). 종전에는 그중 한쪽이 지워졌습니다. 메시지에 걸린 작업 ID 가 실리므로 **ID 로 다시 요청**하거나 `center` 를 함께 지정하세요.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CONFLICT",
    "message": "Multiple replication jobs named 'backup-replication-01' exist (ids: 3, 7). Delete by job id instead."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**잘못된 쿼리 (400 Bad Request)**

`center` 를 2개 이상 지정했거나 값이 빈 경우, V1 에서는 선언되지 않은 쿼리 키를 보낸 경우 반환됩니다. 코드는 `DTO-VALIDATION-03` 입니다.

</details>

---
