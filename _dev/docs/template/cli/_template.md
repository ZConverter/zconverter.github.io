---
layout: docs
title: {command} {subcommand}
section_title: ZDM CLI Documentation
navigation: cli-{version}
---

{명령어에 대한 간단한 설명}

---

## `{command} {subcommand}` {#{command}-{subcommand}}

> * {명령어에 대한 간단한 설명}

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli {command} {subcommand} [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 사용
zdm-cli {command} {subcommand} --option value

# 추가 예시
zdm-cli {command} {subcommand} --option1 value1 --option2 value2
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--option1` | `-o` | string | Required | - | 옵션 설명 | - |
| `--option2` | - | number | Optional | `0` | 옵션 설명 | - |
| `--option3` | - | string | Optional | - | 옵션 설명 | {% include zdm/job-modes.md backup=true %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "Success message",
  "success": true,
  "data": {
    "key": "value"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---

<!--
================================================================================
CLI 문서 작성 가이드
================================================================================

1. 파일 위치 (버전별 관리)
   - 경로: /zdm/cli/{version}/docs/{command}/{subcommand}.md
   - 예시: /zdm/cli/1.0.3/docs/backup/list.md

2. Front Matter (필수)
   - layout: docs (고정)
   - title: {command} {subcommand}
   - section_title: ZDM CLI Documentation (고정)
   - navigation: cli-{version} (예: cli-1.0.3)

3. 필수 섹션
   - 명령어 구문: <div class="command-card"> 사용
   - 사용 예시: bash 코드 블록 사용
   - 파라미터: 7열 테이블 (파라미터|별칭|타입|필수|기본값|설명|선택값)

4. 선택 섹션 (필요시 추가)
   - 출력 예시: json 코드 블록 사용
   - 추가 설명 섹션

5. 파라미터 테이블 규칙
   - 필수 컬럼: Required / Optional
   - 조건부 필수: Optional<span class="required-note">*</span>
     > <span class="required-note">*</span> 조건 설명
   - 기본값 없으면: -
   - 선택값 없으면: -

6. Enum Include 사용법
   - 기존 래퍼 (하위 호환성):
     {% include zdm/job-modes.md backup=true %}
     {% include zdm/server-modes.md %}
     {% include zdm/platforms.md baremetal=true %}
     {% include zdm/output-formats.md %}
   - 새 템플릿 (버전 지정):
     {% include zdm/enum.html name="job-modes" type="cli" version="1.0.3" context="backup" format="inline" %}
   - 주요 enum 목록:
     - job-modes (backup/recovery)
     - server-modes
     - job-status
     - repository-types
     - os-types
     - platforms (baremetal 포함)
     - overwrite-options (notAllow 사용)
     - schedule-types
     - weekdays
     - output-formats (CLI 전용)

7. HTML 엔티티
   - < : &lt;
   - > : &gt;

8. 섹션 구분
   - 주요 섹션 간 구분: ---

9. details 태그
   - 기본 열림: <details markdown="1" open>
   - 기본 닫힘: <details markdown="1">

10. 신규 버전 추가 시
    - docs/update.md 참고
    - _data/zdm/cli/{version}/enums.yml 생성
    - _data/navigation.yml에 cli-{version} 추가

마지막. 사이드바 네비게이션 추가
    - 파일 생성 후 _data/navigation.yml에 링크 추가 필요
    - 버전별 네비게이션 키: cli-{version} (예: cli-1.0.3)

================================================================================
-->
