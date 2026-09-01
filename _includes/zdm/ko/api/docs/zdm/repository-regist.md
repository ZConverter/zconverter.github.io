
새로운 ZDM 레포지토리를 등록합니다.

---

## `POST /zdms/repositories` {#post-zdms-repositories}

> * 새로운 레포지토리를 등록합니다.
> * SMB 타입의 경우 account와 password가 필수입니다.
> * 등록 요청 후 최대 10초간 결과를 확인하며, 10초 이내에 완료되지 않으면 실패로 간주합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/zdms/repositories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# NFS 레포지토리 등록
curl -X POST "https://api.example.com/api/zdms/repositories" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "type": "nfs",
    "remotePath": "/backup",
    "localPath": "/mnt/backup",
    "ip": "192.168.1.200"
  }'

# SMB 레포지토리 등록
curl -X POST "https://api.example.com/api/zdms/repositories" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "Main-Center",
    "type": "smb",
    "remotePath": "backup",
    "localPath": "B:",
    "ip": "192.168.1.200",
    "account": "admin",
    "password": "password123"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `type` | string | Required | 레포지토리 타입 | {% include zdm/repository-types.md %} |
| `remotePath` | string | Required | 원격 경로 | - |
| `localPath` | string | Required | 로컬 경로 (SMB: 드라이브, NFS: 마운트 경로) | - |
| `ip` | string | Required | 레포지토리 서버 IP | - |
| `port` | string | Optional | 포트 번호 | - |
| `account` | string | Required (SMB) | 계정 (SMB 타입 필수) | - |
| `password` | string | Required (SMB) | 비밀번호 (SMB 타입 필수) | - |
| `user` | string | Optional | 등록 사용자 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Repository Registration Results",
  "success": true,
  "timestamp": "2026-01-17T20:55:08.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `traceId` | string | 요청 추적 ID (서버 로그와 동일) |
| `message` | string | 결과 메시지 |
| `success` | boolean | 성공 여부 |
| `timestamp` | string | 응답 시간 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (422 Unprocessable Entity)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-01",
    "message": "Request body validation failed.",
    "details": {
      "account": ["account is required for SMB type"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-ERROR-01",
    "message": "Zdm with ID '999' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**등록 실패 (500 Internal Server Error)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "Repository registration failed (result: FAIL)"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**등록 시간 초과 (500 Internal Server Error)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "Repository registration timed out (10s elapsed)"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
