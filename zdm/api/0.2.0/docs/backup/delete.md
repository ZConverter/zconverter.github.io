---
layout: docs
title: DELETE /backups/:identifier
section_title: ZDM API Documentation
navigation: api-0.2.0
---

특정 백업 작업을 삭제합니다.

---

## `DELETE /backups/:identifier` {#delete-backups-identifier}

> * 백업 ID 또는 백업 이름으로 특정 백업 작업을 삭제합니다.
> * 삭제 시 관련된 모든 데이터(기본 정보, 상세 정보, 히스토리, 로그)가 함께 삭제됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/v1/backups/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 백업 ID로 삭제
curl -X DELETE "https://api.example.com/api/v1/backups/1" \
  -H "Authorization: Bearer <token>"

# 백업 이름으로 삭제
curl -X DELETE "https://api.example.com/api/v1/backups/daily-backup" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 백업 ID (숫자) 또는 백업 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "jobInfo": [
      {
        "name": "daily-backup",
        "partition": "/",
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
        "logDataDeleted": 10
      }
    }
  },
  "message": "Backup job deleted",
  "timestamp": "2025-01-15T10:30:00Z"
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
| `jobInfo[].deletedComponents.detailInfo` | boolean | 상세 정보 삭제 여부 |
| `jobInfo[].deletedComponents.historyData` | boolean | 히스토리 데이터 삭제 여부 |
| `jobInfo[].deletedComponents.logData` | boolean | 로그 데이터 삭제 여부 |
| `jobInfo[].errorMessage` | string | 실패 시 오류 메시지 |
| `summary.state` | string | 삭제 결과 (`success` / `fail`) |
| `summary.affectedComponents.basicInfoDeleted` | number | 삭제된 기본 정보 수 |
| `summary.affectedComponents.detailInfoDeleted` | number | 삭제된 상세 정보 수 |
| `summary.affectedComponents.historyDataDeleted` | number | 삭제된 히스토리 데이터 수 |
| `summary.affectedComponents.logDataDeleted` | number | 삭제된 로그 데이터 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**백업 작업을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "code": "BACKUP_NOT_FOUND",
    "message": "ID가 '999'인 Backup을 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
