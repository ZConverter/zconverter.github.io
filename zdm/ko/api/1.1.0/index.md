---
layout: docs
title: ZDM API Documentation v1.1.0
section_title: ZDM API Documentation
navigation: ko-api-1.1.0
lang: ko
---

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [ZDM API v1.1.0 소개](#zdm-api-v110-소개)
- [v1.0.3 대비 변경 사항](#v103-대비-변경-사항)
- [Base URL](#base-url)
- [표준 API 응답 형식](#표준-api-응답-형식)
- [식별자 패턴](#식별자-패턴-identifier-pattern)

</details>

---

## ZDM API v1.1.0 소개

ZDM-API v1.1.0은 백업, 복구, 시스템 관리를 위한 **API 서버**입니다.

> v1.0.3 대비 DB 스키마 일부 변경이 있으므로, 해당 버전의 DB 환경에서 사용하세요.

---

## v1.0.3 대비 변경 사항

<details markdown="1" open>
<summary><strong>신규 엔드포인트</strong></summary>

- **GET /backups/histories** — 백업 히스토리 목록 조회
- **GET /backups/histories/:identifier** — 백업 히스토리 단건 조회
- **GET /recoveries/histories** — 복구 히스토리 목록 조회
- **GET /recoveries/histories/:identifier** — 복구 히스토리 단건 조회

</details>

<details markdown="1" open>
<summary><strong>기존 API</strong></summary>

위 신규 엔드포인트를 제외한 나머지 API(Backup, Recovery, Server, Schedule, User, License, ZDM Center, File, Auth)는 [v1.0.3 문서](/zdm/ko/api/1.0.3/index)와 동일합니다.

</details>

---

## Base URL

```
/api
```

모든 API 엔드포인트는 위 Base URL을 기준으로 합니다.

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

| 필드 | 타입 | 설명 |
|------|------|------|
| success | boolean | 요청 성공 여부 (항상 `true`) |
| requestID | string | 요청 고유 ID |
| data | object | 응답 데이터 |
| message | string | 응답 메시지 |
| timestamp | string | 응답 시간 (YYYY-MM-DD HH:mm:ss 형식) |
| meta | object | 추가 메타데이터 (선택적) |

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

| 필드 | 타입 | 설명 |
|------|------|------|
| success | boolean | 요청 성공 여부 (항상 `false`) |
| requestID | string | 요청 고유 ID |
| error | string | 에러 메시지 |
| timestamp | string | 응답 시간 (YYYY-MM-DD HH:mm:ss 형식) |
| detail | object | 상세 에러 정보 (선택적) |

</details>

---

## 식별자 패턴 (Identifier Pattern)

대부분의 엔드포인트는 유연한 식별자 해석을 지원합니다:

<details markdown="1" open>
<summary><strong>식별자 처리 방식</strong></summary>

- **숫자 값** (`1`, `123`): ID로 처리
- **문자열 값** (`"user@example.com"`, `"server-name"`): Name/Email 등으로 처리

**예시:**
```bash
GET /api/users/1              # ID로 조회
GET /api/users/user@example.com  # 이메일로 조회
```

</details>

---
