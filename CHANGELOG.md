# Changelog

모든 주요 변경 사항이 이 파일에 기록됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 합니다.

---

## [Documentation] - 2026-09-04 (backup 전수조사에 따른 API 계약 변경 반영)

### Context
- `backup` 도메인 전수조사(B1~B32)로 삭제·수정·등록·모니터링 경로의 계약이 바뀌었다.
  코드는 반영됐으나 사용자 문서가 옛 계약을 그대로 설명하고 있었다.

### Changed
- **`backup/monitoring-system.md`** — server 기준 모니터링의 계약 변경을 반영
  - 등록된 작업이 없거나 `status` 필터로 0건이 된 경우: **`404` → `200` + 빈 `job` 배열**.
    기존 `JOB-ERROR-01` 404 예시 2개를 제거하고, 남는 404 는 **서버 자체를 못 찾은 경우**임을 분리해 명시
  - **파티션당 한 건만 노출되던 것이 전 작업 반환**으로 바뀐 사실을 개요에 추가
  - `job[].log` 는 **`detail=true` 일 때만** 채워짐을 응답 필드 표에 명시
  - `summary.canceled` 필드 추가 (응답 필드 표 + 예시 3곳)
  - `summary.overallProgress` 는 진행 중인 작업이 없으면 **`"-"`** — `"0%"` 를 쓰지 않는 이유 병기
  - 400(데이터 불완전)은 **server 기준 조회에서 발생하지 않음**을 명시 — 결손 작업만 목록에서 빠진다
- **`backup/monitoring-job.md`** — `job.log` 도 `detail=true` 전용임을 명시 (server 기준과 같은 규칙)
- **`backup/delete.md`** — **409 `CONFLICT`** 신설. 이름으로 삭제할 때 같은 center 안에 동명 작업이
  2개 이상이면 아무것도 지우지 않고 거부하며, 메시지의 작업 ID 목록으로 재요청하도록 안내
- **`backup/update.md`** — 작업 **ID** 로 수정할 때도 `center` 를 대조해 불일치 시 404 임을 404 절에 병기.
  종전에는 ID 경로가 `center` 를 받기만 하고 조회에 쓰지 않아 다른 center 의 작업이 수정됐다
- **`backup/regist.md`** — 이름 중복 검사가 **등록 직전에 한 번 더** 수행되며, 같은 이름을 동시에
  등록하려는 요청이 겹치면 뒤의 요청이 409 를 받는다는 설명 추가

- **`backup/list.md`** — ① **center 가 다른 동명 작업이 각각 나온다**는 사실을 개요에 추가.
  종전에는 목록을 작업 이름으로 묶어 같은 이름의 작업 하나가 빠지고 남은 하나에 다른 작업의 상세가 붙을 수 있었다
  ② `job.info.status.current` 에 잔존 진행 행 보정 설명 병기
- **`backup/delete.md`** — `summary.state` 의 값에 **`not_found`** 추가. 예전부터 나가던 값인데 문서에만 빠져 있었다
- **`backup/monitoring-system.md`** (추가분) — ① `server` 파라미터가 **이 경로에서는 무시된다**는 사실과,
  **존재하지 않는 서버 값을 넣어도 더 이상 404 가 아니라는 점** 명시 ② `progressInfo.status` 에
  잔존 진행 행 보정(종전엔 영구 `Processing`) 설명 병기
- **`cli/docs/backup/monit.md`** — 파라미터 표에 **`--log`(`-l`)** 추가. 문서에 아예 빠져 있던 옵션이다.
  **`--log` 는 표시 토글이 아니라 서버에서 로그를 받아올지까지 결정한다**는 점을 주석으로 명시
  (미지정 시 API 가 `detail` 을 못 받아 로그 구간이 빈다). text·json 출력 예시에 `canceled` 반영

### Notes
- `backup/list.md` 의 `repositoryID` 필터는 **문서 변경 없음** — 문서는 원래 맞았고 코드가 무시하고 있었다.
  이제 실제로 동작한다.
- `monitoring-system.md` 의 `sort` 미지원 안내는 종전 그대로다 — 스키마에서도 제거됐다.

---

## [Documentation] - 2026-09-04 (진행률 100% 인데 상태가 Processing 인 것은 모순이 아님을 모니터링 문서에 명시)

### Context
- 같은 작업을 웹은 `Processing`, API 는 `Complete` 로 표시하던 제보가 있었다. 대상 VM 은 복구가 끝나고
  **재부팅 이전** 단계였고 작업은 아직 끝나지 않았다 — **웹이 맞았다.**
- 원인은 진행 행의 의미다. 데몬은 복구에서 **파티션마다 진행 행을 하나씩** 두는데, 그 행이 종료 단계여도
  그건 **그 파티션의 복사가 끝났다**는 뜻이지 작업 전체의 종료가 아니다. 복사 뒤에 재부팅 같은 후속 단계가
  남는다.
- 구현을 정본으로 삼아 `zdm-api-v2/src/utils/job/calculate-job-status.utils.ts` 를 먼저 읽었다. 종료 단계
  분기(백업 306·307 / 복구 404 / 이미지 복제 502)가 본체(`sJobResult`/`nJobStatus`)가 진행 중이라고 말하면
  완료를 선언하지 않고 본체 기반 판정으로 내려간다. 본체가 실패로 종결된 경우도 같은 분기에서 걸러 `Error`
  로 나간다.

### Changed — `api/docs/recovery/monitoring-job.md` · `monitoring-system.md`
- 응답 필드 표의 `job.progress.status` / `job[].progress.status` 행 설명에 **작업 본체가 정한다**는 점과,
  행이 종료 단계에 들어가도 본체가 진행 중이면 `Processing` 이라는 점을 덧붙였다. "행은 완료를 선언하지
  않는다" 라고 넓게 쓰지 않았다 — 같은 문서의 `partitions[].status` 판정 규칙 표가 "작업 전체에 진행 정보가
  하나도 없으면 행의 상태 = 작업 상태" 라고 적고 있고, 구현도 본체가 진행 중·실패가 아닐 때는 종료 단계 행이
  그대로 완료를 낸다. 본체는 **덮어쓸 뿐**이므로 그만큼만 적었다.
- 두 문서에 이미 있던 **"`partitions[]` 는 파티션마다 다른 값을 냅니다"** 문단을 확장했다. 종전에는 "끝난
  파티션과 시작하지 않은 파티션이 함께 나오는 것이 정상" 까지만 적혀 있었는데, 그 반대 방향 — 행이 전부
  `Complete` 여도 작업이 끝난 것은 아니라는 점 — 을 이어서 적었다.
- 작업 단위 `percent` 표기 규칙 아래의 참고 blockquote 에 한 문단을 더했다.
  **`percent` 가 `"100%"` 인데 `status` 가 `Processing` 인 것은 모순이 아니라는 것**, 진행률과 상태의
  출처가 다르다는 것, 완료 판정은 `status` 로만 하라는 것을 적었다. 바로 아래 파티션 단위 참고가 쓰는
  "…모순이 아닙니다" 어법을 그대로 맞춰 두 참고가 형제로 읽히게 했다.
- **작업 단위 `percent` 를 파티션 행으로 설명하지 않았다.** 같은 문서가 세 곳에서 그 값은 데몬이 세어 둔
  복구 완료 개수에서 나오며 `partitions[]` 로는 재현되지 않는다고 못 박고 있다. "파티션이 전부 100% 라서
  작업 진행률이 100%" 라고 쓰면 몇 줄 옆의 서술과 정면으로 어긋난다. 두 사실을 **본체가 잇는** 형태로 적었다.

### Changed — `api/docs/backup/monitoring-job.md` · `monitoring-system.md`
- 응답 필드 표의 `progressInfo.status` 행에 진행 정보가 종료 단계여도 본체가 진행 중이면 `Processing` 이라는
  점을, `progressInfo.percent` 행에 `"100%"` + `Processing` 이 모순이 아니라는 점을 넣었다. 두 문서에는 응답 필드 표 뒤에 참고 blockquote 를
  두는 관례가 없어 **없는 절을 새로 만들지 않고 표 행 설명을 확장**했다.
- 백업 문서에는 **파티션 어휘를 쓰지 않았다.** 백업은 작업당 진행 행이 하나이고 응답에 `partitions[]` 가
  없다 (`percent` 는 그 행의 `nPercent` 를 그대로 쓴다). "진행 정보" 로 부르고, 후속 단계도 **이름을 붙이지
  않고** "후속 단계" 로만 적었다 — 재부팅은 제보로 확인된 복구 쪽 사실이라 백업에 옮겨 적을 근거가 없다.

### Changed — `api/changelog/3.0.0.md`
- 기존 **응답 값 변경** 블록에 두 줄을 더했다. 새 `BREAKING` · `동작 변경` 절을 만들지 않은 것은 두 항목 모두
  필드 하나의 값이 달라지는 변화(`Complete` → `Processing`, `Complete` → `Error`)이고, 같은 블록에 이미
  버그 수정 성격의 항목(`dates.created` 가 실제 생성일을 반환)이 같은 형식으로 들어 있기 때문이다.
- 2.x 대비 델타로 본 근거는 **코드 변경 자체**다. 본체를 보는 가드가 이번에 새로 들어갔으므로 그 이전에는
  종료 단계 행이면 무조건 완료로 나갔다. (2.0.2 스냅샷이 이 동작을 적지 않았다는 사실은 근거로 쓰지 않았다 —
  문서의 침묵은 동작의 증거가 아니다.)
- 요약 줄(`<summary>`)은 건드리지 않았다. 그 줄은 BREAKING·신규 항목만 싣고 응답 값 변경 항목은 싣지 않는다.

### Notes
- **넣지 않은 문서**: `api/docs/{backup,recovery}/get.md` · `list.md`. 네 문서 모두 `job.info.status.current`
  는 싣지만 **작업 단위 `percent` 를 싣지 않는다** (`percent` grep 결과 0건). 진행률이 없는 화면에서는
  "100% 인데 Processing" 이라는 오해가 생길 자리가 없어 제외했다.
- **`replication` · `os-replication` 모니터링 문서도 넣지 않았다.** 이미지 복제 종료 단계(502)가 같은 가드
  아래 있지만, 두 도메인의 monit 응답 DTO 는 `calculateJobStatus` 를 부르면서 `jobResult` · `jobStatus` 를
  **명시적으로 `undefined` 로 넘긴다.** 유틸은 본체 정보가 없는 호출의 동작을 바꾸지 않으므로 두 경로의
  동작은 종전과 같다 — 적을 델타가 없다.
- **공유 include 확인 결과: 누수 없음.** `_includes/zdm/ko/api/docs/{backup,recovery}/monitoring-*.md` 의
  맨 경로를 참조하는 wrapper 는 `zdm/ko/api/3.0.0/docs/...` 뿐이고, 1.0.3 ~ 2.0.2 wrapper 는
  `monitoring-job/<버전>.md` · `monitoring-system/<버전>.md` 스냅샷을 가리킨다. `changelog/3.0.0.md` 도
  `zdm/ko/index.md` 의 3.0.0 섹션과 3.0.0 index 에서만 include 된다.
- **JSON 파싱 검증**: 손댄 네 문서의 ` ```json ` 블록 28개(복구 8+8, 백업 5+7) 전부 파싱 통과. 예시는 하나도
  건드리지 않았고 산문만 더했다. `changelog/3.0.0.md` 의 블록 하나(`scan` 절의 키-값 발췌)는 원래부터 완전한
  문서가 아닌 조각이며 이번 편집과 무관한 자리다.

---

## [Documentation] - 2026-09-04 (단건 모니터링 `--status` 정리와 backup 작업 기준 파라미터 표 정정)

### Context
- API 가 단건 모니터링 경로에서 `status` 를 제거한 데 맞춰 CLI 도 정리됐다. 구현을 정본으로 삼아
  `commands/{backup,replication,os-replication,recovery}/subCommands/monit/` 의 옵션 정의와
  요청 query 빌더를 모두 읽어 확인했다.
- `replication monit` 은 `--status` 가 **제거**됐다. CLI 는 yargs `.strict()` 라 그대로 둔 스크립트는
  조용히 무시되지 않고 파싱 단계에서 즉시 실패한다 (도움말 출력 + 종료 코드 1).
- `backup monit` 은 옵션을 **유지하되 서버 기준 조회에서만 전송**한다. 작업 기준 조회는 경로 식별자로
  작업 하나를 지목한 단건 조회라 작업을 다시 고르는 필터를 보내지 않는다. `recovery monit` 은 원래부터
  서버 기준 전용이라 기준으로 삼았다.

### Changed — CLI 문서
- `cli/docs/replication/monit.md` 에서 `--status` 를 세 곳 지웠다 — 사용 예시의
  `--jn repl01 --status processing` 줄, 파라미터 표의 `--status` 행, 404 계약을 설명하던 각주 문단.
  각주를 지우면서 바로 앞 줄에 붙어 있던 `<br>` 도 함께 떼어 blockquote 의 마지막 줄이 되도록 되돌렸다.
- 같은 문서 `##` 제목 아래 안내 blockquote 에 BREAKING 항목을 하나 더했다. 같은 파일의 `--server` 제거
  안내와 **같은 형식**(`**v3.0.0 (BREAKING)** — ...`)을 쓰고, 파싱 단계 즉시 실패 · 종료 코드 1 ·
  대체 수단(응답의 `job.progress.status` 를 읽는다)을 적었다.
- `cli/docs/backup/monit.md` 의 `--status` 행 설명을 `작업 상태` 에서
  `작업 상태로 목록을 거름 (서버 기준 조회 전용)` 으로 바꿨다. `recovery/monit.md` 와 **한 글자까지
  같은 문구**다 — 같은 성격의 옵션을 두 문서가 다르게 부르지 않게 한다.
- 같은 문서 표 아래 각주에 두 줄을 더했다 (앞 줄에 `<br>` 추가). 첫 줄은 `recovery/monit.md` 의 각주와
  같은 어법으로 "서버 기준 조회 전용이며 작업 기준 조회에서는 전송되지 않습니다", 둘째 줄은 작업 기준
  조회에서 **조용히 무시된다**는 점과 그것이 종전(작업 기준에서도 동작해 불일치 시 404)에 비해 **실제로
  잃는 동작**이라는 점, 그리고 상태를 읽을 자리(`--output json` 의 `job.progressInfo.status`)를 적었다.
  사용 예시는 이미 `--server-name` 을 쓰고 있어 그대로 뒀다.

### Fixed — `api/docs/backup/monitoring-job.md` 파라미터 표
- `backupMonitByJobQuerySchema` 와 표를 전수 대조했다. 스키마가 받는 키는
  `mode` · `partition` · `drive` · `repositoryType` · `repositoryPath` · `detail` · `server` ·
  `jobName` · `center` · `page` · `limit` 뿐이다 (`.strict()`).
- `sort` 행을 제거했다 — 스키마에 없는 이름이라 보내면 400 이다. 표에서 지우기만 하면 "왜 없어졌는지"
  를 알 수 없으므로 참고 항목에 400 이라는 사실을 남겼다.
- `center` 행을 추가했다. 설명 문구와 표 안에서의 위치는 형제 문서(`backup/get.md` ·
  `backup/list.md` · `backup/history-list.md`)의 `center` 행을 그대로 따랐다.
- `page` · `limit` 의 기본값 칸이 `1` · `20` 으로 적혀 있었으나 스키마에 기본값이 없고, 이 경로에는
  페이지네이션 자체가 없다 (자를 목록이 없는 단건 조회다). 기본값을 `-` 로 고치고 설명에 "이 경로에서는
  적용되지 않음" 을 달았다. 행을 지우지는 않았다 — `license/get.md` 의 `center` 행과 같은 판단으로,
  조회 파라미터 검증 강화 이후 표에 없는 이름은 400 으로 읽히기 때문이다.

### Notes
- **`os-replication monit` 의 `--status` 는 처음부터 없던 옵션이었다.** 어제 이 문서에 들어간 `--status`
  세 곳(사용 예시 · 표 행 · 404 각주)은 실제로 존재한 적 없는 옵션을 문서화한 것이라 모두 지웠고,
  BREAKING 안내는 넣지 않았다 — 제거된 적 없는 것을 제거됐다고 적을 수 없다. 근거는 두 가지다.
  (1) 그 커맨드의 옵션 정의 파일을 건드린 커밋은 두 개뿐이며 어느 쪽에도 `status` 가 없다.
  (2) 커맨드가 만드는 요청 query 에는 `center` 하나뿐이고 CLI 는 `.strict()` 라 다른 옵션은 애초에
  통과하지 못한다. `replication monit` 쪽은 반대로 옵션 정의에 `status` 가 실재했으므로 BREAKING 이 맞다.
- 위 판단에는 부수 효과도 있다. `cli/docs/os-replication/monit.md` 는 3.0.0 뿐 아니라 **2.0.0 · 2.0.2
  wrapper 도 함께 참조**한다. 어제 추가된 `--status` 는 그 두 버전 페이지에도 노출되고 있었고, 이번에
  지우면서 함께 사라진다. 반대로 v3.0.0 안내를 넣었다면 v2.0.x 페이지에 3.0.0 이야기가 실렸을 것이다.
  이 파일은 편집 결과가 어제 편집이 들어가기 이전 내용과 동일함을 파일 해시로 확인했다.
- 나머지 세 문서는 **3.0.0 wrapper 만** 공용 include 를 참조한다 (`replication/monit`,
  `backup/monit`, `api/.../monitoring-job` 모두 1.3.1 · 2.0.2 보존본이 이미 있다). 그래서 버전 보존본을
  새로 만들지 않았다. 버전 스냅샷과 `_site/` 는 손대지 않았다.
- 편집한 네 문서의 JSON 예시를 모두 파싱해 검증했고 (backup CLI 2 · os-replication 1 · backup API 5,
  replication CLI 는 JSON 예시 없음), `<details>` 개폐 수와 `markdown="1"` 도 확인했다. 출력 예시는
  새로 만들 필요가 없어 만들지 않았다.
- 이번 범위 밖이라 두었다: `cli/changelog/3.0.0.md` 에는 CLI 쪽 `--status` 제거 항목이 아직 없다.
  `api/docs/backup/monitoring-system.md` 의 표에도 같은 `sort` 행이
  있고 `center` 행이 빠져 있어 서버 기준 경로에서도 같은 대조가 필요하다. `partition` 은 스키마가
  `string | string[]` 인데 표는 `string` 이며, 이는 형제 문서들도 마찬가지라 문서 전반의 관례로 보인다.
  작업 기준 경로의 `detail` 은 스키마가 받지만 서비스에 아직 상세 DTO 분기가 없어 현재로서는 응답이
  달라지지 않는다.

---

## [Documentation] - 2026-09-04 (CLI `recovery monit` text 출력 예시 채움)

### Context
- 2026-09-03 모니터링 재구성 반영 시 CLI 렌더러가 동시 수정 중이라 text 출력을 **구조 서술로만** 두었다.
  렌더러가 확정돼 실제 실행 출력으로 채운다.

### Added — `cli/docs/recovery/monit.md`
- Text 블록 4곳을 실제 출력 형식으로 채웠다: 작업 기준 기본 / 작업 기준 `--detail`(신규) /
  서버 기준 기본 / 서버 기준 `--detail`(신규). `--detail` 두 절에는 종전에 Text 블록 자체가 없었다.
- 값은 문서의 기존 예시 데이터를 유지하고 **형식만** 실행 출력에 맞췄다 — 같은 절의 JSON 예시와 짝이 어긋나지 않게 한다.
- 캐비앗 명시: `role` 은 작업 기준에서 `-`(JSON 은 키 자체를 싣지 않음), Windows 는 `[Drive N]` / `drive` 키,
  서버 기준 `--detail` 에는 `[Job Logs]` 가 없음.

### Fixed — 파티션 `message` 의 접두어 규칙
- JSON 예시 2곳이 `"Processed Size: …"` 로 돼 있어, 바로 위 작업 단위 메시지
  (`"[source-server_home] 62%, Processed Size: …"`)와 대조하면 **진행률 표기까지 사라진 것처럼** 읽혔다.
  실제로는 `[백업작업명] ` 접두어만 제거된다. `"62%, Processed Size: …"` 로 정정했다.

---

## [Documentation] - 2026-09-04 (단건 모니터링의 `status` 조회 파라미터 제거)

### Context
- API 가 작업 기준 모니터링 네 경로에서 `status` 를 제거했다 — `backups` · `replications`(v1 경로도 같은
  스키마를 re-export 한다) · `os-replications`. 구현을 정본으로 삼아
  `domain/{backup,replication,os-replication}/schemas/query/*monit*.schema.ts` 를 직접 읽어 확인했다.
  backup 은 경로별로 스키마가 갈려 있어 job 기준에는 `status` 가 없고 server 기준에만 남아 있다.
- `GET /resource/{id}` 는 "그 리소스를 달라" 이지 "조건에 맞으면 달라" 가 아니다. 상태 불일치 404 는
  "없다" 와 "있는데 상태가 다르다" 를 한 응답에 뭉개 소비자가 재시도 여부를 판단할 수 없었다.
- **breaking 이다.** 세 스키마 모두 `.strict()` 라 `?status=` 를 그대로 두면 조용히 무시되지 않고
  400 (`DTO-VALIDATION-03`) 으로 거절된다. 종전에는 불일치 시 404 였다.

### Changed — API 문서
- `api/docs/backup/monitoring-job.md` · `api/docs/replication/monitoring-job.md` ·
  `api/docs/os-replication/monitoring-job.md` 의 파라미터 표에서 `status` 행을 제거했다.
- 세 문서 모두 표 아래 기존 주석 blockquote 에 항목을 더했다 — 제거 사실, 보내면 400
  (`DTO-VALIDATION-03`), 종전 404 와의 대비, 그리고 상태는 응답의 `job.progressInfo.status`(backup) ·
  `job.progress.status`(replication · os-replication) 를 읽으면 된다는 안내. 없는 절을 새로 만들지 않고
  각 문서에 이미 있던 주석 자리를 썼다.
- `replication/monitoring-job.md` 의 `?status=running` curl 예시를 삭제했다. 이제 그대로 실행하면 400 이다.
  대체 예시를 넣지 않은 것은 이 경로에 후속 파라미터가 없고 `page` · `limit` · `sort` 는 문서에 이미
  "결과에 영향 없음" 으로 적혀 있어 무엇으로 바꿔도 오해를 부르기 때문이다.
- `replication/monitoring-job.md` 의 에러 응답 절에 400 `DTO-VALIDATION-03` 예시를 더했다. 메시지는
  검증 미들웨어의 실제 문구를 그대로 썼다. `os-replication/monitoring-job.md` 는 에러 코드 표 형식이라
  `DTO-VALIDATION-03` 행을 더하고, `NOT_FOUND` 행 설명에서 `status` 를 뺐다.
- backup 문서는 400 절이 이미 있어 발생 조건 문장에 "제거된 `status` 처럼 지원하지 않는 query 파라미터"
  를 더했다.

### Changed — 버전 changelog
- `api/changelog/3.0.0.md` 에 **BREAKING — 단건 모니터링에서 `status` 조회 파라미터 제거** 항목을
  신설하고 `<summary>` 요약 줄에도 추가했다. 2.0.2 스냅샷 세 개가 모두 `status` 를 받는 파라미터로
  문서화하고 있었고 (replication 스냅샷은 `?status=running` curl 예시까지 실었다) 협력사가 그 문서를
  읽고 연동했을 수 있으므로 2.x→3.0.0 델타로 판단했다. 기존 "조회 파라미터 검증 강화" 항목과 합치지
  않은 것은 그쪽이 메커니즘(선언되지 않은 키 거부) 이고 이번 것은 이름이 있는 개별 파라미터의
  제거라 이전/이후 대비와 이행 안내가 따로 필요하기 때문이다.

### Notes
- **부수 효과를 함께 적었다.** replication · os-replication 의 이 경로는 상태를 활성 작업에서
  `hasSchedule: false` 로 계산하고 active 행이 있을 때만 응답을 만들므로 `scheduled` · `registered` 가
  나올 수 없었다. 즉 그 두 값으로 걸면 **원래부터 항상 404** 였고, 파라미터가 사라지면서 함정도 없어진다.
  backup 은 같은 경로에서 `hasSchedule` 을 실제 스케줄로 계산하므로 해당하지 않아 그 문서에는 적지 않았다.
- `api/docs/backup/monitoring-system.md` 의 `status` 는 손대지 않았다. 서버 기준 조회에서는 job 배열을
  거르는 진짜 필터이고 0 건이면 404 가 아니라 빈 배열이다. 편집 전후로 파일 해시가 같은 것을 확인했다.
- 세 공용 include 를 참조하는 wrapper 는 3.0.0 하나뿐이라 (1.3.1 · 2.0.x wrapper 는 각각
  `monitoring-job/1.3.1.md` · `2.0.2.md` 를 본다) 버전 보존본을 새로 만들지 않았다. 버전 스냅샷과
  `_site/` 는 손대지 않았다.
- 편집한 세 문서의 JSON 예시를 모두 파싱해 검증했고 (backup 5 · replication 4 · os-replication 1),
  `<details>` 개폐 수와 `markdown="1"` 도 확인했다.
- 이번 범위 밖이라 두었지만 같은 결함 부류를 발견했다: `backup/monitoring-job.md` 파라미터 표의 `sort`
  행은 `backupMonitByJobQuerySchema` 에 없는 이름이라 이제 그대로 보내면 400 이고, 반대로 스키마가 받는
  `center` 는 표에 없다. replication 응답 필드 표와 os-replication `progress.status 값` 표가 여전히
  `Scheduled` · `Registered` 를 싣고 있는 것도 같은 이유로 실제로는 나올 수 없는 값이다.

---

## [Documentation] - 2026-09-04 (`GET /licenses/{identifier}` 단건 조회 실제 동작 반영)

### Context
- API 가 `GET /api/licenses/{identifier}` 를 실제로 단건 조회로 처리하게 됐다. 종전에는 라우트가 목록
  핸들러에 걸려 경로 식별자가 무시되고 **200 + 전체 배열**이 나갔다. 구현을 정본으로 삼아 라우터 ·
  컨트롤러 · 서비스 · 응답 DTO · 조회 쿼리 스키마를 읽어 확인했다.
- **breaking 이다.** 응답 `data` 가 배열에서 단건 객체가 되고, 없는 식별자는 200 + 전체 목록 대신 404 다.
  v2.0.2 문서가 "식별자는 서버에서 무시되며 전체 목록을 반환한다" 고 **명시**하고 있었으므로, 그 문구를
  읽고 연동한 협력사가 존재할 수 있는 2.x→3.0.0 델타로 판단했다.

### Changed — API 문서
- `api/docs/license/get.md` 의 제목 아래 안내 blockquote 에서 "식별자 무시 · 전체 목록 반환" 주의와
  "단건이 필요하면 `key`/쿼리를 쓰라" 는 우회 안내를 제거하고, 단건 조회 문서의 관례대로 ID/이름 자동
  판별 설명으로 바꿨다 (숫자면 ID, 그 외에는 이름).
- 200 응답 예시의 `data` 를 배열에서 단건 객체로 바꾸고 `message` 를 `License information list` 에서
  `License information retrieved` 로 고쳤다. 두 값 모두 구현에서 확인한 실제 값이다. 응답 필드 표는
  DTO 와 일치해 그대로 뒀다.
- 에러 응답 절을 신설했다 — 404 `LICENSE-ERROR-01`. 메시지는 구현의 실제 문구(`License with ID '999'
  not found`)를 쓰고, 이름으로 조회했을 때의 문구도 함께 적었다. 형식은 같은 단건 조회 문서인
  `license/key.md` 를 따랐다.
- 파라미터 표의 `center` 행을 "단건 조회에는 적용되지 않는다" 로 정정했다. 라우팅이 목록 핸들러로
  빠져 있던 동안에는 실제로 걸리던 필터인데, 단건 경로에서는 조회 조건으로 들어가지 않는다. 행을
  지우지 않은 것은 조회 파라미터 검증 강화(3.0.0) 이후 표에 없는 이름은 400 으로 읽히기 때문이다.
  값이 빈 `?center=` 가 400 인 것은 스키마 검증이라 종전대로다. 표 아래에 `category` · `exp` ·
  `created` 는 이 경로에서도 적용되며 조건과 맞지 않으면 빈 200 이 아니라 404 라는 주석을 더했다.

### Changed — 에러 코드 총람
- `api/docs/error-codes.md` 의 `LICENSE-ERROR-01` 행 설명을 다듬었다. 행 자체는 이미 있었고 HTTP 상태도
  맞아 발생 지점만 덧붙였다 — 단건 조회 두 경로와 라이선스 할당, 그리고 `GET /licenses/:identifier` 는
  조회 조건과 맞지 않을 때도 같은 코드라는 점.

### Changed — 버전 changelog
- `api/changelog/3.0.0.md` 에 **BREAKING — 라이선스 단건 조회가 실제로 단건을 반환** 항목을 신설했다.
  v2.0.2 대비 표(`data` · `message` · 없는 식별자)와 `data[0]` 을 꺼내 쓰던 클라이언트가 깨진다는 점을
  명시했다. `<summary>` 요약 줄에도 항목을 추가했다.

### Notes
- 공용 include `api/docs/license/get.md` 를 참조하는 wrapper 는 3.0.0 하나뿐이라 (1.x 계열은
  `get/1.3.1.md`, 2.0.x 는 `get/2.0.2.md` 를 본다) 버전 보존본을 새로 만들지 않았다. 버전 스냅샷과
  `_site/` 는 손대지 않았다.
- CLI 는 이 엔드포인트를 호출하는 커맨드가 없어 CLI 문서는 건드리지 않았다.
- 편집한 `get.md` 의 JSON 예시 2개를 모두 파싱해 검증했고, `<details>` 개폐와 `markdown="1"` 도 맞다.

---

## [Documentation] - 2026-09-03 (`replication` · `os-replication` 조회 커맨드의 `--server` 제거)

### Context
- CLI 가 `replication list` · `replication history` · `replication monit` · `os-replication list` ·
  `os-replication history` 다섯 커맨드에서 `--server` 를 제거했다. 구현을 정본으로 삼아 여섯 커맨드의
  옵션 정의를 모두 읽어 확인했으며, `os-replication monit` 에는 애초에 그 옵션이 없었다.
- `replication` 계열 작업 테이블에는 서버 컬럼이 없다. 작업 등록 시 시스템 이름 컬럼(`sSystemName`)에
  center 이름이 들어가므로 `--server` 는 이름과 달리 **실제로는 center 이름 필터**였다. 같은 커맨드의
  `--center` 가 ID·이름·콤마 다중을 모두 받으므로 대체 경로가 이미 존재한다.
- **breaking 이다.** CLI 는 yargs `.strict()` 로 알 수 없는 옵션을 거부하고 `.fail()` 에서
  `process.exit(1)` 한다. 기존 스크립트의 `--server` 는 무시되지 않고 파싱 단계에서 즉시 실패한다.

### Changed — CLI 문서
- `cli/docs/replication/list.md` · `history.md` · `monit.md`, `cli/docs/os-replication/list.md` ·
  `history.md` 의 파라미터 표에서 `--server` 행을 제거했다.
- 예시는 지우지 않고 `--center` 를 쓰는 예시로 바꿨다. `replication history` 는 커맨드 정의의
  `--center center01 --result success` 와 일대일로 맞췄고, `list` · `monit` 은 기존 예시가 이미
  `--center 9` · `--center 9,10` 으로 ID 형태를 보여주고 있어 중복되지 않도록 **이름 형태**
  (`--center center01`) 로 뒀다. 커맨드 정의에도 있는 형태다.
- 다섯 문서 모두 `##` 제목 아래 안내 blockquote 에 항목을 하나 더했다 — 제거 사실, `--center` 로의
  대체, 그리고 조용히 무시되지 않고 즉시 실패한다는 점. 네 문서에는 표 아래 주석 블록이 없어 없는 절을
  새로 만들지 않고 기존 blockquote 를 썼다.

### Changed — 버전 changelog
- `cli/changelog/3.0.0.md` 에 **BREAKING — `replication` · `os-replication` 조회 커맨드의 `--server`
  제거** 항목을 신설했다. 이전/이후 명령 대비와 함께, 유지되는 `--server` 가 무엇인지도 명시했다.
- `<summary>` 요약 줄에 해당 항목을 추가했다.

### Added — 버전 보존본
- `cli/docs/os-replication/list/2.0.2.md` · `history/2.0.2.md` 를 신설하고 v2.0.0 · v2.0.2 wrapper 를
  그쪽으로 돌렸다. 이 두 공용 include 는 3.0.0 뿐 아니라 **2.0.0 · 2.0.2 wrapper 도 함께 참조**하고
  있어서, 그대로 편집하면 `--server` 가 실제로 존재하던 릴리즈의 문서에서까지 옵션이 사라진다.
  `replication` 쪽 세 문서는 3.0.0 wrapper 만 참조하므로 (2.0.2 보존본이 이미 있다) 공용 파일을
  바로 편집했다. 보존본에는 breaking 안내를 넣지 않았다 — 3.0.0 의 이야기다.
- 두 보존본은 편집 직전 공용 파일을 **그대로 복사**한 것이라 v2.0.0 · v2.0.2 페이지의 렌더 결과는
  이번 작업 전후로 달라지지 않는다.

### Notes
- 의미가 다른 `--server` 는 건드리지 않았다. `replication/regist.md` · `regist/2.0.2.md` ·
  `overview.md` 의 `--server` 는 `unit-type=server` 등록 시 **진짜 서버**를 가리키며 구현
  (`describe: "server ID or name, comma separated for multiple (for unit-type=server)"`) 에도 그대로
  남아 있다. `backup` · `recovery` 의 `--server` · `--server-name` 도 진짜 서버다. `--unit` 선택지
  문자열의 `server` 는 옵션이 아니라 선택값이라 그대로 뒀다. 버전 스냅샷과 `_site/` 도 손대지 않았다.
- 문서 표와 구현이 어긋난 부분을 발견했으나 이번 변경 범위 밖이라 두었다: `replication` 세 문서의
  `--center` 별칭 칸이 `-` 인데 구현에는 `alias: "c"` 가 있다 (os-replication 쪽은 `-c` 로 맞다).
  또 `replication/monit.md` 는 별칭을 `--ji`/`--jn`, `os-replication/monit.md` 는 `-ji`/`-jn` 로
  표기해 서로 다르다.

---

## [Documentation] - 2026-09-03 (복구 모니터링 응답의 `progress` 재구성 · 파티션별 진행률 기본 노출)

### Context
- ZDM-API v3.0.0 의 복구 모니터링 응답이 재구성된다. 작업 객체에 평면으로 놓여 있던 `status` · `percent` ·
  `message` 가 **`job.progress` 안으로** 들어가고, `details[]` 가 **`progress.partitions[]`** 로 이름과 위치를
  함께 바꾼다. 두 경로(`/recoveries/monitoring/job/:identifier` · `/recoveries/monitoring/system/:identifier`)
  모두 해당한다.
- **경계가 이동한 것이 이번 변경의 핵심이다.** 파티션별 진행률(`partition`/`drive` · `backupFile` ·
  `status` · `percent` · `message` · `timeInfo`)이 **기본 응답**으로 올라오고, `detail=true` 는 파티션
  **메타데이터**(`targetDisk` · `size` · `mode` · `diskNumber` · `overwrite`)와 **작업 로그**만 담당한다.
  종전에는 파티션 배열 전체가 `detail=true` 뒤에 있었다.
- v3.0.0 은 미릴리즈이므로 3.0.0 changelog 는 v2.0.2 → v3.0.0 하나의 델타를 기술한다. 기존
  "`detail` 과 필터" 항목이 `details[]` · `progressInfo` 를 전제로 쓰여 있어 그대로 두면 문서가 자기모순이 된다.

### Changed — API 문서
- `api/docs/recovery/monitoring-job.md` · `api/docs/recovery/monitoring-system.md` 의 응답 예시를 전부 새
  구조로 다시 썼다. 기본 응답 예시에 `progress.partitions[]` 가 들어가고, `detail=true` 예시는 **같은 행에
  메타데이터만 더해진** 모습으로 보이도록 맞췄다 — 행 수와 진행 값이 달라지지 않는다는 점이 읽는 쪽에
  중요하다.
- 두 문서에 `job` 구조 트리와 **기본 응답 / `detail=true` 대조표**를 신설했다. 어느 필드가 어느 쪽에
  실리는지를 표 하나로 확인할 수 있어야 이번 경계 이동이 전달된다.
- 필터 관련 안내를 다시 썼다. 종전 문구 "필터 효과는 `detail=true` 응답에서 관찰됩니다" ·
  "`detail=false` 면 `details` 키 자체가 없습니다" 는 거짓이 됐다. 이제 필터는 **항상 실리는 배열**을
  좁히므로 `detail` 없이도 효과가 그대로 보이고, `detail` 은 **각 행에 어떤 필드를 실을지**만 정한다.
- `mode` 필터에 캐비앗을 추가했다 — `mode` 는 기본 응답에 실리지 않는 필드로 거르므로, `detail` 없이
  `?mode=` 를 쓰면 행이 줄어든 근거가 응답에 드러나지 않는다.
- 파티션 `message` 가 **작업명 접두어(`[source-server_home] `)가 제거된 형태**이고 작업 단위
  `progress.message` 는 원문 그대로라는 점을 필드 표와 예시 양쪽에 넣었다. 예시의 두 값을 실제로 다르게
  적어 표 설명이 예시에서 확인되도록 했다.
- monitoring-job 의 "필터에 맞는 파티션 없음" 예시를 **기본 응답**으로 바꿨다. 이제 `detail` 없이도
  도달하는 상태이며, `partitions` 는 키가 사라지는 것이 아니라 **빈 배열**이다.
- monitoring-system 의 페이지네이션 예시에 "페이지네이션은 `job` 배열만 자르고 각 작업의 파티션 행은
  전부 실린다" 는 안내를 덧붙였다. 대시보드 연동 가이드도 "파티션 진행률 막대는 폴링 1단계만으로
  그린다" 는 쪽으로 고쳤다.
- `percent` · `status` 판정 규칙 표의 참조 경로를 `job.status` → `job.progress.status`,
  `details[]` → `progress.partitions[]` 로 정정했다. 규칙 자체는 변경 없다.

### Changed — CLI 문서
- `cli/docs/recovery/monit.md` 의 `--detail` 설명이 "파티션별 진행 상태 포함" 으로 돼 있어 사실과
  어긋났다. **파티션별 진행률은 기본 출력**이고 `--detail` 은 메타데이터와 작업 로그를 더한다는 것으로
  바꿨다. 표 아래 안내에도 같은 취지의 항목을 신설했다.
- **출력 구조** 절을 신설해 `data.job` 트리와 기본 출력 / `--detail` 대조표를 넣었다. 파티션 원소가
  (파티션, 백업 작업, 백업 이미지) 조합이라는 설명도 이 절로 옮겼다.
- `--output json` 예시는 API 응답 그대로이므로 새 구조로 전부 갱신했다.
- **text 출력 예시는 축자 재현을 피했다.** CLI 렌더러가 함께 수정 중이라 블록 이름·정렬 폭이 확정
  전이다. 파티션 행을 담던 `[Detail N]` 축자 블록을 걷어내고 "어떤 정보가 어떤 순서로 나오는지" 를
  서술로 대체했으며, 출력 예시 절 머리에 그 사실을 명시했다. 렌더러가 확정되면 text 예시를 다시 채운다.
- `--mode` 가 `--detail` 에서만 보이는 필드로 행을 거른다는 캐비앗을 추가했다.

### Changed — 버전 changelog
- `api/changelog/3.0.0.md` 에 **BREAKING — 복구 모니터링 응답이 `progress` 로 묶이고 파티션별 진행률이
  기본 응답으로** 항목을 신설했다. 구조 트리와 v2.0.2 대비 표(작업 상태 경로 / 파티션 배열 이름 /
  각 필드가 기본인지 `detail` 인지)를 함께 넣었다.
- 기존 **BREAKING — 복구 모니터링의 `detail` 과 필터** 항목에서 이번 재구성으로 거짓이 된 문장을
  고쳤다: "`detail` 없이 호출하면 `details` · `log` 키가 아예 없습니다" 는 이제 메타데이터와 `log` 에만
  해당하고, "`details[].progressInfo` 안에서 올라옵니다" 는 `progress.message` 로 바뀌며, 3행 대조표의
  캡션 `(detail=true)` 는 **기본 응답**이 됐다.
- `<summary>` 요약 줄의 "복구 모니터링 재설계 (BREAKING)" 를 "복구 모니터링 재설계 — 작업 목록 ·
  `progress` 묶음 · 파티션별 진행률 기본 노출 (BREAKING)" 로 넓혔다.

### Notes
- 두 항목은 **구조 변경 / 동작 변경**으로 나눠 두었다. 신규 항목이 배치와 경계를, 기존 항목이 값의
  출처·필터·제거된 파라미터를 다룬다. 한쪽에 몰면 v2.0.2 사용자가 무엇을 고쳐야 하는지가 흐려진다.
- 편집 대상은 공용 include 4개뿐이다. v1.x · v2.0.x wrapper 는 이미 보존본
  (`monitoring-job/2.0.2.md` · `monit/2.0.2.md` 등)을 include 하고 있어 이번 변경이 이전 버전 문서에
  번지지 않는다 — 확인 후 편집했다. 버전 스냅샷은 손대지 않았다.
- 파티션마다 진행 값이 실제로 다르다는 점(끝난 파티션과 시작 전 파티션이 한 작업에 공존)은 예시 데이터로
  계속 드러나게 뒀다. 시작 전 행이 `0%` 가 아니라 `-` 라는 구분도 유지했다.
- 서버 기준 조회는 `detail=true` 여도 `log` 를 싣지 않는다는 현행 정책을 두 API 문서와 changelog 양쪽에
  다시 못박았다. 파티션 메타데이터는 붙는다.

---

## [Documentation] - 2026-09-03 (replication · os-replication 모니터링의 `--status` 옵션 반영)

### Context
- `replication monit` 의 `--status` 가 CLI 파싱 단계에서 8개 값(`preparing` · `processing` · `complete` ·
  `scheduled` · `canceling` · `canceled` · `error` · `registered`)으로 제한됐고, `os-replication monit` 에는
  같은 옵션이 **새로 생겼다**.
- 두 도메인의 모니터링은 **단건 조회**다. `--status` 는 목록을 거르는 필터가 아니라 조회한 작업의 현재 상태에
  대한 조건이며, 상태가 다르면 빈 결과가 아니라 **404** 가 나간다
  (`replication-monitoring-get.service.ts` · `os-replication-monitoring-get.service.ts` 의 `calculateJobStatus`
  대조 분기). recovery 모니터링의 "서버 기준 조회 전용" 개념은 여기 없다.

### Changed — CLI 문서
- `cli/docs/replication/monit.md` 의 사용 예시 `--status run` 을 `--status processing` 으로 교체했다.
  `run` 은 유효값이 아니라 이제 파싱 단계에서 거부된다. 출력 블록 안의 `status : run` 은 응답 필드라 별건이며
  손대지 않았다.
- 같은 파일 `--status` 행의 `선택값` 을 `-` 에서 `{% include zdm/job-status.md %}` 로 채우고, 설명을
  "상태 필터" 에서 "작업의 현재 상태 조건 (불일치 시 404)" 으로 바꿨다. 표 아래 안내에 단건 조회라는 점과
  실제 404 문구(`No replication jobs found with status '...' (identifier: ...).`)를 덧붙였다.

### Added — CLI 문서
- `cli/docs/os-replication/monit.md` 에 `--status` 파라미터 행을 신설했다(string, Optional, 8개 선택값,
  같은 404 설명). 사용 예시도 1줄 추가했다. 404 문구는 구현 그대로
  `No os replication jobs found with status '...' (identifier: ...).` 다 — replication 쪽과 문구가 다르다.
- 두 문서의 서술은 맞추되 마크업은 각 파일의 기존 관례(`Required*` / `<span class="required-note">`)를 유지했다.

### Notes
- `os-replication` 은 서비스가 `server` 를 실제로 걸러 404 를 내지만 **CLI 에 `--server` 옵션이 없다**.
  `replication` 은 반대로 CLI 가 `server` 를 전송하는데 **서비스가 읽지 않는다** — 그래서
  `cli/docs/replication/monit.md` 의 `--server` 행과 "서버 필터 추가" 예시 주석은 실제로 필터가 걸리는 것처럼
  읽힌다. 이번 범위 밖이라 두 파일 모두 손대지 않고 기록만 남긴다.
- 출력 예시는 새로 만들지 않았다(렌더러 정렬 재현이 필요한 변경이 없음). `os-replication/monit.md` 의 기존
  JSON 블록은 파싱 검증했다. 버전 스냅샷과 `_site/` 는 변경하지 않았다.

---

## [Documentation] - 2026-09-03 (replication · os-replication 이력 단건 조회의 center · 필터 적용 반영)

### Context
- `GET /replications/histories/{identifier}` · `GET /os-replications/histories/{identifier}` 가 `center` 와
  행 필터(`jobId` · `jobName` · `server` · `result`)를 **단건 조회에서도 실제로 적용**하기 시작했다.
  종전에는 숫자(ID) 분기와 작업 이름 분기 **양쪽 모두** 무시돼, 다른 센터의 히스토리도 200 으로 나갔다.
- 페이지네이션은 이 엔드포인트에 붙지 않는다 — 작업 이름 조회도 pagination 없이 호출되므로
  `page` · `limit` 은 값 검증만 되고 결과에 영향을 주지 않는다. `sort` 는 작업 이름 조회(목록 응답)에만 적용된다.

### Changed — API 문서
- `api/docs/replication/history-get.md` 의 `center` 행 캐비앗 **"요청 검증에만 사용되며 단건 조회 결과를
  센터로 좁히지는 않습니다"** 가 거짓이 되어 교체했다. 이제 "조회 대상을 해당 center 로 좁힙니다" 이고,
  다른 center 의 행이면 200 이 아니라 404 라는 점을 표 아래 안내에 명시했다.
- 같은 파일의 `page` · `limit` 기본값을 `1` · `20` 에서 `-` 로 바꾸고 "이 엔드포인트에서는 적용되지 않습니다" 로 정정,
  이를 전제하던 `?result=success&page=1&limit=5` 예시도 `?result=success` 로 줄였다. `sort` 는 적용 범위를
  "작업 이름 조회의 목록 응답" 으로 좁혔다.
- 404 예시의 코드·문구를 구현 기준으로 정정했다 — `JOB-ERROR-01` / `Replication history not found for ID '999'` 는
  실제로 나오지 않는 조합이다. 실제는 `NOT_FOUND` + `Replication history not found (ID: 999)` 이며,
  center 불일치 전용 문구(`... does not belong to Center '...'`)와 작업 이름 분기 문구(`(JobName: ...)`) 예시를 추가했다.
- 작업 이름 조회 응답 예시의 `message` 를 `Replication history list` 에서 실제 값인
  `Replication history retrieved` 로 정정했다 (두 분기가 같은 문구를 쓴다).

### Added — API 문서
- `api/docs/os-replication/history-get.md` 에 **쿼리 파라미터 표를 신설**했다. 종전에는 `Authorization` · `identifier`
  두 행뿐이었다. `jobId` · `jobName` · `server` · `result` · `page` · `limit` · `center` · `sort` 를 추가했고,
  구성은 replication 쪽 표(기본값 열 포함)를 따랐다. 두 엔드포인트의 쿼리 계약은 동일하다.
- 같은 파일에 **에러 응답 절을 신설**했다 — 404 세 가지(없는 ID / 다른 center 의 ID / 작업 이름 무결과).
- 작업 이름으로 조회했을 때의 목록 응답 예시를 추가했다. `sort` 가 이 분기에만 영향을 주기 때문이다.
  `pagination` 키가 실리지 않는다는 점도 함께 적었다.
- 두 문서 모두 표 아래 안내를 맞췄다: center 는 ID·이름 양쪽 분기에 적용된다, 존재하지 않는 center 는
  조회 없이 404 다(목록 조회가 빈 배열 200 인 것과 다르다), `center` · 필터를 지정하지 않은 요청은 종전과 동일하다.

### Notes
- center 불일치 전용 404 문구는 **숫자 identifier 조회에서만** 나온다. 작업 이름 분기는 사유와 무관하게
  `(JobName: ...)` 한 문구다. 또 center 는 맞는데 `result` 등 다른 필터에서 걸러진 경우도 center 탓으로
  표기되지 않고 `(ID: ...)` 문구가 나간다 — 두 사실을 문서에 그대로 적었다.
- os-replication 응답 예시의 `message` 를 `OS Replication history retrieved` 에서 실제 값
  `Os Replication history retrieved` 로 맞췄다.
- 두 파일의 JSON 블록 10개를 전수 파싱 검증했고, `<details>` / `<summary>` 개폐 균형도 확인했다.
  버전 스냅샷(`zdm/ko/api/**`)과 `_site/` 는 변경하지 않았다.

---

## [Documentation] - 2026-09-03 (이력 단건 조회 숫자 identifier 의미 · 페이지네이션 반영)

### Context
- `api/docs/backup/history-get.md` · `recovery/history-get.md` 두 문서의 숫자 identifier 서술이 서로 다른 이유로 사실과 달랐다.
  - **backup 은 동작이 바뀌었다(breaking).** 단건 조회 키가 `nJobID` → `nID` 로 이동했다
    (`backup-history.repository.ts` 의 `findById` 가 `nID` 를 조건으로 건다). 그 결과 응답의 `id` 가
    **질의한 값과 일치**한다 — 종전 backup 은 작업 ID 로 찾고 이력 행 ID 를 돌려주어 둘이 달랐다.
  - **recovery 는 원래부터 `nID`** 였고 문서 문장만 틀려 있었다. 동작 변화는 없다.
  - 두 문서 모두 첫 줄은 이미 "히스토리 ID 또는 작업 이름" 이라 같은 문서 안에서 자기모순이었다.
- 이름 identifier 에 `page`·`limit` 이 붙으면 서비스가 `PaginationUtils.createPaginatedResult` 를 태우고
  컨트롤러가 목록 조회와 같은 봉투로 내보낸다. 문서는 "적용되지 않습니다" 라고 적혀 있었다.

### Fixed — API 문서
- 숫자 identifier 를 **히스토리 ID(이력 행 ID)** 로 정정했다(설명 줄 · 요청 예시 주석 · 파라미터 표의
  `identifier` 행 · 응답 예시 summary · center 404 절 문구). 두 문서를 같은 서술로 맞췄다.
- 응답의 `id` 가 요청한 값과 일치하고 `job.id` 는 별개의 작업 ID 라는 점을 참고에 명시했다.
  예시도 이에 맞춰 `GET .../histories/1024` → `"id": 1024`, `"job": { "id": 10 }` 으로 바꿨다.
  종전 예시는 `/10` 요청에 `"id": 1` 이라 요청 값과 응답 `id` 의 일치를 보여주지 못했고,
  backup 에서는 옛 `nJobID` 조회를 전제한 값이기도 했다.
- **"숫자로 조회하면 center 를 제외한 나머지 필터가 무시된다"** 는 서술을 제거했다. 현재 구현은
  `pickRowFilters` 로 `jobId`·`jobName`·`server`(recovery 는 `serverType` 포함)·`partition`·`result` 를
  이름 분기와 **같게** 적용한다. 대신 `sort`·`page`·`limit` 만 이름 분기 전용임을 남겼다 —
  숫자는 이력 행 PK 조회라 정렬·절단할 결과 집합이 없다.
- 이름 분기 목록 예시의 `message` 가 목록 엔드포인트 값(`... history list`)으로 적혀 있던 것을
  컨트롤러 실제 값인 `... history retrieved` 로 정정했다.

### Changed — API 문서
- `page`·`limit` 서술을 교체했다: **이름 분기에서는 적용**되며 둘 중 하나라도 오면 목록 조회와 **같은
  페이지네이션 봉투**(`pagination` 메타)로 응답하고, 둘 다 없으면 응답 형태는 종전 그대로다.
  **숫자 분기는 미적용**(최대 1행)이다.
- 404 조건을 좁혀 적었다 — 이름에 걸리는 이력이 **0건일 때만** 404이고, `?page=99` 같은 범위 밖 페이지는
  **200 + `data: []` + 봉투**다. 서비스가 `countAll` 로 먼저 세고 0건일 때만 404 를 던진다.
- 요청 예시에서 빠져 있던 `page`·`limit` 을 **이름 분기 예시로** 복원했다(숫자 분기에 붙이면 위 서술과 모순된다).
- 응답 예시에 "페이지네이션 적용" · "범위를 벗어난 페이지" 두 절을 신설하고, 응답 필드 표에 `pagination.*` 6행을 추가했다.
  봉투 형태·필드 설명은 목록 조회 문서(`backup/history-list.md` · `recovery/history-list.md`)의 것과 맞췄다 —
  구현이 같은 `createPaginationMeta` 를 쓴다.

### Notes
- 두 문서의 JSON 블록 14개를 전수 파싱 검증했다. 필드명은 `backup-history-get-response.dto.ts` ·
  `recovery-history-get-response.dto.ts` 에서 확인했다(`id` = `nID`, `job.id` = `nJobID`).
- CLI 는 영향이 없다 — `zdm-cli-v2` 에 단건 이력 엔드포인트가 없어 CLI 문서는 손대지 않았다.
- 버전 스냅샷(`history-get/1.x` · `2.0.2.md` 등)과 `_site/` 는 변경하지 않았다.

---

## [Documentation] - 2026-09-03 (CLI `recovery monit` 서버 기준 조회 옵션 3건 반영)

### Added — CLI 문서
- `cli/docs/recovery/monit.md` 파라미터 표에 `--job-name-filter`(`-jnf`) · `--page` · `--limit` 3행 추가.
  설명은 기존 `--status` 행과 같은 "(서버 기준 조회 전용)" 표기를 따르고, 기본값은 `- (전체 목록)` 으로 뒀다.
- `--job-name-filter` 행을 `--job-name` 바로 아래 두고, 표 아래 안내에 두 옵션의 차이를 한 줄로 명시했다 —
  `--job-name` 은 모니터링할 작업을 지목하는 값, `--job-name-filter` 는 서버 기준 조회 결과의 job 목록에서
  이름이 정확히 일치하는 작업만 남기는 필터.
- 사용 예시 2줄 추가(`--job-name-filter` · `--page`/`--limit`).
- 출력 예시에 `### 페이지 지정 출력 - 서버 기준` · `### 범위를 넘긴 페이지 출력 - 서버 기준` 두 절 신설.
  text 는 `[Jobs Page]` 키-값 블록(`currentPage` · `totalPages` · `totalItems` · `itemsPerPage`),
  JSON 은 `data.pagination`(`hasNextPage` · `hasPreviousPage` 포함) 형태다.

### Changed — CLI 문서
- 기존 "`--status` · `--server-type` 은 작업 기준 조회에서는 무시됩니다" 안내를 신규 3개 옵션까지 포함하도록 확장하고,
  표현을 "전송되지 않습니다" 로 정정했다 — 작업 기준 조회에서는 해당 query 자체가 만들어지지 않는다.
- "서버에 걸린 복구 작업을 **모두** 출력합니다" 문장에 `--page` · `--limit` 미지정 조건을 붙였다 —
  페이지네이션이 생기면서 무조건 참이 아니게 된 문장이다.

### Notes
- `summary` 는 필터를 통과한 전체를, `job` 은 그중 한 페이지를 담는다. 범위를 넘긴 페이지는 200 에
  `job: []` + `summary.total > 0` 이 정상이며 버그가 아니라는 점을 명시했다. `[Jobs Page]` 가 빈 목록 안내보다
  먼저 렌더된다는 점도 함께 적었다 — 결과가 비어도 페이지 번호를 확인할 수 있어야 하기 때문이다.
- `[Jobs Page]` 의 키·패딩은 렌더러 구현에서 확인했다. 키-값 출력은 `padEnd(최장 키 길이)` 이므로 폭은
  `itemsPerPage` 기준 12 이고, 불리언 두 필드는 문자열·숫자만 받는 시그니처 때문에 text 출력에서 빠진다.
- 예시 JSON 블록은 전부 파싱 검증했다. 버전 스냅샷(`zdm/ko/cli/**`)과 `_site/` 는 변경하지 않았다.

---

## [Documentation] - 2026-09-03 (DTO 검증 실패 400/422 응답 예시 형식 정정)

### Context
- DTO 검증 실패의 실제 응답은 `error.message` 가 코드별 정형 문구(`Request body validation failed.` ·
  `URL parameter validation failed.` · `Query parameter validation failed.`)이고, **사유는 `error.details.<필드>[]`** 에 담긴다
  (`zod-validation.middleware.ts` 의 `formatZodErrors` + `error-handler.ts`). 일부 기존 예시가 zod 원문 사유를
  `message` 에 직접 넣어 두어, 클라이언트가 `message` 를 파싱하도록 유도하고 있었다.
- `details` 는 `DTO-VALIDATION-*` 에만 실린다. 도메인 에러(`JOB-ERROR-*` 등)에는 이 키가 없다.

### Fixed — API 문서
- `api/docs/backup/history-list.md` · `recovery/history-list.md` · `replication/history-list.md` 의 400 예시:
  `"Invalid enum value. Expected 'success' | 'failed', ..."` 를 `message` 에서 빼고
  `details: { "result": ["result must be one of: success, failed"] }` 로 옮겼다. 문구는 스키마의 `message` 옵션 그대로다.
- `api/docs/replication/list.md` 의 400 예시: 같은 형태로 `details: { "status": [...] }` 로 교체.
  값 목록은 `VALID_JOB_STATUS_VALUES` 를 따른다.
- `api/docs/auth/issue.md` 의 422 예시: 중괄호가 어긋나 **파싱되지 않던 JSON** 을 바로잡았다
  (`details.email` 내용 자체는 스키마와 일치해 그대로 뒀다).
- `api/docs/error-codes.md` 응답 형식 예시에서 `JOB-ERROR-13` 에 붙어 있던 빈 `details` 를 제거했다 —
  도메인 에러에는 실리지 않는 키다. 필드 표의 설명도 "요청 검증 실패 등에서만" 에서
  `DTO-VALIDATION-01/-02/-03` 에만 포함된다고 좁혔다.

### Notes
- 현행 문서 78개(`api/docs/**`, 버전 스냅샷 제외)의 JSON 블록 500개를 전수 파싱 검증했다. 남은 미파싱 블록은
  조각 예시(`"schedule": { ... }`)·주석 포함 예시(`// 요청`)·인용문 내부 예시로, 의도된 문서 표기다.
- 이미 `details` 형식으로 작성돼 있던 나머지 400/422 예시는 손대지 않았다. `BAD_REQUEST` 등 서비스 계층이
  던지는 400 예시도 `details` 가 없는 것이 정상이라 그대로 뒀다(메시지 출처를 서버 코드에서 확인).
- 버전 스냅샷(`zdm/ko/api/1.x` · `2.x`)과 `_site/` 는 변경하지 않았다.

---

## [Documentation] - 2026-09-03 (저장소 스캔 커버리지 `scan` 신설 반영)

### Context
- `zdm-api-v2` 가 이미지 조회 응답에 `scan`(커버리지 + 저장소별 실패)을 싣기 시작했다.
  종전에는 실패 저장소가 **서버 로그에만** 남아 받는 쪽이 목록의 불완전함을 알 수 없었다.

### Changed — API 문서
- `api/docs/backup/images.md` · `images-list.md` 의 **"실패한 저장소는 서버 로그에만 기록됩니다 /
  응답만 보고는 어느 저장소가 빠졌는지 알 수 없습니다"** 문장이 **거짓이 되어 교체**했다.
  `scan` 형식·필드 표·예시로 대체하고, `repositoryId` 로 재호출해 원인을 찾으라는 우회 안내는 제거했다.
- **`scan` 은 실패가 없어도 항상 포함**된다는 점을 두 문서 모두에 명시했다 — `failed: 0` 이 완전함의 신호이고,
  실패 시에만 실으면 이 필드를 모르는 클라이언트가 부분 결과를 전체로 오인한다.
- `api/changelog/3.0.0.md` 에 `신규 — 저장소 스캔 커버리지 scan` 추가, 요약 줄에도 반영.

---

## [Documentation] - 2026-09-03 (조회 파라미터 검증 강화 반영 — 미선언 파라미터 거절 · 열거형 대소문자)

### Context
- `zdm-api-v2` 2026-09-02 변경 2건이 문서에 반영돼 있지 않았다. 둘 다 **전 조회 엔드포인트에 걸치는** 계약 변경이라
  개별 문서가 아니라 공통 안내 자리에 둔다.
- **미선언 query 파라미터 거절** — query 스키마 31개에 `.strict()` 적용. 종전에는 모르는 키가 조용히 strip 되어
  **필터가 빠진 더 넓은 결과가 200 으로** 나갔다. 받는 쪽은 요청이 어긋난 사실조차 알 수 없었다.
  breaking 이므로 버전 changelog 요약 줄에도 올렸다.
- **열거형 query 값의 대소문자 무시** — 응답은 `Processing`, 요청 어휘는 `processing` 이라
  **API 가 만든 값을 API 가 400 으로 거절**하던 것을 해소. 대상은 조회·모니터링의
  `status` / `mode` / `platform` / `repositoryType` / `serverType`.

### Added — API 문서
- `api/index.md` 참고사항에 두 항목 추가. 버전 가드(`include.version >= "3.0.0"`)를 걸어 하위 버전 문서에는 노출되지 않게 했다.
- `api/docs/error-codes.md` 의 `DTO-VALIDATION-03` 아래에 안내 블록과 응답 예시를 넣었다 —
  **`details` 의 key 가 문제 파라미터 이름**이라는 점이 핵심이라 예시로 보여준다.
- `api/changelog/3.0.0.md` 에 `BREAKING — 조회 파라미터 검증 강화` 와 `동작 변경 — 조회 열거형 값의 대소문자` 신설.
  전자는 v2.0.2 대비 표로 차이를 명시했다.

### Notes
- CLI 문서는 손대지 않았다. CLI 자체가 바뀐 것이 아니고, API 가 `.strict()` 를 켜지 않은 4개 스키마가
  정확히 CLI 가 `center` 를 보내는 monit 경로들이라 지금은 CLI 동작에 영향이 없다.
- `backup image` 목록의 저장소 부분 실패는 **이미 문서화돼 있어** 손대지 않았다
  (`api/docs/backup/images.md` · `images-list.md`). 실패 저장소가 서버 로그에만 남는다는 한계까지 적혀 있다.

---

## [Documentation] - 2026-09-03 (복구 "대상 서버 사용 중" 정책 변경 반영 — 등록 허용 / 실행만 거부)

### Context
- `zdm-api-v2` 의 복구 동시성 정책이 바뀌었다. **진행 중인 복구가 있어도 등록은 언제나 허용되고, 막히는 것은 실행뿐이다.**
  사전 등록은 정상 사용례이고, 같은 대상 디스크에 복구가 둘 붙어 서로의 결과를 덮어쓰는 것은 실행 시점의 문제이기 때문이다.
- 계약의 정본은 구현(`recovery-target-activity-guard.service.ts` · `recovery-regist.service.ts` · `recovery-update.service.ts`)으로 두고,
  `notices` 문구와 409 메시지는 코드의 문자열을 그대로 옮겨 적었다.
- 경로별 결론: 등록(`autoStart` 없음) → 성공 + `notices` / 등록(`autoStart=use`) → 성공, 자동 시작만 생략 + `notices`,
  응답 `common.autoStart` 는 `not use` / `PUT` `status=start` → `JOB-ERROR-64`(409) / `status=stop` → 영향 없음.
  가드 조회 자체가 실패하면 등록도 실행도 막지 않는다(fail-open).

### Fixed — API 문서 (`api/docs/recovery/regist.md`)
- **주요 에러 코드 표의 `JOB-ERROR-64` 행이 "대상 서버에 진행 중인 복구 작업이 있음 (`autoStart` 요청 시)" 로
  등록 거부를 설명하고 있어 행을 삭제**했다. 409 를 던지는 `assertTargetAvailableForStart` 의 호출자는
  `recovery-update.service.ts` 하나뿐이라 `POST /recoveries` 는 이 코드를 반환할 수 없다 —
  발생 조건 문구만 고치면 "이 엔드포인트의 주요 에러 코드" 표에 반환되지 않는 코드가 남는다.
  표 아래에 "이 엔드포인트에서는 발생하지 않으며 `PUT ... status=start` 에서만 반환된다" 는 안내를 대신 두었다.

### Changed — API 문서 (`api/docs/recovery/regist.md` · `image-regist.md`)
- 요청 본문 `autoStart` 행에 "대상 서버가 사용 중이면 등록은 되고 자동 시작만 생략" 을 붙이고,
  **"대상 서버가 사용 중일 때"** 안내 블록(경로별 결과 표 + 실행 방법 + fail-open)을 신설했다.
- **응답 `common.autoStart` 가 요청값의 반향이 아니라 실제로 적용된 값**임을 응답 필드 표에 못 박았다.
  `autoStart: "use"` 로 요청해도 `"not use"` 가 나올 수 있다 — 요청값과 응답값이 같다고 가정한 화면은
  "시작됨" 으로 잘못 표시된다. 협력사 연동에서 가장 걸리기 쉬운 지점이라 changelog 에도 별도 문단으로 실었다.
- `image-regist.md` 의 응답 필드 표에는 **`common.autoStart` 행 자체가 없어 신설**했다. 이번 변경의 핵심 값이다.
- `notices` 설명이 양쪽 모두 "자동 skip 되었을 때만" 이라 사실과 달라졌다 — 대상 서버 사용 중 안내도 담기므로
  사유 두 가지로 넓히고, 두 사유가 겹칠 때 **대상 서버 안내가 배열 앞**에 온다는 순서(구현상 `exclusionReasons` 앞에 push)도 적었다.
- `notices` 실제 문구 두 개(자동 시작 생략 / `autoStart` 없이 등록)를 구현 문자열 그대로 인용했다.
- `regist.md` 의 schedule 안내 블록이 "`autoStart=use` 와 함께 사용하면 즉시 1회 실행됩니다" 를 **무조건**으로 서술하고 있어
  두 문장에 단서를 달았다. 새 안내 블록 바로 아래에서 정반대를 말하는 문장이 남아 있으면 독자는 가까운 쪽을 믿는다.

### Added — API 문서 (`api/docs/recovery/update.md`)
- **`status: "start"` 의 409 케이스를 에러 응답 블록에 신설**했다. 메시지는 구현의 `[Recovery start] - ...` 문구 그대로다.
- 요청 본문 `status` 행과 **"실행 요청과 대상 서버 점유"** 안내 블록 신설 — `stop` 은 영향 없음, `status` 없는 설정 수정은 검사 대상 아님,
  **자기 자신의 진행 이력은 차단 근거가 아님**(구현이 `excludeJobId` 로 자기 행을 제외하므로 재시작이 자기 자신 때문에 막히지 않음), fail-open.

### Changed — API 문서 (`api/docs/error-codes.md`)
- `JOB-ERROR-64` 설명을 실행 맥락으로 조정했다 — 한 문장 양식은 유지한 채 "실행 요청에서만 발생하며 등록은 이 사유로 거부되지 않는다" 를 덧붙였다.

### Changed — 변경 안내 (`api/changelog/3.0.0.md`)
- **동작 변경 — 대상 서버가 사용 중일 때 (등록은 허용, 실행만 거부)** 절을 신설하고 `<summary>` 의 절 목록에도 추가했다
  (추가하지 않으면 접힌 상태에서 새 절이 보이지 않는다).
- v2.0.2 대비 표는 이전 열을 **"검사 없음"** 으로 적었다. 이 가드는 v3.0.0 개발 중(2026-08-25)에 처음 들어왔으므로
  "v2.0.2 에서는 409 로 등록이 거부됐다" 고 쓰면 사실이 아니다 — 협력사가 겪은 적 없는 동작을 이력으로 남기지 않았다.

### Changed — CLI 문서 (`cli/docs/recovery/regist.md` · `image-regist.md` · `update.md`)
- `--start` 설명, `[Notices]` 출력 조건, `--status` 설명을 새 정책에 맞게 고쳤다.
- `image-regist.md` 의 `autoStart : -` 주석에 **"요청값이 아니라 서버가 실제로 적용한 값"** 을 덧붙였다.
  CLI 는 `data.common.autoStart || "-"` 를 찍으므로 `-` 는 값이 비었다는 뜻이고, 대상이 사용 중이면 이 줄이 `not use` 로 나온다.
- CLI 는 코드 변경이 없다 — `RegistCommand.ts`·`ImageRegistCommand.ts` 가 이미 `notices` 를 렌더링하고
  `UpdateCommand.ts` 는 `--status` 를 그대로 전달한다. 문서 서술만 고쳤고 새 파일은 만들지 않았다.

### Not touched
- 버전 스냅샷(`zdm/ko/api/1.x` · `2.x`)과 `3.0.0` 래퍼 — 래퍼가 현행 `_includes` 를 include 하므로 자동 반영된다.
- `zdm-api-v2` · `zdm-cli-v2` 소스 (읽기 전용으로만 참조), `_site/` 빌드 산출물.
- `cli/docs/recovery/regist.md` 의 전량 skip 에러 코드 표기(`JOB-ERROR-01`)가 API 문서(`JOB-ERROR-14`)와 어긋나 있으나
  이번 변경과 무관한 기존 불일치라 건드리지 않았다.

---

## [Documentation] - 2026-09-03 (복구 모니터링 문서에 파티션별 진행률 반영 + CLI monit 출력 예시 현행화)

### Context
- `zdm-api-v2` 의 복구 모니터링 `details[]` 각 행이 **그 파티션의 실제 진행 정보**(`status` · `percent` · `message` · `timeInfo`)를 싣도록 바뀌었다.
  종전에는 작업 단위 값을 행마다 복사해 파티션 3개가 전부 같은 상태·같은 진행률로 보였다.
- 작업 단위 `percent` 와 `summary.overallProgress` 의 **출처도 바뀌었다** — 데몬이 세어 둔 복구 완료 개수 기반이며,
  이전의 "진행 행 평균" 이 아니다. 소비자가 `details[]` 로 재계산하지 않도록 문서에 못 박았다.
- 계약의 정본은 구현(`recovery-monitoring-get.type.ts` · `dto/response/monitoring/`)으로 두고, 예시 값·표기 규칙을 전부 코드에서 확인해 적었다.

### Changed — API 문서 (`api/docs/recovery/monitoring-job.md` · `monitoring-system.md`)
- **예시 JSON 의 `details[]` 행을 서로 다른 값으로 재작성**했다. Linux 예시는 `/` 완료(`Complete` · `100%`),
  `/home`(daily 이미지) 복구 중(`Processing` · `62%`), `/home`(weekly 이미지) **미시작**(`Registered` · `"-"`) 세 가지가 한 응답에 공존한다.
  Windows 예시도 `C:` 완료 / `D:` 진행 중으로 갈랐다. 전부 같은 값으로 두면 종전의 잘못된 동작을 문서가 다시 광고하는 셈이라 피했다.
- 응답 필드 표에 `details[].status` · `percent` · `message` · `timeInfo.{start,elapsed,end}` 6줄을 추가했다.
- **표기 규칙 표를 작업 단위와 파티션 단위로 분리**했다. 작업 단위 `percent` 는 데몬이 센 개수 → 진행 정보 → `Complete` 순의 폴백,
  파티션 단위는 **그 파티션의** 진행 정보로 판단한다.
- **`details[].status` 판정 규칙 표(3분기)를 신설**했다 — ① 그 파티션의 진행 정보로 계산 ② 진행 정보 없고 다른 파티션엔 있음 → `Registered`(미시작)
  ③ 작업 전체에 진행 정보가 없음 → 작업 상태 그대로. ③ 때문에 완료 작업의 행이 `Complete` · `100%` 인데 `message` · `timeInfo` 는 `"-"` 로 나오는
  겉보기 모순이 생겨, 그것도 함께 적었다.
- **미시작 파티션은 `0%` 가 아니라 `"-"`** 임을 별도로 못 박았다 — 시작하지 않은 것과 시작해서 0% 인 것은 다르다.
- 예시 옆에 "3행 중 1행 완료(33%)인데 작업 진행률은 `45%`" 를 두고, 이것이 오류가 아니라 **출처가 다른 값**임을 설명했다.
  표만으로는 독자가 계산해 보고 문서 버그로 읽는다.
- 서버 기준 문서의 `summary.overallProgress` 설명에 출처와 분모(진행률을 구할 수 없는 작업도 제외)를 보강했다.

### Changed — CLI 문서 (`cli/docs/recovery/monit.md`)
- **출력 예시 전체가 재설계 이전 형상**(`system.source`/`target`, 중첩 `progressInfo`, 없는 필드들)이라 4개 시나리오를 전부 다시 만들었다.
  실제 렌더러(`MonitCommand.ts`)를 따라 `[Server Information]` · `[Jobs Summary]`(7행, `canceled` 포함) ·
  `[Job N]`(id/name/source/target/role/status/percent/message/start/elapsed/end) · `  [Detail N]` 블록과
  **키 패딩 폭까지** 블록별로 맞춰 적었다.
- `[Job Logs]` 항목 형식을 실제 값(`[시각]메시지`)으로 고쳤고, 헤더 `timestamp` 도 ISO 8601 로 바꿨다.
- `[Detail N]` 블록에 **파티션별 진행 4필드**(`status` · `percent` · `message` · `timeInfo`)를 반영했다. text 렌더러는
  `timeInfo` 를 `start` · `elapsed` · `end` 로 평탄화해 찍으므로 예시도 그 모양이다. 키가 늘었지만 가장 긴 키가
  여전히 `targetDisk`/`backupFile`/`diskNumber`(10자)라 **패딩 폭은 10 그대로**다.
- text 예시는 한 작업 안에서 **완료 / 복구 중 / 미시작**이 한 화면에 갈리도록 구성했다 — JSON 예시와 같은 시나리오다.
- 파라미터 표에 `--status` · `--server-type` 의 서버 기준 전용 여부, `--partition`/`--drive` 상호 배타를 보강했다.

### Changed — 변경 안내 (`api/changelog/3.0.0.md`)
- 기존 "복구 모니터링의 `detail` 과 필터" BREAKING 절에 파티션별 진행률을 반영했다. 종전 문장이
  "작업 단위 값을 파티션 행마다 복사하던 `progressInfo` 는 제거되고" 에서 멈춰 있어, **각 행이 자기 진행을 싣는다**는 사실과
  미시작 파티션 표기, 진행률 출처 변경을 추가했다. 세 행이 어떻게 달라지는지 표로 함께 보였다.

### Not touched
- 버전 스냅샷(`zdm/ko/api/1.x` · `2.x`)과 `3.0.0` 래퍼 — 래퍼가 현행 `_includes` 를 include 하므로 자동 반영된다.
- `zdm-api-v2` · `zdm-cli-v2` 소스 (읽기 전용으로만 참조), `_site/` 빌드 산출물.

---

## [Documentation] - 2026-09-02 (recovery 모니터링 문서 2건 전면 재작성 — 조회 계약 breaking 변경 반영)

### Context
- `zdm-api-v2` 의 recovery 모니터링 두 경로(`/recoveries/monitoring/system/:identifier` ·
  `/recoveries/monitoring/job/:identifier`)가 **breaking 하게 재설계**되어, 응답 봉투·파라미터·에러 조건이 함께 바뀌었다.
- 파라미터 표 몇 줄을 고치는 수준으로는 맞출 수 없어 **두 문서를 전면 재작성**했다
  (`monitoring-system.md` 352 → 571줄, `monitoring-job.md` 254 → 418줄).
- 반영 대상은 공용 include 2개뿐이다. 다른 페이지·navigation·versions 는 손대지 않았다.

### Changed — 서버 기준 조회 (`api/docs/recovery/monitoring-system.md`)

**응답 봉투가 바뀌었다** — `{ server, summary, job[] }` 이고 **`job` 이 배열**이다. 이전에는 작업 하나로 접혔다.

- 최상위 `system.source` / `system.target` **제거**. 한 서버가 여러 복구에 걸리면 응답당 1쌍이 성립하지 않으므로
  작업마다 `info.source` / `info.target` 으로 내려갔고, 조회 기준 서버가 그 작업에서 맡은 쪽은 `info.role`(`source`/`target`)로 표시된다.
  `role` 은 **이 경로에만** 있다.
- `info.id` 신설 — 상세 조회로 이어갈 때 쓰는 값이다. `status` · `percent` · `message` 는 파티션 행이 아니라 **작업 단위**로 올라왔다.
- `summary` 정의를 배열 기준으로 다시 적었다. `total` 은 **작업 수**(이전에는 파티션 행 수), 버킷은
  `completed` / `inProgress` / `failed` / `canceled` / `pending` 이고 **`canceled` 는 신설**이다
  (`Canceling` · `Canceled` 가 어느 버킷에도 안 들어가던 것이 해소). 8개 상태 → 5개 버킷 대응표를 넣고
  **버킷 합 == `total`** 이 페이지네이션과 무관하게 성립함을 명시했다.
  `overallProgress` 의 분모는 진행 정보를 가진 작업이라 `inProgress` 와 일치하지 않는다는 주의도 함께 적었다.
- **적용 순서를 명시** — `조회 → 파티션/드라이브/mode 필터 → status 필터 → 정렬 → summary 집계 → 페이지 잘라내기`.
  따라서 `summary` 는 필터 적용 후 전체, `job` 은 그 중 한 페이지다.
- **제거된 파라미터**: `server`, `sort`. 대상 서버는 경로가 정하고 정렬은 규칙으로 고정됐다.
  실어 보내도 무시될 뿐 에러는 아니라는 점까지 적었다(이전 문서는 두 값을 동작하는 것처럼 서술했다).

### Changed — 작업 기준 조회 (`api/docs/recovery/monitoring-job.md`)

**작업 객체 구조가 서버 기준 조회의 `job[]` 원소와 같아졌다.** 문서도 "차이는 원소가 하나인 것, `log` 가 있는 것,
`info.role` 이 없는 것뿐" 이라고 명시해 두 페이지를 대조해 읽을 수 있게 했다.

- 봉투는 `{ job }` 단수. 최상위 `system` 은 여기서도 제거되고 `info.source` / `info.target` 으로 통일됐다.
- **제거된 파라미터**: `server`, `serverType`, `jobName`, `status`, `sort`. 경로가 이미 작업 하나를 지목하므로
  작업을 다시 고르는 필터가 성립하지 않는다. 나눌 대상이 없어 `page` · `limit` 도 받지 않는다.
- **500 에러 블록 신설** — `JOB-ERROR-16`. 작업은 있는데 짝이 되는 작업 정보 행이 없는 경우로,
  필터 불일치가 아니라 데이터 결손이라 재시도로 해소되지 않는다는 점을 적었다.

### Changed — 두 문서 공통

- **`detail` 파라미터의 의미가 확정됐다.** 이전에는 값을 받기만 하고 응답이 달라지지 않았다.
  이제 기본 `false` = 경량(상태·진행률·시각), `true` = 파티션/드라이브별 `details[]`(+ 작업 기준 조회에서는 `log`).
  `detail=false` 면 해당 키가 **아예 없다**(빈 배열이 아니다). `?detail` 처럼 값 없이 보내면 `true` 다 —
  다른 파라미터의 "빈 값 400" 과 어긋나는 예외라 따로 짚었다.
- **`percent` 표기 규칙을 표로 고정**했다(두 경로 공용). 진행 정보 없음 + `Complete` 는 `"100%"`,
  진행 정보가 있어도 값이 비면 `"-"`, 그 외 미완료는 `"-"`.
- **필터 결과 0건은 200 이고 404 가 아니다.** 다만 0건의 모양이 경로마다 다르다 —
  서버 기준은 `job: []`, 작업 기준은 `details: []`(경로가 지목한 작업 자체는 감춰지지 않는다).
- **404 조건을 각 경로에서 하나로 좁혔다** — 서버 기준은 서버 미존재(`SERVER-ERROR-01`),
  작업 기준은 작업 미존재(`JOB-ERROR-01`). `center` 를 지정했고 그 범위 밖이면 같은 404 다.
- **`page` 범위 초과 시 `job: []` + `summary.total > 0` 은 정상**임을 별도로 못 박았다.
  "작업 없음" 으로 오독하기 쉬운 자리라, 작업 유무는 `summary.total` 로 판단하라고 적었다.
- **`partition` / `drive` / `mode` 가 두 경로에서 다르게 작동하는 비대칭**을 양쪽 참고 항목에 적었다.
  서버 기준에서는 일치 행이 없는 작업이 `job` 배열에서 **제외**되고, 작업 기준에서는 `details[]` 행만 좁혀진다.
  의도된 차이임을 명시했다.
- `details[]` 의 한 행은 (파티션, 백업 작업, 백업 이미지) 조합이라 같은 파티션이 여러 번 실릴 수 있고
  **`backupFile` 이 그 행들을 구분하는 값**이라는 주의를 넣었다. 파티션 이름만으로 행을 식별하지 않도록.

### Added — 「대시보드 연동 가이드」 신설 (두 문서)

폴링 소비자를 대상으로 한 절을 양쪽 문서 끝에 새로 만들었다. 문서가 필드 사전에 그치던 것을 호출 패턴까지 안내한다.

- **2단 조회 패턴** — 목록·상태 타일은 서버 기준 경량 조회로 반복, 상세 클릭 시 `info.id` 를 작업 기준 조회에 넘겨
  `detail=true` 로 1회. 두 문서에 같은 표를 두어 어느 쪽에서 읽어도 상대 경로를 찾을 수 있게 했다.
- **폴링 주기** — 5초 미만 비권장, `detail=true` 는 폴링용이 아님, 전체 목록 조회(`GET /recoveries`)를 폴링에 쓰지 말 것.
- **토큰 만료 처리** — 유효 기간 1시간·refresh 토큰 없음을 전제로 `401 → 재발급 → 같은 요청 1회 재시도 → 그래도 401 이면 중단`.
  매 요청 재발급은 `429` 로 이어진다는 경고를 함께 적었다.
- **로그는 작업 기준 조회에서만 나온다** — 서버 기준은 `detail=true` 라도 `log` 를 반환하지 않는다.
  폴링 경로에 작업마다의 로그 전 이력 조회를 지우지 않기 위한 설계라는 이유까지 적었다.
- **빈 응답의 해석**(서버 기준) — `job: []` + `total > 0`(페이지 범위 밖) / `job: []` + `total == 0`(조건 불일치) / `404`(서버 없음) 3분기.
- **다중 center** — 작업 이름은 center 사이에서 유일하지 않다. 이름으로 조회하면 `center` 로 범위를 지정할 것.

### 손대지 않은 것 (판정 근거)

- **버전 스냅샷 무변경** — 3.0.0 wrapper 는 공용 include 를 그대로 `include` 하는 껍데기라 위 재작성이 자동 반영된다.
  1.x·2.x wrapper 7종은 전부 보존본(`monitoring-system/1.3.1.md` · `2.0.2.md`, `monitoring-job/1.3.1.md` · `2.0.2.md`)을
  가리키고 있어(전수 확인) **당시 계약 그대로** 남는다. 공용 include 를 직접 include 하는 것은 3.0.0 wrapper 뿐이다.
- **recovery 도메인의 다른 페이지** — 이번 변경은 모니터링 두 경로에 한정된다.
  참고로 `GET /recoveries/monitoring/images` 는 이 저장소에 페이지가 없다(이번 범위 밖, 미조치).
- `navigation.yml` · `versions.yml` — 신규/삭제 페이지가 없어 변경 없음.
- CLI 문서 — 이번 계약 변경이 CLI 옵션 표기에 미치는 영향은 **별도 확인 대상**이다. 이번 범위에서 손대지 않았다.

### 남은 작업 — 사용자 몫
- `./run.sh --build` 로 Jekyll 빌드 검증 (이번 작업에서는 실행하지 않았다).

---

## [Documentation] - 2026-09-01 (CLI backup image list 신설 · 출력 스트림 분리 안내 보강)

### Context
- v3.0.0 CLI 문서에 누락돼 있던 두 항목 보강. `backup image list`(3단 커맨드, `backup > image > list`) 문서가 아예 없었고,
  v3.0.0 changelog 에는 출력 스트림(stdout/stderr) 분리라는 사용자 영향 있는 변경이 빠져 있었다.

### Added
- `cli/docs/backup/image-list.md` — 신규 문서. cloud-auth 의 `zos-list` 등 기존 3단 커맨드 문서화 관례(`{group}/{action}.md` 평면 배치)를 따라 `backup/` 아래 `image-list.md` 로 배치. 옵션은 `zdm-cli-v2` 소스(`backup/subCommands/image/subCommands/list/options/index.ts`)에서 직접 확인.
- `zdm/ko/cli/3.0.0/docs/backup/image-list.md` — wrapper.
- `navigation.yml` — `ko-cli-3.0.0` Backup 섹션에 `backup image list` 항목 추가 (`backup list` 바로 아래 — 같은 "목록 조회" 계열, `recovery` 섹션에서 `image-regist` 가 `regist` 옆에 붙는 것과 같은 원리).
- `cli/changelog/3.0.0.md` — `backup image list` 신규 항목(`recovery image-regist` 항목 바로 다음에 배치, 파일명을 찾을 방법이 없던 문제 해결로 이어지게) + 출력 스트림 분리(stdout/stderr) 항목 추가. summary 줄도 갱신.
- `cli/docs/backup/overview.md` 하위 명령어 표에 `image list` 행 추가. 이 공용 파일은 2.0.0/2.0.2/3.0.0 이 함께 참조하고 있어 **버전별 문서 분리 절차**(CLAUDE.md 5단계) 적용 — 기존 내용을 `overview/2.0.2.md` 로 보존하고 2.0.0/2.0.2 wrapper 를 그쪽으로 리타겟, 공용 파일만 3.0.0 기준으로 갱신.

### Changed
- `cli/docs/recovery/image-regist.md` — `backup image list` 로의 상호 참조 링크 1줄 추가 (`--backup-file` 값을 어디서 찾는지).
- `versions.yml` — cli 3.0.0 항목의 `docs:` 주석에 이번에 추가된 두 항목 반영.

### Notes
- `recovery/overview.md` 하위 커맨드 표에는 원래 `recovery image-regist` 도 빠져 있다(3.0.0 릴리즈 당시부터 그랬음). 이번 작업 범위 밖이라 미조치.
- 신규 문서·changelog 의 크로스 링크 경로는 `/zdm/ko/cli/3.0.0/...` 로 하드코딩 — 기존 changelog 링크와 동일한 방식이라 그대로 따랐다. 다음 CLI 버전에서 이 페이지들이 버전별로 분리되면 갱신이 필요하다.

### Verified
- `bundle exec jekyll build` 성공 (신규 페이지 렌더링, 사이드바 링크, 상호 참조 링크, 랜딩페이지 changelog 반영 확인).

### 남은 작업 — 사용자 몫
- 빌드 결과 확인 후 커밋.

---

## [Documentation] - 2026-09-01 (에러 응답 예시 전면 정정 — 45파일)

### Context
- 문서의 에러 예시가 **실제 API 응답과 달랐다.** `"message"` 에 개별 사유를 직접 넣은 예시가
  45개 파일에 걸쳐 있었다(버전 스냅샷 9개는 정책상 제외).
- 착수 전 **dev 서버를 띄워 실제 응답을 측정**하고 그 원문을 기준으로 삼았다. 추론으로 쓰지 않았다.

### Fixed — 응답 형식

실측으로 확정한 형식:

```
error.message  = error-code.ts 의 고정 문자열 (개별 사유가 여기 오지 않는다)
error.details  = { 필드명: [사유, ...] }        검증 에러에만 존재
검증 외 에러(404·401 등)는 details 키 자체가 없다
봉투 = {traceId, success, error, timestamp}     timestamp 는 오프셋 포함 ISO
```

- `DTO-VALIDATION-01` **422** `"Request body validation failed."`
- `DTO-VALIDATION-02` **400** `"URL parameter validation failed."`
- `DTO-VALIDATION-03` **400** `"Query parameter validation failed."`

인증 문구도 실측 확보 — `"Authentication required."` / `"Invalid token."` / `"Token expired."`

### Fixed — 형식보다 깊은 오류가 다수 나왔다

단순 문구 정정으로 시작했으나 실제로는 아래가 함께 발견됐다.

**에러 코드 자체가 틀린 것** — Center 미존재가 `JOB-ERROR-01` 이 아니라 `ZDM-ERROR-01`,
저장소 소속 불일치가 `FORBIDDEN` 이 아니라 `CENTER-ERROR-01`, 사용자 미존재가 `USER-ERROR-01` 이 아니라
`USER-ERROR-03`, replication 작업명 중복이 `JOB-ERROR-07`/409 가 아니라 `BAD_REQUEST`/**400** 등.

**zod 가 던지지 않는 것을 zod 에러로 적어둔 것** — 저장소 경로 양식 검증은 `DTO-VALIDATION-01` 이 아니라
유틸이 던지는 `BAD_REQUEST` 다. 원천적으로 나올 수 없는 코드였다.

**HTTP 라벨 오류** — body 검증(`DTO-VALIDATION-01`)이 "400 Bad Request" 로 적힌 곳이 다수.
정정 후 전 문서 대조 결과 **불일치 0건** (`-01`→422 17건 / `-02`→400 5건 / `-03`→400 46건).

**옛 응답 봉투 잔재** — `"detail": { "validationErrors": {...} }` 형태가 남아 있었다.
에러 객체화(`requestID`→`traceId`, `detail`→`error.details`) 때 따라오지 못한 것으로,
전 문서에서 제거해 **잔여 0건**.

**존재하지 않는 시나리오** — 모니터링 by-job 경로가 던지지 않는 에러가 예시로 실려 있었다.
현행 시나리오로 교체했다.

**상수명이 메시지 자리에** — `"message": "JOB_NAME_ALREADY_EXISTS"` 처럼 실제 문구가 아니라
상수 이름이 들어간 블록이 있었다.

**거짓 안내문** — "에러 문자열은 영문/한글이 혼재하며 customMessage 경로는 한글일 수 있습니다" 라는
서두 설명이 있었으나, 2026-08-27 영문 규약 이후 사실이 아니다.

### Added — 빠져 있던 에러 블록

- image recovery 전용 전량 제외 에러(`JOB-ERROR-14`)가 문서에 없었다. 일반 recovery 와 **문구가 다른
  별개 변종**(`every candidate was excluded` vs `every candidate partition was excluded`)임을 확인하고 추가

### 손대지 않은 것 (판정 근거)

- 본문 설명·표의 한글 — 문서 언어다
- `docs/error-codes.md` 의 한국어 설명 컬럼 — 이 페이지는 한글 message 예시가 0건이고
  "message 는 영문" 을 이미 명시하고 있다
- 소스 라인 번호 참조 — 문서 전반에서 어긋나 있어 일부만 고치면 오히려 불균일해진다. 별건
- 마침표 유무 비대칭(`Schedule ID '999' not found` vs `... not found.`) — 소스가 실제로 그렇다.
  문서는 실제 응답을 적는 것이므로 통일하지 않았다

### 남은 작업 — 사용자 몫
- `./run.sh --build` 로 Jekyll 빌드 검증.

---

## [Documentation] - 2026-09-01 (이력 단건 center 스코프 · 서버별 이미지 부분 실패 반영)

### Context
- `zdm-api-v2` 에서 결함 2건이 수정되어 관련 문서를 현행에 맞췄다.
  코드 변경 상세는 `zdm-api-v2/CHANGELOG.md`, 설계 근거는 `zdm-api-v2/orgs/dev/plans/DOC-01-02-03-수정계획.md`.

### Changed — 이력 **단건** 조회 (`backup/history-get.md` · `recovery/history-get.md`)

직전 갱신에서 넣었던 **"`center` 는 검증은 되지만 조회 범위를 좁히지 않는다"** 캐비앗이 낡았다 — 이제 동작한다.

- `center` 가 이름·숫자 **양쪽 분기 모두**에 적용되며, 불일치·미존재 모두 **404**
- 숫자 조회 시 **원인을 구분하는 진단 문구**가 나온다(행이 없음 / 다른 center 소속).
  이름 조회는 평범한 not-found 이고, 지정한 center 자체가 없으면 진단 문구가 아니라 기본 문구다
- 에러 코드 정정 — `JOB-ERROR-01` 이 아니라 **`NOT_FOUND`** 였다. 기존 문서의 코드·문구가 둘 다 틀렸다
- `recovery/history-get.md` 에는 **파라미터 표에 `center` 행이 아예 없어** 추가했고, **400 예시 블록도 신설**했다

**남아 있는 제약을 사실대로 적었다** — 숫자 조회는 `center` 외 필터(`server`·`partition`·`result` 등)를
**무시하는데 이름 조회는 반영한다.** 같은 엔드포인트가 identifier 형태에 따라 다르게 동작한다(코드 미수정).
`page`/`limit` 은 이 엔드포인트에서 **전혀 동작하지 않아** 기본값 표기와 예시를 정리했다.

### Changed — 서버별 이미지 조회 (`backup/images.md`)

저장소 하나가 비어 있어도 **나머지 저장소의 이미지를 200 으로 반환**한다. 이전에는 전체가 404 였다.

- "백업 이미지 미존재 (404)" 블록을 통째로 교체 — `"Backup image does not exist"` 예시 삭제
  (이 문구는 gitpage 전체에서 이 한 줄뿐이었고, 코드에서도 이 경로로 더 이상 나오지 않는다)
- **"저장소가 비어 있음" 과 "조회 결과 0건" 을 명시적으로 구분**했다.
  전자는 데몬이 스캔 후 이미지 파일이 0건이라고 회신한 **저장소 상태**로 요청한 서버와 무관하고,
  후자는 데몬이 채웠는데 그 서버/작업/파티션 것이 없는 것이다. 후자는 원래부터 200 + 빈 배열이었다
- 500 블록 헤딩을 `작업 시간 초과` → **`모든 저장소 스캔 실패`** 로 정정. 단일 조합 타임아웃은 이제
  부분 실패로 흡수되어 클라이언트에 노출되지 않는다
- 404 는 이제 **Center/Repository 자체를 못 찾은 경우에만** 남는다

### 손대지 않은 것 (근거 있음)

- `images-list.md` — "서버별 조회는 다르다" 취지의 대비 문구가 **애초에 없었다**(grep 0건)
- `recovery/regist.md` — "저장소가 비어 있으면 404" 서술이 없고, 오히려 새 동작(파티션 skip → notices,
  전량 skip 시 거절)이 **이미 정확히** 서술돼 있었다. 전량 거절 메시지는 소스와 축자 일치

### 남은 작업 — 사용자 몫
- `./run.sh --build` 로 Jekyll 빌드 검증 (이번 작업에서는 실행하지 않았다).

---

## [Documentation] - 2026-09-01 (ZDM-API 조회 계약 변경 — 3.0.0 API 문서 반영 완료)

### Context
- `zdm-api-v2` 에서 **조회 계열 공개 계약**이 바뀌어 gitpage 의 3.0.0 API 문서가 낡았던 것을 **반영 완료**했다.
  (본 항목은 처음 "낡음 기록 · 본문 미수정" 으로 작성됐다가, 같은 날 본문 반영이 결정돼 갱신된 것이다.)
  공용 include 52개 + `_data/navigation.yml` + 3.0.0 wrapper 를 수정했고, **버전 보존본은 무변경**이다.
- 3.0.0 wrapper 는 전부 공용 include(`_includes/zdm/ko/api/docs/...`) 를 가리키므로, 아래 공용 경로를 고치면 3.0.0 에 그대로 반영된다.
  구버전 보존본(`{page}/1.3.1.md` · `{page}/2.0.2.md`)은 **당시 계약 그대로이므로 미변경 대상**이다.

### Outdated — 문서와 어긋난 지점

**(1) backup 이미지 조회의 서버 식별자 — `serverName` → `server`, ID 도 허용**

- 계약: `GET /api/backups/images` 의 query 파라미터가 `server`, `GET /api/backups/images/server/{serverName}` 의 path 표기가 **`{server}`** 로 바뀌었다.
  숫자를 주면 **서버 ID** 로 보고 이름으로 해석한 뒤 이미지의 소유 서버명과 비교한다 — 이전에는 이름만 받았다.
  `center` 가 ID/이름을 한 파라미터로 받고 `centerName` 이 따로 없는 것과 같은 규칙이다.
- 고쳐야 할 곳 — `_includes/zdm/ko/api/docs/backup/images.md`
  - 섹션 헤딩 `## GET /backups/images/server/:serverName` · 엔드포인트 카드 `GET /api/backups/images/server/:serverName` → `:server`
  - 파라미터 표의 `serverName` 행 → `server`. 설명 "ZDM에 등록된 서버 이름" 도 **ID 또는 이름**으로 정정(같은 표의 `center` 행 표기와 맞춤)
  - `DTO-VALIDATION-01` 400 예시 메시지 `"서버 이름(serverName)이 필요합니다."` — 파라미터명이 노출되는 자리라 함께 낡음
  - **주의로 남길 것**: 고아 이미지(source 서버가 DB 에 없는 이미지)는 **이름으로만** 조회된다. 서버 행 자체가 없어 ID 가 존재하지 않기 때문.
    파일 상단에 이미 "고아 이미지 지원" 안내 블록이 있으므로 그 자리에 붙이면 된다.
- **문서 자체가 없는 엔드포인트** — `GET /api/backups/images`(서버 지정 없이 전체 조회)는 gitpage 에 **페이지가 없다.**
  `images.md` 는 `/server/:serverName` 경로만 다루고, `_data/navigation.yml` 의 `ko-api-3.0.0` 도 "[GET] 백업 이미지 (서버별)" 한 항목뿐이다.
  → 표 한 줄 정정이 아니라 **공용 include 신설 + nav 항목 추가 + `zdm/ko/api/3.0.0/docs/backup/` wrapper 신설**이 필요한 건이다. 아래 (2)(3)(5) 도 이 엔드포인트에 함께 걸린다.

**(2) `partition` / `drive` 동시 지정 금지 (400)**

- 계약: 두 파라미터는 **같은 컬럼을 가리키는 하나의 필터**다. 함께 주면 400.
  값 형식은 API 가 정규화하므로 `C`, `C:`, `/data` 모두 허용되고 **하나만 쓰면 된다.**
- 현재 문서는 두 행을 `Optional` 로 나란히 적어 **동시 사용이 가능한 것처럼 읽힌다.** 배타 관계와 값 정규화를 함께 적어야 한다.
- 고쳐야 할 곳 (`_includes/zdm/ko/api/docs/` 기준)
  - backup — `get.md` · `list.md` · `monitoring-job.md` · `monitoring-system.md` · `history-list.md` · `history-get.md` · `images.md`
  - recovery — `get.md` · `list.md` · `monitoring-job.md` · `monitoring-system.md` · `history-list.md` · `history-get.md`
  - server — `partitions.md` · `partition.md`
  - `images.md` 의 필터링 동작 설명은 `partition` 과 `drive` 를 **별개 필터로 서술**하고 있어(“`drive`: Windows 서버의 드라이브 문자와…”) 특히 정정 대상이다.
  - history 계열 4개는 표에 `partition` 행만 있고 `drive` 행이 없다 — 배타 안내만 추가하면 된다.

**(3) 빈 값 거절 (400) · `center` 다중 지정 · 삭제 계열 단일 제한**

- 계약: `?center=` · `?server=` 처럼 **키는 보냈는데 값이 빈 경우 400.** 이전에는 조용히 "필터 없음" 으로 처리돼 전체 범위를 조회했다.
  파라미터를 **생략**하는 것은 종전대로 "필터 없음" 이다 — 동작 변화 없음.
- `center` 는 콤마로 여러 개 지정 가능(`?center=1,zdm-b`)하며, 해석되지 않는 식별자가 있으면 **없는 것만 짚어 404** 를 낸다.
  다중 지정 자체는 일부 문서에 이미 적혀 있으나(`backup/list.md` 등의 "comma-separated 다중 가능"), **빈 값 400 과 부분 미해석 404 는 어디에도 없다.**
- **삭제 계열**(`DELETE /...?center=`)은 `center` 를 **정확히 1개만** 허용한다. 규칙 자체는 이전과 같으나 검증 위치가 서비스 → 스키마로 옮겨져 **에러 형식이 바뀌었다.**
  - `recovery/delete.md` 의 `center` 행에 남아 있는 헤지 **"스키마 정의됨, routes 적용 여부 확인 필요"** 는 이제 해소됐다 — 정정 대상.
- 고쳐야 할 곳 — **조회 계열과 삭제 계열이 규칙이 다르므로 나눠서** 손봐야 한다. (`_includes/zdm/ko/api/docs/` 기준)
  - **빈 값 400 · 다중 지정 404 (조회 계열, `center` 행 보유 22개)**
    backup(`get` · `list` · `history-get` · `history-list` · `images`) · recovery(`get` · `list`) ·
    replication(`list` · `history-get` · `history-list`) · os-replication(`list` · `history-list`) ·
    server(`get` · `list` · `partition` · `partitions`) · zdm(`repositories` · `repository`) ·
    schedule(`list`) · cloud-auth(`recovery-list` · `zos-list`) · license(`list`)
  - **빈 값 400 (`server` 행 보유 20개)** — backup · recovery · replication · os-replication 의 `list` / `get` / `monitoring-*` / `history-*` 계열
  - **`center` 정확히 1개 (삭제 계열 10개)** — backup · recovery · replication · os-replication · server · schedule · zdm 의 `delete.md`,
    `zdm/repository-delete.md`, `cloud-auth/recovery-delete.md` · `cloud-auth/zos-delete.md`
    (cloud-auth 두 페이지는 API 쪽에서 같은 삭제 쿼리 규칙을 공유한다 — 문서는 두 곳 모두 손봐야 한다)
  - 조회 계열과 삭제 계열에 **같은 문구를 복사하지 말 것** — 삭제는 다중 지정 자체가 400 이다.
- 곁가지 — `recovery/history-list.md` · `recovery/history-get.md` · `replication/get.md` · `os-replication/get.md` 는
  실제로 `center` 필터를 받는데 **파라미터 표에 `center` 행 자체가 없다.** 이번 변경 이전부터의 누락이지만, 위 (3) 반영 시 함께 보강하는 것이 자연스럽다.

**(4) 목록 조회의 빈 결과 — 200 + 빈 배열**

- 계약: `GET /api/recoveries` 등 **목록** 조회에서 필터에 맞는 항목이 없으면 **200 + 빈 배열**이다.
  이전에는 일부 경우 전체 목록이 반환되는 결함이 있었다. **단건** 조회(`GET /api/recoveries/{identifier}`)의 404 는 종전대로 — 변경 없음.
- 현재 이 동작을 적어 둔 문서는 `schedule/list.md` 하나뿐이다("일치하는 결과가 없거나 `center` 필터가 어떤 센터에도 매칭되지 않으면 빈 배열을 반환합니다 (에러가 아님)").
  **이 문장을 모델로** 나머지 목록 페이지에 추가하면 된다.
- 고쳐야 할 곳 — `recovery/list.md`(우선), `backup/list.md`, `replication/list.md`, `os-replication/list.md`, `server/list.md`,
  각 도메인의 `history-list.md`, 그리고 (1) 에서 신설이 필요한 `GET /api/backups/images` 페이지

**(5) 저장소 부분 실패 허용 (backup 이미지 목록)**

- 계약: `GET /api/backups/images` 는 저장소 하나가 응답하지 않아도 **나머지 저장소의 이미지를 200 으로 반환**한다. 이전에는 전체가 500 이었다.
  응답 스키마는 그대로이며 실패한 저장소는 서버 로그에만 남는다. **모든 저장소가 실패하면 종전대로 실패**한다.
- 고쳐야 할 곳 — `backup/images.md` 의 에러 응답 섹션. 현재 저장소 관련 실패로는 `JOB-ERROR-68`(10초 초과 500) 과
  `ZDM-REPOSITORY-ERROR-01` 만 있어, **일부 실패는 에러가 아니라는 사실이 어디에도 없다.** (1) 의 신설 페이지에도 같은 안내가 필요하다.

### Notes
- 본 변경은 **API 전용**이다. 다만 CLI 문서에도 `--partition` 과 `--drive` 를 **한 표에 나란히** 적은 곳이 두 군데 있어
  (`_includes/zdm/ko/cli/docs/recovery/list.md` · `_includes/zdm/ko/cli/docs/recovery/monit.md`),
  해당 플래그가 API 쿼리로 그대로 전달되는지에 따라 CLI 측 동반 정정이 필요한지는 **별도 확인 대상**이다.
  backup 쪽은 `list.md` 가 `--partition` 만, `monit.md` 가 `--drive` 만 갖고 있어 동시 지정 표기 문제는 없다.
- 반영을 결정할 때 **3.0.0 문서를 갱신할지, 신규 버전으로 분리할지**를 함께 판단해야 한다.
  (1)(2)(3) 은 기존 호출이 400/404 로 깨질 수 있는 계약 변경이라, CLAUDE.md 5단계의 버전별 문서 분리 절차 대상인지 여부가 갈린다.

### Added — 신규 페이지

- **`GET /api/backups/images` 페이지가 아예 없었다.** 기존 `backup/images.md` 는 `/server/:serverName` 하나만
  다뤘고 navigation 에도 "(서버별)" 만 있었다.
  - `_includes/zdm/ko/api/docs/backup/images-list.md` 신설
  - `zdm/ko/api/3.0.0/docs/backup/images-list.md` wrapper 신설
  - `_data/navigation.yml` 의 **`ko-api-3.0.0` 블록에만** "[GET] 백업 이미지 (전체)" 추가
    (다른 버전 블록 무변경 — diff 로 2줄 추가만 확인, YAML 파싱 통과)
- 신규 페이지의 핵심: **스캔 범위가 곧 비용**(조합 1개 = 데몬 왕복 1회)이며, 왕복을 줄이는 파라미터
  (`center`/`repositoryType`/`repositoryId`)와 줄이지 않는 필터(`server`/`jobName`/`repositoryPath`)를 표로 갈랐다.

### Fixed — 기존 문서의 사실 오류 (계약 변경과 무관하게 틀려 있던 것)

본문 반영 중 소스와 대조하며 발견한 것들. **계약이 바뀌어서가 아니라 원래 틀렸던 내용**이다.

- **응답 DTO 형태 전면 불일치** — `size` 가 `{raw, formatted}` 가 아니라
  `{original:{...}, compressed:{...}}`, `compression` 이 `{enabled, ratio}` 가 아니라
  `{level, ratio:{percent, formatted}|null}`. `partition` 의 `size`/`filesystem` 은 실재하지 않는 필드였다.
  `ratio` 는 절감률이라 **음수가 가능하고 원본 크기 0 이면 `null`** 이다.
- **에러 코드** — Path 검증은 `DTO-VALIDATION-01`(body 용, 422)이 아니라 **`DTO-VALIDATION-02`**(400),
  Query 는 **`DTO-VALIDATION-03`**. Center 미존재는 `JOB-ERROR-01` 이 아니라 **`ZDM-ERROR-01`**.
  타임아웃은 `JOB-ERROR-68`/10초가 아니라 **500 / 기본 30초**.
- **에러 메시지는 전부 영문이다.** `"서버 이름(serverName)이 필요합니다."` 같은 한글 메시지는 소스에 없다.
- **서버 미존재는 더 이상 404 가 아니다** — `disableNotFound: true` 라 200 + 빈 배열이다.
- `page`/`limit` 을 **둘 다 생략하면 페이지네이션 없이 전체 반환**된다(`pagination` 필드 없음).
  "기본값 1/20" 은 하나라도 지정했을 때만 적용된다.
- 바이트 포맷 예시 오류(`831622708` → `793.17 MB` 가 아니라 **`793.10 MB`**, 1024 기반).

### 남은 작업 — 사용자 몫
- `./run.sh --build` 로 Jekyll 빌드 검증 (이번 작업에서는 실행하지 않았다).
- **`docs/error-codes` 등 다른 페이지에도 위와 같은 잘못된 에러 코드·한글 메시지가 남아 있을 수 있다.**
  이번 범위 밖이라 확인만 하고 수정하지 않았다.

---

## [Documentation] - 2026-08-31 (recovery 수정 계약 변경 반영 · 에러 코드 총람 정정)

### Changed
- `api/docs/recovery/update.md` — `jobList` 항목 지목이 **파티션 → backup image 기준**으로 바뀐 것을 반영.
  필드 표를 `backupFile`(필수) + `targetPartition`(선택) 로 교체하고, 왜 바뀌었는지(1:N 매핑에서 파티션만으로는
  복구 단위가 특정되지 않음)와 미매칭 시 실패 동작(이전에는 조용히 무시)을 콜아웃으로 명시. 요청 예시 3곳 갱신.
- `cli/docs/recovery/update.md` — `--partition` → `--backup-file` + `--target-partition`. 옵션 표·예시 갱신.
  **Windows 용 옵션이 없어 파티션별 수정이 불가능하던 것**이 단일 옵션 도입으로 해소됨을 반영.

### Fixed
- `api/docs/error-codes.md` — **설명이 `-` 로 비어 있던 10건 정정.**
  원인은 코드가 아니라 **문서 생성 파서**였다. `error-code.ts` 의 `message` 는 전부 채워져 있는데,
  파서가 필드 순서에 취약해 10건을 놓쳤다. 파서를 블록 단위 추출로 고쳐 재생성했고 한국어 설명도 채웠다.
  → 총 150개 코드 전부 설명 보유 (`-` 0건).

### Verified
- `./run.sh --build` 성공.

---

## [Documentation] - 2026-08-28 (ZDM-API 3.0.0 · ZDM-CLI 3.0.0 릴리즈)

### Context
- `zdm-api-v2` / `zdm-cli-v2` 3.0.0 동시 릴리즈. **응답 봉투 breaking** 이 핵심이다 —
  `error` 가 문자열 → `{code, message, details?}` 객체, `requestID` → `traceId`, `timestamp` → ISO 8601.
- 계획: `zdm-api-v2/orgs/dev/plans/3.0.0-gitpage-문서-릴리즈-계획.md`.
  릴리즈 유형은 API **표준**(공용 75파일 중 74파일 영향) / CLI **부분 갱신**(64파일 중 30파일).

### Added — 버전 구조
- `versions.yml` — api·cli `3.0.0` 을 `latest` 로, 기존 `2.0.2` 는 `stable` 로 강등.
  **API 는 Linux 단독**, CLI 는 Windows + Linux (제품별 실제 배포 산출물에 맞춤).
- `navigation.yml` — `ko-api-3.0.0`(13섹션) · `ko-cli-3.0.0` 신설. 메인 링크도 3.0.0 intro 로.
- wrapper — `zdm/ko/api/3.0.0/` 75파일, `zdm/ko/cli/3.0.0/` 65파일.
- 바이너리 3종 배치 — `downloads/zdm-{api,cli}/3.0.0/`. `versions.yml` 이 참조하는 **전 버전 25개 경로 실존 확인**.

### Added — 신규 문서
- `api/docs/recovery/image-regist.md` — `POST /recoveries/image`. 일반 복구와의 차이, 파티션 매핑 규칙, 실제 응답 예시, 에러 4종.
- `api/docs/error-codes.md` — **에러 코드 총람 150개 / 16개 그룹**. `src/error/error-code.ts` 파싱으로 생성.
  응답에 나가지 않는 `DATABASE-ERROR-*` 는 마스킹 정책대로 제외하고 그 사실을 명시.
  **설명은 한국어**(ko 트리 일관성), 단 `error.message` 는 영문 반환임을 상단에 안내.
- `cli/docs/recovery/image-regist.md` — 실제 플래그를 CLI 소스에서 추출.
- `api/changelog/3.0.0.md` · `cli/changelog/3.0.0.md` — 사용자 체감 변경만 게재(내부 리팩터 제외).

### Changed — 문서 본문 (봉투 전환)
- **API 공용 74파일 · CLI 공용 30파일** 을 3.0.0 봉투로 전환.
  `traceId` 326곳 · ISO `timestamp` 326곳 · `error` 객체화 156곳 · `detail` → `error.details` 흡수 4건 (API 기준).
- 버전별 분리 절차 적용 — 공용을 `{page}/2.0.2.md` 로 보존 → 공용을 3.0.0 내용으로 → **구버전 wrapper 197개를 보존본으로 리타겟**.
  결과: 3.0.0 만 새 봉투, 2.0.2 이하는 기존 봉투 유지. 기존에 구버전 보존본을 가리키던 wrapper(1.3.1 등)는 미변경.
- **에러 코드 배정 156곳** — 추측 없이 세 경로로 확정: ① 문서 제목에 이미 적힌 코드 표기 ② 메시지 리터럴로 API 소스 역추적 후 `error-code.ts` 대조 ③ zod 메시지는 검증 계층(body/param/query)으로 `DTO-VALIDATION-01/02/03`.
- `recovery/regist.md` — 전량 skip 응답을 `JOB-ERROR-01`(404) → **`JOB-ERROR-14`(400)** 로 정정.
- `file/download.md` · `cloud-auth/zos-download.md` — "404 가 공통 형식을 따르지 않는다" 는 서술이 **낡은 정보가 됨**.
  API 3.0.0 이 표준 봉투로 고쳤으므로 현행 동작으로 갱신하고, 이전 버전에 그 불일치가 있었음을 함께 남김.
- `zdm/repository-{regist,verify}.md` — 응답 필드 표의 `requestID` → `traceId`.

### Fixed — 빌드 환경
- `Gemfile.lock` — `sass-embedded` 의 플랫폼 변종 3개(`arm64-darwin`/`x86_64-darwin`/`x86_64-linux-gnu`) 제거.
  **lock 이 모순 상태였다**: `PLATFORMS` 는 `x86_64-linux` 인데 변종은 `-gnu` 로만 기록돼, bundler 가 존재하지 않는
  `sass-embedded-1.69.5-x86_64-linux` 를 요구해 `bundle exec` 가 전부 실패했다. 남은 ruby 플랫폼 스펙은 전 OS 에서 동작한다.
- `run.sh` — 용도 주석, `set -euo pipefail`, 경로 독립(스크립트 위치 기준), `HOST`/`PORT` 환경변수,
  **의존성 자동 확인·설치**(같은 실패 시 원인과 대처 안내), **`--build` 모드**(서버 없이 빌드만 — 배포 전 검증용).

### Verified
- `./run.sh --build` 성공. `DocMtime: 9 api + 10 cli entries`.
- 공용 파일의 구 봉투 잔존 0 · `CODE_TODO` 0 · 구버전 보존본 오염 0 · 죽은 nav 링크 0 · 깨진 include 0.
- 불변식(`docs` 값 ↔ wrapper·nav·changelog 1:1) api·cli 모두 충족. 각 버전 블록의 링크가 자기 버전만 참조함을 전수 확인.
- 신규/변경 문서의 JSON 예시 파싱 검증 (기존 `/* ... */` 생략 주석 1건 제외).

### Notes
- 6단계(리다이렉트) **불필요** — `zdm/ko/{api,cli}/index.md` 가 `versions.yml` 의 latest 를 Liquid 로 자동 반영한다
  (파일 주석에 명시). skill 본문의 6단계 지시는 현행 구조와 어긋나 CLAUDE.md 우선 원칙으로 스킵.
- 기존 `ko-api-1.3.1` 블록의 링크 74건이 `1.3.0` 을 가리키는 불일치가 있으나 **본 작업 이전부터 존재**. 미조치.
- `backup/history-{get,list}` 는 wrapper 가 아니라 **본문 인라인**이었고, 정작 공용 include 는 아무도 참조하지 않는
  고아 상태였다(인라인본보다 최신 — `center` 필터 행 추가분 보유). 3.0.0 만 정상 패턴(include)으로 전환.
- 총람의 설명 10건이 `-` 인 것은 `error-code.ts` 의 `message` 가 비어 있기 때문이다(`SCHEDULE-ERROR-{22,39,44,47,49,50}`,
  `JOB-ERROR-{101,102,103,104}`). 임의로 채우지 않았다 — 근본 해결은 코드 쪽 `message` 보강.

### 남은 작업 — 사용자 몫
- Jekyll 빌드 결과 확인 후 커밋·푸시.

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
