
ZOS 클라우드 인증 목록을 조회합니다.

---

## `GET /cloud-auth/zos` {#get-cloud-auth-zos}

> * 등록된 ZOS 클라우드 인증 정보 목록을 조회합니다.
> * 필터링 및 페이지네이션을 지원합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/cloud-auth/zos</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 조회
curl -X GET "https://api.example.com/api/cloud-auth/zos" \
  -H "Authorization: Bearer <token>"

# 필터 + 페이지네이션
curl -X GET "https://api.example.com/api/cloud-auth/zos?cloudPlatform=oci&page=1&limit=10&sort=desc" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `displayName` | Query | string | Optional | 표시 이름 검색 (LIKE) | |
| `cloudPlatform` | Query | string | Optional | 클라우드 플랫폼 필터 | `oci`, `nhn`, `ncp`, `aws`, `azure`, `minio` |
| `page` | Query | number | Optional | 페이지 번호 | |
| `limit` | Query | number | Optional | 페이지당 개수 | |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "...",
  "success": true,
  "data": [
    {
      "id": 1,
      "displayName": "OCI_1712345678901",
      "cloudPlatform": "OCI",
      "fileName": "config.conf",
      "filePath": "/var/www/.../config.conf",
      "createdDate": "2026-04-07 12:00:00"
    }
  ],
  "message": "Cloud Auth ZOS list",
  "timestamp": "2026-04-07 12:00:00"
}
```

</details>
