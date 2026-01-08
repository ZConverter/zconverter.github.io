# ZDM 문서 버전 관리 가이드

이 문서는 ZDM API 및 CLI 문서의 신규 버전 추가 절차를 설명합니다.

---

## 디렉토리 구조

```
zconverter.github.io/
├── _data/
│   ├── navigation.yml              # 네비게이션 설정
│   └── zdm/
│       ├── common/
│       │   ├── versions.yml        # 버전 메타정보
│       │   └── enums.yml           # 공통 enum 데이터
│       ├── api/
│       │   └── 1.0.3/
│       │       └── enums.yml       # API 버전별 enum 데이터
│       └── cli/
│           └── 1.0.3/
│               └── enums.yml       # CLI 버전별 enum 데이터
├── _includes/
│   └── zdm/
│       ├── enum.html               # enum 렌더링 템플릿
│       ├── job-modes.md            # 래퍼 (하위 호환성)
│       └── ...                     # 기타 래퍼 파일들
├── downloads/
│   ├── zdm-api/
│   │   ├── 1.0.3/                  # API 다운로드 파일
│   │   └── 1.0.4/
│   └── zdm-cli/
│       └── 1.0.3/                  # CLI 다운로드 파일
└── zdm/
    ├── api/
    │   ├── index.md                # 리다이렉트 페이지
    │   ├── 1.0.3/                  # 버전별 문서
    │   │   ├── index.md
    │   │   └── docs/
    │   └── 1.0.4/
    └── cli/
        ├── index.md                # 리다이렉트 페이지
        └── 1.0.3/
            ├── index.md
            └── docs/
```

---

## API 신규 버전 추가 절차

### Step 1: 버전 정보 등록

`_data/zdm/common/versions.yml` 파일에 신규 버전 추가:

```yaml
api:
  - version: "1.0.3"
    status: current
    released: 2024-01-01
    description: "현재 안정 버전"
  - version: "1.0.4"
    status: beta          # 신규 버전 추가
    released: 2025-01-01
    description: "베타 버전"
```

**status 값:**
- `current`: 현재 안정 버전 (프로덕션 권장)
- `beta`: 베타 버전
- `deprecated`: 지원 종료 예정

---

### Step 2: 문서 폴더 생성

```bash
# 이전 버전 복사
cp -r zdm/api/1.0.3 zdm/api/1.0.4
```

---

### Step 3: Front Matter 업데이트

복사된 모든 `.md` 파일의 navigation 값 변경:

```bash
# 일괄 변경
find zdm/api/1.0.4 -name "*.md" -exec sed -i 's/navigation: api-1.0.3/navigation: api-1.0.4/' {} \;
```

또는 각 파일에서 수동으로 변경:

```yaml
# 변경 전
navigation: api-1.0.3

# 변경 후
navigation: api-1.0.4
```

---

### Step 4: index.md 제목 업데이트

`zdm/api/1.0.4/index.md` 파일 수정:

```yaml
---
layout: docs
title: ZDM API Documentation v1.0.4
section_title: ZDM API Documentation
navigation: api-1.0.4
---
```

---

### Step 5: 네비게이션 추가

`_data/navigation.yml` 파일에 신규 버전 네비게이션 추가:

```yaml
# API v1.0.4 Navigation
api-1.0.4:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/1.0.4/index"
  - title: "Authentication"
    links:
      - title: "POST /auth/issue"
        url: "/zdm/api/1.0.4/docs/auth/issue"
  # ... 나머지 엔드포인트
```

---

### Step 6: 다운로드 파일 추가

```bash
mkdir -p downloads/zdm-api/1.0.4
# 다운로드 파일 배치
# - zdm-api-linux.tar.gz
```

---

### Step 7: 리다이렉트 업데이트 (current 변경 시)

신규 버전이 current가 되는 경우 `zdm/api/index.md` 수정:

```markdown
---
redirect_to: /zdm/api/1.0.4/index
---

<script>
  window.location.href = "{{ '/zdm/api/1.0.4/index' | relative_url }}";
</script>
```

---

## CLI 신규 버전 추가 절차

### Step 1: 버전 정보 등록

`_data/zdm/common/versions.yml` 파일에 신규 버전 추가:

```yaml
cli:
  - version: "1.0.3"
    status: current
    released: 2024-01-01
    description: "현재 안정 버전"
  - version: "1.0.4"
    status: beta          # 신규 버전 추가
    released: 2025-01-01
    description: "베타 버전"
```

---

### Step 2: 문서 폴더 생성

```bash
# 이전 버전 복사
cp -r zdm/cli/1.0.3 zdm/cli/1.0.4
```

---

### Step 3: Front Matter 업데이트

```bash
# 일괄 변경
find zdm/cli/1.0.4 -name "*.md" -exec sed -i 's/navigation: cli-1.0.3/navigation: cli-1.0.4/' {} \;
```

---

### Step 4: index.md 제목 업데이트

`zdm/cli/1.0.4/index.md` 파일 수정:

```yaml
---
layout: docs
title: ZDM CLI Documentation v1.0.4
section_title: ZDM CLI Documentation
navigation: cli-1.0.4
---
```

---

### Step 5: 네비게이션 추가

`_data/navigation.yml` 파일에 신규 버전 네비게이션 추가:

```yaml
# CLI v1.0.4 Navigation
cli-1.0.4:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/cli/1.0.4/index"
  - title: "Token"
    links:
      - title: "개요"
        url: "/zdm/cli/1.0.4/docs/token/overview"
      - title: "token issue"
        url: "/zdm/cli/1.0.4/docs/token/issue"
  # ... 나머지 커맨드
```

---

### Step 6: 다운로드 파일 추가

```bash
mkdir -p downloads/zdm-cli/1.0.4
# 다운로드 파일 배치
# - zdm-cli-windows.zip
# - zdm-cli-linux.tar.gz
```

---

### Step 7: 리다이렉트 업데이트 (current 변경 시)

신규 버전이 current가 되는 경우 `zdm/cli/index.md` 수정:

```markdown
---
redirect_to: /zdm/cli/1.0.4/index
---

<script>
  window.location.href = "{{ '/zdm/cli/1.0.4/index' | relative_url }}";
</script>
```

---

## Enum 데이터 버전 관리

Enum 데이터는 API/CLI 버전별로 관리됩니다.

### 데이터 구조

```
_data/zdm/
├── common/
│   └── enums.yml           # 공통 enum (버전 무관)
├── api/
│   ├── 1.0.3/
│   │   └── enums.yml       # API 1.0.3 전용 enum
│   └── 1.0.4/
│       └── enums.yml       # API 1.0.4 전용 enum
└── cli/
    ├── 1.0.3/
    │   └── enums.yml       # CLI 1.0.3 전용 enum
    └── 1.0.4/
        └── enums.yml       # CLI 1.0.4 전용 enum
```

### 공통 vs 버전별 enum

| 위치 | 용도 | 예시 |
|------|------|------|
| `common/enums.yml` | 모든 버전에서 동일한 enum | `server-modes`, `job-status`, `weekdays` |
| `api/{version}/enums.yml` | API 버전별 차이가 있는 enum | `os-types` (cloud 포함), `overwrite-options` |
| `cli/{version}/enums.yml` | CLI 버전별 차이가 있는 enum | `platforms` (baremetal 포함), `output-formats` |

---

### Enum 신규 버전 추가 절차

#### Step 1: 버전별 enum 파일 생성

```bash
# 이전 버전에서 복사
cp _data/zdm/api/1.0.3/enums.yml _data/zdm/api/1.0.4/enums.yml
cp _data/zdm/cli/1.0.3/enums.yml _data/zdm/cli/1.0.4/enums.yml
```

#### Step 2: 변경 사항 반영

신규 버전에서 변경된 enum 값을 수정합니다.

```yaml
# _data/zdm/api/1.0.4/enums.yml 예시
job-modes:
  backup:
    - value: "full"
      description: "전체 백업"
    - value: "increment"
      description: "증분 백업"
    - value: "smart"
      description: "스마트 백업"
    - value: "differential"     # 신규 추가
      description: "차등 백업"
```

#### Step 3: Include 래퍼 업데이트 (필요시)

신규 버전에서만 사용되는 새로운 enum이 추가된 경우, 래퍼 파일 생성:

```liquid
{%- comment -%}
New Enum Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="new-enum" type="api" version="1.0.4" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="new-enum" type="api" version="1.0.4" format="inline" -%}
{%- endif -%}
```

---

### Enum Include 사용법

#### 새 템플릿 직접 사용

```liquid
{% include zdm/enum.html name="job-modes" type="api" version="1.0.3" context="backup" %}
{% include zdm/enum.html name="platforms" type="cli" version="1.0.3" format="inline" %}
{% include zdm/enum.html name="schedule-types" show_number=true show_category=true %}
```

#### 기존 래퍼 사용 (하위 호환성)

```liquid
{% include zdm/job-modes.md backup=true %}
{% include zdm/platforms.md baremetal=true %}
{% include zdm/schedule-types.md number=true category=true %}
```

---

### Enum 템플릿 파라미터

| 파라미터 | 타입 | 설명 |
|----------|------|------|
| `name` | string | (필수) enum 이름 |
| `type` | string | `api` 또는 `cli` |
| `version` | string | 버전 (예: `1.0.3`) |
| `context` | string | 컨텍스트 (예: `backup`, `recovery`) |
| `format` | string | `table` (기본값) 또는 `inline` |
| `show_desc` | boolean | 설명 컬럼 표시 (기본값: `true`) |
| `show_number` | boolean | 번호 컬럼 표시 (기본값: `false`) |
| `show_category` | boolean | 카테고리 컬럼 표시 (기본값: `false`) |

---

## 체크리스트

### API 버전 추가

- [ ] `_data/zdm/common/versions.yml`에 버전 정보 추가
- [ ] `_data/zdm/api/{version}/enums.yml` 생성 (이전 버전 복사 후 수정)
- [ ] `zdm/api/{version}/` 폴더 생성 및 문서 복사
- [ ] 모든 문서의 `navigation` 값 업데이트
- [ ] `zdm/api/{version}/index.md` 제목 업데이트
- [ ] `_data/navigation.yml`에 네비게이션 추가
- [ ] `downloads/zdm-api/{version}/` 폴더 생성 및 파일 배치
- [ ] (current 변경 시) `zdm/api/index.md` 리다이렉트 업데이트
- [ ] (current 변경 시) `zdm/index.md`의 문서 링크 및 다운로드 링크 업데이트

### CLI 버전 추가

- [ ] `_data/zdm/common/versions.yml`에 버전 정보 추가
- [ ] `_data/zdm/cli/{version}/enums.yml` 생성 (이전 버전 복사 후 수정)
- [ ] `zdm/cli/{version}/` 폴더 생성 및 문서 복사
- [ ] 모든 문서의 `navigation` 값 업데이트
- [ ] `zdm/cli/{version}/index.md` 제목 업데이트
- [ ] `_data/navigation.yml`에 네비게이션 추가
- [ ] `downloads/zdm-cli/{version}/` 폴더 생성 및 파일 배치
- [ ] (current 변경 시) `zdm/cli/index.md` 리다이렉트 업데이트
- [ ] (current 변경 시) `zdm/index.md`의 문서 링크 및 다운로드 링크 업데이트

---

## 주의사항

1. **버전 형식**: 반드시 Semantic Versioning (예: 1.0.3, 1.0.0) 사용
2. **navigation 키**: `api-{version}` 또는 `cli-{version}` 형식 사용
3. **URL 패턴**: `/zdm/api/{version}/docs/...` 또는 `/zdm/cli/{version}/docs/...`
4. **리다이렉트**: 기존 URL 호환성을 위해 index.md 리다이렉트 페이지 유지
5. **다운로드 파일**: 버전별 디렉토리에 실제 다운로드 파일 배치 필요
