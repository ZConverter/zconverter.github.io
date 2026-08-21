
OS 복제 작업을 단건 조회합니다.

---

## `GET /os-replications/:identifier` {#get-os-replications-identifier}

> * ID(숫자) 또는 작업 이름(문자열)으로 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | 작업 ID(숫자) 또는 작업 이름 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (Upload)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "system": { "name": "center-01" },
    "job": {
      "info": {
        "id": "1",
        "name": "os_repl_upload_1712345678901",
        "replicationType": "Upload",
        "status": {
          "current": "Complete",
          "time": { "start": "2026-04-08 12:00:00", "elapsed": "-", "end": "-" }
        },
        "lastUpdated": "2026-04-08 12:00:00"
      },
      "cloudKeyId": 1,
      "sourceRepository": { "id": "3", "path": "/source/path" },
      "uploadInfo": {
        "mode": "Full",
        "folderName": "testUpload",
        "networkLimit": 10,
        "fileFilter": "*.iso",
        "newly": "Disabled"
      }
    }
  },
  "message": "Os Replication retrieved",
  "timestamp": "2026-04-08 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (Download)</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "system": { "name": "center-01" },
    "job": {
      "info": {
        "id": "2",
        "name": "os_repl_download_1712345678902",
        "replicationType": "Download",
        "status": {
          "current": "Scheduled",
          "time": { "start": "-", "elapsed": "-", "end": "-" }
        },
        "lastUpdated": "2026-04-08 12:00:00"
      },
      "cloudKeyId": 1,
      "sourceRepository": { "id": "-", "path": "-" },
      "downloadInfo": {
        "mode": "Full",
        "type": "Entire Bucket",
        "folderName": "-",
        "networkLimit": 0,
        "fileFilter": "-",
        "repositoryId": "5",
        "repositoryPath": "/download/path"
      }
    }
  },
  "message": "Os Replication retrieved",
  "timestamp": "2026-04-08 12:00:00"
}
```

> `replicationType` 이 `Upload` 이면 `uploadInfo`, `Download` 이면 `downloadInfo` 가 포함됩니다. `downloadInfo.type` 은 `Entire Bucket` 또는 `Specific Folder`. (필드 상세는 `GET /os-replications` 목록 조회 문서의 응답 필드 표 참고)

</details>
