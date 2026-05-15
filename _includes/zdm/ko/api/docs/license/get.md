
특정 라이선스의 상세 정보를 조회합니다.

---

## `GET /licenses/:identifier` {#get-licenses-identifier}

> * **주의 (현재 구현)**: 경로 세그먼트 `:identifier`는 서버에서 무시되며, 본 엔드포인트는 `GET /licenses`와 동일하게 전체 라이선스 목록(배열)을 반환합니다.
> * 단건 조회가 필요한 경우 `GET /licenses/key/:key`를 사용하거나, `GET /licenses?id=...` / `GET /licenses?name=...` 쿼리 파라미터를 사용하세요.

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
| `category` | Query | string | Optional | - | 라이선스 카테고리 필터 | {% include zdm/license-categories.md %} |
| `exp` | Query | string | Optional | - | 만료일 필터 (YYYY-MM-DD) | - |
| `created` | Query | string | Optional | - | 생성일 필터 (YYYY-MM-DD) | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
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
    }
  ],
  "message": "License information list",
  "timestamp": "2025-01-15 10:30:00"
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
| `copies.usage` | number | 사용률 (0-100) |
| `description` | string | 라이선스 설명 |
| `dates.created` | string | 생성일 |
| `dates.expires` | string | 만료일 |
| `dates.daysRemaining` | number | 현재 시각 기준 만료까지 남은 일수 (만료된 경우 `0`) |

</details>

---
