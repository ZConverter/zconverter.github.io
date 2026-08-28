# Changelog

모든 주요 변경 사항이 이 파일에 기록됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 합니다.

---

## [Documentation] - 2026-08-28 (ZDM-API 3.0.0 릴리즈 — 구조 생성)

### Context
- `zdm-api-v2` 3.0.0 은 **응답 봉투 breaking** 릴리즈. `error` 가 문자열 → `{code, message, details?}` 객체,
  `requestID` → `traceId` 개명, `timestamp` → ISO 8601. 공용 include 75파일 중 **74파일**의 응답 예시가 영향받는다.
- 신규 엔드포인트 `POST /recoveries/image` (Image Recovery) 추가.
- 계획: `zdm-api-v2/orgs/dev/plans/3.0.0-gitpage-문서-릴리즈-계획.md` (표준 릴리즈 판정).

### Added
- `_data/zdm/common/versions.yml` — api `3.0.0` 엔트리(`status: latest`, `docs: "3.0.0"`). 기존 `2.0.2` 는 `stable` 로 강등.
  `downloads` 는 **Linux 단독**(API 는 Windows 바이너리를 배포하지 않는다).
- `_data/navigation.yml` — `ko-api-3.0.0` 섹션 신설(2.0.2 블록 복제 + 버전 치환).
  신규 항목 2건: Recovery 의 "[POST] Image Recovery 등록", API Documentation 의 "에러 코드".
- `zdm/ko/api/3.0.0/` wrapper 75파일 (2.0.2 복제 → `navigation:` 키·intro 의 title/changelog include/`version=` 치환).
- `_includes/zdm/ko/api/changelog/3.0.0.md` — 스켈레톤(본문 미작성).
- `downloads/zdm-api/3.0.0/` 디렉토리 (바이너리는 추후 직접 투입).

### Changed
- `_data/navigation.yml` `ko-zdm:` 메인 링크 → `/zdm/ko/api/3.0.0/index`.
- `zdm/ko/index.md` — ZDM-API 헤더 배지 `latest v3.0.0`, 업데이트 목록 최상단에 v3.0.0 블록 추가.

### 미완 — 후속 작업
- **5단계(문서 본문) 미수행**: 공용 include 74파일의 응답 예시 치환 + 보존본 분리 + 구버전 wrapper 리타겟.
- 신규 본문 3건 미작성: `docs/recovery/image-regist.md`, `docs/error-codes.md`, changelog 본문.
- `regist.md` 의 "전체 partition skip 시 `JOB-ERROR-01`(404)" 서술은 3.0.0 에서 `JOB-ERROR-14`(400) 로 정정 필요.

### Notes
- 6단계(리다이렉트) **불필요** — `zdm/ko/api/index.md` 가 `versions.yml` 의 latest 를 Liquid 로 자동 반영한다
  (파일 주석에 명시). skill 본문의 6단계 지시는 현행 구조와 어긋나 CLAUDE.md 우선 원칙으로 스킵.
- 기존 `ko-api-1.3.1` 블록의 링크 74건이 `1.3.0` 을 가리키는 불일치가 있으나 **본 작업 이전부터 존재**. 미조치.

---

## [Documentation] - 2026-08-21 (zdm-api 2.0.2 브랜치 최신 코드 동기화 — 보안 변경 반영 · 끊긴 링크 정정)

### Context
- `zdm-api-v2` `origin/2.0.2` HEAD(`00153e7`, 2026-08-20) 기준으로 gitpage 문서 전수 대조.
- 직전 문서 반영 시점(2026-06-01) 이후의 커밋 중 **2026-07-28 보안 강화 커밋(`d6f5112`)** 이 문서에 미반영 상태였음.
- 2026-08-19~20 로깅 개선 커밋군은 응답 status·본문 무변경 → 문서 영향 없음(확인 완료).
- `src/domain/*/schemas/*`, `src/domain/*/dto/*` 78개 파일 전수 diff 대조로 잔여 계약 변경 2건 추가 발굴.

### Added
- `_includes/zdm/ko/api/docs/user/get.md` · `user/update.md` — **403 Forbidden** 신규. 토큰 주체와 `:identifier` 불일치 시 본인 리소스만 접근 허용
- `_includes/zdm/ko/api/docs/cloud-auth/region-list.md` — 에러 응답 · 에러 코드 섹션 신규(401 / 400 platform 화이트리스트)
- `_includes/zdm/ko/api/docs/cloud-auth/zos-download.md` — 에러 응답 · 에러 코드 섹션 신규(401 / 400 `FILE-ERROR-11` / 404 / 500 stream)
- `_includes/zdm/ko/api/docs/file/download.md` — `FILE-ERROR-11` 에러 코드 행 추가
- `_includes/zdm/ko/api/changelog/2.0.2.md` — `Security — 인증·인가 강화` 섹션 + `신규 에러코드` 표(`FILE-ERROR-11`, `RATE-LIMIT-01`) + `PUT /backups/:identifier` schema extension 섹션 신규

### Fixed
- **HTTP 메서드 오기 정정** — `_includes/zdm/ko/api/changelog/2.0.2.md` 의 `PATCH /replications/:id` · `PATCH /os-replications/:id` · `PATCH /recoveries/:id` (총 7곳) → 실제 라우트인 **`PUT`** 으로 정정. 문서대로 PATCH 호출 시 404
- **끊긴 상대 링크 7건 정정**
  - `backup/regist.md` (2곳) — `../overview` → `../schedule/overview`
  - `schedule/regist.md` (2곳) — `../overview` → `./overview`
  - `backup/update.md` · `replication/delete.md` · `os-replication/delete.md` — `./{page}/2.0.1.md`(include 원본, 렌더 페이지 아님) → `../../../2.0.0/docs/...`
  - `changelog/2.0.2.md` — 랜딩페이지에서도 include 되므로 상대 링크를 절대 경로로 전환
- **`PUT /backups/:identifier` 요청 스키마** — `repository.id` 필수 → **선택**. 생략 시 기존 repository 유지, `path` 만 변경 가능 (등록 흐름은 기존대로 필수)
- **`PUT /backups/:identifier` 응답** — `notices?: string[]` 필드 문서화. schedule 을 ID 로만 지정한 경우 안내 메시지 포함, 비어 있으면 키 생략
- **검증 실패(400/422) 응답 예시 4건 정정** — `recovery/regist.md` 3건 · `file/download.md` 1건. 실제 응답은 `error` 에 메시지가 이어붙지 않고 `error` + `detail.validationErrors` 로 분리됨
- **`GET /files/download/:fileName` 404 응답 형식 정정** — `error.code` 가 문자열이 아닌 `{ code, httpCode, message }` 객체로 내려가는 실제 동작 반영 + 공통 형식 미준수 사항 명시
- **Kramdown 렌더 버그** — `file/download.md` 에러 표의 백틱 없는 `<fileName>` 이 HTML 태그로 파싱되어 사라지던 문제 정정
- **랜딩 include 엔드포인트 오기** — `_includes/zdm/ko/api/index.md` 의 `GET /zdm-centers` → `GET /zdms`, `POST /auth/issue` → v2.0.0 이상은 `POST /token/issue` 로 버전 분기
- **CLI os-replication 모드 값 잔재** — `_includes/zdm/ko/cli/docs/os-replication/{list,regist,update,overview}.md` 의 `incremental` → `increment` (총 9곳). 2026-07-08 감사에서 API 측만 정정되고 CLI 측이 누락되어 있었음. 문서대로 호출 시 API 400
- `zdm/ko/api/2.0.2/index.md` — include 인자 `version="2.0.0"` → `version="2.0.2"` (자체 docs 보유 버전이므로 릴리즈 절차 3단계 (B) 기준)

### 참고 (스킵)
- 이전 버전 스냅샷(`_includes/zdm/ko/{api,cli}/docs/**/1.3.1.md`, `**/2.0.1.md`)은 사용자 참조 보존 원칙에 따라 미변경
- 추가 변경은 공용 include 에 `v2.0.2` 인라인 표기로 반영(기존 관행 — 응답 양식 BREAKING 변경만 5단계 버전 분리 적용)
- 배포·환경변수(`ENABLE_SWAGGER`, `CORS_ALLOWED_ORIGINS`, `LOG_LEVEL` 등) 전용 문서 페이지는 사이트에 부재 — 신설 여부 별도 결정 필요

---

## [Fix] - 2026-07-08 (Replication mode 값 `incremental` → `increment` 정정 · License 응답 `id` 필드 보강)

### Context
- 2026-07-08 gitpage sync audit (`zdm-api-v2/orgs/docwriter/reports/2026-07-08-gitpage-sync-audit.md`) 결과 발견.
- v2.0.2 에서 API 는 `increment` 로 엄격 검증 (`VALID_REPLICATION_MODE_VALUES = ["full","increment","sync"]`, `VALID_OS_REPLICATION_MODE_VALUES = ["full","increment"]`, `VALID_REPLICATION_MODE_V1_VALUES = ["full","increment"]`). gitpage docs 는 v2.0.2 스냅샷 이전의 `incremental` 잔재 존재.
- **사용자 impact (GAP-0008)**: 문서 예시대로 호출 시 API 400 리턴.
- **사용자 impact (GAP-0010)**: License get/list/regist 응답에 실제로는 `id: number` 존재 (`src/domain/license/dto/response/license-get-response-base.dto.ts` line 8) 하나 문서 예시 · 필드 표에 누락 → 사용자가 후속 API 호출 (assign / delete) 시 id 취득 방법 불분명.

### Fixed
- `_data/zdm/common/enums.yml` — `replication-v1-modes` (line 133) 와 `replication-modes` (line 149) 의 `incremental` → `increment` (root cause)
- `_includes/zdm/ko/api/docs/replication/regist.md` — 요청 예시 mode 값 2개 치환 (line 50 · line 158 V1 예시)
- `_includes/zdm/ko/api/docs/replication/update.md` — 요청 예시 (line 33) 및 `updatedFields[].new` (line 148) 치환
- `_includes/zdm/ko/api/docs/os-replication/regist.md` — 파라미터 표 mode 선택값 치환
- `_includes/zdm/ko/api/docs/os-replication/list.md` — 쿼리 파라미터 mode 필터 선택값 치환
- `_includes/zdm/ko/api/docs/os-replication/update.md` — 요청 예시 uploadMode + uploadMode/downloadMode 선택값 3곳 치환
- `_includes/zdm/ko/api/docs/license/get.md` — 응답 예시 JSON + 응답 필드 표에 `id: number` (라이선스 ID) 필드 신규 추가
- `_includes/zdm/ko/api/docs/license/list.md` — 페이지네이션 미적용 / 적용 양쪽 응답 예시 + 응답 필드 표에 `id` 필드 추가
- `_includes/zdm/ko/api/docs/license/regist.md` — 응답 예시 + 응답 필드 표에 `id` 필드 추가

### 참고 (스킵)
- 이전 버전 스냅샷 (`_includes/zdm/ko/api/docs/*/1.3.1.md` 등) 은 사용자 참조 보존 원칙 (별도 조사 · GAP-0011)
- v2.0.3 Observability (`X-Trace-Id`, PII 마스킹 등) 은 v2.0.3 릴리스 sign-off 시점에 반영 (GAP-0009)

### 관련 자료
- QA 리포트: `zdm-api-v2/orgs/qa/reports/2026-07-08-cli-api-dto-consistency.md`
- Docwriter 리포트: `zdm-api-v2/orgs/docwriter/reports/2026-07-08-gitpage-sync-audit.md`
- 도메인 파일 (zdm-api): `src/domain/replication/data/const-value.ts`, `src/domain/os-replication/data/const-value.ts`, `src/domain/license/dto/response/license-get-response-base.dto.ts`

---

## [Documentation] - 2026-06-10

### Changed
- **ZDM-API v2.0.2 changelog 갱신** — `_includes/zdm/ko/api/changelog/2.0.2.md` 에 os-replication 통합 + id 보강 반영:
  - summary 라인에 "OS-Replication schedule 지원 신설" 추가
  - **Schedule 응답 형식 통일 표** — 도메인별 응답 위치 표 에 `POST /os-replications` + `PATCH /os-replications/:id` 행 신규 추가 → **5 endpoint → 7 endpoint**
  - **Replication / OS-Replication schedule 처리 신설** 섹션 — 기존 "Replication schedule 신설" 만 있던 것을 OS-Replication 도 함께 안내. os-replication 의 jobMode 차이 (sync 미지원) 표시
  - **4 도메인 완전 일관성** 안내 — backup / recovery / replication / os-replication 모두 동일 schedule 처리 + 응답 형식
- **사실 정정** — 이전 안내가 4 도메인 통일이라 했으나 실제로는 os-replication 이 미구현 상태였음. 본 갱신으로 4 도메인 일관성 진정 확보.

---

## [Documentation] - 2026-06-09

### Changed
- **ZDM-API v2.0.2 changelog 갱신** — `_includes/zdm/ko/api/changelog/2.0.2.md` 에 본 세션의 사용자 facing 변경 4건 추가. summary 라인도 갱신:
  - **Schedule 응답 형식 4 도메인 통일** — backup-regist / recovery-regist / replication-regist / backup-update 모두 동일 객체 형식 `{ id, type, description }`. 응답 형식 통일을 위해 공용 `describeSchedule` (`src/domain/schedule/utils/schedule-describer.utils.ts`) 도입. type 출처는 `displayMappings` (`"Daily"` / `"Smart Weekly (...)"` 등 PascalCase 영문), description 은 `processScheduleInfo` (`[Basic] Start working at ...` 영문). 4 endpoint 별 응답 위치 표 + 클라이언트 영향도 표 정리. **ScheduleChangeValue 의 type 값 기존 안내(`"daily"` lowercase alias) → `"Daily"` displayMappings 로 정정**, description 기존 안내("매일 03:00 실행" 한국어) → `"[Basic] Start working at 03:00 every day."` 영문으로 정정.
  - **Replication schedule 처리 신설** — `POST /replications` / `PATCH /replications/:id` 의 body schema 에 정의되어 있던 schedule 필드가 그동안 service 에서 무시되던 문제 해결. basic schedule 지원, 모든 jobMode (full/increment/sync) 허용, smart 차단(400). 응답에 schedule 객체 노출 (이전엔 정보 부재).
  - **Recovery 등록 시 backup 없는 partition 자동 skip + notices** — `POST /recoveries` 호출 시 source 의 partition 중 backup 없는 partition 자동 skip + 응답 `notices` 안내. silent skip 대상은 `Job.Common.NOT_FOUND` 만 (BAD_REQUEST / Zdm.Repository.NOT_FOUND 는 throw). 전체 skip 시 NOT_FOUND throw. listOnly true/false 모두 적용. Windows source C/D/E 중 C만 backup 케이스 예시 동봉.
  - **Backup/Recovery Update Status diff `previous` 정확화** — `PUT /backups/:id` / `PATCH /recoveries/:id` 응답의 Job Status 변경 detail 의 `previous` 가 DB raw 값("Complete") 이 아닌 UI 와 동일한 `calculateJobStatus()` 결과("Registered" 등) 로 표시되도록 정정. current 는 사용자가 보낸 status 문자열 그대로 echo.
- **운영 개선 섹션 확장** — 공용 schedule describer / Replication diff-builder + field-mutator 패턴 / schedule-verify replication 분기 신설 (단일 진실원) 항목 추가.

---

## [Documentation] - 2026-06-01

### Added
- **ZDM-API v2.0.2 신규 버전 추가 (부분 갱신 릴리즈)** — `_data/zdm/common/versions.yml` 의 `api:` 최상단에 v2.0.2 추가(`status: latest`, `docs: "2.0.2"`, downloads `/downloads/zdm-api/2.0.2/zdm-api-linux.tar.gz`). 기존 v2.0.1 → stable 강등. 신규 intro 페이지 `zdm/ko/api/2.0.2/index.md` + 80+ wrapper (`zdm/ko/api/2.0.2/docs/**/*.md`, v2.0.0 통째 복사 + `navigation` 키 일괄 `ko-api-2.0.2` 치환). `_data/navigation.yml` 의 `ko-api-2.0.2:` 신규 섹션(182 line, 75 URL) 추가 + `ko-zdm` 메인 링크 `ZDM-API 문서` URL → `/zdm/ko/api/2.0.2/index`. `zdm/ko/api/index.md` 의 redirect / window.location / refresh meta 3곳 모두 `/zdm/ko/api/2.0.2/index` 로 갱신.
- **ZDM-API v2.0.2 changelog include 신규 생성** — `_includes/zdm/ko/api/changelog/2.0.2.md`. 사용자 facing 변경 2건 + 운영 개선 한 줄 요약 (BREAKING 응답 양식 통일 + Schema Extension Schedule detail 구조). 1) **BREAKING**: `DELETE /replications/:identifier` 와 `DELETE /os-replications/:identifier` 응답이 `{ deletedJob, deletedRelations }` → backup/recovery 와 동일한 `{ jobInfo[] + summary }` 구조로 교체. atomic transaction 특성으로 `state` 는 항상 `"success"`, `deletedComponents.*` 모두 true. `partition` / `errorMessage` 키 부재 (replication 미사용 / atomic throw). 기존 `deletedJob.id` 제거. 2) **Schema Extension**: `PUT /backups/:identifier` 응답의 `summary.updatedFields[]` 중 Schedule 계열 (`Schedule` / `Schedule(Basic)` / `Schedule(Advanced)`) 의 `previous` / `new` 가 단순 ID(숫자) → `{ id, type, description }` 객체로 확장. id ≤ 0 → `null`. schedule 자동 복제(1 schedule = 1 job 원칙) 시 `notices` 안내 메시지. ScheduleChangeValue 의 `type` 은 lowercase short alias (`daily`/`weekly`/`monthly_date`/`smart_*` 등). 그 외 필드 응답 형식 변경 없음. 클라이언트 영향도 표 동봉. 운영 개선 항목으로 내부 아키텍처 정비(Modular Monolith + DDD-lite 3계층 통일, port/adapter 폐기, infrastructure/persistence → repository 디렉토리 단순화, dependency-cruiser 도입)는 "외부 API 변경 없음" 한 줄로 요약.
- **ZDM-API v2.0.2 문서 컨텐츠 수정 — 변경된 3 파일 + 이전 버전 보존본 분리** (CLAUDE.md 5단계 절차).
  - `_includes/zdm/ko/api/docs/replication/delete.md`: 응답 예시 + 응답 필드 표를 `jobInfo[] + summary` 양식으로 교체. v2.0.2 변경 사항 안내 박스 + 이전 양식 링크([v2.0.1](./delete/2.0.1.md)) 추가. partition / errorMessage 키 부재 안내.
  - `_includes/zdm/ko/api/docs/os-replication/delete.md`: 동일 패턴. 응답 필드 표 신규 추가 (기존엔 없었음).
  - `_includes/zdm/ko/api/docs/backup/update.md`: 응답 예시의 `updatedFields[]` 배열에 Schedule 케이스 + `notices[]` 안내 메시지 추가. 응답 필드 표에 ScheduleChangeValue 구조 (id / type / description) 별도 표 + previous/new union 타입 (`any | ScheduleChangeValue | null`) 명시.
  - 이전 버전 보존본 분리 — `_includes/zdm/ko/api/docs/{replication,os-replication}/delete/2.0.1.md` 와 `_includes/zdm/ko/api/docs/backup/update/2.0.1.md` 신규 (직전 공용 파일 그대로 복사). `zdm/ko/api/2.0.0/docs/{replication,os-replication}/delete.md` 와 `zdm/ko/api/2.0.0/docs/backup/update.md` 의 include 경로 3곳을 신 보존본 (`.../2.0.1.md`) 으로 변경 — v2.0.0 / v2.0.1 페이지가 이전 양식 그대로 보존됨 (v2.0.1 은 `docs: "2.0.0"` 재사용 패치이므로 v2.0.0 wrapper 갱신만으로 함께 보존).
- **메인 랜딩페이지 ZDM-API 섹션 — 독립 details 블록 추가 (부분 갱신 릴리즈 정책 8단계)** — `zdm/ko/index.md` 의 `## 업데이트 목록` > `### ZDM-API` 헤더 latest 배지 `v2.0.1` → `v2.0.2 (2026-06-01)`. 신규 v2.0.2 독립 details 블록을 ZDM-API 섹션 최상단에 추가 (v2.0.0 details 위). 부분 갱신 릴리즈는 patch 배지 병기가 아닌 독립 details 가 정책 (CLAUDE.md 8단계 표). v2.0.0 details 는 v2.0.0 + patch v2.0.1 (재사용 패치) 그대로 유지.
- **ZDM-CLI v2.0.1 / v2.0.2 changelog include 신규 생성** — `_includes/zdm/ko/cli/changelog/{2.0.1,2.0.2}.md`. `/project/zdm-cli-v2/CHANGELOG.md` 의 `[2.0.1]` 3개 헤더(2026-05-20/21) 와 `[2.0.2]` 4개 헤더(2026-05-28/29) 를 사용자 facing 변경 위주로 통합 정리.
  - **v2.0.1**: `--interactive` 신규 도입(`schedule create`, `backup regist`) / `backup monit` 출력 개편(`--log` 옵션 + message 한 줄) / `backup monit --server-*` description 정정 / `backup update --schedule*` description 보강 / `backup regist --mode` 기본값 `full` / `backup regist --ind` Individual JSON 예시 enum 정정 / Node 빌드 v18→v22 hotfix
  - **v2.0.2**: `schedule create --interactive` type 별 정밀 분기 / `replication·os-replication delete` 응답 양식 통일 / `backup monit` message status 별 placeholder / dependency-cruiser 도입
- **CLI v2.0.1 / v2.0.2 intro 페이지 신규 생성** — `zdm/ko/cli/{2.0.1,2.0.2}/index.md`. 재사용 패치 패턴(`navigation: ko-cli-2.0.0` + `version="2.0.0"` 재사용 + changelog 만 분기) 적용. 버전 셀렉터 드롭다운에서 v2.0.1, v2.0.2 가 보이며 클릭 시 해당 intro 로 진입.

### Changed
- **`_data/zdm/common/versions.yml` cli 섹션 갱신** — `v2.0.2` 를 `status: latest` 로 신규 추가, `v2.0.1` 을 `stable` 로 추가, `v2.0.0` 은 `latest → stable` 로 강등. v2.0.1/v2.0.2 모두 `docs: "2.0.0"` 재사용 패치. 다운로드 파일도 v2.0.0 디렉토리 재사용 (별도 빌드 산출물 미배치).
- **`zdm/ko/index.md` ZDM-CLI 섹션 갱신**:
  - 헤더: `latest v2.0.0 (2026-04-17)` → `latest v2.0.2 (2026-05-29) · base v2.0.0 (2026-04-17) · patch v2.0.1 (2026-05-21)`
  - v2.0.0 details summary 에 `patch v2.0.1`, `patch v2.0.2` 배지 병기
  - 메인 문서 링크에 `[v2.0.2 문서 바로가기]` 병기 (재사용 패치가 latest 일 때 latest intro 로 가도록 — CLAUDE.md 167~168 규정)
  - changelog include 3개(`2.0.2.md` / `2.0.1.md` / `2.0.0.md`) 시간 역순 노출
- **`zdm/ko/cli/index.md` 리다이렉트 갱신** — `redirect_to` / `window.location.href` / `<meta refresh>` / 하단 링크 모두 `/zdm/ko/cli/2.0.0/index` → `/zdm/ko/cli/2.0.2/index` (6단계).
- **`/project/zdm-cli-v2/CHANGELOG.md` 헤더 표기 통일** — `[2.0.2_edit_*]` 형식 4개 헤더(`_edit_delete-uniform`, `_edit_arch`, `_edit_C3`, `_edit_C2`) 를 모두 `[2.0.2]` 로 변경.

### Notes
- CLI docs 본문(`_includes/zdm/ko/cli/docs/**`)은 변경 없음 — v2.0.1/v2.0.2 모두 docs 재사용 패치. `backup monit --log` 등 신규 옵션의 docs 본문 반영은 별도 작업 필요 시 분리.
- 다운로드 바이너리도 v2.0.0 빌드 재사용 — v2.0.2 별도 빌드 산출물이 배치되면 `versions.yml` 의 `downloads[].file` 경로만 갱신.

### Improved (자동화)
- **6단계 리다이렉트 라우터 Liquid 자동화** — `zdm/ko/cli/index.md`, `zdm/ko/api/index.md` 의 latest 버전 URL 을 Liquid 변수(`latest = ... | where: "status","latest" | first`) 로 자동 추출하도록 재작성. frontmatter `redirect_to:` 제거 (jekyll-redirect-from 플러그인 미사용으로 사실상 메타데이터일 뿐). **이제 새 버전 출시 시 두 파일은 갱신 불필요 — `versions.yml` 만 갱신하면 4곳(JS 리다이렉트 / meta refresh / 하단 링크 / 과거 frontmatter) 모두 자동 반영.**
- CLAUDE.md 6단계 가이드 업데이트 — "갱신 필요" → "자동 (별도 갱신 불필요)" 로 변경, 새 라우터 템플릿과 jekyll-redirect-from 도입 시 주의사항 명시.

### Fixed (후속 누락 보정)
- **`_data/navigation.yml` `ko-zdm` 메인 사이드바의 "ZDM-CLI 문서" 링크** — `/zdm/ko/cli/2.0.0/index` → `/zdm/ko/cli/2.0.2/index` 로 갱신. 사이드바에서 클릭 시 v2.0.0 으로 빠지던 문제 정정. (API 메인 링크는 이전 작업에서 v2.0.2 로 이미 갱신된 상태였음 — CLI 만 누락)
- **`zdm/ko/index.md` ZDM-CLI 헤더 표기 단순화** — `latest v2.0.2 (2026-05-29) · base v2.0.0 (2026-04-17) · patch v2.0.1 (2026-05-21)` → `latest v2.0.2 (2026-05-29)` 로 단순화. ZDM-API 헤더(`latest v2.0.2 (2026-06-01)`) 와 표기 일관성 통일. patch 이력은 details summary 의 배지로 그대로 보존.
- **CLI v2.0.2 전용 사이드바 + docs wrapper 신설 (UX 정정)** — v2.0.2 intro 에서 사이드바 항목 클릭 시 `/zdm/ko/cli/2.0.0/docs/...` 로 빠지던 문제 정정 (CLAUDE.md 재사용 패치 정책 그대로의 결과였으나 사용자 입장에서 최신 버전 URL 로 가는 게 자연스럽다는 판단).
  - **`_data/navigation.yml`** — `ko-cli-2.0.2` 섹션 신설 (`ko-cli-2.0.0` 복제 + URL 일괄 `/cli/2.0.0/` → `/cli/2.0.2/`)
  - **`zdm/ko/cli/2.0.2/docs/`** — 64개 wrapper 신설 (2.0.0/docs 복제 + frontmatter `navigation: ko-cli-2.0.0` → `ko-cli-2.0.2`). 실제 본문은 `_includes/zdm/ko/cli/docs/...` 동일 include 재사용으로 0줄 중복
  - **`zdm/ko/cli/2.0.2/index.md`** — `navigation: ko-cli-2.0.0` → `ko-cli-2.0.2`
  - v2.0.1 은 patch stable 이라 그대로 base v2.0.0 사이드바 공유 — v2.0.2 (latest) 만 처리

### Fixed (CI 빌드 안정성)
- **`Gemfile.lock` git 추적 활성화 (`.gitignore` 에서 제거) + `x86_64-linux` 플랫폼 보강** — GitHub Actions 빌드의 `sass-embedded` 컴파일 실패 (`exit code 5`) 영구 해결.
  - **근본 원인**: `Gemfile.lock` 이 `.gitignore` 에 등재되어 git 추적 안 됨 → GitHub Actions 매 빌드마다 lock 없이 `bundle install` → fresh resolve 시 transitive 의존 `sass-embedded` 최신(1.100.0) 가져옴 → Ruby 3.1.7 환경에서 native 컴파일 실패.
  - **트리거**: `actions/setup-ruby` 의 `bundler-cache: true` 가 평소엔 캐시 hit 으로 잠재 문제를 가려왔으나 캐시 만료 + sass-embedded 신버전 게시 타이밍이 겹치며 노출.
  - **조치**:
    - `.gitignore` 에서 `Gemfile.lock` 라인 제거 — Jekyll 사이트는 애플리케이션이므로 lock commit 이 Bundler 공식 표준
    - `Gemfile.lock` 의 `PLATFORMS` 에 `x86_64-linux` 추가 (`bundle lock --add-platform x86_64-linux`)
    - `sass-embedded (1.69.5-x86_64-linux-gnu)` precompiled variant 라인 추가 — Bundler 가 source 컴파일 없이 RubyGems 의 native binary 다운로드
  - **효과**: 캐시 만료 / sass-embedded 신버전 게시 / Ruby 마이너 버전 변동과 무관하게 항상 1.69.5 의 linux precompiled binary 사용. 빌드 재현성 보장.

### Improved (절차서 보강)
- **CLAUDE.md 3단계 (D-2) 신설 — "latest 인 재사용 패치 시 사이드바·wrapper 분리"** — 본 작업(v2.0.2 nav 섹션 + 64개 wrapper 신설) 의 트리거 조건/자동화 명령/검증 항목을 절차서로 명문화. 적용 조건 표(메이저·마이너 / stable patch / latest patch) 로 어디까지 적용하는지 명확화. stable patch 는 base 사이드바 공유 유지 정책 명시. 향후 latest patch 출시 시 명령 복붙으로 처리 가능.
- **CLAUDE.md 3단계 (D) 박스 보조 안내 추가** — "단, 재사용 패치가 `status: latest` 인 경우는 예외 — (D-2) 절차로 분리" 한 줄로 (D) 와 (D-2) 의 분기 트리거 환기.

---

## [Documentation] - 2026-05-19

### Fixed
- **schedule 도메인 5개 액션 상세 동기화** — `_includes/zdm/ko/api/docs/schedule/{overview,list,get,regist,delete}.md`
  - 5개 액션 전수 점검, 총 42건 patch 적용 (Blocker 10 / Missing 13 / Outdated 10 / Info 25)
- **공통 Blocker 패턴**
  - **`type`/`state` 응답값 케이스 정정** (`GET /schedules` / `GET /schedules/:identifier`): 문서는 소문자(`daily`/`enabled`)였으나 실제 응답은 PascalCase (`Daily`/`Enabled`/`Smart Custom (Specific Month and Date)` 등) → 본문 표·예시 정정
  - **`description` 동적 생성 반영** (list / get / delete): 응답 `description`은 `[Basic]`/`[Advanced]` prefix가 붙은 영문 문장 → 본문 표·예시 정정
  - **list `type` 쿼리 enum 형식 명확화**: 기존 표 값(숫자/타이틀케이스)으로는 호출 실패. 소문자(`daily`) 또는 정확한 원문(`Smart Custom (Specific Month and Date)`)만 허용 → 표 수정 + URL encoding 안내 추가
- **액션별 단발 Blocker**
  - **overview**: 타입 0~11 정의 / smart 규칙 / 요일 변환 표 신규 작성
  - **`POST /schedules`**: `basic` 필드 본문 표 Optional 표기 ↔ 실제 누락 시 400 응답 (문서 자기모순) → required 정정
  - **`GET /schedules/:identifier`**: 응답 필드 표에 `type`/`state` enum 선택값·`Unknown` fallback 안내 부재 → 보강
- **`POST /schedules` Outdated 4건** — Center NOT_FOUND / Smart 다중요일 / 시간 형식 / `type` 범위 에러 메시지가 한글로 적혀 있었으나 실제 출력은 영문 + HTTP 코드 일부 부정확(409→400, 422→400) → 정정

### Added
- **schedule 도메인 예시 케이스 47건 신규 추가** — 응답 분기·검증 실패 케이스별 종합 예시
  - **`POST /schedules` 21건**: type 0~11 각각의 요청 body JSON + 정상 응답 JSON + 8가지 검증 실패 응답 예시 (basic 누락, smart에 advanced 누락, single value 제약 위반, time 누락, DTO 검증 실패, Center NOT_FOUND 등)
  - **`GET /schedules` 9건**: 쿼리 조합 6가지(기본 / `type=daily` / `type=Smart Custom (...)` URL encoding / `center=1,3,5` 다중 / `page=2&limit=20` / `id=15`) + 페이지네이션 적용·미적용 응답 분기 + 빈 결과
  - **`GET /schedules/:identifier` 6건**: basic 타입 / smart 타입 / Unknown fallback 응답 + 404 / 422 / 403 에러 응답 JSON
  - **`DELETE /schedules/:identifier` 5건**: 정상 응답 + 404 / 403 / 409 에러 응답 + `SCHEDULE_IN_USE` 메시지의 정확한 형식(`backup(N), recovery(N), replication(N)`, 0 카운트는 생략)
  - **overview 6건**: 타입별 basic/advanced 구조, 응답 description 변환표, 요일 변환 예시
- **`POST /backups` schedule 동봉 예시 20건 추가** — `_includes/zdm/ko/api/docs/backup/regist.md`
  - 정상 등록: schedule 미동봉(즉시 1회 실행), basic type 1/2/3, smart type 7/11, schedule ID 참조
  - 검증 실패 응답: smart 모드인데 schedule 누락 / smart type에 advanced 누락 / 잘못된 type 범위 / basic 단일값 위반 / Center NOT_FOUND
  - 동작 안내: smart 모드 schedule 필수 정책, mode↔schedule 교차 변경 자동 전환 정책, inline schedule 객체 vs schedule ID 참조 우선순위
- **`POST /recoveries` schedule 동봉 예시 15건 추가** — `_includes/zdm/ko/api/docs/recovery/regist.md`
  - 정상 등록: schedule 미동봉(즉시 1회 실행), basic type 0/1/2/6, schedule ID 참조
  - **smart 거부 케이스 명시**: schedule type 7~11(smart) 동봉 시 거부 응답 (정확한 HTTP 코드 + 메시지)
  - 일반 검증 실패: basic 필수 필드 누락, 잘못된 type 범위, Center NOT_FOUND
  - 동작 안내: **Recovery는 smart schedule 미지원** (basic 타입 0~6만 허용), schedule 미동봉 시 즉시 1회 실행 동작, `autoStart` 옵션과의 상호작용
- **`POST /backups` 혼합 schedule ID 참조 예시 4건 추가** — 객체 + basic·advanced 부분 ID 조합 지원 케이스
  - 정상 케이스 3건: basic만 ID(`{ "type": 1, "basic": 15 }`) / smart 양쪽 모두 ID(`{ "type": 7, "basic": 15, "advanced": 16 }`) / smart basic 새 객체 + advanced ID
  - 검증 실패 1건: 부분 ID 미존재 시 응답
  - 동작 안내: 부분 ID도 전체 ID와 동일하게 참조 schedule 데이터를 새 schedule 레코드로 INSERT (응답 schedule ID는 입력 ID와 다른 새 ID)
- **`POST /recoveries` 부분 schedule ID 참조 예시 3건 추가** — basic만 ID 조합 지원 케이스
  - 정상 케이스 1건: basic만 ID(`{ "type": 3, "basic": 15 }`) — basic type 0~6 모두 동일 동작 (type 1·3·5 등은 같은 코드 경로라 단일 예시로 통합)
  - 검증 실패 1건: basic ID 미존재 시 응답
  - 동작 안내: Recovery는 smart 미지원이므로 `advanced` 필드 자체 사용 안 함, 부분 ID는 `basic`에만 적용
- **공개 에러 코드 정정 — 부분 ID 미존재 경로** (backup / recovery 양쪽)
  - 코드 검증 결과 전체 ID(`"schedule": 999`) 경로는 `JOB-ERROR-100` / 404를 그대로 노출하지만, 부분 ID(`schedule.basic: 999`) 경로는 **`SCHEDULE-ERROR-01` / 404** (`Schedule ID '999' not found.`)가 정확한 코드. 두 경로의 차이를 에러 코드 표·예시에 분리 명시
  - `JOB-ERROR-108` (`INVALID_SCHEDULE_MODE`)도 smart 부분 ID에서 selection-bit 불일치 시 발생 가능 — backup 안내 박스에 흡수

### Notes
- 이전 2026-05-15 schedule 항목들은 모두 반영 완료 확인 (외부 응답 변경 없음)
- backup/recovery의 schedule 동봉 흐름은 schedule 도메인의 type 0~11 정책을 그대로 따르되, recovery는 smart 타입(7~11) 거부 정책이 별도 적용
- schedule ID는 전체 / 부분 어느 형태든 참조 시 새 schedule 레코드로 INSERT — 응답에 입력 ID와 다른 새 ID 노출되는 동작은 의도된 동작이며 양 도메인 공통
- 총 변경량 131건 (patch 42 + schedule 예시 47 + backup schedule 예시 20 + recovery schedule 예시 15 + backup 혼합 ID 예시 4 + recovery 부분 ID 예시 3), 실패 0건. 변경량이 크므로 빌드 후 시각적 검증 권장

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
