
Recovery 클라우드 인증 목록을 조회합니다.

---

## `GET /cloud-auth/recovery` {#get-cloud-auth-recovery}

> * 등록된 Recovery 클라우드 인증 정보 목록을 조회합니다.
> * cloudType별 필터링 및 페이지네이션을 지원합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/cloud-auth/recovery</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 조회
curl -X GET "https://api.example.com/api/cloud-auth/recovery" \
  -H "Authorization: Bearer <token>"

# AWS만 필터
curl -X GET "https://api.example.com/api/cloud-auth/recovery?cloudType=aws&page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `displayName` | Query | string | Optional | 표시 이름 검색 (LIKE) | |
| `cloudType` | Query | string | Optional | 클라우드 타입 필터 | `aws`, `gcp` |
| `page` | Query | number | Optional | 페이지 번호 | |
| `limit` | Query | number | Optional | 페이지당 개수 | |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (AWS)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    {
      "id": 1,
      "displayName": "AWS_RECOVERY",
      "cloudType": "AWS",
      "accessKey": "AKIAIOSFODNN7EXAMPLE",
      "secretKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      "region": "ap-northeast-2",
      "displayRegion": "Asia Pacific (Seoul)"
    }
  ],
  "message": "Cloud Auth Recovery list",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (GCP)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    {
      "id": 2,
      "displayName": "GCP_RECOVERY",
      "cloudType": "GCP",
      "serviceAccount": "my-sa@project.iam.gserviceaccount.com",
      "project": "my-project",
      "serviceKeyFile": "service-key.json",
      "serviceKeyFilePath": "/var/www/.../user@example.com/GCP/service-key.json",
      "region": "asia-northeast3",
      "regionSub": "asia-northeast3-a",
      "displayRegion": "Asia-Northeast3(Seoul)"
    }
  ],
  "message": "Cloud Auth Recovery list",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `id` | number | 공통 | 인증 정보 ID |
| `displayName` | string | 공통 | 표시 이름 |
| `cloudType` | string | 공통 | `AWS` 또는 `GCP` |
| `accessKey` | string | AWS | AWS Access Key |
| `secretKey` | string | AWS | AWS Secret Key |
| `serviceAccount` | string | GCP | GCP 서비스 계정 |
| `project` | string | GCP | GCP 프로젝트 ID |
| `serviceKeyFile` | string | GCP | 업로드된 키 파일명 |
| `serviceKeyFilePath` | string | GCP | 키 파일 저장 경로 |
| `region` | string | AWS/GCP | 리전 코드 |
| `regionSub` | string | GCP | 존 코드 |
| `displayRegion` | string | AWS/GCP | 리전 표시 이름 |

</details>
