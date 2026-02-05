---
layout: docs
title: POST /zdms/repositories
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

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

**성공 응답 (201 Created)**

```json
{
  "requestID": "cc7d5af3-50b2-4ebd-a2f6-62c57614bbb7",
  "message": "Repository Registration Results",
  "success": true,
  "timestamp": "2026-01-17 20:55:08"
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
  "error": "SMB 타입일 경우 account는 필수입니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Center를 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**등록 실패 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Repository registration failed (result: FAIL)",
  "timestamp": "2025-01-15 10:30:00"
}
```

**등록 시간 초과 (500 Internal Server Error)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Repository registration timed out (10s elapsed)",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
