---
layout: docs
title: {METHOD} /{endpoint}
section_title: ZDM API Documentation
navigation: api
---

{API에 대한 간단한 설명}

---

## `{METHOD} /{endpoint}` {#{method}-{endpoint}}

> * {API에 대한 간단한 설명}

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>{METHOD} /api/v1/{endpoint}</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 요청
curl -X {METHOD} "https://api.example.com/api/v1/{endpoint}" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json"

# 파라미터 포함 요청
curl -X {METHOD} "https://api.example.com/api/v1/{endpoint}?param=value" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `param1` | Query | string | Required | - | 파라미터 설명 | - |
| `param2` | Query | number | Optional | `0` | 파라미터 설명 | - |
| `param3` | Body | string | Optional | - | 파라미터 설명 | `value1`, `value2`, `value3` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "key": "value"
  },
  "message": "Success message",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---

<!--
================================================================================
API 문서 작성 가이드
================================================================================

1. 파일 위치
   - 경로: /zdm/api/docs/{resource}/{action}.md
   - 예시: /zdm/api/docs/backup/list.md

2. Front Matter (필수)
   - layout: docs (고정)
   - title: {METHOD} /{endpoint}
   - section_title: ZDM API Documentation (고정)
   - navigation: api (고정)

3. 필수 섹션
   - 엔드포인트: <div class="command-card"> 사용
   - 요청 예시: bash (curl) 코드 블록 사용
   - 파라미터: 7열 테이블 (파라미터|위치|타입|필수|기본값|설명|선택값)

4. 선택 섹션 (필요시 추가)
   - 요청 본문: POST/PUT 요청의 경우
   - 응답 예시: json 코드 블록 사용
   - 에러 응답: 에러 케이스 설명

5. 파라미터 테이블 규칙
   - 위치 컬럼: Query, Path, Body, Header
   - 필수 컬럼: Required / Optional
   - 조건부 필수: Optional<span class="required-note">*</span>
     > <span class="required-note">*</span> 조건 설명
   - 기본값 없으면: -
   - 선택값 없으면: -

6. HTTP 메서드
   - GET: 조회
   - POST: 생성
   - PUT: 수정 (전체)
   - PATCH: 수정 (부분)
   - DELETE: 삭제

7. 섹션 구분
   - 주요 섹션 간 구분: ---

8. details 태그
   - 기본 열림: <details markdown="1" open>
   - 기본 닫힘: <details markdown="1">

9. 사이드바 네비게이션 추가
   - 파일 생성 후 _data/navigation.yml에 링크 추가 필요

================================================================================
-->
