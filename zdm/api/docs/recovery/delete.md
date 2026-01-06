---
layout: docs
title: DELETE /recoveries/:identifier
section_title: ZDM API Documentation
navigation: api
---

복구 작업을 삭제합니다.

---

## `DELETE /recoveries/:identifier` {#delete-recovery}

> * 복구 작업을 삭제합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/v1/recoveries/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 삭제
curl -X DELETE "https://api.example.com/api/v1/recoveries/1" \
  -H "Authorization: Bearer <token>"

# 작업명으로 삭제
curl -X DELETE "https://api.example.com/api/v1/recoveries/system-recovery-job" \
  -H "Authorization: Bearer <token>"

# 강제 삭제
curl -X DELETE "https://api.example.com/api/v1/recoveries/1?force=true" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 작업 ID 또는 작업명 | - |
| `force` | Query | boolean | Optional | `false` | 강제 삭제 여부 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-recovery-delete",
  "data": {
    "jobInfo": [
      {
        "name": "system-recovery-job",
        "partition": "/, /test/, /de",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "state": "success",
      "affectedComponents": {
        "basicInfoDeleted": 1,
        "additionalInfoDeleted": 1,
        "detailInfoDeleted": 2,
        "historyDataDeleted": 5,
        "logDataDeleted": 3
      }
    }
  },
  "message": "복구 작업이 성공적으로 삭제되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
