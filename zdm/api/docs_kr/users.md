---
layout: page
title: User Management
---

## User Management

### GET `/users`

사용자 목록을 조회합니다.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-456",
  "data": [
    {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "개발자"
    }
  ],
  "message": "사용자 목록을 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/users/:identifier`

특정 사용자 정보를 조회합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-789",
  "data": {
    "id": "1",
    "email": "user@example.com",
    "userName": "홍길동",
    "company": "ZDM Corp",
    "country": "KR",
    "position": "개발자"
  },
  "message": "사용자 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/users/:identifier`

사용자 정보를 업데이트합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| userName | string | Optional | 사용자명 |
| password | string | Optional | 비밀번호 |
| pwData | string | Optional | 비밀번호 데이터 |
| position | string | Optional | 직책 |
| company | string | Optional | 회사명 |
| country | string | Optional | 국가 코드 (2자리, 예: KR, US) |

**Response:**

```json
{
  "success": true,
  "requestID": "req-user-update",
  "data": {
    "userInfo": {
      "id": "1",
      "email": "user@example.com",
      "userName": "홍길동",
      "company": "ZDM Corp",
      "country": "KR",
      "position": "Senior Developer"
    },
    "summary": {
      "state": "success",
      "message": "사용자 정보가 성공적으로 업데이트되었습니다",
      "updatedFieldsCount": 1,
      "updatedFields": [
        {
          "field": "직책",
          "previous": "개발자",
          "new": "Senior Developer"
        }
      ]
    }
  },
  "message": "사용자 정보가 성공적으로 업데이트되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**특징:**

- 변경 이력 추적: 수정된 각 필드의 이전 값과 새 값을 추적
- 보안 필드 마스킹: password, pwData 필드는 응답에서 `********`로 표시
- 부분 업데이트: 제공된 필드만 업데이트

**Status Codes:**

- `200` - 업데이트 성공
- `400` - 잘못된 요청 데이터
- `404` - 사용자를 찾을 수 없음
- `500` - 서버 오류
