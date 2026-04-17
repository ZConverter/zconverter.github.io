
OS 복제 작업 목록을 조회합니다.

---

## `GET /os-replications` {#get-os-replications}

> * 등록된 OS 복제 작업 목록을 조회합니다.
> * 필터링 및 페이지네이션을 지원합니다.
> * `replicationType`에 따라 `uploadInfo` 또는 `downloadInfo` 중 하나만 포함됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications?type=upload&mode=full&page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `jobId` | Query | number | Optional | 작업 ID 필터 | |
| `jobName` | Query | string | Optional | 작업 이름 필터 | |
| `server` | Query | string | Optional | 서버 이름 필터 | |
| `type` | Query | string | Optional | 복제 방식 필터 | `upload`, `download` |
| `mode` | Query | string | Optional | 복제 모드 필터 | `full`, `incremental` |
| `page` | Query | number | Optional | 페이지 번호 | |
| `limit` | Query | number | Optional | 페이지당 개수 | |
| `center` | Query | string | Optional | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (Upload)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    {
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
    }
  ],
  "message": "Os Replication list",
  "timestamp": "2026-04-08 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (Download)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    {
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
        },
        "schedule": {
          "id": "10",
          "type": "daily",
          "description": "매일 02:00"
        }
      }
    }
  ],
  "message": "Os Replication list",
  "timestamp": "2026-04-08 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `job.info.replicationType` | string | 공통 | `Upload` 또는 `Download` |
| `job.cloudKeyId` | number | 공통 | Cloud Key ID |
| `job.sourceRepository` | object | 공통 | 소스 저장소 (id, path) |
| `job.uploadInfo` | object | Upload | 업로드 설정 (mode, folderName, networkLimit, fileFilter, newly) |
| `job.uploadInfo.newly` | string | Upload | `Disabled` 또는 `Newly Created Files Only` |
| `job.downloadInfo` | object | Download | 다운로드 설정 (mode, type, folderName, networkLimit, fileFilter, repositoryId, repositoryPath) |
| `job.downloadInfo.type` | string | Download | `Entire Bucket` 또는 `Specific Folder` |
| `job.schedule` | object | 스케줄 있을 때 | 스케줄 정보 (id, type, description) |

</details>
