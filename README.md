# ZConverter Documentation

ZConverter 제품군의 공식 문서 사이트입니다. Jekyll 기반 정적 사이트로 GitHub Pages를 통해 배포됩니다.

**배포 URL:** https://zconverter.github.io

---

## 목차

- [프로젝트 구조](#프로젝트-구조)
- [로컬 개발 환경](#로컬-개발-환경)
- [사이드바 네비게이션 관리](#사이드바-네비게이션-관리)
- [문서 작성 규칙](#문서-작성-규칙)
- [배포](#배포)
- [기술 스택](#기술-스택)

---

## 프로젝트 구조

### 주요 디렉토리

| 디렉토리 | 설명 |
|---------|------|
| `_layouts/` | Jekyll 레이아웃 템플릿 (home, docs, page 등) |
| `_includes/` | 재사용 가능한 HTML 컴포넌트 |
| `_includes/zdm/` | ZDM 문서용 include 템플릿 (enum, platforms 등) |
| `_data/` | 중앙 집중식 데이터 파일 |
| `assets/` | CSS, 이미지 등 정적 자산 |
| `zdm/` | ZDM 제품 문서 (API, CLI) |
| `zdm/api/1.0.3/docs/` | ZDM API 문서 페이지들 |
| `zdm/cli/1.0.3/docs/` | ZDM CLI 문서 페이지들 |
| `.github/workflows/` | GitHub Actions 자동 배포 설정 |
| `_site/` | Jekyll 빌드 결과물 (git 제외) |
| `.jekyll-cache/` | Jekyll 캐시 (git 제외) |

### 데이터 폴더 구조

```
_data/
├── navigation.yml           # 사이드바 네비게이션 구조
└── zdm/
    ├── common/
    │   ├── enums.yml        # 공통 enum 정의
    │   └── versions.yml     # 버전 메타정보
    ├── api/
    │   └── v1_0_3/          # API 버전별 데이터
    │       └── enums.yml
    └── cli/
        └── v1_0_3/          # CLI 버전별 데이터
            └── enums.yml
```

> **주의: 데이터 폴더 네이밍 규칙**
>
> Jekyll은 `site.data` 접근 시 폴더명의 점(.)을 제거합니다.
> - `_data/zdm/cli/1.0.3/` → `site.data.zdm.cli["103"]` (점 제거됨)
> - `_data/zdm/cli/v1_0_3/` → `site.data.zdm.cli["v1_0_3"]` (정상 접근)
>
> 따라서 버전별 데이터 폴더는 `v1_0_3` 형식을 사용합니다.
> 문서 URL 경로(`zdm/api/1.0.3/`)는 점(.) 사용 가능합니다.

### 주요 설정 파일

| 파일 | 용도 |
|-----|------|
| `_config.yml` | Jekyll 전역 설정 |
| `_data/navigation.yml` | 사이드바 네비게이션 구조 |
| `_data/zdm/common/enums.yml` | 공통 enum 값 정의 |
| `_data/zdm/common/versions.yml` | API/CLI 버전 메타정보 |
| `Gemfile` | Ruby 의존성 패키지 |
| `.github/workflows/jekyll.yml` | GitHub Pages 배포 워크플로우 |

---

## 로컬 개발 환경

### 시스템 요구사항

- Ruby 2.5.0 이상
- Bundler
- Git

### 설치

```bash
# Ubuntu/Debian
apt-get update
apt-get install -y ruby-full build-essential zlib1g-dev

# Bundler 설치
gem install bundler

# 프로젝트 의존성 설치
bundle install
```

### 서버 실행

```bash
# 기본 실행
bundle exec jekyll serve

# 권장: 라이브 리로드 + 증분 빌드
bundle exec jekyll serve --livereload --incremental

# 모든 네트워크 인터페이스에서 접근
bundle exec jekyll serve --host 0.0.0.0 --port 4000

# 초안(draft) 포함
bundle exec jekyll serve --drafts
```

사이트는 http://localhost:4000 에서 접근 가능합니다.

### 서버 관리

```bash
# 서버 중지: Ctrl + C 또는
pkill -f "jekyll serve"

# 서버 상태 확인
ps aux | grep jekyll

# 다른 포트 사용
bundle exec jekyll serve --port 4001
```

### 문제 해결

```bash
# 의존성 문제
rm Gemfile.lock
bundle install

# 캐시 문제
rm -rf _site .jekyll-cache
bundle exec jekyll serve

# 빌드만 수행 (서버 없이)
bundle exec jekyll build

# 프로덕션 환경 빌드
JEKYLL_ENV=production bundle exec jekyll build
```

---

## 사이드바 네비게이션 관리

모든 사이드바 구조는 `_data/navigation.yml`에서 중앙 관리됩니다.

### 사용 방법

1. `_data/navigation.yml`에서 네비게이션 섹션 정의
2. 마크다운 파일의 front matter에 `navigation: api-1.0.3` 형태로 지정
3. 모든 페이지가 자동으로 동일한 사이드바 구조를 공유

### 예시

**_data/navigation.yml:**
```yaml
api-1.0.3:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/1.0.3/index"
      - title: "GET /users"
        url: "/zdm/api/1.0.3/docs/user/list"
```

**문서 파일 (zdm/api/1.0.3/docs/user/list.md):**
```yaml
---
layout: docs
title: GET /users
section_title: ZDM API Documentation
navigation: api-1.0.3
---
```

---

## 문서 작성 규칙

### 기본 규칙

- 이모지 사용 금지
- `docs` 레이아웃 사용
- Kramdown 문법 사용

### 접을 수 있는 섹션

```markdown
<details markdown="1" open>
<summary><strong>섹션 제목</strong></summary>

내용...

</details>
```

> `markdown="1"` 속성 필수 (내부 마크다운 렌더링)
> `open` 속성: 기본 펼침 상태

### Include 사용

```markdown
<!-- 인라인 출력 -->
| --platform | {% include zdm/platforms.md baremetal=true inline=true %} |

<!-- 테이블 출력 -->
{% include zdm/platforms.md baremetal=true desc=true %}
```

### 파라미터 테이블 형식

```markdown
| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --mode | -m | string | Required | - | 작업 모드 | {% include zdm/job-modes.md %} |
```

---

## 배포

`main` 브랜치에 push하면 GitHub Actions가 자동으로 빌드 및 배포합니다.

### 배포 전 확인사항

1. 로컬에서 모든 페이지 렌더링 확인
2. 링크 정상 작동 확인
3. 이미지 및 자산 로드 확인
4. 반응형 디자인 확인

---

## 기술 스택

| 구분 | 기술 | 버전 |
|------|------|------|
| 정적 사이트 생성기 | Jekyll | 4.4.1 |
| 마크다운 파서 | Kramdown (GFM) | - |
| 코드 하이라이팅 | Rouge | - |
| 호스팅 | GitHub Pages | - |
| CI/CD | GitHub Actions | - |
| Ruby | Ruby | 3.0.2 |
| 패키지 관리 | Bundler | 2.5.23 |

### 주요 플러그인

- `jekyll-feed`: RSS 피드 생성
- `jekyll-seo-tag`: SEO 메타 태그 자동 생성
