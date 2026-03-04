# API Documentation Update Log

## 날짜: 2026-03-04

### 변경 사유
- API v1.1.0 히스토리 엔드포인트 문서에 누락된 필터 파라미터 추가
- CLI v1.0.4 히스토리 서브커맨드 문서 신규 추가

---

### 변경된 파일 목록

#### [zdm/ko/api/1.1.0/index.md]
- 신규 엔드포인트 설명에 `partition`, `serverType` 필터 파라미터 명시

#### [zdm/ko/api/1.1.0/docs/backup/history-list.md]
- `partition` 쿼리 파라미터 추가 (정확 매칭)
- 파티션 필터 요청 예시 추가
- Windows 서버 파티션 정규화(`:` 자동 추가) 참고 사항 추가

#### [zdm/ko/api/1.1.0/docs/backup/history-get.md]
- `partition` 쿼리 파라미터 추가

#### [zdm/ko/api/1.1.0/docs/recovery/history-list.md]
- `serverType` 쿼리 파라미터 추가 (기본값: `target`, 선택값: `source`/`target`)
- `partition` 쿼리 파라미터 추가 (개별 항목 정확 매칭)
- 소스/타겟 서버 필터 요청 예시 추가
- `serverType`, `partition`, Windows 파티션 정규화 참고 사항 추가

#### [zdm/ko/api/1.1.0/docs/recovery/history-get.md]
- `serverType`, `partition` 쿼리 파라미터 추가

#### [zdm/ko/cli/1.0.4/index.md] (신규)
- CLI v1.0.4 버전 소개 페이지
- v1.0.3 대비 변경 사항: `backup history`, `recovery history` 서브커맨드 추가

#### [zdm/ko/cli/1.0.4/docs/backup/history.md] (신규)
- `backup history` 커맨드 문서
- 옵션: `--job-id`, `--job-name`, `--server`, `--partition`, `--result`, `--asc`
- Text/JSON 출력 예시 포함

#### [zdm/ko/cli/1.0.4/docs/recovery/history.md] (신규)
- `recovery history` 커맨드 문서
- 옵션: `--job-id`, `--job-name`, `--server`, `--server-type`, `--partition`, `--result`, `--asc`
- `--server-type` 소스/타겟 구분 설명 및 참고 사항 포함
- Text/JSON 출력 예시 포함

---

## 날짜: 2026-02-06

### 변경 사유
- Repository Update 문서와 코드 응답 형식 불일치 수정
  - backup/recovery update 응답 양식과 통일
  - `summary.state` 필드 추가
  - `repositoryInfo`에서 불필요한 필드 제거 (type, remotePath, localPath, ip)

---

## 변경된 파일 목록

### [zdm/ko/api/1.0.3/docs/zdm/repository-update.md]
- 응답 예시 JSON: `repositoryInfo`에서 `id`, `centerName`만 유지 (type, remotePath, localPath, ip 제거)
- 응답 예시 JSON: `summary.state: "success"` 필드 추가
- 응답 필드 테이블: 불필요한 필드 제거 및 `summary.state` 필드 추가
- `field: "ip"` → `field: "ipAddress"` 변경 (코드와 일치)

---

## 날짜: 2026-01-16

### 변경 사유
- Recovery 작업 등록시 `overwrite` 필드 타입 변경
  - **요청 (INPUT)**: `"allow"` / `"not allow"` (string) → `true` / `false` (boolean)
  - **응답 (OUTPUT)**: `"allow"` / `"not allow"` (string) → `"overwrite"` / `"not overwrite"` (string)

---

## 변경된 파일 목록

### [_data/zdm/api_0_3/enums.yml]
- `overwrite-options` 값 변경 (요청 본문용)
  - 기존: `"allow"`, `"not allow"`
  - 변경: `"true"`, `"false"` (boolean 타입)

### [zdm/ko/api/1.0.3/docs/recovery/regist.md]
- 요청 본문 테이블: `overwrite` 필드 타입 `string` → `boolean`으로 변경
- jobList 항목 구조 테이블: `overwrite` 필드 타입 `string` → `boolean`으로 변경
- 요청 예시 JSON: `"overwrite": "allow"` → `"overwrite": true`로 변경
- 응답 예시 JSON: `"overwrite": "allow"` → `"overwrite": "overwrite"`로 변경

### [zdm/ko/api/1.0.3/docs/recovery/list.md]
- 응답 예시 JSON (detail=true): `"overwrite": "allow"` → `"overwrite": "overwrite"`로 변경

### [zdm/ko/api/1.0.3/docs/recovery/get.md]
- 상세 응답 예시 JSON (detail=true): `"overwrite": "allow"` → `"overwrite": "overwrite"`로 변경

---

## DTO 검토 결과 (전체 도메인)

### Recovery 도메인 ✅ 변경됨
- `overwrite` 필드 타입 변경 (위 내용 참조)
- 응답 DTO: `RecoveryTypes.OverwriteState.Type` = `"overwrite" | "not overwrite"` (string)

### Backup 도메인 ✅ 일치
- `backup/regist.md` - scriptRun 값 ("before"/"after")이 스키마와 일치함
- `backup/update.md` - scriptRun 값이 스키마와 일치함
- `backup/list.md` - 변경 불필요
- `backup/get.md` - 변경 불필요
- `backup/monitoring-job.md` - 변경 불필요

### Server 도메인 ✅ 일치
- `server/list.md` - DTO 구조와 일치함
- `server/get.md` - DTO 구조와 일치함
- `server/partition.md` - DTO 구조와 일치함
- `server/partitions.md` - DTO 구조와 일치함

### Schedule 도메인 ✅ 일치
- `schedule/regist.md` - 스키마와 일치함
- `schedule/list.md` - DTO 구조와 일치함
- `schedule/get.md` - DTO 구조와 일치함

### License 도메인 ✅ 일치
- `license/list.md` - DTO 구조와 일치함
- `license/get.md` - DTO 구조와 일치함
- `license/regist.md` - DTO 구조와 일치함
- `license/assign.md` - DTO 구조와 일치함

### User 도메인 ✅ 일치
- `user/list.md` - DTO 구조와 일치함
- `user/get.md` - DTO 구조와 일치함
- `user/update.md` - DTO 구조와 일치함

### ZDM 도메인 ✅ 일치
- `zdm/list.md` - DTO 구조와 일치함
- `zdm/get.md` - DTO 구조와 일치함
- `zdm/repository.md` - DTO 구조와 일치함
- `zdm/repositories.md` - DTO 구조와 일치함
- `zdm/repository-regist.md` - DTO 구조와 일치함

### File 도메인 ✅ 일치
- `file/list.md` - DTO 구조와 일치함 (files[], totalCount)
- `file/upload.md` - DTO 구조와 일치함
- `file/download.md` - DTO 구조와 일치함

### Auth 도메인 ✅ 일치
- `auth/issue.md` - DTO 구조와 일치함 (token, expiresAt)

---

## 참고사항
- Recovery 도메인의 `overwrite` 필드만 변경됨
- **중요**: 요청(INPUT)과 응답(OUTPUT)의 타입이 다름
  - 요청: `boolean` (true/false)
  - 응답: `string` ("overwrite"/"not overwrite")
- Backup 도메인은 `overwrite` 필드를 사용하지 않아 변경 불필요
- 다른 모든 도메인은 DTO와 문서가 일치함을 확인
