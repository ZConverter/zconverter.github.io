---
layout: docs
title: ZDM API Documentation
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/index"
      - title: "Overview"
        url: "/zdm/api/docs/overview"
      - title: "Authentication"
        url: "/zdm/api/docs/authentication"
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

## ZDM API 소개

ZDM-API는 백업, 복구, 시스템 관리를 위한 **API 서버**입니다.

---

## 주요 기능

<details markdown="1" open>
<summary><strong>핵심 기능</strong></summary>

- **토큰 기반 인증** - 안전한 API 접근 제어
- **사용자 관리** - 사용자 계정 및 권한 관리
- **서버 관리** - 시스템 리소스 통합 관리
- **백업/복구** - 자동화된 데이터 보호 및 복원
- **스케줄링** - 정기적인 백업 작업 예약
- **파일 관리** - 백업 파일 업로드/다운로드
- **라이선스 관리** - 라이선스 발급 및 할당
- **ZDM 센터** - 멀티 센터 환경 관리

</details>

---

## Quick Start

### 1. 토큰 발급

모든 API 요청에는 인증 토큰이 필요합니다.

<details markdown="1" open>
<summary><strong>토큰 발급 예시</strong></summary>

```bash
POST /api/v1/auth/issue
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "your-password"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expiresAt": "2024-12-31T23:59:59.000Z"
  }
}
```

</details>

### 2. API 호출

발급받은 토큰을 Authorization 헤더에 포함하여 API를 호출합니다.

<details markdown="1" open>
<summary><strong>API 호출 예시</strong></summary>

```bash
GET /api/v1/users
Authorization: eyJhbGciOiJIUzI1NiIs...
```

</details>

---

## Base URL

```
/api/v1
```

모든 API 엔드포인트는 위 Base URL을 기준으로 합니다.
