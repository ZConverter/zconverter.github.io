
특정 복구 작업을 삭제합니다.

---

## `DELETE /recoveries/:identifier` {#delete-recoveries-identifier}

> * 복구 ID 또는 복구 이름으로 특정 복구 작업을 삭제합니다.
> * 삭제 시 관련된 모든 데이터가 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복구 ID로 삭제
curl -X DELETE "https://api.example.com/api/recoveries/1" \
  -H "Authorization: Bearer <token>"

# 복구 이름으로 삭제 (이름 삭제 시 center 필수, 1개만)
curl -X DELETE "https://api.example.com/api/recoveries/daily-recovery?center=1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 ID (숫자) 또는 복구 이름 | - |
| `center` | Query | string | Conditional | - | 삭제 대상 center 식별자 (ID 또는 이름). **정확히 1개만** 지정할 수 있습니다. 복구 ID로 삭제할 때는 선택, 복구 이름으로 삭제할 때는 필수입니다 | - |

> **참고:**
> - `center`는 삭제 대상이 모호해지지 않도록 **정확히 1개**만 허용합니다. `?center=1,zdm-b`처럼 여러 개를 지정하면 400으로 거부됩니다.
>   (조회 계열의 comma-separated 다중 지정은 삭제에는 적용되지 않습니다.)
> - `?center=`처럼 **키만 보내고 값이 비어 있으면 400**입니다. 파라미터를 아예 **생략**하는 것과는 다릅니다.
> - `center`의 **개수·빈 값** 검증은 요청 스키마 단계에서 수행되므로, 응답은 요청 검증 에러 형식으로 반환됩니다.
> - 복구 **이름**으로 삭제하면서 `center`를 생략하면 `CENTER-ERROR-02`(400)로 거부됩니다. 다중 center 환경에서 다른 center의 동명 작업이 삭제되는 것을 막기 위함입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "jobInfo": [
      {
        "name": "daily-recovery",
        "partition": "/",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
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
        "additionalInfoDeleted": 1,
        "detailInfoDeleted": 2,
        "historyDataDeleted": 5,
        "logDataDeleted": 10
      }
    }
  },
  "message": "Recovery job deleted",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `jobInfo[].name` | string | 삭제된 작업 이름 |
| `jobInfo[].partition` | string | 대상 파티션 |
| `jobInfo[].deletedComponents.basicInfo` | boolean | 기본 정보 삭제 여부 |
| `jobInfo[].deletedComponents.additionalInfo` | boolean | 추가 정보 삭제 여부 |
| `jobInfo[].deletedComponents.detailInfo` | boolean | 상세 정보 삭제 여부 |
| `jobInfo[].deletedComponents.historyData` | boolean | 히스토리 데이터 삭제 여부 |
| `jobInfo[].deletedComponents.logData` | boolean | 로그 데이터 삭제 여부 |
| `jobInfo[].errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 삭제 결과 (`success` / `fail`) |
| `summary.affectedComponents.basicInfoDeleted` | number | 삭제된 기본 정보 수 |
| `summary.affectedComponents.additionalInfoDeleted` | number | 삭제된 추가 정보 수 |
| `summary.affectedComponents.detailInfoDeleted` | number | 삭제된 상세 정보 수 |
| `summary.affectedComponents.historyDataDeleted` | number | 삭제된 히스토리 데이터 수 |
| `summary.affectedComponents.logDataDeleted` | number | 삭제된 로그 데이터 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**복구 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-01",
    "message": "Job info not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**center 지정 오류 (400 Bad Request)**

`center`를 2개 이상 지정했거나, 값이 비어 있는 경우 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": [
        "exactly one center must be specified"
      ]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
