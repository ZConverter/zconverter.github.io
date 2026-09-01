
ZOS 클라우드 인증 목록을 조회합니다.

---

## `GET /cloud-auth/zos` {#get-cloud-auth-zos}

> * 등록된 ZOS 클라우드 인증 정보 목록을 조회합니다.
> * 필터링 및 페이지네이션을 지원합니다.
> * `center` 는 ID 또는 이름을 콤마로 여러 개 지정할 수 있습니다. 파라미터를 **생략**하면 종전대로 center 필터 없이 조회하지만, `?center=` 처럼 **키만 보내고 값이 비면 400**입니다.
> * 필터에 맞는 항목이 없으면 **200과 빈 배열**을 반환합니다 (404가 아님).

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
| `center` | Query | string | Optional | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`). 값이 빈 `?center=` 는 400 | - |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary><strong>빈 결과 응답 (200 OK)</strong></summary>

> 일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열을 반환합니다 (에러가 아님).

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": true,
  "data": [],
  "message": "Cloud Auth ZOS list",
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**`center` 빈 값 (400 Bad Request)**

`?center=` 처럼 키만 보내고 값이 비면 반환됩니다. 파라미터를 **생략**한 경우는 종전대로 "필터 없음"이며 동작 변화가 없습니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["center must contain at least one identifier"]
    }
  },
  "timestamp": "2026-04-07T12:00:00.000+09:00"
}
```

</details>
