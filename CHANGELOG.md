# Changelog

모든 주요 변경 사항이 이 파일에 기록됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 합니다.

---

## [API v1.0.3] - 2026-01-29

### Changed
- **GET /backups/images/server/:serverName jobName 필터 동작 변경**
  - 정확히 일치 → 부분 일치로 변경
  - 백업 이미지 파일명에 해당 문자열이 포함된 경우 반환
  - 예시: `jobName=backupTest_ROOT_1` → `SOURCE-backupTest_ROOT_1_[2026-01-29].ZIA` 매칭
  - 관련 커밋: `06fdc3f` (Recovery 작업 등록 시 백업 이미지 조회 실패 버그 수정)
- **GET /backups/images/server/:serverName serverName 파라미터 설명 보완**
  - "ZDM에 등록된 서버 이름 (Center 이름으로 인식됨)" 명시
  - `backup_imageinfo` 테이블은 Center 이름 기준으로 저장됨을 문서화
- **POST /recoveries jobList 항목 구조 개선**
  - `backupJob` 필드 추가: 사용할 백업 작업 이름 (미지정 시 최신 성공 작업 자동 선택)
  - `backupFile` 필드 설명 상세화: 사용할 백업 이미지 파일명 (미지정 시 최신 이미지 자동 선택)
  - 요청 예시에 `backupJob`, `backupFile` 필드 추가

---

## [API v1.0.3] - 2026-01-28

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

## [API v1.0.3] - 2026-01-24

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

## [API v1.0.3] - 2025-01-16

### Changed
- Backup API 문서 업데이트
  - DELETE /backups/:identifier: `partition` 쿼리 파라미터 추가
  - POST /backups: `description` 필드 제거, `rotation` 기본값 1 명시
  - PUT /backups/:identifier: `description` 필드 제거
  - GET /backups/monitoring/job/:identifier: `serverName`, `jobName`, `page`, `limit` 파라미터 추가

---

## [Documentation] - 2025-01-14

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

## [Documentation] - 2025-01-12

### Added
- CHANGELOG.md 생성
- CONTRIBUTING.md 개발자 가이드 분리

### Changed
- README.md 공개용으로 간소화
- 데이터 폴더 네이밍 규칙 변경 (`1.0.3` → `v1_0_3`)
  - Jekyll의 점(.) 제거 문제 해결
