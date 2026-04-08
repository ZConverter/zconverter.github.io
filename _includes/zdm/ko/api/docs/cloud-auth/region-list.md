
플랫폼별 클라우드 리전 목록을 조회합니다.

---

## `GET /cloud-auth/regions/:platform` {#get-cloud-auth-regions}

> * AWS 또는 GCP의 리전 목록을 반환합니다.
> * 서버에 저장된 리전 파일을 우선 사용하며, 파일이 없으면 내장된 기본 데이터를 반환합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/cloud-auth/regions/:platform</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# AWS 리전 목록
curl -X GET "https://api.example.com/api/cloud-auth/regions/aws" \
  -H "Authorization: Bearer <token>"

# GCP 리전 목록
curl -X GET "https://api.example.com/api/cloud-auth/regions/gcp" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `platform` | Path | string | Required | 클라우드 플랫폼 | `aws`, `gcp` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (AWS)</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    { "code": "us-east-1", "name": "US East (N. Virginia)" },
    { "code": "ap-northeast-2", "name": "Asia Pacific (Seoul)" }
  ],
  "message": "AWS region list",
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
      "code": "asia-northeast3",
      "name": "Seoul, South Korea",
      "zones": ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
    }
  ],
  "message": "GCP region list",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
