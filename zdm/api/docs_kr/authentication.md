---
layout: docs
title: Authentication
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/docs_kr"
      - title: "Overview"
        url: "/zdm/api/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/api/docs_kr/authentication"
        sublinks:
          - title: "토큰 발급"
            url: "/zdm/api/docs_kr/authentication#token-issue"
      - title: "User Management"
        url: "/zdm/api/docs_kr/users"
      - title: "Server Management"
        url: "/zdm/api/docs_kr/servers"
      - title: "Schedule Management"
        url: "/zdm/api/docs_kr/schedules"
      - title: "Backup Management"
        url: "/zdm/api/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/api/docs_kr/recoveries"
      - title: "File Management"
        url: "/zdm/api/docs_kr/files"
      - title: "License Management"
        url: "/zdm/api/docs_kr/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

모든 보호된 엔드포인트는 토큰이 필요합니다:

```text
Authorization: Bearer <token>
```

## Authentication Endpoints

### POST `/auth/issue` {#token-issue}

토큰을 발급합니다.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Required | 사용자 이메일 |
| password | string | Required | 사용자 비밀번호 |

**Response:**

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

**Status Codes:**

- `201` - 토큰 발급 성공
- `400` - 잘못된 요청 데이터
- `401` - 인증 실패
