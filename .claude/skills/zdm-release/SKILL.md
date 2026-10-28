---
name: zdm-release
description: ZDM CLI/API 신규 버전 릴리즈 절차 (versions.yml 등록, navigation, wrapper·intro 생성, changelog, 보존본 분리, 바이너리 배치, 랜딩페이지, CHANGELOG). 버전 추가·패치·재업로드 작업 시 사용.
---

# 신규 버전 릴리즈 절차

CLI 또는 API 신규 버전 업로드 시 아래 절차를 순서대로 수행합니다.

> 예시는 CLI 기준. API도 동일한 패턴 (`cli` → `api`로 치환).

### 릴리즈 유형 분류 (먼저 판정)

ZDM 릴리즈는 **바이너리 변경 여부 × 문서 변경 여부**로 3가지 유형으로 분류되며, 유형에 따라 수행할 단계가 달라집니다. 작업 시작 전에 해당 릴리즈가 어느 유형인지 먼저 판정하세요.

| 유형 | 조건 | 적용 단계 |
|------|------|-----------|
| **표준 릴리즈** | 새 바이너리 + 문서 변경 있음 (대부분의 마이너·메이저) | 1~10단계 전체 |
| **부분 갱신 릴리즈** | 새 바이너리 + 일부 문서만 변경 (소규모 마이너·기능 추가형 패치) | 1~10단계 전체, 5단계는 변경된 파일만 분리 |
| **재사용 패치** | 버그 수정만 + 사용자 가이드 변경 無 (바이너리는 있거나 없거나) | 1·7·8·9단계만 (축약 절차 별도 명시) |

**판정 플로차트**

```
① 사용자 가이드(파라미터 / 커맨드 / 엔드포인트)가 변경됐는가?
   ├─ 전부 변경       → 표준 릴리즈
   ├─ 일부만 변경     → 부분 갱신 릴리즈
   └─ 변경 無         → 재사용 패치

② 새 바이너리를 배포하는가?
   ├─ 예              → 7단계에서 신규 디렉토리에 배치
   └─ 아니오          → versions.yml downloads 경로를 이전 버전 디렉토리로 재사용
                        (재사용할 버전이 없으면 `downloads: []`로 비움)
```

**모든 유형 공통 불변식**

이 네 가지는 릴리즈 유형과 무관하게 항상 지켜져야 합니다.

1. `_data/zdm/common/versions.yml`의 `docs:` 값이 문서 체계의 **단일 진실원**입니다. 아래 artifact는 모두 `docs:` 값과 1:1 매칭되어야 합니다.
   - `zdm/ko/{prod}/{X}/docs/` 하위 wrapper들 (intro 페이지 `index.md` 제외)
   - `_data/navigation.yml`의 `ko-{prod}-{X}` 섹션
   - `_includes/zdm/ko/{prod}/changelog/{X}.md` changelog include
   - → 이 artifact들은 **`docs == X`인 버전이 처음 생길 때에만 생성**합니다. `docs`를 재사용하는 버전(예: v1.2.1 → `docs: "1.2.0"`)은 새로 만들지 않습니다.
   - **예외 — intro 페이지(`zdm/ko/{prod}/{version}/index.md`)는 모든 버전이 개별 생성**: 사용자가 보는 헤더 텍스트가 `title: ZDM API Documentation v{version}` 형태로 그 페이지 안에 직접 박혀 있어, 재사용 패치가 latest인 경우 `docs:` 버전의 intro로 보내면 헤더가 기준 버전으로 표시됨. 따라서 intro만은 새 버전 디렉토리에 별도 wrapper로 만들고 `title:`만 새 버전으로 두며, `navigation:`·include의 `version=`·changelog include는 `docs:` 버전을 재사용. 자세한 절차는 3단계 (D) 참조.

   - 위 원칙의 결과로 latest 버전의 intro URL을 가리키는 모든 Liquid 링크는 `v.docs | default: v.version`이 아니라 `v.version`을 사용해야 합니다. 해당 경로는 다음 4곳:
     - `zdm/ko/index.md` — ZDM-CLI / ZDM-API 카드의 "문서 바로가기" 링크
     - `zdm/ko/downloads.md` — CLI / API 다운로드 표의 "v{X} 문서" 링크 (각 행)
     - `_layouts/docs.html` — 버전 선택기 dropdown

2. **wrapper의 `navigation:` vs `include:` 는 독립 관리**
   - `navigation:` 키는 wrapper가 속한 버전으로 고정 (예: `ko-cli-1.3.0`)
   - `include:` 경로는 "해당 페이지 내용이 마지막으로 유효했던 버전의 보존본"을 가리킴
     - 내용이 현 공용 파일과 같으면 → 최신 보존본 또는 공용 파일 참조
     - 내용이 이전 버전에서 멈췄으면 → `{% include .../{page}/{version}.md %}`
   - 한 wrapper에서 `navigation:` 버전과 `include:` 버전이 다를 수 있습니다. 이는 버그가 아니라 정상 패턴입니다.

3. **`versions.yml`에 등록한 downloads 경로의 파일은 실제로 존재해야 함**
   Jekyll은 이 경로를 검증하지 않아 빌드에는 성공하지만, 사이트 방문자는 404를 보게 됩니다. 7단계 직후의 로컬 정합성 검증(하단 참조)과 CI(`/.github/workflows/jekyll.yml`의 "Verify versions.yml downloads integrity" 스텝)에서 필수로 확인합니다.

4. **리다이렉트 URL은 `/zdm/{lang}/{product}/{version}/index` 형식** (언어 코드 필수)
   과거 일부 파일에 언어 코드가 빠진 잘못된 형식이 있었으나 오타입니다. 현재는 전부 수정됐습니다.

---

### 1단계. 버전 등록 — `_data/zdm/common/versions.yml`

- `cli:` (또는 `api:`) 목록 **최상단**에 신규 버전 추가
- 신규 버전 `status: latest`, 기존 latest → `status: stable`
- `docs:` — 문서 버전 지정
  - 문서 변경 있음 → 이번 버전 문자열 (예: `"1.3.0"`)
  - 문서 변경 없음(재사용 패치) → 재사용하는 이전 버전 문자열 (예: v1.2.1이 v1.2.0 문서 재사용 시 `"1.2.0"`)
- `downloads:` — OS별 바이너리 경로 지정
  - 새 바이너리 배포 → 이번 버전 디렉토리 (예: `/downloads/zdm-cli/1.3.0/...`)
  - 바이너리도 이전과 동일 → 이전 버전 디렉토리 경로 재사용 (예: `/downloads/zdm-cli/1.2.0/...`)
  - 바이너리 자체가 없음(지원 종료 / 미확보) → `downloads: []` (다운로드 페이지에 "준비 중"으로 표시됨)
  - **주의**: 여기 명시한 경로의 파일이 실제로 존재해야 합니다. 7단계 끝의 정합성 검증에서 확인합니다.
- `released:` — **(자동 추출, 보통 입력 불필요)** 다운로드 페이지의 **배포일** 컬럼은 `downloads[0].file`이 가리키는 바이너리의 **git 최종 커밋 시각**(= CI에서 `git restore-mtime`으로 복원한 mtime)으로 자동 채워집니다. 따라서 새 바이너리를 커밋·push하면 별도 입력 없이 그날 날짜가 표시됩니다.
  - `downloads: []` (바이너리 미제공) → 자동 추출 대상이 없으므로 **이 필드를 수동 입력**해야 표에 날짜가 표시됩니다. 입력하지 않으면 `-`로 출력됩니다.
  - 자동 추출 결과가 잘못 잡히는 케이스에서만 수동 입력으로 덮어쓸 수 있게 fallback으로 남겨두었지만, 일반적인 릴리즈에서는 사용하지 않습니다.
- `docs_updated:` — **(자동 추출, 보통 입력 불필요)** Jekyll Generator(`_plugins/doc_mtime_generator.rb`)가 빌드 시 해당 버전의 wrapper(`zdm/ko/{prod}/{docs}/**/*.md`)가 transitive로 include하는 파일 중 **`_includes/zdm/ko/{prod}/` 하위의 .md 파일만** 추적해, 그 파일들의 **git 최종 커밋 시각 중 최대값**을 자동으로 계산합니다. 결과는 `site.data.zdm.common.doc_mtimes[prod][version]`에 주입되어 다운로드 페이지·메인 랜딩페이지의 "문서 갱신일 / 문서 업데이트" 셀에 표시됩니다.
  - 추적 제외 대상: **공통 include**(`_includes/zdm/*.md` 등 cli/api 디렉토리 밖), **wrapper 자체**(라우팅 용도로만 파싱), **`_data/*.yml`**(마크다운이 아님).
  - 따라서 `_data/zdm/common/enums.yml` 같은 공통 enum이 바뀌어도 docs_updated는 자동 갱신되지 않습니다. 변경 사실을 표시하려면 해당 enum을 표시하는 `_includes/zdm/ko/{prod}/.../*.md`를 함께 손대거나 `versions.yml`의 `docs_updated`를 명시적으로 입력하세요.
  - 자동 추출이 잘못 잡힌다고 판단되는 경우에만 이 필드에 `YYYY-MM-DD`를 명시해 수동 fallback으로 덮어쓸 수 있습니다.
  - 재사용 패치(`docs:`를 이전 버전 값으로 둔 경우)도 자동 추출이 그대로 동작합니다 — wrapper 디렉토리가 같아도 패치 시점에 _includes 파일이 수정됐다면 그 시각이 잡힙니다.

> **동일 버전 재업로드 (hotfix 재빌드)** — 버전 번호를 올리지 않고 같은 버전의 바이너리만 다시 배포하는 경우:
> - `released:` → **수동 입력 불필요**. 새 바이너리를 커밋·push하면 CI의 git mtime 복원 단계가 새 커밋 시각을 mtime으로 반영하므로 다운로드 페이지의 배포일이 자동으로 갱신됩니다.
> - `docs_updated:` → **문서가 실제로 바뀐 경우에만 갱신**. 사용자 가이드에 변화가 없다면 그대로 두어 "문서는 그대로, 바이너리만 새로 빌드됨"을 정확히 보여줍니다.
> - 단, 시맨틱 버저닝 관점에서는 가능하면 패치 번호를 올리는 쪽(예: 2.0.0 → 2.0.1)을 우선 검토하세요. 동일 버전 재업로드는 사용자가 자신이 받은 바이너리의 정체를 식별하기 어렵게 만듭니다.

```yaml
cli:
  - version: "1.3.0"
    status: latest
    docs: "1.3.0"
    docs_updated: "2026-04-10"
    # released 미입력: 바이너리 git mtime이 배포일로 자동 사용됨
    downloads:
      - os: "Windows"
        file: "/downloads/zdm-cli/1.3.0/zdm-cli-windows.zip"
      - os: "Linux"
        file: "/downloads/zdm-cli/1.3.0/zdm-cli-linux.tar.gz"
  - version: "1.2.1"
    status: stable          # ← latest에서 변경
    docs: "1.2.0"           # 재사용 패치: 기준 버전 문자열
    released: "2026-04-09"  # downloads: [] fallback (바이너리 없으면 수동 입력)
    docs_updated: "2026-04-09"   # 재사용 패치는 패치일로 갱신
    downloads: []
    ...
```

이 파일이 자동 반영하는 곳: 다운로드 페이지(버전·상태·다운로드·**배포일**·문서·**문서 갱신일**), 메인 랜딩페이지, 버전 셀렉터 드롭다운

> **배포일 자동 추출 동작 원리** — CI(`.github/workflows/jekyll.yml`)의 "Restore mtimes from git history" 스텝이 `git-restore-mtime`을 실행해 `downloads/` 안의 모든 파일 mtime을 그 파일의 git 최종 커밋 시각으로 복원합니다. 이후 Jekyll 빌드 시 `site.static_files.modified_time`이 이 mtime을 읽어 배포일로 표시합니다.
> - 로컬에서 빌드해보고 싶다면 동일하게 `git restore-mtime`(또는 동등 스크립트)을 한 번 돌리고 `bundle exec jekyll build`를 실행하면 됩니다.
> - 로컬에서 mtime 복원을 하지 않으면 checkout 시각 기준 mtime으로 빌드되어 배포 결과와 다르게 보일 수 있습니다 — 실제 배포 결과는 CI 빌드만 신뢰하면 됩니다.

### 2단계. 사이드바 네비게이션 — `_data/navigation.yml`

> **재사용 패치 — 부분 생략**: 사이드바 섹션(A)은 `docs:`가 이전 버전과 동일하면 이미 있는 `ko-{prod}-{X}` 섹션을 그대로 쓰므로 새 섹션 추가 불필요(intro 페이지의 `navigation:` 키도 `docs:` 버전 그대로 재사용). 단 메인 링크(B)는 **재사용 패치가 latest일 때 신규 intro URL(`/zdm/ko/{prod}/{version}/index`)로 갱신해야 합니다** — 3단계 (D)에서 만든 새 intro 페이지로 사용자를 보내야 헤더 버전 표기가 어긋나지 않음. 재사용 패치가 latest가 아니면 메인 링크도 변경 불필요.

**(A) 버전별 네비게이션 섹션 추가** (표준·부분 갱신) — 이전 버전 블록 복사 후 버전 번호 치환:

```yaml
ko-cli-1.3.0:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/ko/cli/1.3.0/index"
  - title: "Backup"
    links:
      - title: "backup regist"
        url: "/zdm/ko/cli/1.3.0/docs/backup/regist"
  ...
```

신규 커맨드/엔드포인트가 추가됐으면 해당 항목도 네비게이션에 추가.

**(B) 메인 네비게이션 링크 갱신** — `ko-zdm:` 섹션의 문서 링크를 신규 버전으로 변경:

```yaml
ko-zdm:
  - title: "ZDM Services"
    links:
      - title: "ZDM-CLI 문서"
        url: "/zdm/ko/cli/1.3.0/index"    # ← 변경
```

### 3단계. 버전 디렉토리 및 문서 페이지 생성

> **재사용 패치 — 부분 생략 (intro 페이지만 신규 생성)**: `docs:`가 이전 버전과 동일하므로 개별 문서 wrapper(`docs/**/*.md`)는 신규로 만들지 않고 기존 `docs:` 버전 디렉토리를 그대로 재사용합니다. **단, `zdm/ko/{prod}/{version}/index.md`(intro 페이지)는 무조건 새 버전 디렉토리에 생성합니다.** intro 페이지의 `title:`(예: `ZDM API Documentation v2.0.1`)이 사용자가 보는 헤더 텍스트이기 때문에, 재사용 패치가 latest일 때 latest 링크가 기준 버전 헤더로 빠지면 버전 표기가 어긋납니다. intro만 분리하는 절차는 아래 (D) 참조.
>
> intro 페이지의 `navigation:`은 `docs:` 버전 키(예: `ko-api-2.0.0`)를 그대로 사용해 사이드바를 재사용합니다. include의 `version=` 인자도 `docs:` 값을 그대로 넘겨 feature 분기가 일관되게 동작하도록 합니다. 결과적으로 사용자는 intro에서만 v2.0.1 헤더를 보고, 사이드바·하위 문서 페이지는 v2.0.0 콘텐츠를 그대로 사용합니다.
>
> **단, 재사용 패치가 `status: latest` 인 경우는 예외** — 사이드바 docs 링크가 `docs:` 버전 URL(예: `/zdm/ko/cli/2.0.0/docs/...`) 로 빠져 사용자 입장에서 "최신 버전 문서에 들어왔는데 옛 URL 로 빠진다" 는 위화감을 줍니다. 이 경우 (D-2) 절차로 latest 전용 사이드바·wrapper 를 분리 생성합니다. stable patch (예: v2.0.1) 는 본 (D) 그대로 유지(latest 가 아니므로 진입 빈도 낮음).

**(A) 이전 버전 디렉토리 복사**:
```bash
cp -r zdm/ko/cli/1.2.0 zdm/ko/cli/1.3.0
```

**(B) `index.md` 수정** — `navigation:`, `title:`, changelog include 경로를 신규 버전으로 변경:
```yaml
---
layout: docs
title: ZDM CLI Documentation v1.3.0
navigation: ko-cli-1.3.0
lang: ko
---
{% capture changelog %}
{% include zdm/ko/cli/changelog/1.3.0.md %}
{% endcapture %}
{% include zdm/ko/cli/index.md version="1.3.0" changelog=changelog changelog_title="변경 사항" %}
```

**(C) 개별 문서 wrapper** — `navigation:` 값 일괄 치환:
```bash
# 모든 wrapper의 navigation 키를 새 버전으로 변경
find zdm/ko/cli/1.3.0 -name "*.md" -exec sed -i 's/ko-cli-1.2.0/ko-cli-1.3.0/g' {} +
```

> **wrapper navigation vs include 독립 원칙**
> - `navigation:` 값은 wrapper가 속한 버전으로 고정 (예: `ko-cli-1.3.0`)
> - `include:` 경로는 wrapper가 속한 버전이 아니라 **"페이지 내용이 마지막으로 유효했던 버전의 보존본"** 을 가리킵니다.
>   - 신규 버전 wrapper 대부분은 공용 파일 또는 최신 보존본을 include
>   - 이전 버전 wrapper는 5단계에서 일괄 갱신된 결과 `{page}/{보존_버전}.md`를 include
> - 즉 **한 wrapper에서 `navigation:` 버전과 `include:` 버전이 다를 수 있습니다.** 이는 정상입니다.

**(D) 재사용 패치 — intro 페이지만 분리 생성**:

재사용 패치 유형이면 (A)(B)(C)를 모두 생략하고 아래만 수행합니다.

```bash
mkdir -p zdm/ko/api/2.0.1
cat > zdm/ko/api/2.0.1/index.md <<'EOF'
---
layout: docs
title: ZDM API Documentation v2.0.1
section_title: ZDM API Documentation
navigation: ko-api-2.0.0
lang: ko
---

{% capture changelog %}
{% include zdm/ko/api/changelog/2.0.0.md %}
{% endcapture %}

{% include zdm/ko/api/index.md version="2.0.0" changelog=changelog changelog_title="변경 사항" %}
EOF
```

규칙:
- `title:` — 새 버전(`v2.0.1`)
- `navigation:` — `docs:` 버전 키(`ko-api-2.0.0`) 재사용 → 신규 navigation 섹션 추가 불필요
- changelog include / version 인자 — `docs:` 버전(`2.0.0`) 그대로
- 하위 `docs/` 디렉토리는 만들지 않음 — 사이드바의 모든 docs 링크가 `docs:` 버전(`2.0.0`)을 가리키므로 안전

**(D-2) latest 인 재사용 패치 — 사이드바·wrapper 분리 (선택 적용)**:

**적용 조건 표** — 어떤 케이스에 어디까지 적용하는지:

| 케이스 | (D) intro 신규 | (D-2) 사이드바·wrapper 분리 |
|---|:---:|:---:|
| 표준 메이저/마이너 (docs 본문 신규) | — (3단계 (A)(B)(C) 그대로) | — |
| 재사용 패치 + `status: stable` | 예 | — (base 사이드바 공유) |
| **재사용 패치 + `status: latest`** | 예 | **예** |

**자동화 명령** — `cli` v2.0.0 → v2.0.2 (latest 패치) 예시. 다른 product/버전은 경로의 `cli`·버전 숫자만 치환:

```bash
PROD=cli
BASE=2.0.0
NEW=2.0.2

# 1) navigation.yml — base 섹션을 통째 복제 + URL/키 일괄 치환 → base 섹션 끝 직후에 삽입
BASE_START=$(grep -n "^ko-${PROD}-${BASE}:" _data/navigation.yml | cut -d: -f1)
BASE_END=$(awk -v s="${BASE_START}" 'NR>s && /^[a-z]/ {print NR-1; exit}' _data/navigation.yml)
sed -n "${BASE_START},${BASE_END}p" _data/navigation.yml \
  | sed "s|ko-${PROD}-${BASE}|ko-${PROD}-${NEW}|g; s|/zdm/ko/${PROD}/${BASE}/|/zdm/ko/${PROD}/${NEW}/|g" \
  > /tmp/ko-${PROD}-${NEW}-section.yml
sed -i "${BASE_END}r /tmp/ko-${PROD}-${NEW}-section.yml" _data/navigation.yml

# 2) docs wrapper 64개 일괄 생성 + navigation 키 치환
cp -r zdm/ko/${PROD}/${BASE}/docs zdm/ko/${PROD}/${NEW}/
find zdm/ko/${PROD}/${NEW}/docs -name "*.md" \
  -exec sed -i "s|navigation: ko-${PROD}-${BASE}|navigation: ko-${PROD}-${NEW}|g" {} +

# 3) intro 의 navigation 키도 latest 로 변경 ((D) 에서 base 키를 썼던 것을 덮어씀)
sed -i "s|navigation: ko-${PROD}-${BASE}|navigation: ko-${PROD}-${NEW}|" \
  zdm/ko/${PROD}/${NEW}/index.md

# 4) 검증 — 잔존 base 참조가 0 이어야 함
grep -c "ko-${PROD}-${BASE}\|/${PROD}/${BASE}/" zdm/ko/${PROD}/${NEW}/docs/**/*.md zdm/ko/${PROD}/${NEW}/index.md
awk "/^ko-${PROD}-${NEW}:/,/^[a-z]/" _data/navigation.yml | grep -c "${PROD}/${BASE}"
```

**규칙**:
- 본문 콘텐츠는 0줄 중복 — wrapper 의 `{% include _includes/zdm/ko/{prod}/docs/... %}` 가 동일 파일을 가리킴
- 신규 wrapper 는 `navigation:` 만 latest 키로 다름. 그 외(특히 `include:` 경로)는 base 와 동일
- `include` 의 `version=` 인자도 base 그대로 (`version="2.0.0"`) — feature 분기 일관성 유지
- **stable patch (예: v2.0.1) 는 본 절차 미적용** — base 사이드바를 공유함. 적용하면 git diff·유지 비용만 증가

**8단계 Verification 추가 항목** (latest 재사용 패치만 해당):
- `_data/navigation.yml` 의 `ko-{prod}-{latest}` 섹션 안 URL 이 모두 `/{prod}/{latest}/` 로 통일되는지 확인 (위 명령의 4번)
- `zdm/ko/{prod}/{latest}/docs/**/*.md` 의 `navigation:` 값이 `ko-{prod}-{latest}` 인지 확인

### 4단계. Changelog include 생성

> **재사용 패치 — 선택적**: `docs:` 재사용이면 changelog include는 기본적으로 공유합니다. 단 **패치 자체에 사용자에게 안내할 변경(behavior/bug fix/신규 에러코드 등)이나 내부 리팩터링이 있는 경우 `_includes/zdm/ko/{prod}/changelog/{version}.md`를 별도 생성**할 수 있습니다.
>
> 생성 시 다음을 함께 갱신합니다:
> 1. 3단계 (D)에서 만든 신규 intro 페이지(`zdm/ko/{prod}/{version}/index.md`)의 `{% include zdm/ko/{prod}/changelog/...md %}` 경로를 신규 `{version}.md`로 교체 (재사용하는 `docs:` 버전 changelog는 더 이상 표시하지 않음 — 사용자는 이미 그 버전 시점에 changelog를 봤다고 가정)
> 2. 메인 랜딩페이지 `zdm/ko/index.md`의 기준 버전 details 블록에 신규 `{version}.md` include를 **추가**(기준 버전 changelog 다음 줄). v1.3.0 + patch v1.3.1 패턴(부분 갱신 릴리즈)과 동일한 모양이지만, 재사용 패치는 별도 details 블록은 만들지 않고 기준 버전 details 안에 두 changelog를 함께 보여줍니다.
> 3. 9단계의 `CHANGELOG.md` 항목과 별도로 관리합니다 — 9단계는 gitpage repo의 release-level 변경 기록, 4단계는 사용자 노출용 인-페이지 changelog.
>
> 생성하지 않는 경우(코드 측 변경이 단순 hotfix 빌드 재기록 수준이거나 사용자 노출 가치가 적은 경우)는 기존 규칙대로 `CHANGELOG.md`(9단계)에만 기록합니다.

`_includes/zdm/ko/cli/changelog/1.3.0.md`:

```markdown
<details markdown="1">
<summary><strong>v1.3.0</strong> — 한줄 요약</summary>

변경 사항 상세 내용...

</details>
```

**작성 가이드 — 내부 식별자 / 스키마 비노출**

changelog include는 사이트 방문자에게 공개되므로 **사용자 노출 정보만 기록**합니다. 다음은 포함하지 않습니다:

- 내부 함수·메서드·헬퍼 이름 (예: `applyBaseConditions`, `normalizeWindowsPartition`, `processJobList`, `withServiceContext`, `validateJobScheduleCompatibility`, `insertLicenseHistory`)
- 소스 파일 경로 (`src/domain/.../*.ts`)
- 내부 DB 컬럼명 / 테이블명 / 인덱스 (`sLetter`, `nPartFree`, `sSystemName`, `nCenterID`, `license_history` 등)
- 내부 클래스·서비스·DTO 이름 (`recovery-monitoring-get.service`, `BackupDBFilterManager`, `ScheduleTypeGuards` 등)
- 내부 구현 흐름·라인 변화·쿼리 수 변화·zod regex·shell exec 인자 형식 등 구현 세부

다음은 포함해도 좋습니다:

- 엔드포인트 경로(`POST /recoveries`)와 HTTP 메서드
- 공개 요청·응답 필드명(`sourceRepository`, `copies.usage`, `daysRemaining` 등 — 사용자가 직접 보내거나 받는 JSON 키)
- HTTP 상태 코드(`403 CENTER_MISMATCH`, `409 ALREADY_ASSIGNED`)
- 공개 에러 코드(`JOB-ERROR-22`, `SCHEDULE-ERROR-51` 등 — 클라이언트로 그대로 전달되도록 설계된 식별자)
- 사용자가 보내거나 받는 예시 페이로드·쿼리 파라미터(`?center=destconm,destconm2`)
- 동작 변화의 사용자 관찰 가능 결과(예: `jobName`이 `WIN-SRV01C` → `WIN-SRV01_C`)
- Breaking Change 여부를 명시적으로 표시

내부 리팩터링이 응답에 영향을 주지 않는 경우엔 `"운영 개선 — ... 내부 구조 단순화. 외부 응답 시그니처·구조 변경 없음 (클라이언트 영향 없음)"` 한 줄 정도로 요약하고 끝냅니다.

### 5단계. 문서 컨텐츠 수정 (변경된 경우만)

- 내용 변경 없음 → 기존 include 파일 재사용 (작업 불필요)
- 내용 변경 있음 → 아래 **버전별 문서 분리** 절차 적용

#### 버전별 문서 분리 절차

신규 버전에서 기능이 변경되어 문서 내용이 달라지는 경우, **공용 파일을 최신으로 유지**하고 이전 버전용 파일을 별도 보존합니다. 신규 버전 이후의 문서에서는 변경 내용이 기본으로 적용됩니다.

> 예시: v1.3.1에서 `schedule/create.md` 내용이 변경되는 경우

**(A) 기존 파일을 이전 버전용으로 복사:**
```bash
mkdir -p _includes/zdm/ko/cli/docs/schedule/create/
cp _includes/zdm/ko/cli/docs/schedule/create.md \
   _includes/zdm/ko/cli/docs/schedule/create/1.3.0.md
```

디렉토리 규칙: `{page}/{마지막으로_해당_내용이_유효한_버전}.md` — 커맨드명 디렉토리 아래에 버전별 파일 보관

**(B) 공용 파일을 신규 버전 내용으로 수정:**
```bash
# _includes/zdm/ko/cli/docs/schedule/create.md 를 1.3.1 내용으로 수정
# 신규 버전(1.3.1) wrapper는 변경 불필요 (이미 공용 파일을 include)
```

**(C) 이전 버전 wrapper에서 보존 파일을 include하도록 변경:**
```bash
# 변경 대상 wrapper 사전 확인
grep -rl "{% include zdm/ko/cli/docs/schedule/create.md %}" zdm/ko/cli/

# 1.3.0 이하 모든 버전의 wrapper 일괄 변경
for ver in 1.0.3 1.0.4 1.2.0 1.3.0; do
  sed -i 's|{% include zdm/ko/cli/docs/schedule/create.md %}|{% include zdm/ko/cli/docs/schedule/create/1.3.0.md %}|' \
    zdm/ko/cli/$ver/docs/schedule/create.md
done
```

**결과 구조:**
```
_includes/zdm/ko/cli/docs/schedule/
  ├── create.md          ← 최신 (v1.3.1+, 공용)
  └── create/
      └── 1.3.0.md       ← 이전 버전용 (v1.3.0 이하)

zdm/ko/cli/1.3.1/docs/schedule/create.md  → {% include .../create.md %}
zdm/ko/cli/1.3.0/docs/schedule/create.md  → {% include .../create/1.3.0.md %}
```

**주의사항:**
- 신규 버전 wrapper는 공용 파일을 그대로 참조하므로 수정 불필요
- 향후 또 변경 시 같은 절차 반복: 현재 공용 → `{page}/{version}.md`로 복사, 공용 갱신, 해당 버전 이하 wrapper 변경
- 변경되지 않은 문서는 그대로 공용 파일을 공유 (불필요한 분리 금지)
- **이전 버전 wrapper 일괄 갱신 대상은 `grep -rl`로 확인한 모든 wrapper입니다.** 여러 버전 디렉토리가 동일 공용 파일을 참조하던 경우, 보존본 분리 시 그 모든 wrapper를 수정해야 합니다. 누락하면 이전 버전 페이지가 새 공용(= 신규 버전 내용)을 보여주게 됩니다.
- `legacy/` 디렉토리는 이전 문서 분리 방식으로, 현재는 `{page}/{version}.md` 방식으로 대체됨. 기존 legacy 파일은 버전별 파일로 마이그레이션 후 삭제

### 6단계. 리다이렉트 페이지 — 자동 (별도 갱신 불필요)

> **`zdm/ko/cli/index.md` / `zdm/ko/api/index.md` 는 더 이상 손대지 않습니다.** `_data/zdm/common/versions.yml` 의 `status: latest` 항목을 Liquid 변수(`latest`)로 자동 참조하므로 versions.yml 갱신 한 곳으로 4곳(`window.location.href` / `<meta refresh>` / 하단 링크 + 과거 frontmatter `redirect_to:`)이 모두 자동 반영됩니다.

`_data/navigation.yml` 의 `ko-zdm` 메인 링크(ZDM-API 문서 / ZDM-CLI 문서)는 별도 검토 — 정적 URL 이면 latest intro 경로로 수동 갱신 필요.

**리다이렉트 URL 형식: `/zdm/{lang}/{product}/{version}/index` (언어 코드 필수)**
과거 일부 파일에 언어 코드가 빠진 `/zdm/{product}/{version}/index` 형식이 있었으나 오타입니다.

현재 라우터 파일(참고용 — 갱신 불필요):

```yaml
---
layout: docs
title: ZDM CLI Documentation
section_title: ZDM CLI Documentation
navigation: ko-cli
lang: ko
---
{%- assign latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first -%}
{%- assign latest_url = '/zdm/ko/cli/' | append: latest.version | append: '/index' -%}

<script>
  window.location.href = "{{ latest_url | relative_url }}";
</script>

<noscript>
  <meta http-equiv="refresh" content="0; url={{ latest_url | relative_url }}">
</noscript>

이 페이지는 [최신 CLI 문서]({{ latest_url }})로 리다이렉트됩니다.
```

> **주의 — `jekyll-redirect-from` 플러그인 미사용**: 그래서 frontmatter `redirect_to:` 는 사용하지 않습니다 (Jekyll 이 무시함). 실제 리다이렉트는 body 의 `<script>` + `<noscript><meta refresh>` 가 담당합니다. 추후 플러그인을 도입하면 `redirect_to: {{ latest_url }}` 를 frontmatter 에 추가하되 frontmatter 는 Liquid 미평가이므로 사이트 빌드 시점 자동 분기는 별도 처리(예: Generator) 필요.

### 7단계. 바이너리 배치

```bash
mkdir -p downloads/zdm-cli/1.3.0/
# 바이너리 파일을 해당 디렉토리에 배치
# 파일명은 versions.yml의 downloads[].file과 일치해야 함
```

> **재사용 패치에서의 처리**
> - 새 바이너리가 있으면 표준과 동일하게 배치
> - 바이너리도 이전과 공유 → 이 단계 생략 (1단계에서 `downloads:` 경로를 이전 버전 디렉토리로 지정한 것이 대신함)
> - 바이너리 없음(지원 종료/미확보) → `versions.yml`의 `downloads: []`로 비움

**검증 — `versions.yml`과 실제 파일 정합성 (모든 유형 필수)**

`versions.yml`에 등록한 `downloads[].file` 경로가 실제 파일과 일치하는지 확인합니다. 동일한 검증이 CI의 "Verify versions.yml downloads integrity" 스텝에서 자동 실행되지만, 커밋 전 로컬에서도 돌려보는 것을 권장합니다.

```bash
ruby -ryaml -e '
  data = YAML.load_file("_data/zdm/common/versions.yml")
  missing = []
  %w[api cli].each do |prod|
    (data[prod] || []).each do |v|
      (v["downloads"] || []).each do |d|
        path = "." + d["file"]
        missing << "  #{prod} v#{v["version"]} -> #{d["file"]}" unless File.exist?(path)
      end
    end
  end
  if missing.empty?
    puts "OK: all downloads paths exist"
  else
    puts "MISSING downloads referenced in versions.yml:"
    puts missing
    exit 1
  end
'
```

출력이 `MISSING:`으로 시작하면 커밋 전에 원인을 해결해야 합니다. 원인별 대응:
- 바이너리를 배치하지 않았음 → 파일 업로드 후 재검증
- `downloads:` 경로를 이전 버전 공유로 의도했는데 실제 파일이 없음 → 공유 대상 버전에 바이너리를 먼저 올리거나, `downloads: []`로 비움
- 바이너리를 제공하지 않기로 한 버전 → `downloads: []`로 비움

### 8단계. 메인 랜딩페이지 업데이트 목록 추가 — `zdm/ko/index.md`

**표준·부분 갱신 릴리즈** — `## 업데이트 목록` > `### ZDM-CLI` (또는 `### ZDM-API`) 섹션 **최상단**에 신규 버전 항목 추가:

```markdown
<details markdown="1">
<summary><strong>v1.3.0</strong> <span class="update-date">(2026-04-10)</span></summary>

[v1.3.0 문서 바로가기](/zdm/ko/cli/1.3.0/index)

{% include zdm/ko/cli/changelog/1.3.0.md %}

</details>
```

**재사용 패치** — 독립 details 블록을 만들지 않고, **기준 버전의 summary에 `patch` 배지를 병기**합니다. (예: v1.2.1이 v1.2.0 문서를 재사용하는 경우)

```markdown
<details markdown="1">
<summary><strong>v1.2.0</strong> <span class="update-date">(2026-04-09)</span> · <span class="badge badge-patch">patch v1.2.1</span> <span class="update-date">(2026-04-09)</span></summary>

[v1.2.0 문서 바로가기](/zdm/ko/cli/1.2.0/index)

{% include zdm/ko/cli/changelog/1.2.0.md %}

</details>
```

- 문서 링크는 기준 버전(v1.2.0)을 가리킵니다
- changelog include도 기준 버전 것을 그대로 사용합니다
- 패치의 실제 변경 내용은 `CHANGELOG.md`(9단계)에 기록합니다

### 9단계. Changelog 기록

`CHANGELOG.md` (gitpage 최상위)에 Documentation 변경 기록 추가.

**기록 대상:**
- API/CLI 신규 버전 문서 추가
- 기존 문서 내용 수정 (파라미터 변경, 필드 추가 등)
- versions.yml, navigation.yml 변경
- 리다이렉트 URL 변경

**기록 형식:**

```markdown
## [Documentation] - 2026-04-10

### Changed
- **CLI v1.3.0 변경 내용 반영** — 변경 요약
```

### 10단계. (선택) Enum / 공통 데이터 변경

#### (A) 신규 enum 값 추가
- `_data/zdm/common/enums.yml` 수정 또는
- `_data/zdm/cli/v1_3_0/enums.yml` 생성 (디렉토리명에 점 대신 언더스코어 사용)

#### (B) 공통 데이터 변경 시 문서 갱신일 반영 규칙

`_data/zdm/common/enums.yml`이나 `_includes/zdm/*.md` 같은 **cli/api 디렉토리 밖**의 공통 자료를 변경하면 출력값은 모든 버전에 즉시 반영되지만, `_plugins/doc_mtime_generator.rb`의 추적 대상 밖이라 **`docs_updated`가 자동 갱신되지 않습니다.** 변경 사실을 다운로드/랜딩 페이지의 "문서 갱신일"에 노출하려면 아래 둘 중 하나를 반드시 수행하세요.

**옵션 1 — 함께 touch 커밋 (권장)**
변경된 enum/공통 include가 사용되는 각 제품 도메인의 `_includes/zdm/ko/{prod}/docs/...` 파일 중 하나 이상을 같은 커밋에 포함시킵니다. 의미상 그 도메인이 새 enum 값을 반영했음을 표시하는 작은 수정(주석 갱신, 행 정렬 등)도 좋고, 변경이 실제로 텍스트에 영향을 주는 파일을 손대는 게 가장 자연스럽습니다.

```bash
# 예: replication 관련 enum 값을 변경한 경우
git add _data/zdm/common/enums.yml \
        _includes/zdm/ko/api/docs/replication/regist.md \
        _includes/zdm/ko/cli/docs/replication/regist.md
git commit -m "..."
```

영향 받는 모든 제품(API/CLI)에 대해 도메인 파일을 1개 이상씩 포함해야 그 제품들의 `docs_updated`가 갱신됩니다.

**옵션 2 — `versions.yml`의 `docs_updated` 수동 입력**
일괄 touch가 부담스럽거나 enum 변경 영향이 모든 버전에 균일하다면 해당 제품의 모든 버전 항목에 `docs_updated: "YYYY-MM-DD"`를 명시합니다. 단, Generator의 자동값이 우선이므로 자동값을 비울 만큼 강제하고 싶다면 `versions.yml`을 직접 수정 후 해당 _includes 파일들을 touch하지 않는 식의 운영이 필요합니다. **옵션 1이 더 깔끔하고 추천됩니다.**

> **왜 자동화하지 않는가**: `_data/*.yml` 변경을 무조건 추적하면 한 enum 값 수정으로 CLI/API 모든 버전이 동시에 갱신되어 노이즈가 큽니다. 어떤 도메인에 enum이 사용되는지 자동 매핑은 정확도가 낮습니다. 명시적인 touch 커밋이 의도를 가장 정확히 표현합니다.

### 체크리스트 (릴리즈 유형별)

범례: **O** 필수 / **−** 건너뜀 / **◇** 조건부(아래 각주 참조)

| # | 파일/디렉토리 | 작업 | 표준 | 부분갱신 | 재사용패치 |
|---|--------------|------|------|----------|------------|
| 1 | `_data/zdm/common/versions.yml` | 버전 추가, 기존 latest→stable. `released`·`docs_updated`는 보통 입력 불필요 (각각 바이너리 git mtime / wrapper+include git mtime으로 자동 추출). `downloads: []`일 때만 `released` 수동 입력, 자동 추출이 잘못된 경우에만 `docs_updated`로 덮어쓰기. 그 외 `docs:`·`downloads:` 분기는 1단계 본문 참조 | O | O | O |
| 2 | `_data/navigation.yml` | `ko-{prod}-{X}` 섹션 추가 + `ko-zdm` 메인 링크 갱신 | O | O | ◇³ |
| 3 | `zdm/ko/{product}/{version}/` | 버전 디렉토리 + 문서 wrapper 생성 | O | O | intro만 (3단계 (D)) |
| 4 | `_includes/.../changelog/{version}.md` | Changelog include 생성 | O | O | ◇⁴ |
| 5 | `_includes/.../docs/**` | 컨텐츠 수정 + 이전 버전 보존본 분리 | 대량 | 변경분만 | − |
| 6 | `zdm/ko/{product}/index.md` | 리다이렉트 URL 갱신 | O | O | O |
| 7 | `downloads/{product}/{version}/` | 바이너리 배치 | O | O | ◇¹ |
| 7+ | 정합성 검증 (ruby 스크립트) | `versions.yml` ↔ 실제 파일 | O | O | O |
| 8 | `zdm/ko/index.md` | 업데이트 목록 항목 | 독립 details | 독립 details | patch 배지 병기 |
| 9 | `CHANGELOG.md` | Documentation 변경 기록 | O | O | O |
| 10 | `_data/zdm/.../enums.yml` 또는 공통 `_includes/zdm/*.md` | Enum/공통 자료 변경 시 영향 도메인의 `_includes/zdm/ko/{prod}/docs/...` 파일 함께 touch (또는 `docs_updated` 수동 입력) — 10단계 (B) 참조 | ◇² | ◇² | ◇² |

¹ 재사용 패치의 바이너리 배치: 새 바이너리가 있을 때만 수행. 바이너리 재사용이면 1단계에서 downloads 경로를 이전 디렉토리로 지정한 것이 대신함. 바이너리 없음이면 `downloads: []`로 비움.
³ 재사용 패치의 navigation.yml: `ko-{prod}-{X}` 신규 섹션은 만들지 않습니다(intro 페이지의 `navigation:`은 `docs:` 버전 키 재사용). 단 `ko-zdm` 메인 링크 중 latest 제품의 문서 URL은 신규 intro(`/zdm/ko/{prod}/{version}/index`)로 갱신합니다. 재사용 패치가 latest가 아니면 메인 링크도 변경 불필요.
⁴ 재사용 패치의 changelog include: 패치 자체에 사용자 노출 변경(behavior/bug fix/신규 에러코드)이나 내부 리팩터링이 있어서 in-page에 표시할 가치가 있다면 `{version}.md`를 생성. 생성 시 intro 페이지의 changelog include 경로를 신규 파일로 교체하고 랜딩페이지 기준 버전 details에 추가 include로 병기. 생성하지 않으면 9단계의 `CHANGELOG.md`에만 기록.
² Enum/공통 자료 변경: 신규 enum 값 추가나 공통 include 텍스트 변경이 있을 때만 수행. 변경했다면 영향 도메인(`_includes/zdm/ko/{prod}/docs/...`) 1개 이상을 같은 커밋에 포함해야 `docs_updated`에 반영됨.

**실제 사례 대조** (신규 릴리즈 유형 판정 연습용)

| 릴리즈 | 유형 | 근거 |
|--------|------|------|
| CLI v1.2.1 | 재사용 패치 | `docs: "1.2.0"` 재사용, 문서 변경 없음, 바이너리 미제공(`downloads: []`) |
| CLI v1.3.1 | 부분 갱신 | 바이너리 신규 + 일부 문서만 변경(`schedule delete` 신규 커맨드 + 일부 파일 수정) |
| API v1.3.1 | 부분 갱신 | 바이너리 신규 + 일부 엔드포인트만 변경(`/backups/histories` 등 추가) |
| CLI/API v2.0.0 | 표준 (메이저) | 전체 재작성, breaking change |


