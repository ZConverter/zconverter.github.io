---
layout: docs
title: ZDM API Documentation v1.0.3
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [ZDM API 소개](#zdm-api-소개)
- [주요 기능](#주요-기능)
- [Quick Start](#quick-start)
- [Base URL](#base-url)
- [인증 헤더](#인증-헤더)
- [표준 API 응답 형식](#표준-api-응답-형식)
- [공통 패턴](#공통-패턴)

</details>

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

---

## 인증 헤더

모든 보호된 엔드포인트는 Authorization 헤더가 필요합니다:

```text
Authorization: <token>
```

또는

```text
Authorization: Bearer <token>
```

---

## 표준 API 응답 형식

모든 API 응답은 일관된 JSON 형식을 사용합니다.

### 성공 응답 (Success Response)

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

```json
{
  "success": true,
  "requestID": "string",
  "data": {},
  "message": "string",
  "timestamp": "string",
  "meta": {}
}
```

**필드 설명:**
- `success`: 요청 성공 여부 (항상 `true`)
- `requestID`: 요청 고유 ID
- `data`: 응답 데이터
- `message`: 응답 메시지
- `timestamp`: 응답 시간 (ISO 8601 형식)
- `meta`: 추가 메타데이터 (선택적)

</details>

### 에러 응답 (Error Response)

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

```json
{
  "success": false,
  "requestID": "string",
  "error": "string",
  "timestamp": "string",
  "detail": {}
}
```

**필드 설명:**
- `success`: 요청 성공 여부 (항상 `false`)
- `requestID`: 요청 고유 ID
- `error`: 에러 메시지
- `timestamp`: 응답 시간
- `detail`: 상세 에러 정보 (선택적)

</details>

---

## 공통 패턴

### HTTP 상태 코드

<details markdown="1" open>
<summary><strong>상태 코드 목록</strong></summary>

| 코드 | 의미 | 설명 |
|------|------|------|
| `200` | OK | 요청 성공 |
| `201` | Created | 리소스 생성 성공 |
| `400` | Bad Request | 잘못된 요청 데이터 |
| `401` | Unauthorized | 인증 실패 또는 토큰 없음 |
| `403` | Forbidden | 권한 부족 |
| `404` | Not Found | 리소스를 찾을 수 없음 |
| `409` | Conflict | 리소스 충돌 (중복 등) |
| `500` | Internal Server Error | 서버 내부 오류 |

</details>

---

### 식별자 패턴 (Identifier Pattern)

대부분의 엔드포인트는 유연한 식별자 해석을 지원합니다:

<details markdown="1" open>
<summary><strong>식별자 처리 방식</strong></summary>

- **숫자 값** (`1`, `123`): ID로 처리
- **문자열 값** (`"user@example.com"`, `"server-name"`): Name/Email 등으로 처리

**예시:**
```bash
GET /api/v1/users/1              # ID로 조회
GET /api/v1/users/user@example.com  # 이메일로 조회
```

</details>

---
