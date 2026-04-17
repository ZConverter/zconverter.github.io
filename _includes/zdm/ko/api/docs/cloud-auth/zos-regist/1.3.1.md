
ZOS 클라우드 인증 키 파일을 업로드하고 메타데이터를 등록합니다.

---

## `POST /cloud-auth/zos` {#post-cloud-auth-zos}

> * 인증 키 파일과 메타데이터를 함께 등록합니다.
> * `multipart/form-data` 형식으로 요청합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/cloud-auth/zos</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X POST "https://api.example.com/api/cloud-auth/zos" \
  -H "Authorization: Bearer <token>" \
  -F "file=@/path/to/config.conf" \
  -F "center=center-01" \
  -F "displayName=OCI 인증키" \
  -F "cloudPlatform=oci"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `file` | Body (form-data) | file | Required | 인증 키 파일 | |
| `center` | Body (form-data) | string | Required | 센터 ID 또는 이름 | |
| `displayName` | Body (form-data) | string | Optional | 표시 이름 (미입력 시 자동생성: `{PLATFORM}_{timestamp}`) | |
| `cloudPlatform` | Body (form-data) | string | Required | 클라우드 플랫폼 | `oci`, `nhn`, `ncp`, `aws`, `azure`, `minio` |

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
      "displayName": "OCI_1712345678901",
      "cloudPlatform": "oci",
      "fileName": "config.conf",
      "filePath": "/var/www/.../user@example.com/ZOS/config.conf"
    }
  },
  "message": "Cloud Auth ZOS registered",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
