---
layout: docs
title: Authentication
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/docs"
      - title: "Overview"
        url: "/zdm/api/docs/overview"
      - title: "Authentication"
        url: "/zdm/api/docs/authentication"
        sublinks:
          - title: "토큰 발급"
            url: "/zdm/api/docs/authentication#token-issue"
      - title: "User Management"
        url: "/zdm/api/docs/users"
      - title: "Server Management"
        url: "/zdm/api/docs/servers"
      - title: "Schedule Management"
        url: "/zdm/api/docs/schedules"
      - title: "Backup Management"
        url: "/zdm/api/docs/backups"
      - title: "Recovery Management"
        url: "/zdm/api/docs/recoveries"
      - title: "File Management"
        url: "/zdm/api/docs/files"
      - title: "License Management"
        url: "/zdm/api/docs/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs/zdm-centers"
---

모든 보호된 엔드포인트는 토큰이 필요합니다:

```text
Authorization: Bearer <token>
```

## Authentication Endpoints

### POST `/auth/issue` {#token-issue}

토큰을 발급합니다.

<details markdown="1" open>
<summary><strong>Request Body</strong></summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Required | 사용자 이메일 |
| password | string | Required | 사용자 비밀번호 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

```json
{
  "success": true,
  "requestID": "req-123",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expiresAt": "2024-12-31T23:59:59.000Z"
  },
  "message": "토큰이 성공적으로 발급되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>