# 로컬 개발 환경 가이드

## 개요
이 문서는 ZConverter Documentation 사이트를 로컬에서 실행하고 테스트하는 방법을 설명합니다.

## 시스템 요구사항

- Ruby 2.5.0 이상 (현재 설치: Ruby 3.0.2)
- Bundler
- Git

## 초기 환경 설정

### 1. Ruby 및 필수 패키지 설치

```bash
# Ubuntu/Debian
apt-get update
apt-get install -y ruby-full build-essential zlib1g-dev
```

### 2. Bundler 설치

```bash
gem install bundler
```

### 3. 프로젝트 의존성 설치

```bash
bundle install
```

## 로컬 서버 실행

### 기본 실행

```bash
bundle exec jekyll serve
```

기본적으로 http://localhost:4000/ 에서 사이트에 접근할 수 있습니다.

### 모든 네트워크 인터페이스에서 접근 가능하도록 실행

```bash
bundle exec jekyll serve --host 0.0.0.0 --port 4000
```

### 라이브 리로드 사용

파일 변경 시 브라우저가 자동으로 새로고침됩니다:

```bash
bundle exec jekyll serve --livereload
```

### 증분 빌드 (빠른 재빌드)

```bash
bundle exec jekyll serve --incremental
```

### 증분, 라이브 리로드 함께 사용 (권장)
```bash
bundle exec jekyll serve --livereload --incremental
```


### 초안(draft) 포함하여 보기

```bash
bundle exec jekyll serve --drafts
```

### 특정 포트 사용

```bash
bundle exec jekyll serve --port 4001
```

## 서버 관리

### 서버 중지

- `Ctrl + C` 를 눌러 서버를 중지합니다.
- 또는 다른 터미널에서:

```bash
pkill -f "jekyll serve"
```

### 서버 상태 확인

```bash
ps aux | grep jekyll
```

## 프로젝트 구조

```
zconverter.github.io/
├── _config.yml          # Jekyll 설정 파일
├── Gemfile             # Ruby 의존성 정의
├── index.md            # 홈페이지
├── _layouts/           # 페이지 레이아웃
├── _includes/          # 재사용 가능한 컴포넌트
├── assets/             # CSS, JS, 이미지 등
└── zdm/                # ZDM 문서
```

## 설치된 환경 정보

- **Ruby**: 3.0.2
- **Bundler**: 2.5.23
- **Jekyll**: 4.4.1
- **Theme**: minima 2.5
- **Markdown Parser**: kramdown (GFM 입력 모드)
- **Syntax Highlighter**: rouge

## 주요 플러그인

- `jekyll-feed`: RSS 피드 생성
- `jekyll-seo-tag`: SEO 메타 태그 자동 생성

## 문제 해결

### 포트가 이미 사용 중인 경우

```bash
# 다른 포트 사용
bundle exec jekyll serve --port 4001
```

### 의존성 문제

```bash
# Gemfile.lock 삭제 후 재설치
rm Gemfile.lock
bundle install
```

### 캐시 문제

```bash
# 빌드된 사이트 삭제
rm -rf _site .jekyll-cache
bundle exec jekyll serve
```

## 배포 전 확인 사항

1. 로컬에서 모든 페이지가 정상적으로 렌더링되는지 확인
2. 링크가 올바르게 작동하는지 확인
3. 이미지 및 자산이 제대로 로드되는지 확인
4. 반응형 디자인 확인 (모바일, 태블릿, 데스크톱)

## 유용한 명령어

```bash
# Jekyll 버전 확인
bundle exec jekyll --version

# 사이트 빌드만 수행 (서버 실행 없음)
bundle exec jekyll build

# 프로덕션 환경으로 빌드
JEKYLL_ENV=production bundle exec jekyll build

# 도움말
bundle exec jekyll help
```

## 참고 자료

- [Jekyll 공식 문서](https://jekyllrb.com/docs/)
- [GitHub Pages 문서](https://docs.github.com/en/pages)
- [Minima 테마](https://github.com/jekyll/minima)

## 현재 서버 상태

서버가 실행 중입니다:
- **주소**: http://0.0.0.0:4000/ 또는 http://localhost:4000/
- **자동 재생성**: 활성화
- **파일 변경 감지**: 활성화

파일을 수정하면 자동으로 사이트가 재빌드되며, 브라우저를 새로고침하면 변경사항을 확인할 수 있습니다.
