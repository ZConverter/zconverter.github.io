---
layout: docs
title: Overview
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "Overview & Authentication"
        url: "/zdm/api/docs_kr/overview"
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

## Overview

ZDM-API는 백업, 복구, 시스템 관리를 위한 REST API 서버입니다. 토큰 인증을 기반으로 하며, 도메인 주도 설계 아키텍처를 따릅니다.

**Base URL**: `/api/v1`

## Authentication

모든 보호된 엔드포인트는 토큰이 필요합니다:

```text
Authorization: Bearer <token>
```

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

## Authentication Endpoints

### POST `/auth/issue`

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

### Pagination

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
```
