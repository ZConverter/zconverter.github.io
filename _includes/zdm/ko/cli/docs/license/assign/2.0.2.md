
특정 Server에 License를 할당하는 명령어입니다.

---

## `license assign` {#license-assign}

> * 특정 Server에 License를 할당합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license assign [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 특정 라이센스를 서버에 할당
zdm-cli license assign --license "my-license" --server "server-01"

# 별칭을 사용한 할당
zdm-cli license assign -l "my-license" -s "server-01"

# JSON 형식으로 출력
zdm-cli license assign --license "my-license" --server "server-01" --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --license | -l | string | Required | - | 할당할 라이센스 ID 또는 Name | - |
| --server | -s | string | Required | - | 라이센스 할당할 서버 ID 또는 Name | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* License Assign Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : License assigned successfully
timestamp : 2024-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server]
  id                : 1
  name              : server-01

[License]
  id                : 5
  name              : my-license
  category          : zdm(backup)
  created           : 2024-01-01
  expiration        : 2025-12-31

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "License assigned successfully",
  "success": true,
  "data": {
    "server": {
      "id": "1",
      "name": "server-01"
    },
    "license": {
      "id": "5",
      "name": "my-license",
      "category": "zdm(backup)",
      "created": "2024-01-01",
      "expiration": "2025-12-31"
    }
  },
  "timestamp": "2024-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>할당 제약</strong></summary>

API 검증으로 다음 케이스에서 할당이 거부되며 CLI는 에러 메시지를 출력하고 종료합니다.

- **License와 Server가 서로 다른 center에 속한 경우** (HTTP 403)
  - 메시지 예: `License (center 1) and Server 'server-01' (center 2) belong to different centers`
- **Server에 이미 다른 license가 할당된 경우** (HTTP 409)
  - 메시지 예: `Server 'server-01' already has a license assigned (nLicenseID: 5)`
- **해당 server가 과거 라이선스를 할당받은 이력이 있는 경우** (HTTP 409)
  - 메시지 예: `License (id 5) is already assigned to server 'server-01' in center 1`
  - `license_history` 테이블에 `(sSystemName, nCenterID)` 매칭 row가 있으면 거부됨 — 한 번 할당된 server는 재할당 불가

</details>

---
