# Changelog

모든 주요 변경 사항이 이 파일에 기록됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 합니다.

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

## [API v1.0.4] - 개발 중

### Added
- (예정)

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
