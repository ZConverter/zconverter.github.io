---
layout: docs
title: Overview
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

## Standard API Response Format

모든 API 응답은 다음 표준 형식을 따릅니다:

**Success Response:**

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

**Error Response:**

```json
{
  "success": false,
  "requestID": "string",
  "error": "string",
  "timestamp": "string",
  "detail": {}
}
```

**Pagination Response:**

```json
{
  "success": true,
  "requestID": "string",
  "data": [],
  "message": "string",
  "timestamp": "string",
  "meta": {
    "currentPage": 1,
    "totalPages": 10,
    "totalItems": 100,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  }
}
```

---

## Common Patterns

### Error Response Format

모든 에러 응답은 다음 형식을 따릅니다:

```json
{
  "error": {
    "code": "string",
    "message": "string",
    "details": {}
  }
}
```

### Status Codes

- `200` - 성공
- `201` - 생성 성공
- `400` - 잘못된 요청
- `401` - 인증 실패
- `403` - 권한 부족
- `404` - 리소스 없음
- `409` - 충돌
- `500` - 서버 오류

### Identifier Pattern

대부분의 엔드포인트는 유연한 식별자 해석을 지원합니다:

- **숫자 값**: ID로 처리
- **문자열 값**: Name/Email 등으로 처리

<!-- ### Pagination

목록 조회 엔드포인트는 표준 페이지네이션을 지원합니다:

```json
{
  "data": [],
  "pagination": {
    "page": "number",
    "limit": "number",
    "total": "number",
    "totalPages": "number"
  }
}
``` -->
