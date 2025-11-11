---
layout: docs
title: User Management
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
        sublinks:
          - title: "전체 목록 조회"
            url: "/zdm/api/docs/users#get-users"
          - title: "특정 사용자 조회"
            url: "/zdm/api/docs/users#get-user"
          - title: "사용자 정보 수정"
            url: "/zdm/api/docs/users#update-user"
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

### GET `/users` {#get-users}

사용자 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---
### GET `/users/:identifier` {#get-user}

특정 사용자 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

</details>

<details markdown="1" open>
<summary><strong>Query Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | 사용자명 필터 |
| position | string | Optional | 직책 필터 |
| company | string | Optional | 회사명 필터 |
| country | string | Optional | 국가 필터 |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---
### PUT `/users/:identifier` {#update-user}

사용자 정보를 업데이트합니다.

<details markdown="1" open>
<summary><strong>Path Parameters</strong></summary>

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | 사용자 ID 또는 이메일 |

</details>

<details markdown="1" open>
<summary><strong>Request Body</strong></summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| userName | string | Optional | 사용자명 |
| password | string | Optional | 비밀번호 |
| pwData | string | Optional | 비밀번호 데이터 |
| position | string | Optional | 직책 |
| company | string | Optional | 회사명 |
| country | string | Optional | 국가 코드 (2자리, 예: KR, US) |

</details>

<details markdown="1" open>
<summary><strong>Response</strong></summary>

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

</details>

---