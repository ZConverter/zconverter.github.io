# ZDM CLI Command Reference

ZDM CLI는 ZDM 서비스를 명령줄에서 관리할 수 있는 도구입니다.

## 목차

- [개요](#개요)
- [공통 옵션](#공통-옵션)
- [Token 커맨드](#token-커맨드)
- [Config 커맨드](#config-커맨드)
- [ZDM 커맨드](#zdm-커맨드)
- [Server 커맨드](#server-커맨드)
- [License 커맨드](#license-커맨드)
- [Backup 커맨드](#backup-커맨드)
- [Recovery 커맨드](#recovery-커맨드)
- [Schedule 커맨드](#schedule-커맨드)
- [File 커맨드](#file-커맨드)

---

## 개요

### 기본 사용법

```bash
zdm-cli <command> <subcommand> [options]
```

### API 엔드포인트 구조

```
Base URL: http://{IPADDRESS}:{PORT}/api
```

---

## 공통 옵션

모든 커맨드에서 사용 가능한 공통 옵션입니다.

| 옵션 | 별칭 | 타입 | 설명 | 선택값 |
|------|------|------|------|--------|
| `--output` | `-o` | string | 출력 형식 지정 | `text`, `json`, `table` |

---

## Token 커맨드

### `token issue`

API 접근을 위한 인증 토큰을 발급받습니다.

**엔드포인트:** `POST /api/token/issue`

**사용 예시:**

```bash
# 기본 사용
zdm-cli token issue -m admin@example.com -p password

# 이메일 입력 없이 (프롬프트로 입력)
zdm-cli token issue -p password
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--user-mail` | `-m` | string | Optional | 포털 로그인 ID (이메일) |
| `--user-pwd` | `-p` | string | Required | 포털 로그인 비밀번호 |

---

## Config 커맨드

### `config show`

현재 설정된 CLI 설정 정보를 조회합니다.

**사용 예시:**

```bash
zdm-cli config show
```

### `config set`

CLI 설정 값을 변경합니다.

**사용 예시:**

```bash
# ZDM IP 주소 설정
zdm-cli config set --zdm-ip 192.168.1.100

# ZDM ID 설정
zdm-cli config set --zdm-id zdm-center-01

# Repository ID 설정
zdm-cli config set --zdm-repo-id 1
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--zdm-ip` | | string | Optional | ZDM 서버 IP 주소 |
| `--zdm-id` | | string | Optional | ZDM Center ID |
| `--zdm-repo-id` | | number | Optional | 기본 Repository ID |
| `--zdm-api-port` | | number | Optional | ZDM API 포트 번호 |

---

## ZDM 커맨드

### `zdm list`

ZDM 센터 목록을 조회합니다.

**엔드포인트:** `GET /api/zdms` | `GET /api/zdms/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 ZDM 목록 조회
zdm-cli zdm list

# 특정 ZDM 조회 (ID)
zdm-cli zdm list --id 1

# 특정 ZDM 조회 (이름)
zdm-cli zdm list --name zdm-center-01

# 연결된 ZDM만 조회
zdm-cli zdm list --connection connect

# Repository 정보 포함 조회
zdm-cli zdm list --repository

# 상세 정보 조회
zdm-cli zdm list --detail
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--name` | | string | Optional | 조회할 ZDM 이름 (단일 조회) | |
| `--id` | | number | Optional | 조회할 ZDM ID (단일 조회) | |
| `--connection` | `conn` | string | Optional | ZDM 연결 상태 | `connect`, `disconnect` |
| `--activation` | `active` | string | Optional | ZDM 활성화 상태 | `ok`, `fail` |
| `--repository` | `repo` | boolean | Optional | Repository 정보 추가조회 | |
| `--repository-only` | `ro` | boolean | Optional | Repository 정보만 조회 | |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

---

## Server 커맨드

### `server list`

서버 목록을 조회합니다.

**엔드포인트:** `GET /api/servers` | `GET /api/servers/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 서버 목록 조회
zdm-cli server list

# 특정 서버 조회 (ID)
zdm-cli server list --id 1

# 특정 서버 조회 (이름)
zdm-cli server list --name web-server-01

# Linux 서버만 조회
zdm-cli server list --os lin

# Source 모드 서버만 조회
zdm-cli server list --mode source

# 라이센스 할당된 서버만 조회
zdm-cli server list --license-assign-only

# Partition 정보 포함 조회
zdm-cli server list --partition

# 상세 정보 조회
zdm-cli server list --detail --output table
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--name` | | string | Optional | 조회할 Server 이름 (단일 조회) | |
| `--id` | | number | Optional | 조회할 Server ID (단일 조회) | |
| `--os` | | string | Optional | 조회할 Server OS | `win`, `lin` |
| `--mode` | | string | Optional | 조회할 Server 모드 | `source`, `target` |
| `--license` | | number | Optional | Server에 할당된 License ID | |
| `--license-assign-only` | `lao` | boolean | Optional | 라이센스가 할당된 Server만 조회 | |
| `--license-un-assign-only` | `luao` | boolean | Optional | 라이센스가 할당되지 않은 Server만 조회 | |
| `--partition` | | boolean | Optional | Partition 정보 추가조회 | |
| `--partition-only` | `po` | boolean | Optional | 대상 Server의 Partition정보만 조회 | |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

---

## License 커맨드

### `license list`

라이센스 목록을 조회합니다.

**엔드포인트:** `GET /api/licenses` | `GET /api/licenses/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 라이센스 목록 조회
zdm-cli license list

# 특정 라이센스 조회 (ID)
zdm-cli license list --license-id 1

# 특정 타입 라이센스 조회
zdm-cli license list --type backup

# 만료 날짜로 조회
zdm-cli license list --expiration-date 2025-12-31

# 생성 날짜로 조회
zdm-cli license list --create-date 2025-01-01
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--license-id` | | number | Optional | 라이센스 ID |
| `--type` | | string | Optional | 라이센스 타입 |
| `--expiration-date` | | string | Optional | 만료 날짜 (YYYY-MM-DD) |
| `--create-date` | | string | Optional | 생성 날짜 (YYYY-MM-DD) |

### `license assign`

서버에 라이센스를 할당합니다.

**엔드포인트:** `POST /api/licenses/assign`

**사용 예시:**

```bash
# 라이센스 할당
zdm-cli license assign --license 1 --server web-server-01
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--license` | | number | Required | 할당할 라이센스 ID |
| `--server` | | string | Required | 대상 서버 이름 또는 ID |

### `license regist`

라이센스를 등록합니다.

**엔드포인트:** `POST /api/licenses`

**사용 예시:**

```bash
# 라이센스 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345

# 이름과 설명을 포함하여 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345 --name "Production License" --description "Production environment license"

# 사용자 정보를 포함하여 등록
zdm-cli license regist --center 1 --key LICENSE-KEY-12345 --user admin@example.com
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--center` | `-c` | string | Required | License를 등록할 센터 ID 또는 Name |
| `--key` | `-k` | string | Required | 등록할 License Key |
| `--user` | `-u` | string | Optional | 요청 사용자 ID 또는 메일 |
| `--name` | `-n` | string | Optional | 등록할 License Name |
| `--description` | `-d` | string | Optional | 등록할 License 설명 |

---

## Backup 커맨드

### `backup list`

백업 작업 목록을 조회합니다.

**엔드포인트:** `GET /api/backups` | `GET /api/backups/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 백업 작업 목록 조회
zdm-cli backup list

# 특정 백업 작업 조회 (ID)
zdm-cli backup list --id 1

# 특정 백업 작업 조회 (이름)
zdm-cli backup list --name daily-backup

# 특정 서버의 백업 작업 조회
zdm-cli backup list --server web-server-01

# 작업 모드로 필터링
zdm-cli backup list --mode full

# 작업 상태로 필터링
zdm-cli backup list --status complete

# Repository 경로로 필터링
zdm-cli backup list --repository-path /backup/repo01

# 상세 정보 조회
zdm-cli backup list --detail --output table
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--server` | | string | Optional | 작업 대상 Server | |
| `--name` | | string | Optional | 작업 이름 | |
| `--id` | | number | Optional | 작업 ID | |
| `--mode` | | string | Optional | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | | string | Optional | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--repository-path` | `rp` | string | Optional | 작업에 사용한 repository path | |
| `--repository-type` | `rt` | string | Optional | 작업에 사용한 repository type | `smb`, `nfs` |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

### `backup regist`

새로운 백업 작업을 등록합니다.

**엔드포인트:** `POST /api/backups`

**사용 예시:**

```bash
# 기본 백업 작업 등록
zdm-cli backup regist --server web-server-01 --mode full

# 특정 파티션만 백업
zdm-cli backup regist --server web-server-01 --mode full --partition /,/home

# 암호화 백업 등록
zdm-cli backup regist --server web-server-01 --mode full --encryption

# 압축 없이 백업
zdm-cli backup regist --server web-server-01 --mode full --no-compression

# 스케줄과 함께 등록
zdm-cli backup regist --server web-server-01 --mode full --schedule daily-schedule --start

# 스크립트와 함께 등록
zdm-cli backup regist --server web-server-01 --mode full --scriptPath /scripts/pre-backup.sh --scriptRun before

# Repository 지정
zdm-cli backup regist --server web-server-01 --mode full --repository-id 1

# 작업 이름 및 설명 추가
zdm-cli backup regist --server web-server-01 --mode full --jobName daily-backup --description "Daily backup job"
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--center` | | string | Optional | | 작업 등록 Center (config 기본값 사용) | |
| `--server` | | string | Required | | 작업 대상 Server | |
| `--mode` | | string | Required | | 작업 모드 | `full`, `increment`, `smart` |
| `--repository-id` | `ri` | number | Optional | | Repository ID (config 기본값 사용) | |
| `--repository-path` | `rp` | string | Optional | | Repository Path | |
| `--partition` | | string | Optional | | 작업 대상 파티션 (쉼표로 구분) | |
| `--jobName` | `name` | string | Optional | | 작업 이름 | |
| `--schedule` | `sc` | string | Optional | | 작업에 사용할 Schedule | |
| `--description` | `desc` | string | Optional | | 작업 설명 | |
| `--rotation` | `rot` | number | Optional | 1 | 작업 반복횟수 | |
| `--no-compression` | `ncomp` | boolean | Optional | | 작업 압축 안함 | |
| `--encryption` | `enc` | boolean | Optional | | 작업 암호화 | |
| `--excludeDir` | `exd` | string | Optional | | 작업 제외 폴더 | |
| `--excludePartition` | `exp` | string | Optional | | 작업 제외 partition | |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | |
| `--start` | | boolean | Optional | | 작업 자동시작 여부 | |
| `--scriptPath` | `sp` | string | Optional | | 작업시 사용할 script full path | |
| `--scriptRun` | `sr` | string | Optional | | 스크립트 실행 타이밍 | `before`, `after` |
| `--individual` | `ind` | string | Optional | | 파티션별 개별 설정 (JSON 문자열) | |

### `backup delete`

백업 작업을 삭제합니다.

**엔드포인트:** `DELETE /api/backups/{IDENTIFIER}`

**사용 예시:**

```bash
# ID로 삭제
zdm-cli backup delete --id 1

# 이름으로 삭제
zdm-cli backup delete --name daily-backup
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--name` | | string | Optional* | 작업 이름 |
| `--id` | | number | Optional* | 작업 ID |

> *둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

### `backup update`

백업 작업 정보를 수정합니다.

**엔드포인트:** `PUT /api/backups/{IDENTIFIER}`

**사용 예시:**

```bash
# 작업 이름 변경
zdm-cli backup update --id 1 --changeName new-backup-name

# 작업 모드 변경
zdm-cli backup update --name daily-backup --mode increment

# 압축 및 암호화 활성화
zdm-cli backup update --id 1 --compression --encryption

# 반복횟수 및 네트워크 제한 설정
zdm-cli backup update --name daily-backup --rotation 5 --networkLimit 1000

# 스케줄 변경
zdm-cli backup update --id 1 --schedule weekly-schedule

# Repository 변경
zdm-cli backup update --id 1 --repository-id 2

# 스크립트 설정
zdm-cli backup update --id 1 --scriptPath /scripts/backup.sh --scriptRun before
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--id` | | number | Optional* | | 작업 ID | |
| `--name` | | string | Optional* | | 작업 Name | |
| `--mode` | | string | Optional | | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | | string | Optional | | 작업 상태 | |
| `--repository-id` | `ri` | number | Optional | | Repository ID | |
| `--repository-path` | `rp` | string | Optional | | Repository Path | |
| `--changeName` | `chn` | string | Optional | | 변경할 작업 이름 | |
| `--schedule` | `sc` | string | Optional | | 작업에 사용할 Schedule | |
| `--description` | `desc` | string | Optional | | 작업 설명 | |
| `--rotation` | `rot` | number | Optional | 1 | 작업 반복횟수 | |
| `--compression` | `comp` | boolean | Optional | | 작업 압축 | |
| `--encryption` | `enc` | boolean | Optional | | 작업 암호화 | |
| `--excludeDir` | `exd` | string | Optional | | 작업 제외 폴더 | |
| `--scriptPath` | `sp` | string | Optional | | 작업시 사용할 script full path | |
| `--scriptRun` | `sr` | string | Optional | | 스크립트 실행 타이밍 | `before`, `after` |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | |

> *둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

### `backup monit`

백업 작업 진행 상황을 모니터링합니다.

**엔드포인트:** `GET /api/backups/monitoring/job/{IDENTIFIER}` | `GET /api/backups/monitoring/system/{IDENTIFIER}`

**사용 예시:**

```bash
# 작업 ID로 모니터링
zdm-cli backup monit --job-id 123

# 작업 이름으로 상세 모니터링
zdm-cli backup monit --job-name "daily-backup" --detail

# 서버 ID로 모니터링
zdm-cli backup monit --server-id 456

# 서버 이름으로 상태 필터링 모니터링
zdm-cli backup monit --server-name "MyServer" --status running

# 작업 ID와 모드로 필터링 모니터링
zdm-cli backup monit --job-id 789 --mode full

# 서버와 저장소 경로로 모니터링
zdm-cli backup monit --server-name "DB-Server" --repository-path "/backup/db"
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--job-id` | `ji` | number | Optional* | 작업 ID | |
| `--job-name` | `jn` | string | Optional* | 작업 Name | |
| `--server-id` | `si` | number | Optional* | 작업 대상 Server ID | |
| `--server-name` | `sn` | string | Optional* | 작업 대상 Server Name | |
| `--mode` | | string | Optional | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | | string | Optional | 작업 상태 | |
| `--repository-path` | `rp` | string | Optional | Repository Path | |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

> *job-id/job-name 또는 server-id/server-name 중 하나는 필수이며, job과 server는 동시에 사용할 수 없습니다.

---

## Recovery 커맨드

### `recovery list`

복구 작업 목록을 조회합니다.

**엔드포인트:** `GET /api/recoveries` | `GET /api/recoveries/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 복구 작업 목록 조회
zdm-cli recovery list

# 특정 복구 작업 조회 (ID)
zdm-cli recovery list --id 1

# 특정 복구 작업 조회 (이름)
zdm-cli recovery list --name disaster-recovery

# 특정 소스 서버의 복구 작업 조회
zdm-cli recovery list --source web-server-01

# 작업 모드로 필터링
zdm-cli recovery list --mode full

# 작업 상태로 필터링
zdm-cli recovery list --status complete

# 상세 정보 조회
zdm-cli recovery list --detail --output table
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--source` | | string | Optional | 작업 대상 Source 서버 | |
| `--target` | | string | Optional | 작업 대상 Target 서버 | |
| `--name` | | string | Optional | 작업 이름 | |
| `--id` | | number | Optional | 작업 ID | |
| `--mode` | | string | Optional | 작업 모드 | `full`, `increment` |
| `--status` | | string | Optional | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--repository-path` | `rp` | string | Optional | 작업에 사용한 repository path | |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

### `recovery regist`

새로운 복구 작업을 등록합니다.

**엔드포인트:** `POST /api/recoveries`

**사용 예시:**

```bash
# 기본 복구 작업 등록
zdm-cli recovery regist --source web-server-01 --target recovery-server --platform aws --mode full

# OCI 클라우드로 복구
zdm-cli recovery regist --source db-server --target oci-instance --platform oci --mode full --cloudAuth oci-auth-01

# 부팅 모드 지정
zdm-cli recovery regist --source app-server --target recovery-01 --platform vmware --mode full --afterReboot shutdown

# 파티션 오버라이트 허용
zdm-cli recovery regist --source web-server --target recovery-02 --platform ncp --mode full --overwrite allow

# 스케줄과 함께 등록
zdm-cli recovery regist --source db-server --target recovery-03 --platform aws --mode full --schedule weekly --start

# 스크립트와 함께 등록
zdm-cli recovery regist --source app-server --target recovery-04 --platform gcp --mode full --scriptPath /scripts/pre-recovery.sh --scriptRun before

# 특정 파티션만 복구 (jobList 사용)
zdm-cli recovery regist --source web-server --target recovery-05 --platform azure --mode full --listOnly --jobList '[{"partition":"/"}]'
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--center` | | string | Optional | | 작업 등록 Center (config 기본값 사용) | |
| `--source` | | string | Required | | 작업 대상 Source 서버 | |
| `--target` | | string | Required | | 작업 대상 Target 서버 | |
| `--platform` | | string | Required | | Target 서버 플랫폼 | `oci`, `ncp`, `gcp`, `aws`, `azure`, `vmware`, `scp`, `openstack`, `cloudstack`, `kt`, `nhn`, `nutanix`, `proxmox`, `kvm`, `hyperv`, `xenserver` |
| `--mode` | | string | Required | | 작업 모드 | `full`, `increment`, `smart` |
| `--repository-id` | `ri` | number | Optional | | Repository ID (config 기본값 사용) | |
| `--repository-path` | `rp` | string | Optional | | Repository Path | |
| `--jobName` | `name` | string | Optional | | 작업 이름 | |
| `--user` | | string | Optional | | 사용자 ID 또는 메일 | |
| `--schedule` | `sc` | string | Optional | | 작업에 사용할 Schedule | |
| `--description` | `desc` | string | Optional | | 작업 설명 | |
| `--excludePartition` | `exp` | string | Optional | | 작업 제외 partition | |
| `--mailEvent` | | string | Optional | | 작업 이벤트 수신 mail | |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | |
| `--start` | | boolean | Optional | | 작업 자동시작 여부 | |
| `--scriptPath` | `sp` | string | Optional | | 실행할 스크립트 파일 경로 | |
| `--scriptRun` | `sr` | string | Optional | | 스크립트 실행 타이밍 | `before`, `after` |
| `--overwrite` | | string | Optional | | 파티션 오버라이트 허용 여부 (linux 전용) | `allow`, `notAllow` |
| `--afterReboot` | | string | Optional | `reboot` | 복구 완료 후 동작 | `reboot`, `shutdown`, `maintain` |
| `--cloudAuth` | | string | Optional | | 클라우드 인증정보 ID 또는 Name | |
| `--listOnly` | | boolean | Optional | | jobList에 지정된 파티션만 작업 등록 | |
| `--jobList` | | string | Optional | | 사용자 커스텀 작업 등록 (JSON 문자열) | |

### `recovery delete`

복구 작업을 삭제합니다.

**엔드포인트:** `DELETE /api/recoveries/{IDENTIFIER}`

**사용 예시:**

```bash
# ID로 삭제
zdm-cli recovery delete --id 1

# 이름으로 삭제
zdm-cli recovery delete --name disaster-recovery
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--name` | | string | Optional* | 작업 이름 |
| `--id` | | number | Optional* | 작업 ID |

> *둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

### `recovery update`

복구 작업 정보를 수정합니다.

**엔드포인트:** `PUT /api/recoveries/{IDENTIFIER}`

**사용 예시:**

```bash
# 작업 이름 변경
zdm-cli recovery update --id 1 --changeName new-recovery-name

# 플랫폼 변경
zdm-cli recovery update --name disaster-recovery --platform gcp

# 작업 모드 변경
zdm-cli recovery update --id 1 --mode increment

# 부팅 모드 변경
zdm-cli recovery update --id 1 --afterReboot shutdown

# 스케줄 변경
zdm-cli recovery update --name recovery-job --schedule monthly-schedule

# 네트워크 제한 설정
zdm-cli recovery update --id 1 --networkLimit 500

# 스크립트 설정
zdm-cli recovery update --id 1 --scriptPath /scripts/recovery.sh --scriptRun after

# 파티션 지정하여 업데이트
zdm-cli recovery update --id 1 --partition / --mode full
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--id` | | number | Optional* | | 작업 ID | |
| `--name` | | string | Optional* | | 작업 Name | |
| `--changeName` | `chn` | string | Optional | | 변경할 작업 이름 | |
| `--platform` | `pf` | string | Optional | | 변경할 플랫폼 | `oci`, `ncp`, `gcp`, `aws`, `azure`, `vmware`, `scp`, `openstack`, `cloudstack`, `kt`, `nhn`, `nutanix`, `proxmox`, `kvm`, `hyperv`, `xenserver` |
| `--schedule` | `sc` | string | Optional | | 작업에 사용할 Schedule | |
| `--mode` | | string | Optional | | 작업 모드 | `full`, `increment` |
| `--afterReboot` | `ar` | string | Optional | | 작업 완료 후 부팅 모드 | `reboot`, `shutdown`, `maintain` |
| `--mailEvent` | `me` | string | Optional | | 작업 이벤트 수신 mail | |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | |
| `--scriptPath` | `sp` | string | Optional | | 작업 스크립트 경로 | |
| `--scriptRun` | `sr` | string | Optional | | 작업 스크립트 실행 타이밍 | `before`, `after` |
| `--status` | | string | Optional | | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--partition` | `pt` | string | Optional | | 변경할 작업 대상 파티션 | |

> *둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

### `recovery monit`

복구 작업 진행 상황을 모니터링합니다.

**엔드포인트:** `GET /api/recoveries/monitoring/job/{IDENTIFIER}` | `GET /api/recoveries/monitoring/system/{IDENTIFIER}`

**사용 예시:**

```bash
# 작업 ID로 모니터링
zdm-cli recovery monit --job-id 123

# 작업 이름으로 상세 모니터링
zdm-cli recovery monit --job-name "disaster-recovery" --detail

# 서버 ID로 모니터링
zdm-cli recovery monit --server-id 456

# 서버 이름으로 상태 필터링 모니터링
zdm-cli recovery monit --server-name "RecoveryServer" --mode full

# 작업 ID와 파티션으로 필터링 모니터링
zdm-cli recovery monit --job-id 789 --partition /

# 서버와 드라이브로 모니터링 (Windows)
zdm-cli recovery monit --server-name "WinServer" --drive C
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--job-id` | `ji` | number | Optional* | 작업 ID | |
| `--job-name` | `jn` | string | Optional* | 작업 Name | |
| `--server-id` | `si` | number | Optional* | 작업 대상 Server ID | |
| `--server-name` | `sn` | string | Optional* | 작업 대상 Server Name | |
| `--mode` | | string | Optional | 작업 모드 | `full`, `increment` |
| `--partition` | | string | Optional | 파티션 (Linux) | |
| `--drive` | | string | Optional | 드라이브 (Windows) | |
| `--server-type` | `st` | string | Optional | 서버 타입 | `source`, `target` |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

> *job-id/job-name 또는 server-id/server-name 중 하나는 필수이며, job과 server는 동시에 사용할 수 없습니다.

---

## Schedule 커맨드

### `schedule list`

스케줄 목록을 조회합니다.

**엔드포인트:** `GET /api/schedules` | `GET /api/schedules/{IDENTIFIER}`

**사용 예시:**

```bash
# 전체 스케줄 목록 조회
zdm-cli schedule list

# 특정 스케줄 조회 (ID)
zdm-cli schedule list --id 1

# 스케줄 타입으로 필터링
zdm-cli schedule list --type 3

# 스케줄 상태로 필터링
zdm-cli schedule list --state active
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--id` | | number | Optional | 스케줄 ID | |
| `--type` | | number | Optional | 스케줄 타입 번호 | 0~11 |
| `--state` | | string | Optional | 스케줄 상태 | |

**스케줄 타입:**

| 번호 | 타입 | 설명 |
|------|------|------|
| 0 | once | 한 번 실행 |
| 1 | every minute | 매분 실행 |
| 2 | hourly | 매시간 실행 |
| 3 | daily | 매일 실행 |
| 4 | weekly | 매주 실행 |
| 5 | monthly on specific week | 매월 특정 주 |
| 6 | monthly on specific day | 매월 특정 일 |
| 7 | smart weekly on specific day | 스마트 주간 특정 요일 |
| 8 | smart monthly on specific week and day | 스마트 월간 특정 주+요일 |
| 9 | smart monthly on specific date | 스마트 월간 특정 날짜 |
| 10 | smart custom monthly on specific month, week and day | 스마트 커스텀 월간 (월+주+요일) |
| 11 | smart custom monthly on specific month and date | 스마트 커스텀 월간 (월+날짜) |

### `schedule regist`

새로운 스케줄을 등록합니다.

**엔드포인트:** `POST /api/schedules`

**사용 예시:**

```bash
# JSON 파일로 스케줄 등록
zdm-cli schedule regist --path ./schedules/daily-schedule.json
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--path` | | string | Required | 스케줄 정의 JSON 파일 경로 |

### `schedule create`

스케줄 데이터를 생성합니다. (JSON 파일 생성)

**사용 예시:**

```bash
# Type 0 (한 번 실행) 스케줄 생성
zdm-cli schedule create --type 0 --basic-year 2025 --basic-month 12 --basic-day 31 --basic-time 23:59

# Type 3 (매일 실행) 스케줄 생성
zdm-cli schedule create --type 3 --basic-time 02:00

# Type 4 (매주 실행) 스케줄 생성
zdm-cli schedule create --type 4 --basic-day 1 --basic-time 03:00

# 센터와 사용자 정보를 포함한 생성
zdm-cli schedule create --type 3 --basic-time 01:00 --center zdm-center-01 --user admin@example.com

# 저장 경로 지정
zdm-cli schedule create --type 3 --basic-time 02:00 --path ./schedules/backup-schedule.json
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--type` | `-t` | number | Required | Schedule Type (0~11, 위 스케줄 타입 참조) |
| `--path` | `-p` | string | Optional | 생성된 Schedule File 저장 Path |
| `--center` | `-c` | string | Optional | Schedule 등록 Center |
| `--user` | `-u` | string | Optional | Schedule 등록 User |
| `--basic-year` | `by` | string | Optional | Basic Schedule - 년도 설정 |
| `--basic-month` | `bm` | string | Optional | Basic Schedule - 월 설정 |
| `--basic-week` | `bw` | string | Optional | Basic Schedule - 주 설정 |
| `--basic-day` | `bd` | string | Optional | Basic Schedule - 일 설정 |
| `--basic-time` | `bt` | string | Optional | Basic Schedule - 시간 설정 |
| `--basic-interval-hour` | `bih` | string | Optional | Basic Schedule - 간격 시간 |
| `--basic-interval-minute` | `bim` | string | Optional | Basic Schedule - 간격 분 |
| `--advanced-year` | `ay` | string | Optional | Advanced Schedule - 년도 설정 (Smart Schedule용) |
| `--advanced-month` | `am` | string | Optional | Advanced Schedule - 월 설정 (Smart Schedule용) |
| `--advanced-week` | `aw` | string | Optional | Advanced Schedule - 주 설정 (Smart Schedule용) |
| `--advanced-day` | `ad` | string | Optional | Advanced Schedule - 일 설정 (Smart Schedule용) |
| `--advanced-time` | `at` | string | Optional | Advanced Schedule - 시간 설정 (Smart Schedule용) |
| `--advanced-interval-hour` | `aih` | string | Optional | Advanced Schedule - 간격 시간 (Smart Schedule용) |
| `--advanced-interval-minute` | `aim` | string | Optional | Advanced Schedule - 간격 분 (Smart Schedule용) |

**참고:**
- Basic Schedule: Type 0~6에서 사용
- Advanced Schedule: Type 7~11 (Smart Schedule)에서 사용
- 각 타입별로 필요한 파라미터가 다르므로 스케줄 타입 표를 참고하세요

### `schedule verify`

스케줄 JSON 파일을 검증합니다.

**사용 예시:**

```bash
# 스케줄 파일 검증
zdm-cli schedule verify --path ./schedules/daily-schedule.json

# 다른 경로의 스케줄 파일 검증
zdm-cli schedule verify --path /etc/zdm/schedules/backup-schedule.json
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--path` | `-p` | string | Required | 검증할 Schedule File Path |

---

## File 커맨드

### `file list`

업로드된 파일 목록을 조회합니다.

**엔드포인트:** `GET /api/files/list`

**사용 예시:**

```bash
# 파일 목록 조회 (text 형식)
zdm-cli file list

# JSON 형식으로 출력
zdm-cli file list --output json

# Table 형식으로 출력
zdm-cli file list --output table
```

**파라미터:**

별도의 쿼리 파라미터가 없습니다. 전역 옵션(`--output`)만 사용 가능합니다.

**응답 예시:**

```json
{
  "requestID": "req-abc123",
  "message": "File list retrieved successfully",
  "success": true,
  "data": {
    "files": [
      {
        "fileName": "file-1698500000000-123456789-example.txt",
        "fileOriginName": "example.txt",
        "size": "1.5 KB",
        "uploadDate": "2025-10-28 08:30:00"
      },
      {
        "fileName": "file-1698500000001-987654321-test.pdf",
        "fileOriginName": "test.pdf",
        "size": "2.3 MB",
        "uploadDate": "2025-10-28 09:15:00"
      }
    ],
    "totalCount": 2
  },
  "timestamp": "2025-10-28 08:30:00"
}
```

**출력 형식:**

- **text 형식**: 파일별로 상세 정보를 키-값 쌍으로 표시
- **table 형식**: 파일 목록을 테이블로 표시
- **json 형식**: 원본 JSON 응답 그대로 출력

### `file upload`

파일을 서버에 업로드합니다.

**엔드포인트:** `POST /api/files/upload`

**사용 예시:**

```bash
# 단일 파일 업로드
zdm-cli file upload --file-path ./backup.tar.gz

# 파일 경로를 지정하여 업로드
zdm-cli file upload --file-path /home/user/data/backup.tar.gz
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--file-path` | `-f` | string | Required | 업로드할 파일의 경로 |

### `file download`

서버에서 파일을 다운로드합니다.

**엔드포인트:** `GET /api/files/download/{fileName}`

**사용 예시:**

```bash
# 현재 디렉토리에 다운로드
zdm-cli file download --file-name backup.tar.gz

# 특정 디렉토리에 다운로드
zdm-cli file download --file-name backup.tar.gz --save-path /downloads

# 다른 이름으로 저장
zdm-cli file download --file-name backup.tar.gz --save-path /downloads/my-backup.tar.gz
```

**파라미터:**

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--file-name` | `-f` | string | Required | 다운로드할 파일명 |
| `--save-path` | `-s` | string | Optional | 저장할 경로 (기본값: 현재 디렉토리) |

**진행률 표시:**

다운로드 중에는 실시간으로 진행률이 표시됩니다:
```
Progress: 45% | 4.50MB / 10.00MB | Elapsed: 00:00:12
```

---

## 응답 형식

### 공통 응답 구조

#### 성공 응답:

```json
{
  "requestID": "req-12345",
  "message": "Success",
  "success": true,
  "data": { ... },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

#### 실패 응답:

```json
{
  "requestID": "req-12345",
  "message": "Error message",
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "details": { ... }
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

---

## 환경 설정

### 설정 파일 위치

- **Linux/macOS:** `~/.zdm-cli/config.json`
- **Windows:** `%USERPROFILE%\.zdm-cli\config.json`

### 설정 파일 구조

```json
{
  "zdmIpAddress": "192.168.1.100",
  "zdmApiPort": 53307,
  "zdmId": "zdm-center-01",
  "zdmRepoId": 1,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## 버전 정보

```bash
# 버전 확인
zdm-cli --version

# 도움말 확인
zdm-cli --help
```

---

## 문제 해결

### 인증 오류

```bash
# 토큰 재발급
zdm-cli token issue -m your-email@example.com -p your-password
```

### 연결 오류

```bash
# ZDM IP 주소 확인
zdm-cli config show

# ZDM IP 주소 재설정
zdm-cli config set --zdm-ip 192.168.1.100
```

### 디버그 모드

```bash
# 환경 변수로 로그 레벨 설정
LOG_LEVEL=debug zdm-cli backup list
```

---

## 참고사항

- 모든 커맨드는 사전에 `token issue`로 인증 토큰을 발급받아야 사용 가능합니다
- `--output` 옵션으로 결과 출력 형식을 변경할 수 있습니다 (`text`, `json`, `table`)
- 기본 설정값은 `config set` 명령으로 미리 설정하면 매번 입력할 필요가 없습니다
- JSON 문자열 파라미터는 작은따옴표로 감싸서 입력합니다
- 스크립트 파일은 사전에 ZDM 서버에 업로드되어 있어야 합니다

---

**문서 버전:** 1.0.1
**최종 수정일:** 2025-11-11
**작성자:** ZDM CLI Development Team
