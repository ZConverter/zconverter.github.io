
새로운 OS 복제 작업을 등록합니다.

---

## `POST /os-replications` {#post-os-replications}

> * 새로운 OS 복제 작업을 시스템에 등록합니다.
> * 복제 방식(upload, download)에 따라 해당 타입 필드만 DB에 매핑됩니다.
> * `cloudKeyId`, `zosRepositoryId`, `repositoryId`는 필수이며, center 소속 검증이 수행됩니다.
> * `repositoryPath` 미입력 시 `repositoryId`의 `remotePath` 값을 자동 사용합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/os-replications</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시 (Upload)</strong></summary>

```bash
curl -X POST "https://api.example.com/api/os-replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "center-01",
    "replicationType": "upload",
    "cloudKeyId": 1,
    "zosRepositoryId": 2,
    "repositoryId": 3,
    "mode": "full",
    "folderName": "testUpload",
    "uploadNewly": "disabled",
    "networkLimit": 10,
    "fileFilter": "*.iso"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 예시 (Download)</strong></summary>

```bash
curl -X POST "https://api.example.com/api/os-replications" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "center-01",
    "replicationType": "download",
    "cloudKeyId": 1,
    "zosRepositoryId": 2,
    "repositoryId": 5,
    "mode": "full",
    "downloadType": "all",
    "networkLimit": 0
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|---------|------|------|------|--------|------|--------|
| `Authorization` | Header | string | Required | | Bearer 토큰 | |
| `center` | Body | string | Required | | 센터 ID 또는 이름 | |
| `replicationType` | Body | string | Required | | 복제 방식 | `upload`, `download` |
| `cloudKeyId` | Body | number | Required | | Cloud Key ID (`cloud_info_zos.nID`) | |
| `zosRepositoryId` | Body | number | Required | | ZOS Repository ID (`center_zos_repository.nID`) | |
| `repositoryId` | Body | number | Required | | Repository ID (`center_repository.nID`) | |
| `mode` | Body | string | Required | | 복제 모드 | `full`, `incremental` |
| `jobName` | Body | string | Optional | 자동생성 | 작업 이름 | |
| `repositoryPath` | Body | string | Optional | Repository의 remotePath | 저장소 경로 | |
| `folderName` | Body | string | Optional | | 폴더 이름 | |
| `networkLimit` | Body | number | Optional | `0` | 네트워크 제한 (KB/s) | |
| `fileFilter` | Body | string | Optional | | 파일 필터 | |
| `uploadNewly` | Body | string | Optional | `disabled` | 업로드 신규 파일 옵션 (upload 전용) | `disabled`, `newly_only` |
| `downloadType` | Body | string | Optional | `all` | 다운로드 타입 (download 전용) | `all`, `folder` |
| `schedule` | Body | object/number | Optional | | 스케줄 | |
| `autoStart` | Body | string | Optional | `not use` | 자동 시작 | `use`, `not use` |

> **검증 항목:**
> - `center` — DB 존재 확인
> - `cloudKeyId` — `cloud_info_zos` 존재 + center 소속 검증
> - `zosRepositoryId` — `center_zos_repository` 존재 + center 소속 검증
> - `repositoryId` — `center_repository` 존재 + center 소속 검증

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "results": [
      {
        "state": "success",
        "jobName": "os_repl_upload_1712345678901",
        "unitType": "Upload",
        "replicationMode": "Full",
        "autoStart": "not use"
      }
    ],
    "summary": { "total": 1, "successful": 1, "failed": 0 }
  },
  "message": "Os Replication registered",
  "timestamp": "2026-04-08 12:00:00"
}
```

</details>
