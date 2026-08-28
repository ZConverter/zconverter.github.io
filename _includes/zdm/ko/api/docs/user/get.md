
특정 사용자의 상세 정보를 조회합니다.

---

## `GET /users/:identifier` {#get-users-identifier}

> * 사용자 ID 또는 이메일로 특정 사용자의 정보를 조회합니다.
> * identifier가 숫자인 경우 사용자 ID로, 그 외에는 이메일로 조회합니다.
> * 토큰 주체 본인의 사용자 리소스만 조회할 수 있습니다. (v2.0.2 신규)

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/users/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 사용자 ID로 조회
curl -X GET "https://api.example.com/api/users/1" \
  -H "Authorization: Bearer <token>"

# 이메일로 조회
curl -X GET "https://api.example.com/api/users/user@example.com" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 사용자 ID (숫자) 또는 이메일 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": "1",
    "email": "user@example.com",
    "userName": "홍길동",
    "company": "Acme Corp",
    "country": "KR",
    "position": "Manager"
  },
  "message": "User information retrieved",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | string | 사용자 ID |
| `email` | string | 사용자 이메일 |
| `userName` | string | 사용자 이름 |
| `company` | string | 회사명 |
| `country` | string | 국가 |
| `position` | string | 직책 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**사용자를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "USER-ERROR-01",
    "message": "ID가 '999'인 User를 찾을 수 없습니다"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "토큰이 만료되었습니다."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**권한 없음 (403 Forbidden)**

> **v2.0.2 신규**: 토큰 주체 본인의 사용자 리소스만 조회할 수 있습니다. `identifier`가 토큰 주체의 사용자 ID 또는 이메일(이메일은 대소문자 구분 없음)과 일치하지 않으면 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "FORBIDDEN",
    "message": "You can only access your own user resource."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

`identifier` 파라미터 검증이 먼저 수행되므로, 형식이 올바르지 않거나 비어 있는 `identifier`는 403이 아닌 400 (유효성 검사 실패)이 반환됩니다.

</details>

---
