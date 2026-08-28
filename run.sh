#!/usr/bin/env bash
#
# run.sh — ZDM 문서 사이트(gitpage) 로컬 미리보기 서버
#
# 무엇을 하는가
#   1) 이전 빌드 산출물(_site)과 Jekyll 캐시(.jekyll-cache)를 지운다
#      → 삭제한 페이지가 남아 있거나 캐시된 옛 include 가 섞이는 것을 막는다.
#   2) 의존 gem 이 갖춰졌는지 확인하고, 빠졌으면 설치한다.
#   3) Jekyll 개발 서버를 띄운다 (기본 http://0.0.0.0:4040).
#
# 왜 매번 캐시를 지우는가
#   이 사이트는 버전별 wrapper 가 `_includes/` 의 공용 문서를 참조하는 구조라,
#   include 대상이 바뀌어도 증분 빌드가 이를 놓치는 경우가 있다. 미리보기 정확성을
#   빌드 속도보다 우선한다.
#
# 사용법
#   ./run.sh                 기본 포트(4040)로 실행
#   PORT=8080 ./run.sh       포트 변경
#   HOST=127.0.0.1 ./run.sh  로컬에서만 접속 허용
#   ./run.sh --build         서버를 띄우지 않고 빌드만 (배포 전 검증용)
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO"

HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-4040}"
BUILD_ONLY=0
[ "${1:-}" = "--build" ] && BUILD_ONLY=1

# ── 의존성 확인 ──────────────────────────────────────────────
# bundle exec 는 gem 이 하나라도 빠지면 "Could not find ... in locally installed
# gems" 로 죽는다. 그 지점에서 멈추지 말고 여기서 먼저 채운다.
if ! bundle check >/dev/null 2>&1; then
  echo "[run.sh] 의존 gem 이 빠져 있습니다. 설치합니다..."
  # root 실행 경고는 컨테이너 환경에서 무의미하므로 억제한다.
  if ! bundle install --quiet 2>&1 | grep -v "Don't run Bundler as root"; then
    echo "[run.sh] bundle install 실패." >&2
    echo "         네트워크가 막혀 있다면 인터넷이 되는 환경에서 한 번 실행해 주세요." >&2
    exit 1
  fi
  bundle check >/dev/null 2>&1 || { echo "[run.sh] 의존성이 여전히 충족되지 않습니다." >&2; exit 1; }
fi

# ── 이전 산출물 정리 ─────────────────────────────────────────
rm -rf _site .jekyll-cache

# ── 빌드 / 서버 실행 ─────────────────────────────────────────
if [ "$BUILD_ONLY" -eq 1 ]; then
  echo "[run.sh] 빌드만 수행합니다 (서버 미실행)."
  exec bundle exec jekyll build
fi

echo "[run.sh] http://${HOST}:${PORT} 에서 실행합니다. (종료: Ctrl+C)"
exec bundle exec jekyll serve --host "$HOST" --port "$PORT"
