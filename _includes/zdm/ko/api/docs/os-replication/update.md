{% include zdm/base-path.html %}

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
    "center": "center-01",
    "changeName": "new-job-name",
    "uploadMode": "increment",
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
| `center` | Body | string \| number | Required | 센터 ID 또는 이름 (소속 검증용) | |
| `changeName` | Body | string | Optional | 변경할 작업 이름 | |
| `status` | Body | string | Optional | 작업 상태. 대소문자를 구분하지 않습니다 | `start`, `stop` |
| `uploadMode` | Body | string | Optional | 업로드 모드 | `full`, `increment` |
| `uploadFolderName` | Body | string | Optional | 업로드 폴더 이름 | |
| `uploadNewly` | Body | string | Optional | 업로드 신규 파일 옵션 | `disabled`, `newly_only` |
| `uploadNetworkLimit` | Body | number | Optional | 업로드 네트워크 제한 | |
| `uploadFileFilter` | Body | string | Optional | 업로드 파일 필터 | |
| `downloadMode` | Body | string | Optional | 다운로드 모드 | `full`, `increment` |
| `downloadNetworkLimit` | Body | number | Optional | 다운로드 네트워크 제한 | |
| `schedule` | Body | object \| number | Optional | 스케줄 객체 또는 schedule ID. type `0`~`6`(basic)만 지원합니다. 변경 시 `updatedFields` 에 `{ id, type, description }` 객체로 표시. 아래 "schedule 객체 구조" 참조 | |

</details>

<details markdown="1">
<summary><strong>schedule 객체 구조</strong></summary>

{% include zdm/schedule-object.md smart=false %}

- 숫자 ID 는 **복사 없이 그 스케줄을 참조**하며, 작업의 스케줄이 실제로 그 ID 로 바뀝니다.
- 존재하지 않는 ID 는 404 `SCHEDULE-ERROR-01` 입니다.
- 지정한 스케줄이 작업이 속한 center 의 것이 아니면 403 `CENTER-ERROR-01` 입니다(`Schedule ID '<id>' does not belong to center <center>`). `nCenterID = 0` 도 하나의 center 로 비교합니다. 객체 안 숫자 ID 는 행 type 이 요청 `type` 과 다르면 400 `JOB-ERROR-108` 이며, 검사 순서는 존재(404) → center(403) → type(400)입니다.
- Smart 스케줄(type 7~11)은 400 `JOB-ERROR-101` 로 거부됩니다.

**Smart 스케줄 거부 예시 (400 Bad Request)**

```json
{
  "center": "center-01",
  "schedule": {
    "type": 7,
    "basic": { "day": "mon", "time": "10:00" }
  }
}
```

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-101",
    "message": "For full/increment job types, schedule must contain only basic."
  },
  "timestamp": "2026-04-08T12:00:00.000+09:00"
}
```

</details>

> **v2.0.2 신설**: schedule 변경 시 `updatedFields[]` 에 `{ field: "schedule", previous: <객체>, new: <객체> }` 형식으로 노출. 이전엔 service 가 schedule 입력을 무시했으나 본 버전부터 정상 처리.

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": {
    "replicationInfo": { "id": 1, "name": "new-job-name" },
    "summary": {
      "updatedFields": [
        { "field": "jobName", "previous": "old-name", "new": "new-job-name" },
        { "field": "status", "previous": "Registered", "new": "start" },
        { "field": "uploadMode", "previous": "Full", "new": "Incremental" },
        { "field": "uploadNewly", "previous": "Disabled", "new": "Newly Created Files Only" },
        {
          "field": "schedule",
          "previous": { "id": 5, "type": "Daily", "description": "[Basic] Start working at 03:00 every day." },
          "new": { "id": 10, "type": "Weekly", "description": "[Basic] Start working at 03:00 Monday, Wednesday every week." }
        }
      ]
    }
  },
  "message": "Os Replication updated",
  "timestamp": "2026-04-08T12:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `replicationInfo.id` | number | 작업 ID |
| `replicationInfo.name` | string | 작업 이름 |
| `summary.updatedFields[].field` | string | 변경 필드명 |
| `summary.updatedFields[].previous` | string \| object | 변경 전 값. `field` 가 `schedule` 인 경우 `{ id, type, description }` 객체 |
| `summary.updatedFields[].new` | string \| object | 변경 후 값. `field` 가 `schedule` 인 경우 `{ id, type, description }` 객체 |

> **`status` 항목** (v4.0.0): `previous` 는 조회 응답 `job.info.status.current` 와 같은 상태 값(`Preparing`·`Processing`·`Complete`·`Scheduled`·`Registered`·`Canceling`·`Canceled`·`Error`), `new` 는 요청 본문의 `status` 값 그대로(`start`/`stop`)입니다. 종전에는 두 값 모두 `Waiting`·`Start` 같은 별도 표기였습니다.

**ScheduleChangeValue 구조** (`field` 가 `schedule` 인 경우 `previous` / `new` 값):

{% include zdm/schedule-change-value.md %}

</details>

<details markdown="1" open>
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `NOT_FOUND` | 404 | 작업 / center 미존재 |
| `CENTER-ERROR-01` | 403 | 작업의 center 소속과 요청 center 불일치 |
| `INTERNAL_SERVER_ERROR` | 500 | 트랜잭션 실패 등 내부 오류 |

</details>
