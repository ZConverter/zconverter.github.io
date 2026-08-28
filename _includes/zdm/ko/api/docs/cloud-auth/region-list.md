
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

> 단수형 alias `GET /api/cloud-auth/region/:platform` 도 동일하게 동작합니다(권장: 복수형).

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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": [
    { "code": "us-east-1", "name": "US East (N. Virginia)" },
    { "code": "ap-northeast-2", "name": "Asia Pacific (Seoul)" }
  ],
  "message": "AWS region list",
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시 (GCP)</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": [
    {
      "code": "asia-northeast3",
      "name": "Seoul, South Korea",
      "zones": ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
    }
  ],
  "message": "GCP region list",
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication required."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**지원하지 않는 플랫폼 (400 Bad Request)**

> **v2.0.2 신규**: 파일 시스템에 접근하기 전에 플랫폼 허용 목록(`aws`, `gcp`)을 먼저 검사합니다. `platform` 경로 파라미터를 이용한 path traversal 시도를 파일 접근 이전 단계에서 차단합니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "BAD_REQUEST",
    "message": "Unsupported platform: azure. Supported platforms: aws, gcp"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

> 지원되는 플랫폼인데 서버에 리전 파일이 없는 경우는 에러가 아닙니다. 내장된 기본 데이터로 대체되어 `200 OK`로 응답합니다.

</details>

<details markdown="1">
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 메시지 | 발생 시점 |
|------|------|--------|-----------|
| `UNAUTHORIZED` | 401 | Authentication required. | 토큰이 없거나 유효하지 않음 |
| `BAD_REQUEST` | 400 | `Unsupported platform: <platform>. Supported platforms: aws, gcp` | `platform` 값이 `aws`, `gcp` 가 아님 (대소문자 무시) |

</details>
