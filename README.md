# ZConverter Documentation

ZConverter 제품군의 공식 문서 사이트 저장소입니다. Jekyll 기반 정적 사이트로 GitHub Pages를 통해 배포됩니다.

## 프로젝트 구조

### 주요 디렉토리

| 디렉토리 | 설명 |
|---------|------|
| `_layouts/` | Jekyll 레이아웃 템플릿 (home, docs, page 등) |
| `_includes/` | 재사용 가능한 HTML 컴포넌트 (사이드바 등) |
| `_data/` | 중앙 집중식 데이터 파일 (navigation.yml - 사이드바 네비게이션 구조) |
| `assets/` | CSS, 이미지 등 정적 자산 |
| `zdm/` | ZDM 제품 문서 (API, CLI) |
| `zdm/api/docs/` | ZDM API 문서 페이지들 |
| `zdm/cli/docs/` | ZDM CLI 문서 페이지들 |
| `.github/workflows/` | GitHub Actions 자동 배포 설정 |
| `_site/` | Jekyll 빌드 결과물 (git에서 제외) |
| `.jekyll-cache/` | Jekyll 캐시 디렉토리 (git에서 제외) |

### 주요 YAML 파일

| 파일 | 용도 |
|-----|------|
| `_config.yml` | Jekyll 사이트 전역 설정 (title, baseurl, markdown 엔진, 플러그인 등) |
| `_data/navigation.yml` | 사이드바 네비게이션 구조 정의 (zdm, api, cli 섹션별 관리) |
| `Gemfile` | Ruby 의존성 패키지 정의 (Jekyll, 플러그인) |
| `.github/workflows/jekyll.yml` | GitHub Pages 자동 배포 워크플로우 |

### 루트 레벨 파일

| 파일 | 설명 |
|-----|------|
| `index.md` | 사이트 메인 페이지 |
| `DEVELOPMENT.md` | 개발 가이드 문서 |
| `.gitignore` | Git 제외 파일 목록 |

## 로컬 개발 환경 설정

### 1. 의존성 설치

```bash
bundle install
```

### 2. 개발 서버 실행

```bash
bundle exec jekyll serve --livereload
```

사이트는 `http://localhost:4000`에서 접근 가능합니다.

## 사이드바 네비게이션 관리

모든 사이드바 구조는 `_data/navigation.yml`에서 중앙 관리됩니다.

### 사용 방법

1. `_data/navigation.yml`에서 네비게이션 섹션 정의 (예: `api`, `cli`, `zdm`)
2. 마크다운 파일의 front matter에 `navigation: api` 형태로 지정
3. 모든 페이지가 자동으로 동일한 사이드바 구조를 공유

### 예시

**_data/navigation.yml:**
```yaml
api:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/index"
      - title: "Overview"
        url: "/zdm/api/docs/overview"
```

**문서 파일 (zdm/api/docs/overview.md):**
```yaml
---
layout: docs
title: Overview
section_title: ZDM API Documentation
navigation: api
---
```

## 문서 작성 규칙

- 이모지 사용 금지
- `<details>` 태그로 접을 수 있는 섹션 구현
- Kramdown 문법 사용 (`markdown="1"` 속성 필수)
- 각 문서는 `docs` 레이아웃 사용

## 배포

`main` 브랜치에 push하면 GitHub Actions가 자동으로 빌드 및 배포를 수행합니다.

**배포 URL:** https://zconverter.github.io

## 기술 스택

- **Jekyll 4.3** - 정적 사이트 생성기
- **Kramdown** - 마크다운 파서
- **Rouge** - 코드 하이라이팅
- **GitHub Pages** - 호스팅
- **GitHub Actions** - CI/CD
