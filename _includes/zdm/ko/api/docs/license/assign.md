
라이선스를 서버에 할당합니다.

---

## `PUT /licenses/assign` {#put-licenses-assign}

> * 특정 서버에 라이선스를 할당합니다.
> * 서버와 라이선스는 ID 또는 이름으로 지정할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/licenses/assign</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 할당
curl -X PUT "https://api.example.com/api/licenses/assign" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "server": "1",
    "license": "5"
  }'

# 이름으로 할당
curl -X PUT "https://api.example.com/api/licenses/assign" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "server": "server-01",
    "license": "Enterprise-License",
    "user": 1
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `server` | string | Required | 서버 ID (숫자) 또는 서버 이름 |
| `license` | string | Required | 라이선스 ID (숫자) 또는 라이선스 이름 |
| `center` | string \| number | Optional | 검증용 center ID 또는 이름 — 입력 시 license가 해당 center에 속하는지 한번 더 확인 (불일치 시 403). 빈 문자열 거부. |
| `user` | string \| number | Optional | 할당 요청 사용자 ID 또는 이름 (생략 시 인증 토큰의 사용자 ID 자동 적용) |

```json
{
  "server": "server-01",
  "license": "Enterprise-License",
  "user": 1
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "server": {
      "id": "1",
      "name": "server-01"
    },
    "license": {
      "id": "5",
      "name": "Enterprise-License",
      "category": "zdm(backup)",
      "created": "2025-01-01",
      "expiration": "2026-01-01"
    }
  },
  "message": "License assigned successfully",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `server.id` | string | 서버 ID |
| `server.name` | string | 서버 이름 |
| `license.id` | string | 라이선스 ID |
| `license.name` | string | 라이선스 이름 |
| `license.category` | string | 라이선스 카테고리 |
| `license.created` | string | 라이선스 생성일 |
| `license.expiration` | string | 라이선스 만료일 |

</details>

<details markdown="1" open>
<summary><strong>할당 제약 조건</strong></summary>

다음 조건을 모두 충족해야 할당이 진행됩니다. 하나라도 어긋나면 트랜잭션 진입 전에 거부됩니다.

| # | 조건 | 위반 시 응답 |
|---|------|-------------|
| 1 | 요청 body에 `center`가 있다면 그 center가 license가 속한 center와 동일해야 함 | 403 CENTER_MISMATCH |
| 2 | License와 Server는 동일한 center에 등록되어 있어야 함 | 403 CENTER_MISMATCH |
| 3 | 대상 Server는 현재 어떤 license도 할당받지 않은 상태여야 함 (`server.nLicenseID === 0`) | 409 ALREADY_ASSIGNED |
| 4 | `license_history` 테이블에 `(sSystemName, nCenterID)` 조합으로 매칭되는 이력이 존재하지 않아야 함 (해당 server는 과거 어떤 라이선스도 할당된 적이 없어야 함) | 409 ALREADY_ASSIGNED |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**서버를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Server를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**라이선스를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 License를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**Center 불일치 (403 Forbidden)**

License의 center와 Server의 center가 다르거나, 요청 body의 `center`가 license의 center와 다른 경우.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "License (center 1) and Server 'server-01' (center 2) belong to different centers",
  "timestamp": "2025-01-15 10:30:00"
}
```

**서버에 이미 라이선스 할당됨 (409 Conflict)**

대상 server의 `nLicenseID`가 이미 0이 아닌 상태.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Server 'server-01' already has a license assigned (nLicenseID: 5)",
  "timestamp": "2025-01-15 10:30:00"
}
```

**이전 할당 이력 존재 (409 Conflict)**

`license_history` 테이블에 동일 server가 같은 center에서 라이선스를 할당받은 이력이 남아 있는 경우. 한 번 할당된 server에는 재할당 불가.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "License (id 5) is already assigned to server 'server-01' in center 1",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
