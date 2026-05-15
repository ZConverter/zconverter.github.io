
Recovery 클라우드 인증 정보를 등록합니다.

---

## `POST /cloud-auth/recovery` {#post-cloud-auth-recovery}

> * AWS: JSON body로 인증 정보를 등록합니다.
> * GCP: `multipart/form-data`로 키 파일과 함께 등록합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/cloud-auth/recovery</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# AWS 등록
curl -X POST "https://api.example.com/api/cloud-auth/recovery" \
  -H "Authorization: Bearer <token>" \
  -F "center=center-01" \
  -F "cloudType=aws" \
  -F "displayName=AWS 프로덕션" \
  -F "awsAccessKey=AWS_ACC_KEY" \
  -F "awsSecretKey=AWS_SEC_KEY" \
  -F "awsRegion=ap-northeast-2" \
  -F "awsDisplayRegion=Asia Pacific (Seoul)"

# GCP 등록 (키 파일 필수)
curl -X POST "https://api.example.com/api/cloud-auth/recovery" \
  -H "Authorization: Bearer <token>" \
  -F "file=@/path/to/service-key.json" \
  -F "center=center-01" \
  -F "cloudType=gcp" \
  -F "displayName=GCP 프로덕션" \
  -F "gcpServiceAccount=my-sa@project.iam.gserviceaccount.com" \
  -F "gcpProject=my-project" \
  -F "gcpRegion=asia-northeast3"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터 (공통)</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `center` | Body | string | Required | 센터 ID 또는 이름 | |
| `cloudType` | Body | string | Required | 클라우드 타입 | `aws`, `gcp` |
| `displayName` | Body | string | Optional | 표시 이름 (미입력 시 자동생성: `{PLATFORM}_RECOVERY_{timestamp}`) | |

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터 (AWS: cloudType=aws)</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `awsAccessKey` | Body | string | Optional | AWS Access Key |
| `awsSecretKey` | Body | string | Optional | AWS Secret Key |
| `awsRegion` | Body | string | Required | AWS 리전 코드 (리전 목록은 [GET /cloud-auth/regions/:platform](#get-cloud-auth-regions) 참고) |
| `awsDisplayRegion` | Body | string | Required | AWS 리전 표시 이름 |

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터 (GCP: cloudType=gcp)</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `file` | Body (form-data) | file | Required | GCP 서비스 키 파일 |
| `gcpServiceAccount` | Body | string | Required | GCP 서비스 계정 |
| `gcpProject` | Body | string | Required | GCP 프로젝트 ID |
| `gcpRegion` | Body | string | Required | GCP 리전 코드 (리전 목록은 [GET /cloud-auth/regions/:platform](#get-cloud-auth-regions) 참고) |
| `gcpRegionSub` | Body | string | Optional | GCP 존 (미입력 시 해당 리전 첫 번째 존 자동 설정) |
| `gcpDisplayRegion` | Body | string | Optional | GCP 리전 표시 이름 (미입력 시 `Asia-Northeast3(Seoul)` 형식으로 자동 생성) |

> **자동 생성 필드:**
> - `serviceKeyFile` — 업로드된 파일의 원본 파일명
> - `serviceKeyFilePath` — 파일 저장 경로 (`{CLOUD_AUTH_FILE_SAVE_PATH}/{userEmail}/GCP/{파일명}`)
> - `displayRegion` — `Asia-Northeast3(Seoul)` 형식으로 자동 생성
> - `regionSub` 미입력 시 — 리전 데이터에서 해당 리전의 첫 번째 zone 자동 설정
>
> **검증 실패 예:** `cloudType=gcp` 인데 `file` 미첨부 시 `FILE-ERROR-01` (HTTP 404) 반환.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": {
    "state": "success",
    "cloudInfo": {
      "id": 1,
      "displayName": "GCP_RECOVERY_1712345678901",
      "cloudType": "gcp"
    }
  },
  "message": "Cloud Auth Recovery registered",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>주요 에러 코드</strong></summary>

| 코드 | HTTP | 의미 |
|------|------|------|
| `FILE-ERROR-01` | 404 | GCP 키 파일 미첨부 (`cloudType=gcp` 시 필수) |
| `CENTER-ERROR-01` | 403 | 지정한 `center`에 속하지 않음 (삭제 시) |
| `CLOUD-AUTH-ERROR-01` | 400 | 업로드 파일 크기 초과(10MB) |
| `CLOUD-AUTH-ERROR-02` | 400 | 파일 업로드 실패 |
| `BAD_REQUEST` | 400 | 요청 본문 검증 실패(zod) |
| `INTERNAL_SERVER_ERROR` | 500 | 서버 내부 오류 |

</details>
