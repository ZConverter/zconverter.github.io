# Changelog

모든 주요 변경 사항이 이 파일에 기록됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 합니다.

---

## [Documentation] - 2026-05-18

### Changed
- **API changelog include 단순화 — 내부 식별자·스키마 비노출** — `_includes/zdm/ko/api/changelog/{1.3.1, 2.0.0, 2.0.1}.md` 일괄 트리밍. 내부 함수·메서드·헬퍼명(`applyBaseConditions` / `normalizeWindowsPartition` / `processJobList` / `withServiceContext` / `validateJobScheduleCompatibility` / `insertLicenseHistory` 등), 소스 파일 경로(`src/domain/.../*.ts`), DB 컬럼명·테이블명(`sLetter` / `nPartFree` / `sSystemName` / `nCenterID` / `license_history` 등), 내부 클래스·서비스명, 구현 흐름·라인 변화·쿼리 수 변화·zod regex 등을 모두 제거. 엔드포인트 경로·공개 요청/응답 필드명·HTTP 상태 코드·공개 에러 코드·사용자 관찰 가능 동작 변화는 유지. 내부 리팩터링은 "외부 응답 변경 없음(클라이언트 영향 없음)" 한 줄로 축약. 동작 로직 / 스키마 유출 위험 차단 목적. v1.0.3·1.1.0·1.2.0·1.3.0은 이미 간결하여 변경 없음.
- **CLAUDE.md 4단계 작성 가이드 보강** — changelog include 작성 시 내부 식별자/스키마 비노출 규칙 명시. 포함 가능 정보(엔드포인트, 공개 필드명, HTTP 코드, 공개 에러 코드, 예시 페이로드, breaking change 표시) vs 제외 대상(함수명, 파일 경로, DB 컬럼, 내부 클래스, 구현 세부) 항목별 명시 + 내부 리팩터링은 한 줄 요약 권장 규칙 추가.
- **재사용 패치 규칙 갱신 — intro 페이지(`index.md`)는 모든 버전이 개별 생성** (`CLAUDE.md` 3단계 (D) 신설). 기존 규칙은 `docs:` 재사용 시 `zdm/ko/{prod}/{version}/` 디렉토리 자체를 만들지 않았으나, 이 경우 latest 재사용 패치의 문서 링크가 `docs:` 버전의 intro로 빠져 헤더가 기준 버전(예: `ZDM API Documentation v2.0.0`)으로 표시되는 문제 발생. 변경 후엔 `zdm/ko/{prod}/{version}/index.md`만 새 버전 디렉토리에 만들고(`title:`만 새 버전, `navigation:`·include `version=`·changelog는 `docs:` 버전 재사용) 하위 docs wrapper는 만들지 않음. 영향 파일:
  - `CLAUDE.md` 3단계 (D)·6단계 본문 / 2단계 본문 / 모든 유형 공통 불변식 #1 / 체크리스트 표(행 2·3·6 + 각주 ³) 일괄 갱신
  - `zdm/ko/index.md`·`zdm/ko/downloads.md`·`_layouts/docs.html` Liquid: intro 링크가 `v.docs | default: v.version` → `v.version`으로 변경되어 latest 재사용 패치도 자신의 intro로 정확히 라우팅. 4곳 모두 갱신.
  - `_data/navigation.yml`의 `ko-zdm` 메인 ZDM-API 문서 링크 `/zdm/ko/api/2.0.0/index` → `/zdm/ko/api/2.0.1/index`
  - `zdm/ko/api/index.md` 리다이렉트 URL `/zdm/ko/api/2.0.0/index` → `/zdm/ko/api/2.0.1/index`
- **CLI v1.2.1 intro 페이지 백필** — 신규 규칙 일관성을 위해 `zdm/ko/cli/1.2.1/index.md`를 생성(기존엔 디렉토리 자체가 없었음). `title: ZDM CLI Documentation v1.2.1` / `navigation: ko-cli-1.2.0` / changelog include는 v1.2.0 그대로.
- **재사용 패치 changelog include 규칙 추가** (`CLAUDE.md` 4단계) — 재사용 패치라도 사용자 노출 변경(behavior/bug fix/신규 에러코드)이나 내부 리팩터링이 있는 경우 `_includes/zdm/ko/{prod}/changelog/{version}.md`를 선택적으로 생성하도록 명문화. 생성 시 intro의 changelog include를 신규 파일로 교체하고 랜딩페이지 기준 버전 details에 추가 include로 병기. 체크리스트 행 4 (재사용 패치 컬럼: `−` → `◇⁴`) + 각주 ⁴ 신설.
- **ZDM-API v2.0.1 changelog include 신규 생성** — `_includes/zdm/ko/api/changelog/2.0.1.md`. `/project/zdm-api-v2/CHANGELOG.md`의 `[2.0.0]` 섹션 중 gitpage 2.0.0.md에 없던 2026-05-15 신규 항목(monitoring 서비스 공통 패턴 추출 / server-partition swap 누락 / Recovery Windows 파티션 정규화 / Job-name OS 일관성 / `JOB-ERROR-22` 신규)을 v2.0.1 changelog로 발췌. `zdm/ko/api/2.0.1/index.md` 인트로의 changelog include는 `2.0.0.md` → `2.0.1.md`로 교체(인트로 페이지에서는 v2.0.1 신규 변경분만 표시 — v2.0.0 changelog 본문은 v2.0.0 인트로로 가서 확인). 랜딩페이지 `zdm/ko/index.md`의 기준 버전(v2.0.0 + patch v2.0.1) details에는 `2.0.0.md` 다음 줄에 `2.0.1.md`도 함께 include하여 두 changelog가 같은 details에 노출됨(v1.3.0 + v1.3.1 부분 갱신 패턴과 동일한 표시 모양).

### Added
- **ZDM-API v2.0.1 추가 (재사용 패치)** — v2.0.0 대비 사용자 가이드(엔드포인트·요청/응답 스키마) 변경 없음. `_data/zdm/common/versions.yml`의 `api:` 최상단에 v2.0.1(latest, `docs: "2.0.0"`) 추가하고 기존 v2.0.0은 stable로 강등. **신규 intro 페이지 `zdm/ko/api/2.0.1/index.md` 생성** (위 Changed 항목의 신규 규칙 적용). 신규 바이너리 `/downloads/zdm-api/2.0.1/zdm-api-linux.tar.gz` 배치. `_data/navigation.yml`·`zdm/ko/api/2.0.1/`·`_includes/zdm/ko/api/changelog/2.0.1.md`·리다이렉트 페이지는 `docs:` 재사용 규칙대로 신규 생성하지 않음. 메인 랜딩페이지 `zdm/ko/index.md`의 ZDM-API 헤더는 `latest v2.0.1 (2026-05-18)`로 갱신하고 v2.0.0 details summary에 `patch v2.0.1 (2026-05-18)` 배지를 병기(CLI v1.2.0/v1.2.1 패턴과 동일, 별도 details 블록은 만들지 않음). 자잘한 내부 버그 수정 모음:
  - **서버 파티션 조회 시 size 0 파티션(swap/cdrom 등) 일괄 배제** — `server-partition.repository.ts`에 `applyBaseConditions` 신설 후 read 경로 4곳(`findAll`/`countAll`/`findBySystemNames`/`findByServerName`)에 일괄 적용. 기존엔 `applyFilters` 미경유 경로에서 swap이 결과에 포함되던 문제 해소
  - **Recovery Windows 파티션 입력 정규화** — `recovery-validation.service.ts`에 `normalizeWindowsPartition` 신설. `C` / `c` / `C:` / `c:` 모두 매치, DB sLetter 대소문자 혼재에도 안전. `recovery-job-list-normalizer.service.ts`의 `processJobList` `exist` 매칭도 동일 정규화 적용해 user input이 silent하게 무시되던 케이스 차단
  - **작업 이름 생성기 Windows/Linux 형식 비대칭 해소** — `job-name.utils.ts`에서 Windows도 `C:` → `_C`로 prefix 통일(Linux `/var/log` → `_var_log`와 대칭). 입력 누락 시 에러도 `throw new Error` → `createCustomError(Job.Common.MISSING_REQUIRED_PARAMETER)`로 교체하여 외곽 catch에서 `NO_PARTITIONS_TO_PROCESS`로 부정확하게 래핑되던 문제 정정. `error-code.ts`에 신규 `JOB-ERROR-22`(400) 추가
  - **Backup/Recovery monitoring 서비스 공통 패턴 추출 + step 2 단순화** — `validateSettledResults`/`unwrapSettled`/`fetchLatestLogMessages`/`computeCalculatedStatus`/`assertStatusMatches`/`withServiceContext` 6개 private helper로 보일러플레이트 통합. ByJob 흐름에서 step 1의 `identifierCheck`를 재활용해 step 2의 `type==="name"|"id"` 분기와 recovery/backup 재조회 생략(쿼리 4→3 / 3→2). 외부 응답 시그니처/구조 동일성 유지
  - **모니터링 percent 원인파악용 DEBUG 로그 정리** — `recovery-monitoring-get.service.ts` ByJob/ByServer에 `recoveryActive raw result` 로그 추가. DTO 진입 시점 active 값 + partition별 computed percent 로그 추가(원인 확정 후 제거 예정인 임시 로그)
- 세부 출처: `/project/zdm-api-v2/CHANGELOG.md`의 2026-05-15 entries 및 `git log` (`6b0f5e2 서버 파티션 - 스왑 파티션 제거`, `3570919 백업 모니터링 수정`, `0770442 리커버리 모니터링 수정`, `b909aa7 recovery regist 진행시 jobList에서 source/targetPartition에서 윈도우 정규화`, `844004d 작업이름 관련 신규 에러코드 추가 및 윈도우 작업이름 양식 수정`, `0328753 서버 파티션 조회시 swap 같은 사이즈 0으로 책정되는 파티션들 배제`).
- **다운로드 페이지에 배포일·문서 갱신일 컬럼 추가** — 사용자가 각 버전의 바이너리 배포 시점과 문서 마지막 갱신 시점을 한눈에 확인할 수 있도록 `_data/zdm/common/versions.yml`에 `released`·`docs_updated` 필드를 추가하고 `zdm/ko/downloads.md` 테이블 컬럼 2개 확장. 재사용 패치(`docs:` 재사용)는 `docs_updated`를 패치일로 기록하는 규칙을 `CLAUDE.md` 1단계 및 체크리스트에 명시.
- **동일 버전 재업로드(hotfix 재빌드) 처리 규칙** — `CLAUDE.md` 1단계에 명문화. `released`는 새 업로드일로 갱신하되 `docs_updated`는 문서가 실제로 바뀐 경우에만 갱신. 시맨틱 버저닝 관점에서는 가능한 경우 패치 번호 부여를 우선 검토.

### Fixed
- **v2.0.0 `docs_updated` 실제 마지막 문서 변경일 기준으로 정정** — 신규 도입한 필드 초기값이 최초 등록일(4/17)로 일괄 입력되어 있던 것을 CHANGELOG 추적 결과 기준으로 수정.
  - API v2.0.0: `2026-04-17` → `2026-05-15` (12개 도메인 94건 patch 동기화일)
  - CLI v2.0.0: `2026-04-17` → `2026-04-22` (`backup/update.md` 스케줄 정책 표 추가일)
  - `released`는 양쪽 모두 `2026-04-17` 유지 (바이너리 재배포 기록 없음).
- **메인 랜딩페이지 ZDM-CLI/ZDM-API 카드의 "업데이트" 표시 출처 변경 + 프로그램/문서 일자 분리** — `zdm/ko/index.md`의 두 카드가 `{{ site.time }}`(사이트 빌드 시각)을 보여주던 것을 제거. 대신 "프로그램 업데이트"(latest 버전의 `released`)와 "문서 업데이트"(latest 버전의 `docs_updated`) 두 행으로 분리해 의미를 구분. 사이트 어디든 push되면 빌드 시각이 갱신되어 "버전 자체가 갱신된 날"을 호도할 수 있었던 문제를 해소. 값이 비어 있으면 각자 `-` 표시.

### Changed
- **배포일·문서 갱신일 모두 git history 자동 추출로 전환** — 수동 `released`·`docs_updated` 입력을 fallback으로 격하하고 두 값 모두 git mtime 기반으로 자동 계산되도록 변경. 진실원이 git history로 통일됨.
  - **배포일** — OS별로 분리해 각 `downloads[].file` 바이너리의 git mtime을 그대로 표시(Windows / Linux 각각 별도 행). 기존 단일 컬럼/행 표시를 OS 단위로 분리.
  - **문서 갱신일** — 신규 Jekyll Generator 플러그인 `_plugins/doc_mtime_generator.rb`가 wrapper(`zdm/ko/{prod}/{docs}/**/*.md`)의 transitive include 중 **`_includes/zdm/ko/{prod}/` 하위의 .md 파일만** 추적해 git mtime 최대값을 계산. wrapper 자체와 공통 include(`_includes/zdm/*.md`)·`_data/*.yml`은 추적 제외. 결과를 `site.data.zdm.common.doc_mtimes[prod][version]`에 주입.
  - **공통 자료 변경 시 운영 규칙 명문화** — `CLAUDE.md` 10단계 (B) 신설. enum/공통 include를 변경하면 `docs_updated` 자동 추적 밖이므로, 영향 받는 각 제품 도메인의 `_includes/zdm/ko/{prod}/docs/...` 파일 중 하나 이상을 같은 커밋에 포함해 touch하는 규칙을 명시. 체크리스트 10단계도 보강.
  - 부수 효과: CLI v2.0.0의 `docs_updated`가 수동값 `2026-04-22`보다 정확한 자동값 `2026-04-23`으로 잡힘 — Generator가 transitive include까지 추적하면서 놓치고 있던 변경 시점을 잡아낸 결과.
  - 보조 변경: tar.gz 우선 매칭 → OS별 분리 매칭으로 Liquid 로직 단순화.
  - `.github/workflows/jekyll.yml`에 `git-restore-mtime` 설치·실행 스텝 추가. `actions/checkout@v4` `fetch-depth: 0`로 변경(full history 필요).
  - `zdm/ko/downloads.md`·`zdm/ko/index.md`에서 `v.released` 참조를 `site.static_files | where: "path", v.downloads[0].file | first` 의 `modified_time`으로 교체. 추출 실패 시 `v.released` 수동 fallback → `-` 순.
  - `_data/zdm/common/versions.yml`에서 자동 추출이 가능한 모든 항목의 `released` 필드 제거. `downloads: []`인 CLI v1.2.0/v1.2.1만 수동 fallback으로 유지.
  - 부수 효과: 정보 부재로 비어 있던 v1.0.3(CLI/API) 배포일이 git 기준 `2026-03-04`로 자동 채워짐. API v2.0.0은 오늘(2026-05-18) 신규 바이너리 커밋 시각이 반영됨.
  - `CLAUDE.md` 1단계의 `released`·동일버전 재업로드 규칙·체크리스트를 자동 추출 동작 기준으로 재작성.

---

## [Documentation] - 2026-05-15

### Fixed
- **API v2.0.0 문서 ↔ ZDM-API 코드 일괄 동기화** — 12개 도메인(auth / backup / cloud-auth / file / license / os-replication / recovery / replication / schedule / server / user / zdm) 전수 점검 후 **총 94건 patch 적용 (실패 0)**. 도메인별 동기화 리포트는 ZDM-API repo의 `.claude/doc-sync-reports/2026-05-15/<domain>.md`에 보존
  - **1차 Blocker 40건** — 사용자가 문서 그대로 사용 시 실패하는 케이스 일괄 해소
    - `auth/issue.md` 엔드포인트 경로 오기 (`/api/auth/issue` → `/api/token/issue`)
    - `recovery/update.md`, `replication/update.md`, `os-replication/update.md`, `replication/delete.md`의 필수 `center` 필드 누락 보강
    - `cloud-auth/recovery-regist.md` curl 예시 `awsSecretKey==` 등호 두 개 오타 정정
    - `replication` get/list/monitoring 응답: `job.info` 구조 + `unitType`/`replicationMode`/`compression`/`encryption` PascalCase 표기 정정
    - `schedule` POST 응답: `type`/`state` 응답값을 string → numeric enum으로 정정, MED-003/008 prefix 정상화 반영
    - `file` upload/download status code(201 → 200) 및 응답 본문 구조 정정, `/files/list` 인증 명세 제거
    - `license/:identifier` 라우트 목록 조회 동작 명시, 성공 응답 status code 정정
    - `zdm/repository-update.md` 상태코드 오기재 정정(409→400, 400→403, 201→200), `repository.os` 필드 응답 제거
  - **2차 Missing + Outdated 51건** — 쿼리 파라미터 표 누락 보강 및 응답 구조 동기화
    - `backup` 4건: `delete/get/monitoring-*`의 `center`/`page`/`limit`/`sort`/`detail` 쿼리 파라미터 표 추가
    - `server` 4건: 오늘자 변경 `nPartFree != 0` 필터(swap/cdrom 등 제외) 동작 문서화
    - `recovery`: Windows 콜론/대소문자 자동 정규화 동작 반영(`regist.md`/`update.md`), `history-get`/`history-list` include 본문 신규 생성
    - `os-replication` 6건: 쿼리 파라미터 + 도메인 에러 코드 표 + `schedule`/`autoStart` 동작 설명 추가
    - `user/update.md` 응답 `summary.updatedFields[].field` 한글 → 영문 라벨 정정
    - `auth/issue.md` 유효성 실패 응답 상태코드 400 → 422 정정
  - **3차 Extra + Info 3건** — `cloud-auth` INFO-004 zos-delete/recovery-delete `center` 쿼리 추가 등 보조 patch

### Changed
- **백그라운드 에이전트 기반 자동 동기화 파이프라인 도입** — ZDM-API repo의 `api-doc-sync` 서브에이전트가 12개 도메인 독립 병렬로 코드↔문서 비교 → unified diff 형식 patch 제안 → 도메인별 적용 에이전트가 적용. 시급도 1/2/3차 단계로 순차 진행. 정책상 버전 스냅샷(`<action>/<version>.md`)은 수정 대상 외, 최상위 `<action>.md`만 갱신
- **API v2.0.0 좌측 사이드바 네비게이션 한글화** — `_data/navigation.yml`의 `ko-api-2.0.0` 섹션
  - 75개 항목 중 73개 `title:` 한글화 (기존 한글 항목 `API 소개` / `개요`는 유지)
  - 표기 스타일: `[METHOD] <한글 요약>` (배지 형식, 예: `[POST] 토큰 발급`, `[GET] 목록 조회`, `[PUT] 수정`, `[DELETE] 삭제`)
  - 명명 규칙: 동사 통일(`조회 / 등록 / 수정 / 삭제 / 발급 / 할당 / 업로드 / 다운로드 / 모니터링`), "단일 조회" vs "목록 조회"로 구분, 같은 섹션 내 동일 동사가 여러 번이면 괄호로 보조 분류(예: `모니터링 (작업 단위)` / `모니터링 (시스템 단위)`, `파티션 목록 (서버별)` / `파티션 전체 목록`)
  - 용어 통일: `레포지토리` → `저장소` (ZDM Center 섹션 6건), 모니터링 `(작업)` → `(작업 단위)` (4건), `(시스템)` → `(시스템 단위)` (2건)
  - URL 라인은 변경 없음 — `title:` 라인만 수정 (73 insertion / 73 deletion, 단일 hunk @ L1566)
  - **영향 범위는 좌측 사이드바만** — `_layouts/docs.html`이 `navigation.yml`의 `title`을 사이드바에 한해서만 사용 확인. 브라우저 탭 제목/breadcrumb/페이지 본문은 별도 출처라 영향 없음
  - 다른 버전(`ko-api-1.0.3` ~ `ko-api-1.3.1`) 및 CLI 섹션은 손대지 않음 (당시 표기 historical preservation)
  - `_includes/zdm/ko/api/index.md`의 명세표, `CONTRIBUTING.md` 등 본문 문서는 미변경 (역할 분리: 사이드바는 탐색용 한글, 본문은 정식 엔드포인트 명세)

### Notes
- 스킵 51건의 대부분은 의도된 케이스(상위 단계 patch에 선반영 또는 단순 관찰 Info — patch 블록 부재)
- 실패 0건, 모든 12개 도메인 정상 동기화
- 사이드바 한글화는 v2.0.0만 우선 적용. 사용자 반응 보고 v1.x 점진 확장 여부 결정

---

## [Documentation] - 2026-04-22

### Fixed
- **CLI v1.2.0 / v1.2.1 다운로드 404 수정** — `_data/zdm/common/versions.yml`에서 두 버전의 `downloads:`를 빈 배열(`[]`)로 변경. 해당 경로의 바이너리가 실제로 존재한 적 없어(`downloads/zdm-cli/1.2.0/`, `downloads/zdm-cli/1.2.1/`) 다운로드 페이지에서 "준비 중"으로 정상 표시되도록 수정.
- **CLI 리다이렉트 URL 언어 코드 누락 수정** — `zdm/ko/cli/index.md`의 4개 리다이렉트 경로를 `/zdm/cli/2.0.0/index` → `/zdm/ko/cli/2.0.0/index`로 보정. 이전 버전부터 반복된 오타를 정리.

### Changed
- **CLAUDE.md 릴리즈 절차 전면 보강** — 메이저/마이너/패치 케이스를 모두 포괄하도록 재작성
  - "릴리즈 유형 분류" 절 신설 — 표준 / 부분 갱신 / 재사용 패치 3유형 판정 기준과 공통 불변식 명시
  - `versions.yml`의 `docs:`·`downloads:` 분기 상세화
  - "재사용 패치" 시 2·3·4·6·7단계 생략 규칙과 8단계 patch 배지 병기 패턴 문서화
  - wrapper의 `navigation:` 키와 `include:` 경로가 독립 관리된다는 원칙 명문화
  - 7단계에 `versions.yml` ↔ 실제 파일 정합성 검증 하위 단계 추가
  - 리다이렉트 URL 형식(`/zdm/{lang}/{product}/{version}/index`) 명시
  - 체크리스트를 3유형별 매트릭스로 교체 + 과거 릴리즈 사례 대조표 추가
- **API `backup/update.md` 스케줄 정책 표를 CLI 문서에도 반영** — `_includes/zdm/ko/cli/docs/backup/update.md`에 "스케줄 등록/수정 정책 (v2.0.0)" 섹션 추가 (API/CLI 문서 일관성 유지)

### Added
- **CI 정합성 검증 스텝** — `.github/workflows/jekyll.yml`에 "Verify versions.yml downloads integrity" 스텝 추가. `versions.yml`에 등록된 `downloads[].file` 경로의 실제 파일 존재 여부를 빌드 전 검증해 깨진 링크 배포를 차단.

---

## [Documentation] - 2026-04-20

### Changed
- **API v2.0.0 Changelog 추가 항목** — `_includes/zdm/ko/api/changelog/2.0.0.md`에 누적 fix 반영
  - Schedule 처리 정책 정리(`PUT /backups/:identifier`)
  - Schedule 작업명 매핑 fix(`POST /recoveries`, `PUT /recoveries/:identifier`, `PUT /backups/:identifier`)
  - Recovery 등록 backup image 조회 timeout 동적화(파티션당 30초)
  - 에러 응답 메시지 구체화(필수 필드 누락 시 `<field> is required`, fallback에 원본 메시지 포함)
- **API 문서 컨텐츠** — `backup/update.md`에 스케줄 등록/수정 정책 표 추가

---

## [Documentation] - 2026-04-17

### Added
- **CLI v2.0.0 문서 추가** — 멀티 ZDM(Center) 지원, Replication V2 API, 전체 커맨드 문서 신규 작성
- **CLI v2.0.0 Changelog 추가** — `_includes/zdm/ko/cli/changelog/2.0.0.md`
- **API v2.0.0 문서 추가** — Replication regist body schema 단순화(Breaking) 및 GET 엔드포인트 `center` query parameter 지원
- **API v2.0.0 Changelog 추가** — `_includes/zdm/ko/api/changelog/2.0.0.md`

### Changed
- **versions.yml** — CLI v2.0.0 / API v2.0.0 latest 등록, 각 v1.3.1 stable 변경
- **navigation.yml** — `ko-cli-2.0.0`, `ko-api-2.0.0` 네비게이션 섹션 추가, `ko-zdm` 메인 링크를 v2.0.0으로 갱신
- **CLI 리다이렉트** — `/zdm/ko/cli/index.md` → v2.0.0으로 갱신
- **API 리다이렉트** — `/zdm/ko/api/index.md` → v2.0.0으로 갱신
- **CLI 문서 컨텐츠** — 전체 커맨드 문서 v2.0.0 기준으로 재작성, 이전 버전용 1.3.1 보존 파일 분리
- **API 문서 컨텐츠** — 전체 71개 공용 include 파일을 1.3.1 보존본으로 분리(메이저 버전 라인 분리), v2.0.0 공용에서 `replication/regist.md` 재작성(Breaking) 및 12개 list 파일에 `center` 쿼리 행 추가
- **메인 랜딩** — `zdm/ko/index.md`의 ZDM-API 업데이트 목록 최상단에 v2.0.0 항목 추가, latest 배지 갱신

---

## 2026-04-13

### Changed
- **API v1.3.1 문서 추가** — Schedule 검증 개선 및 Backup Update 모드 자동 전환
  - Schedule `type` 필드 문자열 입력 지원
  - Backup Update 모드-스케줄 교차 변경 시 자동 전환
  - Smart Schedule basic/advanced 모드 정합성 검증 추가
  - Schedule 삭제 시 사용 중 여부 검증 추가, 삭제 응답에 type/description 포함
  - Backup Update 기존 스케줄 ID 참조 시 동작 수정, 호환성 검증 추가
  - Schedule description 변환 수정 (타입 7 시간 누락, 타입 11 월/날짜 순서)
- **CLI v1.3.1 문서 추가** — Schedule 검증 강화 / 출력 형식 개선
  - Schedule 입력값 mode별 검증 추가 (smart 구조, type 범위, JSON 문법)
  - `backup regist` smart 모드 schedule 필수화
  - `backup regist/update` `--schedule-id` 옵션 smart 모드 JSON 형식 지원
  - `schedule delete` 신규 커맨드 추가
  - `schedule create` 서버 자동 등록으로 변경
  - `--schedule` / `--schedule-file` 입력 시 basic 자동 래핑
  - `schedule list --type` 문자열 입력 지원
  - Schedule type 출력 문자열 개선

---

## 2026-04-10

### Changed
- **CLI v1.3.0 변경 내용 반영** — `--schedule` 옵션 3개 분리 (`--schedule`, `--schedule-id`, `--schedule-file`)
  - 기존: `--schedule` 하나로 ID/JSON/파일 자동 감지 → ID 입력 시 파일 경로로 오인식되는 버그 존재
  - 변경: 용도별 명시적 분리, 상호 배타적 사용, `[Schedule]` 헬프 섹션 분리
  - 적용 커맨드: backup, recovery, replication, os-replication의 regist/update

---

## 2026-04-09

### Changed
- **CLI v1.2.1 패치 내용 반영** — `backup regist` `--repository-path` 선택적 변경, 에러 출력 수정
- **API v1.3.1 패치 내용 반영** — Repository 조회 실패 에러 메시지 구체화
- **CLI `backup regist` 문서 수정** — `--repository-path` 파라미터 설명 변경
  - 기본값 `-` → `config 설정값`, 미입력 + config 없으면 생략 가능으로 명시
- **API `POST /backups` 요청 본문 문서 수정** — `repository` 필드 구조 변경
  - `repository.id` 필드 추가 (Required)
  - `repository.type` Required → Optional
  - `repository.path` Required → Optional
- **versions.yml** — CLI 1.2.1을 `latest`로 추가 (docs: 1.2.0), API 1.3.1을 `latest`로 추가 (docs: 1.3.0)

### Added
- **CLI v1.2.0 문서 추가** — Replication 커맨드 6개 + 개요
  - `replication list` — Replication 목록/정보 조회
  - `replication regist` — Replication 등록 (V1/V2 분기)
  - `replication delete` — Replication 삭제
  - `replication update` — Replication 수정
  - `replication monit` — Replication 모니터링
  - `replication history` — Replication 실행 히스토리 조회

- **1.1.0 문서 디렉토리 생성**
  - `zdm/ko/cli/1.2.0/` — 기존 1.0.4 문서 + 신규 replication 7개 페이지
  - `_includes/zdm/ko/cli/docs/replication/` — 7개 include 파일 (overview, list, regist, delete, update, monit, history)

### Changed
- **versions.yml** — CLI 1.2.0을 `latest`로 추가, 1.0.4를 `stable`로 변경
- **navigation.yml** — `ko-cli-1.2.0` 네비게이션 섹션 추가 (Replication 포함), 메인 네비 링크 1.2.0으로 갱신
- **zdm/ko/cli/index.md** — 리다이렉트 대상 1.0.4 → 1.2.0으로 변경
- **license assign 문서** — 출력 예시를 실제 API 응답 구조(`{ server, license }`)에 맞게 수정, resultTitle `License Info Result` → `License Assign Result`

---

## 2026-04-08

### Added
- **API v1.3.0 문서 추가** — Cloud Auth 8개, OS Replication 8개 엔드포인트
  - **Cloud Auth (ZOS)**
    - `POST /cloud-auth/zos` — ZOS 인증 키 파일 업로드 + 메타데이터 등록
    - `GET /cloud-auth/zos` — ZOS 인증 목록 조회
    - `GET /cloud-auth/zos/download/:fileName` — ZOS 인증 키 파일 다운로드
    - `DELETE /cloud-auth/zos/:identifier` — ZOS 인증 삭제
  - **Cloud Auth (Recovery)**
    - `POST /cloud-auth/recovery` — Recovery 인증 정보 등록 (GCP: 키 파일 업로드 포함)
    - `GET /cloud-auth/recovery` — Recovery 인증 목록 조회
    - `DELETE /cloud-auth/recovery/:identifier` — Recovery 인증 삭제
  - **Cloud Auth (Region)**
    - `GET /cloud-auth/regions/:platform` — 플랫폼별 리전 목록 조회 (aws, gcp)
  - **OS Replication**
    - `POST /os-replications` — OS 복제 작업 등록
    - `GET /os-replications` — OS 복제 작업 목록 조회
    - `GET /os-replications/:identifier` — OS 복제 작업 단건 조회
    - `PUT /os-replications/:identifier` — OS 복제 작업 수정
    - `DELETE /os-replications/:identifier` — OS 복제 작업 삭제
    - `GET /os-replications/histories` — OS 복제 히스토리 목록 조회
    - `GET /os-replications/histories/:identifier` — OS 복제 히스토리 단건 조회
    - `GET /os-replications/monitoring/job/:identifier` — OS 복제 작업 모니터링

- **1.3.0 문서 디렉토리 생성**
  - `zdm/ko/api/1.3.0/` — 기존 1.2.0 문서 + 신규 cloud-auth 8개 + os-replication 8개
  - `_includes/zdm/ko/api/docs/cloud-auth/` — 8개 include 파일
  - `_includes/zdm/ko/api/docs/os-replication/` — 8개 include 파일

- **다운로드 파일 추가**
  - `downloads/zdm-api/1.3.0/zdm-api-linux.tar.gz`

### Changed
- **versions.yml** — API 1.3.0을 `latest`로 추가, 1.2.0을 `stable`로 변경
- **navigation.yml** — `ko-api-1.3.0` 네비게이션 섹션 추가 (Cloud Auth, OS Replication 포함), 메인 네비 링크 1.3.0으로 갱신
- **zdm/ko/api/index.md** — 리다이렉트 대상 1.2.0 → 1.3.0으로 변경, 경로 오류 수정 (`/zdm/api/` → `/zdm/ko/api/`)
- **recovery-regist.md** — AWS/GCP 리전 파라미터에 리전 목록 조회 API 참조 링크 추가, GCP 요청 예시에 `displayName` 파라미터 추가

---

## 2026-03-25

### Added
- **API v1.2.0 문서 추가** — Replication API 8개 엔드포인트
  - `GET /replications` — 복제 작업 목록 조회
  - `GET /replications/:identifier` — 복제 작업 단건 조회
  - `POST /replications` — 복제 작업 등록
  - `PUT /replications/:identifier` — 복제 작업 수정
  - `DELETE /replications/:identifier` — 복제 작업 삭제
  - `GET /replications/histories` — 복제 히스토리 목록 조회
  - `GET /replications/histories/:identifier` — 복제 히스토리 단건 조회
  - `GET /replications/monitoring/job/:identifier` — 복제 작업 모니터링

- **Replication V1/V2 스키마 구분 문서화**
  - 서버 환경변수 `REPLICATION_VERSION`에 따른 V1/V2 차이점 표기
  - 각 엔드포인트 페이지 상단에 버전 안내 공통 include 적용
  - V1 차이점은 `<details>` 접기 섹션으로 표기 (V2 기본)
  - V1 전용 enum 추가: `replication-v1-unit-types` (`image`, `repository`), `replication-v1-modes` (`full`, `incremental`)

- **1.2.0 문서 디렉토리 생성**
  - `zdm/ko/api/1.2.0/` — 기존 1.1.0 문서 50개 + 신규 replication 8개 + index.md (총 59개)
  - `_includes/zdm/ko/api/docs/replication/` — 8개 include 파일
  - `_includes/zdm/ko/api/docs/replication/_version-notice.md` — 버전 안내 공통 include

- **Replication 관련 enum include 파일 생성**
  - `replication-unit-types`, `replication-modes`, `transfer-types`, `replication-job-status`, `replication-history-result`
  - V1 전용: `replication-v1-unit-types`, `replication-v1-modes`

### Changed
- **versions.yml** — API 1.2.0을 `latest`로 추가, 1.1.0을 `stable`로 변경
- **navigation.yml** — `ko-api-1.2.0` 네비게이션 섹션 추가 (Replication / Replication V1 포함), 메인 네비 링크 1.2.0으로 갱신
- **zdm/ko/api/index.md** — 리다이렉트 대상 1.1.0 → 1.2.0으로 변경
- **zdm/ko/index.md** — v1.2.0 업데이트 항목 추가

---

## 2026-03-05

### Added
- **문서 콘텐츠 includes 공통화**
  - API 문서 46개, CLI 문서 38개를 `_includes/zdm/ko/` 하위로 추출
  - 버전별 페이지는 front matter + `{% include %}` 호출 구조로 변경
  - CLI 1.0.4 독립 문서 38개, API 1.1.0 독립 문서 46개 생성

- **버전 셀렉터 드롭다운 UI 추가**
  - `_layouts/docs.html` breadcrumb 옆에 버전 선택 드롭다운 추가
  - `versions.yml` 데이터 기반 동적 버전 목록 표시
  - `assets/css/style.css`에 드롭다운 스타일 추가

- **다운로드 페이지 신설** (`/zdm/ko/downloads`)
  - `versions.yml` 기반 버전별 다운로드 테이블 동적 생성
  - 바이너리 미등록 버전은 "준비 중" 표시
  - 접기/펼치기(details) 지원

- **Token 개요에 토큰 발급 절차 섹션 추가**
  - config set → config show → token issue 단계별 예시

- **Config 튜토리얼 초기 설정 절차 개선**
  - zdm list → config set → zdm list --repo-only → config set → config show 단계별 예시
  - Token 개요 페이지 동적 링크 추가

- **다운로드 디렉토리 버전별 구조 생성**
  - `downloads/zdm-api/1.1.0/`, `downloads/zdm-cli/1.0.4/` 생성

### Changed
- **네비게이션 URL 수정**
  - `ko-cli-1.0.4` 섹션: 모든 URL을 `/zdm/ko/cli/1.0.3/` → `/zdm/ko/cli/1.0.4/`로 변경
  - `ko-api-1.1.0` 섹션: 모든 URL을 `/zdm/ko/api/1.0.3/` → `/zdm/ko/api/1.1.0/`로 변경

- **소개 페이지(index.md) 구조 개선**
  - API/CLI index를 `_includes`로 공통화 (버전 파라미터로 분기)
  - 소개 페이지: 목차 + 소개 + 주요 기능 + 변경 사항 + 공통 옵션/Base URL + 참고사항
  - Quick Start, 기본 사용법, 응답 형식, 식별자 패턴, 환경 설정 등 레퍼런스 성격 내용 제거

- **메인 페이지(zdm/ko/index.md) 다운로드 동적 렌더링**
  - 하드코딩된 버전/링크를 `versions.yml` 기반으로 변경
  - 다운로드 미등록 시 링크 숨김, "전체 버전" 링크로 다운로드 페이지 연결

- **versions.yml 구조 개선**
  - `downloads` 배열 필드 추가 (os, file)
  - 불필요한 `released`, `description` 필드 제거

- **include 내 링크 동적 경로 처리**
  - `page.url` 기반 `base_path` 변수로 버전별 올바른 경로 생성
  - Token overview의 Config 개요 링크 404 수정

### Removed
- **1.1.0 index의 "나머지 API는 v1.0.3 문서와 동일합니다" 문구 제거** (자체 문서 보유)
- **1.0.4 index의 "나머지 커맨드는 v1.0.3 문서와 동일합니다" 문구 제거** (자체 문서 보유)
- **사용 가이드 페이지 제거** (내용을 소개 페이지 및 각 섹션 문서로 분산)

---

## [Documentation] - 2026-03-04

### Added
- **API v1.1.0 history 엔드포인트 누락 필터 파라미터 추가**
  - `zdm/ko/api/1.1.0/index.md` — 신규 엔드포인트 설명에 `partition`, `serverType` 필터 파라미터 명시
  - `zdm/ko/api/1.1.0/docs/backup/history-list.md` — `partition` 쿼리 파라미터 추가(정확 매칭), 파티션 필터 요청 예시 추가, Windows 서버 파티션 정규화(`:` 자동 추가) 참고 사항 추가
  - `zdm/ko/api/1.1.0/docs/backup/history-get.md` — `partition` 쿼리 파라미터 추가
  - `zdm/ko/api/1.1.0/docs/recovery/history-list.md` — `serverType` 쿼리 파라미터 추가(기본값 `target`, 선택값 `source`/`target`), `partition` 쿼리 파라미터 추가(개별 항목 정확 매칭), 소스/타겟 서버 필터 요청 예시 추가
  - `zdm/ko/api/1.1.0/docs/recovery/history-get.md` — `serverType`, `partition` 쿼리 파라미터 추가
- **CLI v1.0.4 history 서브커맨드 문서 신규 추가**
  - `zdm/ko/cli/1.0.4/index.md` (신규) — v1.0.3 대비 변경 사항(`backup history`, `recovery history` 서브커맨드 추가) 안내
  - `zdm/ko/cli/1.0.4/docs/backup/history.md` (신규) — `backup history` 커맨드. 옵션: `--job-id`, `--job-name`, `--server`, `--partition`, `--result`, `--asc`. Text/JSON 출력 예시 포함
  - `zdm/ko/cli/1.0.4/docs/recovery/history.md` (신규) — `recovery history` 커맨드. 옵션: `--job-id`, `--job-name`, `--server`, `--server-type`, `--partition`, `--result`, `--asc`. `--server-type` 소스/타겟 구분 설명 및 참고 사항 포함, Text/JSON 출력 예시 포함

---

## 2026-03-03

### Added
- **GET /backups/histories 엔드포인트 문서 추가**
  - 백업 히스토리 목록 조회 (필터링 + 페이지네이션)
  - 필터 옵션: `jobId`, `jobName`, `server`, `result`(`success`/`failed`), `sort`
  - 페이지네이션: `page`, `limit`

- **GET /backups/histories/:identifier 엔드포인트 문서 추가**
  - 백업 히스토리 단건 조회 (ID 또는 작업 이름)
  - ID 조회 시 단건 응답, 작업 이름 조회 시 목록 응답

- **GET /recoveries/histories 엔드포인트 문서 추가**
  - 복구 히스토리 목록 조회 (필터링 + 페이지네이션)
  - `recoverDrive` 필드: `string[]` 타입 (콤마 구분 문자열을 배열로 변환)

- **GET /recoveries/histories/:identifier 엔드포인트 문서 추가**
  - 복구 히스토리 단건 조회 (ID 또는 작업 이름)

- **API v1.1.0 문서 디렉토리 생성**
  - `zdm/ko/api/1.1.0/` 경로에 index 및 history 문서 4개 추가
  - navigation.yml에 `ko-api-1.1.0` 네비게이션 섹션 추가
  - 기존 API(v1.0.3)와 동일한 엔드포인트는 v1.0.3 문서 참조 안내

---

## [Documentation] - 2026-02-06

### Fixed
- **Repository Update 문서와 코드 응답 형식 불일치 수정** — `zdm/ko/api/1.0.3/docs/zdm/repository-update.md`
  - 응답 예시 JSON: `repositoryInfo`에서 `id`, `centerName`만 유지 (`type`, `remotePath`, `localPath`, `ip` 제거)
  - 응답 예시 JSON: `summary.state: "success"` 필드 추가
  - 응답 필드 테이블: 불필요한 필드 제거 및 `summary.state` 필드 추가
  - `field: "ip"` → `field: "ipAddress"` 변경 (코드와 일치)
  - backup/recovery update 응답 양식과 통일

---

## 2026-02-05

### Added
- **PUT /zdm-centers/repositories/:identifier 엔드포인트 추가**
  - Repository 정보 수정 기능
  - 수정 가능 필드: `remotePath`, `remoteUser`, `remotePwd`, `ip`
  - `center` 필수 입력: Center 존재 여부 및 Repository 소속 일치 검증
  - `remotePath` 입력 시: DB의 저장소 타입(SMB/NFS)에 따른 경로 양식 검증
  - `ip` 입력 시: IPv4 양식 검증 + 기존 등록 IP와 중복 검사 후 `|` 구분자로 추가
  - 응답 형식: `repositoryInfo` + `summary.updatedFields[{field, previous, new}]`
  - `remotePwd` 변경 시 previous/new 모두 `"********"`로 마스킹

### Changed
- **POST /zdm-centers/repositories 등록 결과 확인 개선**
  - 기존: `job_interactive` INSERT 후 바로 성공 응답 (실제 등록 결과 미확인)
  - 변경: INSERT 후 최대 10초간 polling하여 실제 등록 결과 확인 후 응답
  - 성공: `sJobResult === "SUCCESS"` 시 성공 응답
  - 실패: `sDescription` 내용을 에러 메시지로 반환 (HTTP 500)
  - 타임아웃: 10초 경과 시 타임아웃 에러 반환 (HTTP 500)

- **POST /backups individual.jobName 처리 개선**
  - `individual`에서 `jobName`을 명시적으로 지정한 경우 파티션 suffix 없이 그대로 사용
  - 기존: `individual.jobName = "vmware-12.0204"` → `"vmware-12.0204_var_www_html"` (suffix 강제 추가)
  - 변경: `individual.jobName = "vmware-12.0204"` → `"vmware-12.0204"` (그대로 사용)
  - 중복 jobName 지정 시 `JOB_NAME_ALREADY_EXISTS` 에러 반환 (HTTP 409)
  - `individual.jobName` 미지정 시 기존 자동 생성 로직 유지

### Documentation
- **POST /zdms/repositories 문서 수정**
  - 등록 소요 시간 안내 문구 추가: 최대 10초간 결과 확인, 초과 시 실패 간주
  - 에러 응답 추가: 등록 실패 (500), 등록 시간 초과 (500)

---

## 2026-02-04

### Added
- **CLI: list 명령어 정렬 옵션 추가**
  - `--asc`: 오름차순 정렬 (기본값: 내림차순)
  - 적용 명령어: `backup list`, `recovery list`, `server list`, `license list`, `schedule list`, `zdm list`, `file list`
  - 사용 예시: `zdm-cli backup list --asc`
- **CLI: `config set --auto` 옵션 추가**
  - `--zdm-repo-id`와 함께 사용 시 repository path 자동 조회
  - 사용 예시: `zdm-cli config set --zri 15 --auto`
- **API: 모든 조회 API에 `sort` 쿼리 파라미터 추가**
  - 사용법: `?sort=asc` (오름차순), 기본값: 내림차순(desc)
  - 적용 API: GET /zdm-centers, /servers, /backups, /recoveries, /schedules, /users, /licenses, /files/list 등

### Changed
- **CLI: `zdm list --repo` 출력에서 `os` 필드 제거**
  - API 변경사항 반영
- **API: GET /zdm-centers/:identifier/repositories 응답에서 `os` 필드 제거**
  - Repository 정보에서 OS 필드가 더 이상 반환되지 않음

### Fixed
- **CLI: `config set` SMB 경로 입력 시 백슬래시 손실 문제 수정**
  - `config set --zrp "\\192.168.2.108\ZConverter"` 입력 시 올바르게 저장
- **CLI: 심볼릭 링크로 실행 시 config 파일 인식 오류 수정**
  - 바이너리를 심볼릭 링크로 등록 후 실행 시 원본 위치의 config 파일을 찾지 못하던 문제 해결
- **CLI: `config set --auto` 옵션 repository 조회 오류 수정**
  - 존재하는 repository ID 입력 시 "not found" 오류가 발생하던 문제 해결
- **API: GET /zdm-centers/:identifier/repositories type 값 "Unknown" 오류 수정**
  - ZDM 신규 버전에서 Repository 타입이 "Unknown"으로 표시되던 문제 해결
  - nType 값 22, 23에 대한 매핑 추가 (22→SMB, 23→NFS)

---

## 2026-01-29

### Added
- **CLI: recovery regist 명령어 `--repository-type` 옵션 추가**
  - 별칭: `-rt`
  - 작업시 사용할 Repository 타입 지정
- **API: GET /backups/images/server/:serverName 응답 필드 추가**
  - `image.jobName`: 백업 작업 이름 필드 추가

### Changed
- **API: GET /backups/images/server/:serverName jobName 필터 동작 변경**
  - 부분 일치 → 정확히 일치로 변경
  - 작업 이름과 정확히 일치하는 백업 이미지만 반환
- **API: GET /backups/images/server/:serverName partition 파라미터 설명 개선**
  - Linux/Windows 통합 지원 명시
  - Windows 드라이브 콜론 자동 제거 설명 추가 (`C:` → `C`)
- **API: POST /recoveries repository 필드 구조 변경**
  - `repository.id`: Optional → Required로 변경
  - `repository.type`: Required → Optional로 변경
  - `repository.path`: Required → Optional로 변경
- **API: POST /recoveries jobList 항목 구조 개선**
  - `backupJob` 필드 추가: 사용할 백업 작업 이름 (미지정 시 최신 성공 작업 자동 선택)
  - `backupFile` 필드 설명 상세화: 사용할 백업 이미지 파일명 (미지정 시 최신 이미지 자동 선택)
  - `repository` 객체 구조 추가: 개별 파티션마다 다른 Repository 사용 가능
  - `excludePartition` 설명 상세화: 콤마 구분 예시 추가
  - `listOnly` 설명 상세화: true/false 동작 명시
  - `mode`, `repository` 필드 설명 보완
- **API: POST /recoveries 응답 필드명 변경**
  - `backup.useLast` → `backup.useLatest`

---

## 2026-01-28

### Added
- **GET /backups/images/server/:serverName 필터 파라미터 추가**
  - `center`: Center ID 또는 이름으로 필터
  - `repositoryId`: Repository ID로 필터
  - `repositoryPath`: Repository 경로로 필터

### Changed
- **GET /backups/images/server/:serverName 에러 응답 개선**
  - Center 미존재: "요청한 Center 'X'을(를) 찾을 수 없습니다"
  - Repository 미존재: "요청한 Repository ID X를 찾을 수 없습니다" / "등록된 Repository가 없습니다"
  - 백업 이미지 미존재: "백업 이미지가 존재하지 않음 (Center: X, Repository ID: Y)"
  - 작업 시간 초과: "백업 이미지 조회 작업 시간 초과 (10초 경과)"

---

## 2026-01-24

### Added
- **GET /backups/images/server/:serverName 필터 파라미터 추가**
  - `partition`: Linux 파티션(mountPoint) 필터 (예: `/`, `/boot`)
  - `drive`: Windows 드라이브 필터 (예: `C`, `C:`)
  - 각 필터는 정확히 일치하는 경우만 반환
- **GET /backups/images/server/:serverName 에러 응답 추가**
  - 404 Not Found: 이미지가 없고 서버도 존재하지 않는 경우

### Changed
- **GET /backups/images/server/:serverName 응답 구조 변경**
  - 기존: `data: { images: [...], total }`
  - 변경: `data: [...]` (불필요한 래핑 제거)
  - Linux/Windows OS에 따라 응답 구조 분기:
    - Linux: `partition: { mountPoint, device, size, filesystem }`
    - Windows: `drive: { letter, size, filesystem }`
  - 필드 구조 변경:
    - `name`, `type`, `time` → `image: { name, type, createdAt, ... }`
    - `compressed`, `compressionRatio` → `image.compression: { enabled, ratio }`
    - `server`, `os` → `server: { name, os }`
  - `diskNumber`, `partitionNumber` 필드 제거
- **GET /backups/images/server/:serverName jobName 필터 동작 변경**
  - 부분 일치 → 정확히 일치로 변경
  - `backupName`에서 확장자(`.ZIA`) 제거 후 비교
- **GET /backups/images/server/:serverName 고아 이미지 지원 문서화**
  - 서버 정보가 삭제되어도 백업 이미지가 존재하면 조회 가능
  - OS 타입을 `UNKNOWN`으로 처리하여 `partition` 형식으로 응답

---

## [API v1.0.3] - 2026-01-23

### Added
- **DELETE /schedules/:identifier 엔드포인트 문서 추가**
  - 스케줄 ID 기반 삭제 기능
  - Path 파라미터: `identifier` (숫자만 허용)
  - 응답: 삭제된 스케줄 ID 및 이름 반환

- **DELETE /zdm-centers/repositories/:identifier 엔드포인트 문서 추가**
  - Repository ID 기반 삭제 기능
  - Path 파라미터: `identifier` (숫자만 허용)
  - 응답: 삭제된 Repository ID, 센터 이름, 원격/로컬 경로 반환

- **DELETE /zdm-centers/:identifier 엔드포인트 문서 추가**
  - ZDM ID 기반 삭제 기능
  - Path 파라미터: `identifier` (숫자만 허용)
  - 응답: 삭제된 ZDM ID, 이름, 관련 테이블 삭제 수 반환

---

## [CLI v1.0.3] - 2026-01-19

### Changed
- **Backup/Recovery update 명령어 `--status` 파라미터 값 제한**
  - 변경 전: 제한 없음
  - 변경 후: `start`, `stop` 2가지만 허용
- **Backup/Recovery list, monit 명령어 `--status` 파라미터 값 변경**
  - 변경 전: `run`, `complete`, `start`, `waiting`, `cancel`, `schedule`
  - 변경 후: `preparing`, `processing`, `complete`, `scheduled`, `canceling`, `canceled`, `error`, `registered`
- **Backup list 명령어 `--drive` 파라미터 추가**
  - Windows 드라이브 필터 지원 (예: `C:`, `D:`)
- **Backup monit 명령어 `--drive` 파라미터 추가**
  - Windows 드라이브 필터 지원
- **Backup monit 명령어 `--status` 파라미터 선택값 추가**
  - 작업 상태 필터링 가능: `preparing`, `processing`, `complete`, `scheduled`, `canceling`, `canceled`, `error`, `registered`
- **Recovery monit 명령어 `--status` 파라미터 추가**
  - 작업 상태 필터링 지원
- **Backup list, monit / Recovery monit API 파라미터명 변경 반영**
  - `serverName` → `server` (API 일관성 통일)
- **License regist 명령어 `--center` 파라미터 옵션화**
  - 변경 전: 필수 파라미터
  - 변경 후: 선택 파라미터 (미입력시 config의 zdm.id 값 사용)

---

## [API v1.0.3] - 2026-01-19

### Changed
- **Backup/Recovery API 작업 상태(status) 응답 형식 변경**
  - 응답의 `status.current` 및 `progressInfo.status` 값이 PascalCase로 변경
  - 변경 전: `"complete"`, `"run"`, `"pending"` 등 (소문자)
  - 변경 후: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`
  - 쿼리 파라미터 `status`는 대소문자 구분 없이 사용 가능
- **작업 상태 계산 로직 개선**
  - `active.nProcessType`, 스케줄 여부, `sJobResult`, `nJobStatus`를 기반으로 상태 계산
  - 스케줄이 있는 완료된 작업은 `Scheduled` 상태로 표시
  - 스케줄 없이 대기 중인 작업은 `Registered` 상태로 표시
- **Recovery Monitoring API status 필터 파라미터 추가**
  - GET /recoveries/monitoring/job/:identifier: `status` 파라미터 추가
  - GET /recoveries/monitoring/system/:identifier: `status` 파라미터 추가
  - 계산된 상태값 기반 필터링 지원
- **PUT /recoveries/:identifier 요청 필드명 변경**
  - `state` → `status` (Backup API와 일관성 통일)
- **PUT /backups/:identifier, PUT /recoveries/:identifier status 파라미터 제한**
  - 작업 상태 변경 값이 `start`, `stop` 2가지로 제한
  - `start`: 작업 시작 (nJobStatus=3)
  - `stop`: 작업 정지 (nJobStatus=2)

---

## [API v1.0.3] - 2026-01-18

### Fixed
- **PUT /recoveries/:identifier jobList 버그 수정**
  - `jobList`만 전달 시 개별 파티션 mode 변경이 적용되지 않던 문제 해결
  - 변경 전: `jobList`만 전달하면 DB 업데이트 없이 빈 응답 반환
  - 변경 후: 개별 파티션 mode 변경이 정상 적용되고 `eachUpdatedFields`에 변경 내역 표시

### Changed (추가)
- **PUT /recoveries/:identifier jobList Windows 지원**
  - 요청: `partition` (Linux) 또는 `drive` (Windows) 중 하나 필수
  - 응답: OS에 따라 `partition` 또는 `drive` 필드로 구분하여 반환
  - Windows 드라이브는 대문자 + `:` 형식으로 자동 정규화 (예: `c` → `C:`)
- **POST /recoveries 응답 필드명 변경**
  - `backup.useLast` → `backup.useLatest` (최신 백업 사용 여부)
  - 값: `"yes"` / `"no"` (변경 없음)
- **GET /recoveries, GET /recoveries/:identifier 응답 필드 값 형식 변경**
  - `backup.latest` 값: `"true"` → `"use"` (또는 `"not use"`)
  - 다른 옵션 필드들과 동일한 문자열 형식으로 통일
- **Recovery Monitoring API 서버 필터 파라미터 통일**
  - `serverName` → `server` 파라미터명 변경 (다른 API와 일관성)
  - `server` 파라미터는 서버 이름 또는 ID 모두 입력 가능
  - 숫자로만 구성된 경우 서버 ID로 판단하여 서버 이름으로 자동 변환
  - 수정된 엔드포인트: GET /recoveries/monitoring/job/:identifier, GET /recoveries/monitoring/system/:identifier
- **Backup Monitoring API 서버 필터 파라미터 통일**
  - `serverName` → `server` 파라미터명 변경 (Recovery Monitoring API와 일관성)
  - `server` 파라미터는 서버 이름 또는 ID 모두 입력 가능
  - 숫자로만 구성된 경우 서버 ID로 판단하여 서버 이름으로 자동 변환
  - `drive` 필터 파라미터 추가 (Windows 드라이브 필터)
  - 수정된 엔드포인트: GET /backups/monitoring/job/:identifier, GET /backups/monitoring/system/:identifier

### Fixed (추가)
- **Recovery Monitoring API server 필터 미적용 버그 수정**
  - `server`, `serverType` 필터가 모니터링 조회 시 적용되지 않던 문제 해결
  - 변경 전: `server=oracle-server&serverType=target` 전달해도 필터 무시됨
  - 변경 후: 지정된 서버 필터 조건으로 정상 필터링

### Added
- **Backup Monitoring API 에러 응답 문서화**
  - GET /backups/monitoring/job/:identifier: 에러 응답 섹션 추가
    - `JOB-ERROR-01` (404): 조건에 맞는 Backup 작업을 찾을 수 없음
    - `JOB-ERROR-20` (400): 작업 데이터 불완전 (backup/backupInfo 누락)
  - GET /backups/monitoring/system/:identifier: 에러 응답 섹션 추가
    - `JOB-ERROR-01` (404): 서버에 파티션/백업 작업 없음
    - `JOB-ERROR-20` (400): 작업 데이터 불완전
- **GET /recoveries/:identifier 필터 파라미터 문서화**
  - 지원 필터: server, serverType, mode, partition, drive, status, repositoryID, repositoryType, repositoryPath, platform, backupName
  - 필터 조건 불일치 시 에러 응답 추가: "작업은 존재하지만, 지정된 필터 조건과 일치하는 결과가 없습니다."
- **GET /backups/:identifier 필터 파라미터 문서화**
  - 필터 조건 불일치 시 에러 응답 추가

### Changed
- **Backup API 서버 필터 파라미터 통일**
  - `serverName` → `server` 파라미터명 변경 (Recovery API와 일관성)
  - `server` 파라미터는 서버 이름 또는 ID 모두 입력 가능
  - 수정된 파일: backup/get.md, backup/list.md
- **Backup API drive 필터 추가**
  - Windows 드라이브 필터 지원 (`C:`, `D:` 등)
  - 기존 `partition` 필터는 Linux 파티션용으로 유지
  - 수정된 파일: backup/get.md, backup/list.md
- **Backup API 응답 partition/drive 필드 구분**
  - Linux 서버: `partition` 필드로 파티션 출력 (예: `/`, `/home`)
  - Windows 서버: `drive` 필드로 드라이브 출력 (예: `C:`, `D:`)
  - 수정된 파일: backup/get.md, backup/list.md
- **Backup/Recovery API server 필터 개선**
  - 숫자로만 구성된 경우 서버 ID로 판단하여 서버 이름으로 자동 변환
  - 예: `server=12` → 서버 ID 12의 sSystemName으로 조회
  - 서버 이름과 ID 모두 동일한 파라미터로 사용 가능
- **Recovery API drive 필터 정규화**
  - 대문자 변환 및 `:` 자동 추가 (예: `drive=c` → `C:`로 조회)
  - Backup API와 동일한 정규화 로직 적용
- **Recovery API partition/drive 필터 다중 값 지원**
  - 콤마로 구분된 문자열 지원 (예: `partition=/,/boot`, `drive=c,d`)
  - IN 절을 사용하여 여러 파티션/드라이브 동시 조회 가능
- **Recovery API 조회 응답 from/to 필드 통일**
  - Windows와 Linux 모두 동일한 `from`, `to` 필드 사용
  - 변경 전 (Windows): `"drive": "C:"`
  - 변경 후 (Windows): `"from": "C:", "to": "C:"`
  - `drive` 필드 제거로 API 응답 스키마 통일
  - 수정된 파일: recovery/list.md, recovery/get.md
- **Recovery API overwrite 필드 타입 변경**
  - `boolean` → `string` (일관성 개선)
  - 등록 요청 (regist): `"overwrite": "allow"` / `"overwrite": "not allow"`
  - 조회 응답 (list, get): `"overwrite": "Overwritten"` / `"overwrite": "Not overwritten"`
  - 다른 옵션 필드들(`autoStart`, `afterReboot` 등)과 동일한 문자열 형식으로 통일
  - 수정된 파일: recovery/regist.md, recovery/list.md, recovery/get.md
- **API 에러 응답 형식 통일** (10개 파일)
  - `error` 필드를 객체에서 문자열로 변경 (실제 API 응답 형식과 일치화)
  - 변경 전: `"error": { "code": "...", "message": "..." }`
  - 변경 후: `"error": "에러 메시지"`
  - 수정된 파일:
    - backup/list.md, backup/monitoring-job.md, backup/monitoring-system.md
    - recovery/list.md, recovery/monitoring-job.md, recovery/monitoring-system.md
    - file/list.md, license/list.md, schedule/list.md
    - server/list.md, server/partitions.md
    - user/list.md, zdm/list.md, zdm/repositories.md
- **스케줄 타입 이름 변경** (displayMappings 일치화)
  - `smart weekly on specific day` → `Smart Weekly (Specific Day of the Week)`
  - `smart monthly on specific week and day` → `Smart Monthly (Specific Week and Day of the Week)`
  - `smart monthly on specific date` → `Smart Monthly (Specific Date)`
  - `smart custom monthly on specific month, week and day` → `Smart Custom (Specific Month, Week and Day of the Week)`
  - `smart custom monthly on specific month and date` → `Smart Custom (Specific Month and Date)`
- **스케줄 요일 필드 형식 변경**
  - 숫자 (`"0"` ~ `"6"`) → 문자열 (`"mon"`, `"tue"`, `"wed"`, `"thu"`, `"fri"`, `"sat"`, `"sun"`)
- **Smart 스케줄 basic 필드 제한사항 문서화**
  - type 7~11의 basic 필드에서 단일 값만 허용 (복수 선택 불가)
  - 에러 메시지 개선: 현재 선택된 값 표시
- **time 필드 검증 추가**
  - type 7~11에서 time 형식 검증 (`"HH:mm"`, `"00:00"` ~ `"23:59"`)
- **전체 API 문서 날짜 형식 통일** (39개 파일, 214개 항목)
  - ISO 8601 형식 (`2025-01-15T02:00:00Z`) → `YYYY-MM-DD HH:mm:ss` 형식 (`2025-01-15 02:00:00`)
  - 영향받는 필드: `timestamp`, `expiresAt`, `start`, `end`, `lastUpdated`, `createdAt`, `updatedAt` 등
  - 실제 API 응답 형식과 문서 일치화
- **Query String 네이밍 컨벤션 통일** (camelCase)
  - GET /users: `user_name` → `userName` 파라미터명 변경
  - 프로젝트 전체 camelCase 통일

---

## [CLI v1.0.3] - 2026-01-16

### Added
- `server delete` 명령어 문서 추가

### Changed
- 파라미터 별칭 일관성 개선 및 변경
  - `recovery regist`: `--center` 별칭 `-c` 추가, `--user` 별칭 `-u` 추가
  - `backup regist`: `--center` 별칭 `-c` 추가
  - `license list`: `--expiration-date` 별칭 `--exp` → `-expd` 변경
  - `server list`: `--license-assign-only` 별칭 `-lao` → `-assigned` 변경, `--license-un-assign-only` 별칭 `-luao` → `-unassigned` 변경
  - `token issue`: `--user-mail` 별칭 `-m` → `-mail` 변경
  - `zdm list`: `--repository-only` 별칭 `-ro` → `-repo-only` 변경

### Removed
- `recovery regist`: `--description` 옵션 제거
- `license regist`: `--description` 옵션 제거
- `server list`: `--partition-only` 옵션 제거

---

## [API v1.0.3] - 2026-01-16

### Added
- GET /users/:identifier: 응답 필드 섹션 추가

### Changed
- GET /licenses: `id`, `name` 쿼리 파라미터 추가
- POST /recoveries: `description` 필드 제거
- GET /schedules: `page`, `limit` 페이지네이션 파라미터 추가
- GET /zdms: `page`, `limit` 페이지네이션 파라미터 추가

---

## [Documentation] - 2026-01-16

### Changed
- **Recovery 작업 등록시 `overwrite` 필드 타입 변경** — `zdm/ko/api/1.0.3/docs/recovery/{regist,list,get}.md`
  - **요청 (INPUT)**: `"allow"` / `"not allow"` (string) → `true` / `false` (boolean)
  - **응답 (OUTPUT)**: `"allow"` / `"not allow"` (string) → `"overwrite"` / `"not overwrite"` (string)
  - `_data/zdm/api_0_3/enums.yml` — `overwrite-options` 값 변경: `"allow"`/`"not allow"` → `"true"`/`"false"` (boolean 타입)
  - `regist.md` 요청 본문 테이블 + jobList 항목 구조 테이블의 `overwrite` 타입 `string` → `boolean`
  - `regist.md` 요청 예시 JSON: `"overwrite": "allow"` → `"overwrite": true`
  - `regist.md` 응답 예시 + `list.md`/`get.md` (detail=true) 응답 예시: `"overwrite": "allow"` → `"overwrite": "overwrite"`
  - **참고**: 요청은 boolean, 응답은 string으로 비대칭. 이후 2026-01-19 [API v1.0.3]에서 `boolean` → `string` 통일로 재변경됨
- **DTO 전체 도메인 검토 결과**: Recovery만 변경, 나머지 8개 도메인(Backup/Server/Schedule/License/User/ZDM/File/Auth) DTO와 문서 일치 확인 — 추가 변경 없음

---

## [API v1.0.3] - 2025-01-16

### Changed
- Backup API 문서 업데이트
  - DELETE /backups/:identifier: `partition` 쿼리 파라미터 추가
  - POST /backups: `description` 필드 제거, `rotation` 기본값 1 명시
  - PUT /backups/:identifier: `description` 필드 제거
  - GET /backups/monitoring/job/:identifier: `serverName`, `jobName`, `page`, `limit` 파라미터 추가

---

## 2025-01-14

### Added
- 다국어 지원 (i18n) 폴더 기반 구조 적용
  - `/zdm/ko/` 한국어 문서
  - `/zdm/en/` 영어 문서 (준비중)
- 언어 선택 UI 컴포넌트 (`_includes/language-selector.html`)
- 404 페이지 추가 (3초 후 홈으로 리다이렉트)

### Changed
- URL 구조 변경
  - `/zdm/api/1.0.3/` → `/zdm/ko/api/1.0.3/`
  - `/zdm/cli/1.0.3/` → `/zdm/ko/cli/1.0.3/`
- navigation.yml 언어별 구조로 변경 (`ko-api-1.0.3`, `ko-cli-1.0.3`)
- 메인 페이지 링크 경로 업데이트
- 언어 선택 UI 위치 변경 (사이드바 → 헤더 우측 하단)

### Removed
- `/zdm/api/`, `/zdm/cli/` 레거시 폴더 삭제 (404 페이지로 대체)

---

## [API v1.0.3] - 2025-01-14

### Added
- 페이지네이션 정보 추가
  - GET /backups/images/server/:serverName
  - GET /backups/monitoring/system/:identifier
  - GET /recoveries/monitoring/system/:identifier
  - GET /servers/:identifier/partition
  - GET /servers/:identifier/partitions
  - GET /zdm-centers/:identifier/repository
  - GET /zdm-centers/:identifier/repositories

### Changed
- POST /schedules 필드 타입 변경
  - `center`: number → string (identifier 패턴 지원)
  - `user`: number → string (identifier 패턴 지원)
- POST /backups 문서 업데이트
  - `individual` 객체 구조 상세화
- POST /recoveries 응답 필드 변경
  - `partitions[].partition` → `partitions[].sourcePartition`, `partitions[].targetPartition`

---

## [CLI v1.0.3] - 2025-01-14

### Added
- `license list` 명령어 신규 옵션
  - `--id`: License ID로 조회
  - `--name`, `-n`: License 이름으로 조회

### Changed
- `recovery list` 문서 업데이트
- `recovery regist` 출력 예시 업데이트
  - `partition` → `sourcePartition`, `targetPartition` 필드 분리 반영
- `config set` 출력 형식 업데이트
  - 변경된 필드별 이전값/신규값 상세 표시
- `server list` 문서 내용 보강 (응답 필드 상세화)
- `zdm list` 문서 내용 보강 (응답 필드 상세화)
- 파라미터 네이밍 kebab-case로 통일
  - `--jobName` → `--job-name`
  - `--excludeDir` → `--exclude-dir`
  - `--excludePartition` → `--exclude-partition`
  - `--networkLimit` → `--network-limit`
  - `--scriptPath` → `--script-path`
  - `--scriptRun` → `--script-run`
  - 적용 파일: backup/regist, backup/update, recovery/regist, recovery/update

---

## [API v1.0.3] - 2025-01-12

### Added
- 페이지네이션 지원 (`page`, `limit` 파라미터)
  - GET /servers
  - GET /backups
  - GET /recoveries
  - GET /licenses
  - GET /users
  - GET /files/list
- GET /backups/images/server/:serverName 엔드포인트
- Schedule Overview 문서 분리

### Changed
- 응답 예시에 페이지네이션 적용/미적용 케이스 구분
- 파라미터 테이블에 include 모듈화 적용

---

## [CLI v1.0.3] - 2025-01-12

### Added
- OS 호환성 정보 문서 (compatibility.md)
- Config 튜토리얼 문서
- License list 신규 옵션추가
  - id, name

### Changed
- 파라미터 테이블 include 모듈화
  - job-modes, platforms, output-formats 등
- 참조 섹션 추가 (enum 상세 설명)
- cli 실행시 자동으로 생성되는 디렉토리 이름 변경
  - zdm-cli -> zdm-cli-data

### Fixed
- navigation 값 오류 수정 (cli → cli-1.0.3)

---

## 2025-01-12

### Added
- CHANGELOG.md 생성
- CONTRIBUTING.md 개발자 가이드 분리

### Changed
- README.md 공개용으로 간소화
- 데이터 폴더 네이밍 규칙 변경 (`1.0.3` → `v1_0_3`)
  - Jekyll의 점(.) 제거 문제 해결
