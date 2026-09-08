
특정 라이선스의 상세 정보를 조회합니다.

---

## `GET /licenses/:identifier` {#get-licenses-identifier}

> * 라이선스 ID 또는 라이선스 이름으로 특정 라이선스의 정보를 조회합니다.
> * identifier가 숫자인 경우 라이선스 ID로, 그 외에는 라이선스 이름으로 조회합니다.
> * 이름으로 조회할 때는 **정확일치** 입니다 — 이름의 일부만 주면 찾지 못합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/licenses/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 라이선스 ID로 조회
curl -X GET "https://api.example.com/api/licenses/1" \
  -H "Authorization: Bearer <token>"

# 라이선스 이름으로 조회
curl -X GET "https://api.example.com/api/licenses/Enterprise-License" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 라이선스 ID (숫자) 또는 라이선스 이름 | - |
| `center` | Query | string | Optional | - | 단건 조회에는 적용되지 않습니다 (보내도 오류는 아님). 값이 빈 `?center=` 는 400 | - |
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | {% include zdm/license-categories.md %} |
| `exp` | Query | string | Optional | - | 만료일 필터 (YYYY-MM-DD) | - |
| `created` | Query | string | Optional | - | 생성일 필터 (YYYY-MM-DD) | - |

> **참고:**
> - `category`, `exp`, `created` 는 이 엔드포인트에서도 조회 조건으로 적용됩니다. 지정한 라이선스가 존재하더라도 조건과 맞지 않으면 **404** 입니다 — 빈 200 이 아닙니다.
> - `center` 는 단건 조회에서 조회 범위를 좁히지 않습니다. 보내도 오류가 되지 않고 무시되므로 필터가 걸린 것으로 오해하지 마세요.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 1,
    "name": "Enterprise License",
    "key": "XXXX-XXXX-XXXX-XXXX",
    "category": "zdm(backup)",
    "copies": {
      "total": 100,
      "used": 25,
      "available": 75,
      "usage": 25
    },
    "description": "Enterprise backup license",
    "dates": {
      "created": "2025-01-01",
      "expires": "2026-01-01",
      "daysRemaining": 365
    }
  },
  "message": "License information retrieved",
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 라이선스 ID |
| `name` | string | 라이선스 이름 |
| `key` | string | 라이선스 키 |
| `category` | string | 라이선스 카테고리 |
| `copies.total` | number | 총 카피 수 |
| `copies.used` | number | 사용 중인 카피 수 |
| `copies.available` | number | 사용 가능한 카피 수 |
| `copies.usage` | number | 사용률 (0-100) |
| `description` | string | 라이선스 설명 |
| `dates.created` | string | 생성일 |
| `dates.expires` | string | 만료일 |
| `dates.daysRemaining` | number | 현재 시각 기준 만료까지 남은 일수 (만료된 경우 `0`) |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**라이선스를 찾을 수 없음 (404 Not Found)**

지정한 ID 또는 이름의 라이선스가 없는 경우 반환됩니다. 라이선스는 있으나 `category` · `exp` · `created` 조건과 맞지 않는 경우에도 같은 응답입니다.

이름을 **부분만** 지정한 경우도 여기에 해당합니다. 단건 조회에서 부분일치를 허용하면 이름이 다른 라이선스가 잡혀 200 으로 나가기 때문에, 이름 지목은 정확일치로만 처리합니다. 이름 일부로 찾으려면 목록 조회(`GET /licenses`)의 `name` 필터를 쓰십시오 — 그쪽은 부분일치입니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "LICENSE-ERROR-01",
    "message": "License with ID '999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

이름으로 조회한 경우의 메시지는 `License with Name 'Enterprise-License' not found` 입니다.

</details>

---
