---
layout: docs
title: Overview
section_title: ZDM API Documentation
navigation: api
---

## 표준 API 응답 형식

모든 API 응답은 일관된 JSON 형식을 사용합니다.

---

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

---

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

<!-- ### 페이지네이션 응답 (Pagination Response)

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

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

**Meta 필드 설명:**
- `currentPage`: 현재 페이지 번호
- `totalPages`: 전체 페이지 수
- `totalItems`: 전체 아이템 수
- `itemsPerPage`: 페이지당 아이템 수
- `hasNextPage`: 다음 페이지 존재 여부
- `hasPreviousPage`: 이전 페이지 존재 여부

</details>

--- -->

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

## 인증 헤더

모든 보호된 엔드포인트는 Authorization 헤더가 필요합니다:

```text
Authorization: <token>
```

또는

```text
Authorization: Bearer <token>
```
