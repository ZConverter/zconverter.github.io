
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
| `mode` | Body | string | Required | | 복제 모드 | `full`, `increment` |
| `jobName` | Body | string | Optional | 자동생성 | 작업 이름 | |
| `repositoryPath` | Body | string | Optional | Repository의 remotePath | 저장소 경로 | |
| `folderName` | Body | string | Optional | | 폴더 이름 | |
| `networkLimit` | Body | number | Optional | `0` | 네트워크 제한 (KB/s) | |
| `fileFilter` | Body | string | Optional | | 파일 필터 | |
| `uploadNewly` | Body | string | Optional | `disabled` | 업로드 신규 파일 옵션 (upload 전용) | `disabled`, `newly_only` |
| `downloadType` | Body | string | Optional | `all` | 다운로드 타입 (download 전용) | `all`, `folder` |
| `schedule` | Body | object/number | Optional | | 스케줄 객체 또는 schedule ID (basic only, smart 차단) | |
| `autoStart` | Body | string | Optional | `not use` | 자동 시작 | `use`, `not use` |

> **검증 항목:**
> - `center` — DB 존재 확인
> - `cloudKeyId` — `cloud_info_zos` 존재 + center 소속 검증
> - `zosRepositoryId` — `center_zos_repository` 존재 + center 소속 검증
> - `repositoryId` — `center_repository` 존재 + center 소속 검증
> - `schedule` — basic schedule 만 지원 (smart 차단). jobMode `full` / `increment` 모두 허용
>
> **참고**: `autoStart`가 `use`이면 `nJobStatus=START`, `not use`이면 `nJobStatus=COMPLETE`로 저장됩니다.

> **v2.0.2 신설**: 이전엔 schedule 처리가 미구현이었으나 본 버전부터 schedule 입력 시 처리 + 응답에 `schedule: { id, type, description }` 객체 노출. basic schedule 만 지원 (smart 차단). 모든 jobMode (full / increment) 에서 허용.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": {
    "results": [
      {
        "state": "success",
        "jobName": "os_repl_upload_1712345678901",
        "unitType": "Upload",
        "replicationMode": "Full",
        "autoStart": "not use",
        "schedule": {
          "id": 7,
          "type": "Daily",
          "description": "[Basic] Start working at 03:00 every day."
        }
      }
    ],
    "summary": { "total": 1, "successful": 1, "failed": 0 }
  },
  "message": "Os Replication registered",
  "timestamp": "2026-04-08T12:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `results[].state` | string | 처리 결과 (`success` / `failed`) |
| `results[].jobName` | string | 등록된 작업 이름 |
| `results[].unitType` | string | 복제 방식 (Upload / Download) |
| `results[].replicationMode` | string | 복제 모드 (Full / Incremental) |
| `results[].autoStart` | string | 자동 시작 여부 (`use` / `not use`) |
| `results[].schedule` | object | (Optional) 등록된 스케줄 정보. 미지정 시 응답에 포함되지 않음 |
| `results[].schedule.id` | number | 등록된 schedule ID |
| `results[].schedule.type` | string | displayMappings PascalCase 영문 (`Once`, `Every Minute`, `Hourly`, `Daily`, `Weekly`, `Monthly (Specific Week and Day of the Week)`, `Monthly on Specific Date`, `Unknown`) |
| `results[].schedule.description` | string | `processScheduleInfo` 영문 (예: `[Basic] Start working at 03:00 every day.`). 조회 실패 시 `Schedule lookup failed` |
| `summary.total` | number | 요청 건수 |
| `summary.successful` | number | 성공 건수 |
| `summary.failed` | number | 실패 건수 |

</details>

<details markdown="1" open>
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `NOT_FOUND` | 404 | center / cloudKey / zosRepository / repository 미존재 |
| `BAD_REQUEST` | 400 | cloudKey / zosRepository / repository 의 center 소속 불일치, 또는 등록 center 안에 같은 `jobName` 의 작업이 이미 존재 |
| `CONFLICT` | 409 | 같은 center · 같은 `jobName` 에 대한 동시 등록 경합 — 이름 락 대기 한도(10초) 초과 |
| `INTERNAL_SERVER_ERROR` | 500 | 트랜잭션 실패 등 내부 오류 |

> **작업 이름 중복 (400)** — `jobName` 을 **명시적으로 지정한** 경우에만 해당합니다. 생략하면 자동생성 이름(`os_repl_<type>_<timestamp>`)이 쓰여 사실상 겹치지 않습니다.
> 검사 범위는 **등록 center 안**입니다 — 다른 center 에 같은 이름이 있어도 등록됩니다.
>
> 중복 검사와 INSERT 는 이름 락 안에서 함께 수행됩니다. 같은 이름을 동시에 등록하려는 요청이 겹치면 뒤의 요청은 락을 얻은 뒤에 중복을 확인해 400 을 받고, 락 대기 한도를 넘긴 경우에는 409 를 받습니다. 409 는 재시도로 해소되는 성격입니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "BAD_REQUEST",
    "message": "Os Replication jobName already exists in the center (jobName: os_repl_upload_01, centerID: 1)"
  },
  "timestamp": "2026-04-08T12:00:00.000+09:00"
}
```

</details>
