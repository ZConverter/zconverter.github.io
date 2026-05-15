
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
