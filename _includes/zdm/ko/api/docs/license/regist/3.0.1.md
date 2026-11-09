
새로운 라이선스를 등록합니다.

---

## `POST /licenses` {#post-licenses}

> * 새로운 라이선스를 시스템에 등록합니다.
> * 라이선스 키를 파싱하여 관련 정보를 자동으로 추출합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/licenses</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X POST "https://api.example.com/api/licenses" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "key": "ABCDEFGH12345678IJKLMN",
    "name": "Enterprise License",
    "description": "Enterprise backup license"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름. 영문 대소문자·숫자·`_`·`-`만 허용 (공백/특수문자 거부) |
| `key` | string | Required | 라이선스 키. **영문 대소문자·숫자만 허용** (`[A-Za-z0-9]+`). 하이픈·공백·특수문자 포함 시 거부 (shell 주입 방어) |
| `user` | string \| number | Optional | 라이선스 사용자 ID 또는 이름 (생략 시 인증 토큰의 사용자 ID 자동 적용) |
| `name` | string | Optional | 라이선스 이름 |
| `description` | string | Optional | 라이선스 설명 |

```json
{
  "center": "1",
  "key": "ABCDEFGH12345678IJKLMN",
  "name": "Enterprise License",
  "description": "Enterprise backup license"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "name": "Enterprise License",
    "key": "ABCDEFGH12345678IJKLMN",
    "category": "zdm(backup)",
    "copies": {
      "total": 100,
      "used": 0,
      "available": 100,
      "usage": 0
    },
    "description": "Enterprise backup license",
    "dates": {
      "created": "2025-01-15",
      "expires": "2026-01-15",
      "daysRemaining": 365
    }
  },
  "message": "License Registration Results",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `name` | string | 라이선스 이름 |
| `key` | string | 라이선스 키 |
| `category` | string | 라이선스 카테고리 |
| `copies.total` | number | 총 카피 수 |
| `copies.used` | number | 사용 중인 카피 수 |
| `copies.available` | number | 사용 가능한 카피 수 |
| `copies.usage` | number | 사용률(%) (예: 0, 25) |
| `description` | string | 라이선스 설명 |
| `dates.created` | string | 생성일 |
| `dates.expires` | string | 만료일 |
| `dates.daysRemaining` | number | 만료까지 남은 일수 (만료된 경우 `0`) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 — 필수 필드 누락 (422 Unprocessable Entity)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "key": ["key is required"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**유효성 검사 실패 — key 형식 위반 (422 Unprocessable Entity)**

`key`에 영숫자 외 문자가 포함된 경우 (하이픈/공백/특수문자 등).

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "key": ["key must contain only letters and digits"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**유효성 검사 실패 — center 형식 위반 (422 Unprocessable Entity)**

`center`에 허용 외 문자(공백·특수문자·한글 등)가 포함된 경우.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "center": ["center must contain only letters, digits, '_', or '-'"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**이미 등록된 라이선스 (409 Conflict)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "LICENSE-ERROR-11",
    "message": "License is already registered (ID: 3)."
  },
  "timestamp": "2026-10-12T10:30:00.000+09:00"
}
```

> 같은 키가 이미 등록돼 있으면 발생합니다.

**다른 ZDM 용으로 발급된 라이선스 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "LICENSE-ERROR-12",
    "message": "License was not issued for this ZDM (UUID: {dca42442-7fa9-689b-8304-412cb7d103c3})."
  },
  "timestamp": "2026-10-12T10:30:00.000+09:00"
}
```

> 키는 발급 시 지정한 ZDM UUID 에서만 등록할 수 있습니다. UUID 는 대소문자·중괄호까지 일치해야 합니다.

**유효하지 않은 라이선스 키 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "LICENSE-ERROR-09",
    "message": "Invalid license key."
  },
  "timestamp": "2026-10-12T10:30:00.000+09:00"
}
```

> 형식(영숫자)은 맞지만 라이선스 키로 해석되지 않으면 발생합니다.

</details>

---
