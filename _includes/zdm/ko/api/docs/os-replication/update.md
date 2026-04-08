
OS 복제 작업을 수정합니다.

---

## `PUT /os-replications/:identifier` {#put-os-replications}

> * ID(숫자) 또는 작업 이름(문자열)으로 대상을 지정합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/os-replications/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X PUT "https://api.example.com/api/os-replications/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "changeName": "new-job-name",
    "uploadMode": "incremental",
    "uploadFolderName": "newFolder",
    "uploadNewly": "newly_only",
    "uploadNetworkLimit": 1000,
    "uploadFileFilter": "*.img"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `identifier` | Path | string | Required | 작업 ID 또는 이름 | |
| `changeName` | Body | string | Optional | 변경할 작업 이름 | |
| `status` | Body | string | Optional | 작업 상태 | `start`, `stop` |
| `uploadMode` | Body | string | Optional | 업로드 모드 | `full`, `incremental` |
| `uploadFolderName` | Body | string | Optional | 업로드 폴더 이름 | |
| `uploadNewly` | Body | string | Optional | 업로드 신규 파일 옵션 | `disabled`, `newly_only` |
| `uploadNetworkLimit` | Body | number | Optional | 업로드 네트워크 제한 | |
| `uploadFileFilter` | Body | string | Optional | 업로드 파일 필터 | |
| `downloadMode` | Body | string | Optional | 다운로드 모드 | `full`, `incremental` |
| `downloadNetworkLimit` | Body | number | Optional | 다운로드 네트워크 제한 | |
| `schedule` | Body | object/number | Optional | 스케줄 | |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "replicationInfo": { "id": 1, "name": "new-job-name" },
    "summary": {
      "updatedFields": [
        { "field": "jobName", "previous": "old-name", "new": "new-job-name" },
        { "field": "uploadMode", "previous": "Full", "new": "Incremental" },
        { "field": "uploadNewly", "previous": "Disabled", "new": "Newly Created Files Only" }
      ]
    }
  },
  "message": "Os Replication updated",
  "timestamp": "2026-04-08 12:00:00"
}
```

</details>
