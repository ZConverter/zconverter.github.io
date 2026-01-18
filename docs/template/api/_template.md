---
layout: docs
title: {METHOD} /{endpoint}
section_title: ZDM API Documentation
navigation: api-{version}
---

{API에 대한 간단한 설명}

---

## `{METHOD} /{endpoint}` {#{method}-{endpoint}}

> * {API에 대한 간단한 설명}

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>{METHOD} /api/{endpoint}</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 요청
curl -X {METHOD} "https://api.example.com/api/{endpoint}" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json"

# 파라미터 포함 요청
curl -X {METHOD} "https://api.example.com/api/{endpoint}?param=value" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `param1` | Query | string | Required | - | 파라미터 설명 | - |
| `param2` | Query | number | Optional | `0` | 파라미터 설명 | - |
| `param3` | Body | string | Optional | - | 파라미터 설명 | {% include zdm/job-modes.md backup=true %} |

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

1. 파일 위치 (버전별 관리)
   - 경로: /zdm/api/{version}/docs/{resource}/{action}.md
   - 예시: /zdm/api/1.0.3/docs/backup/list.md

2. Front Matter (필수)
   - layout: docs (고정)
   - title: {METHOD} /{endpoint}
   - section_title: ZDM API Documentation (고정)
   - navigation: api-{version} (예: api-1.0.3)

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

6. Enum Include 사용법
   - 기존 래퍼 (하위 호환성):
     {% include zdm/job-modes.md backup=true %}
     {% include zdm/server-modes.md %}
     {% include zdm/platforms.md %}
   - 새 템플릿 (버전 지정):
     {% include zdm/enum.html name="job-modes" type="api" version="1.0.3" context="backup" format="inline" %}
   - 주요 enum 목록:
     - job-modes (backup/recovery)
     - server-modes
     - job-status
     - repository-types
     - os-types
     - platforms
     - overwrite-options
     - schedule-types
     - weekdays

7. HTTP 메서드
   - GET: 조회
   - POST: 생성
   - PUT: 수정 (전체)
   - PATCH: 수정 (부분)
   - DELETE: 삭제

8. 섹션 구분
   - 주요 섹션 간 구분: ---

9. details 태그
   - 기본 열림: <details markdown="1" open>
   - 기본 닫힘: <details markdown="1">

10. 중첩 Collapsible 규칙
   - 응답 예시: 2개 이상인 경우에만 중첩 collapsible 적용
     - 1개: **성공 응답 (200 OK)** (볼드 텍스트)
     - 2개 이상: <details><summary>기본 응답</summary>...</details>
   - 응답 필드: 필드 카테고리가 2개 이상인 경우 중첩 collapsible 적용
     - 예: 기본 필드, 상세 필드(detail=true), 디스크 필드(disk=true) 등
   - base/detail 응답이 다른 경우:
     - <details><summary>기본 응답 (detail=false)</summary>...</details>
     - <details><summary>상세 응답 (detail=true)</summary>...</details>

11. 조건부 응답 필드 테이블 형식
    - 조건부 필드가 있을 경우 "조건" 컬럼 추가
    - 형식: | 필드 | 타입 | 설명 | 조건 |
    - 조건 값 예시: 기본, detail=true, disk=true, partition=true
    - 무조건 포함 필드: "기본" 또는 "-"

12. 코드 검증 필수 규칙
    - 문서 작성 전 반드시 실제 코드와 일치 여부 확인
    - 응답 필드: src/domain/{도메인}/dto/response/*.dto.ts
    - 요청 파라미터: src/domain/{도메인}/schemas/**/*.schema.ts
    - 확인 항목:
      - 필드명 대소문자 정확히 일치 (camelCase vs lowercase)
      - 타입 정확히 일치 (number vs string, 특히 포맷된 값 주의)
      - 중첩 객체 구조 일치 (예: file.filename vs filename)
      - 선택값(enum) 일치

13. 엔드포인트 분리 규칙
    - 동일 리소스에 대해 서로 다른 path parameter를 사용하는 경우 별도 파일로 분리
    - 예시:
      - GET /monitoring/job/:identifier → monitoring-job.md
      - GET /monitoring/system/:identifier → monitoring-system.md
    - 파일명 규칙: {action}-{구분자}.md

14. 신규 버전 추가 시
    - docs/update.md 참고
    - _data/zdm/api/{version}/enums.yml 생성
    - _data/navigation.yml에 api-{version} 추가

마지막. 사이드바 네비게이션 추가
    - 파일 생성 후 _data/navigation.yml에 링크 추가 필요
    - 버전별 네비게이션 키: api-{version} (예: api-1.0.3)

================================================================================
-->
