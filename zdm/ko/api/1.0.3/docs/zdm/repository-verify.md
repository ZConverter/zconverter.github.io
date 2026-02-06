---
layout: docs
title: POST /zdms/repositories/verify
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

ZDM 레포지토리 연결을 검증합니다.

---

## `POST /zdms/repositories/verify` {#post-zdms-repositories-verify}

> * 레포지토리 경로에 대한 연결 가능 여부를 검증합니다.
> * SMB 타입의 경우 account와 password가 필수입니다.
> * 검증 요청 후 최대 10초간 결과를 확인하며, 10초 이내에 완료되지 않으면 실패로 간주합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/zdms/repositories/verify</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# SMB 레포지토리 연결 검증
curl -X POST "https://api.example.com/api/zdms/repositories/verify" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "type": "smb",
    "path": "\\\\192.168.1.200\\share",
    "account": "admin",
    "password": "password123",
    "domain": "WORKGROUP"
  }'

# NFS 레포지토리 연결 검증
curl -X POST "https://api.example.com/api/zdms/repositories/verify" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "Main-Center",
    "type": "nfs",
    "path": "192.168.1.200:/backup"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 | 선택값 |
|------|------|------|------|--------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름 | - |
| `type` | string | Required | 레포지토리 타입 | `smb`, `nfs` |
| `path` | string | Required | 검증할 경로 (SMB: UNC 경로, NFS: IP:/path) | - |
| `account` | string | Required (SMB) | 계정 (SMB 타입 필수) | - |
| `password` | string | Required (SMB) | 비밀번호 (SMB 타입 필수) | - |
| `domain` | string | Optional | 도메인 (SMB 타입 선택) | - |
| `user` | string | Optional | 등록 사용자 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "requestID": "cc7d5af3-50b2-4ebd-a2f6-62c57614bbb7",
  "message": "Repository Verify Results",
  "success": true,
  "timestamp": "2026-02-05 14:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `requestID` | string | 요청 ID |
| `message` | string | 결과 메시지 |
| `success` | boolean | 성공 여부 |
| `timestamp` | string | 응답 시간 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": {
    "message": "Request body validation failed",
    "details": {
      "type": ["type은 smb와 nfs만 가능합니다"],
      "account": ["SMB 타입일 경우 account는 필수입니다"]
    }
  },
  "timestamp": "2026-02-05 14:30:00"
}
```

**경로 양식 오류 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "SMB path format is invalid. Expected UNC path (e.g., \\\\server\\share)",
  "timestamp": "2026-02-05 14:30:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Center를 찾을 수 없습니다",
  "timestamp": "2026-02-05 14:30:00"
}
```

**검증 실패 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Repository verify failed (result: FAIL)",
  "timestamp": "2026-02-05 14:30:00"
}
```

**검증 시간 초과 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Repository verify timed out (10s elapsed)",
  "timestamp": "2026-02-05 14:30:00"
}
```

</details>

---
