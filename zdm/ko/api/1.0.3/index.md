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
- [Base URL](#base-url)
- [표준 API 응답 형식](#표준-api-응답-형식)
- [식별자 패턴](#식별자-패턴-identifier-pattern)

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
