---
layout: docs
title: Backup Management
section_title: ZDM CLI Documentation
sidebar:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/cli/index"
      - title: "Overview"
        url: "/zdm/cli/docs/overview"
      - title: "Authentication"
        url: "/zdm/cli/docs/authentication"
      - title: "Config Management"
        url: "/zdm/cli/docs/config"
      - title: "ZDM Center Management"
        url: "/zdm/cli/docs/zdm-centers"
      - title: "Server Management"
        url: "/zdm/cli/docs/servers"
      - title: "License Management"
        url: "/zdm/cli/docs/licenses"
      - title: "Backup Management"
        url: "/zdm/cli/docs/backups"
        sublinks:
          - title: "백업 목록 조회"
            url: "/zdm/cli/docs/backups#backup-list"
          - title: "백업 작업 등록"
            url: "/zdm/cli/docs/backups#backup-regist"
          - title: "백업 작업 삭제"
            url: "/zdm/cli/docs/backups#backup-delete"
          - title: "백업 작업 수정"
            url: "/zdm/cli/docs/backups#backup-update"
          - title: "백업 모니터링"
            url: "/zdm/cli/docs/backups#backup-monit"
      - title: "Recovery Management"
        url: "/zdm/cli/docs/recoveries"
      - title: "Schedule Management"
        url: "/zdm/cli/docs/schedules"
      - title: "File Management"
        url: "/zdm/cli/docs/files"
---

백업 작업을 등록, 조회, 수정, 삭제하고 모니터링합니다.

---

## Backup Commands

### `backup list` {#backup-list}

백업 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

# 여러 필터 조합
zdm-cli backup list --server web-server-01 --mode full --status complete
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `backup regist` {#backup-regist}

새로운 백업 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

# 모든 옵션 포함
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --jobName "production-backup" \
  --description "Production server full backup" \
  --partition /,/home,/var \
  --encryption \
  --rotation 5 \
  --networkLimit 1000 \
  --repository-id 1 \
  --schedule daily-schedule \
  --start
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `backup delete` {#backup-delete}

백업 작업을 삭제합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli backup delete --id 1

# 이름으로 삭제
zdm-cli backup delete --name daily-backup
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--name` | | string | Optional* | 작업 이름 |
| `--id` | | number | Optional* | 작업 ID |

> *둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

</details>

---

### `backup update` {#backup-update}

백업 작업 정보를 수정합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

# 여러 옵션 동시 변경
zdm-cli backup update \
  --id 1 \
  --mode increment \
  --compression \
  --rotation 10 \
  --networkLimit 500
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `backup monit` {#backup-monit}

백업 작업 진행 상황을 모니터링합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

## 백업 모드

<details markdown="1" open>
<summary><strong>백업 모드 설명</strong></summary>

| 모드 | 설명 | 동작 방식 |
|------|------|--------------|
| `full` | 전체 백업 | 전체 백업 |
| `increment` | 증분 백업 | 변경된 데이터만 백업 |
| `smart` | 스마트 백업 | 스케쥴에 따라 전체와 증분 백업 복합적으로 진행 |

</details>

---

## 백업 상태

<details markdown="1" open>
<summary><strong>작업 상태 값</strong></summary>

| 상태 | 설명 |
|------|------|
| `waiting` | 대기 중 |
| `start` | 시작됨 |
| `run` | 실행 중 |
| `complete` | 완료 |
| `cancel` | 취소됨 |
| `schedule` | 예약됨 |

</details>

---

## 백업 옵션

<details markdown="1" open>
<summary><strong>압축 옵션</strong></summary>

```bash
# 압축 활성화 (기본값)
zdm-cli backup regist --server web-server-01 --mode full

# 압축 비활성화
zdm-cli backup regist --server web-server-01 --mode full --no-compression

# 기존 작업 압축 활성화
zdm-cli backup update --id 1 --compression
```

</details>

<details markdown="1" open>
<summary><strong>암호화 옵션</strong></summary>

```bash
# 암호화 백업
zdm-cli backup regist --server web-server-01 --mode full --encryption

# 기존 작업 암호화 활성화
zdm-cli backup update --id 1 --encryption
```
</details>

<details markdown="1" open>
<summary><strong>파티션 선택</strong></summary>

```bash
# 특정 파티션만 백업
zdm-cli backup regist --server web-server-01 --mode full --partition /,/home

# 특정 파티션 제외
zdm-cli backup regist --server web-server-01 --mode full --excludePartition /tmp,/var/tmp

# 특정 디렉토리 제외
zdm-cli backup regist --server web-server-01 --mode full --excludeDir /home/user/temp,/var/cache
```

</details>

<details markdown="1" open>
<summary><strong>네트워크 제한</strong></summary>

```bash
# 네트워크 속도 제한 (KB/s)
zdm-cli backup regist --server web-server-01 --mode full --networkLimit 1000

# 제한 없음 (기본값)
zdm-cli backup regist --server web-server-01 --mode full --networkLimit 0

# 기존 작업 네트워크 제한 변경
zdm-cli backup update --id 1 --networkLimit 500
```

</details>

<details markdown="1" open>
<summary><strong>Rotation (반복횟수)</strong></summary>

```bash
# Rotation 설정
zdm-cli backup regist --server web-server-01 --mode full --rotation 5

# Rotation 변경
zdm-cli backup update --id 1 --rotation 10
```

</details>

---

## 스케줄 백업

<details markdown="1" open>
<summary><strong>스케줄과 함께 등록</strong></summary>

```bash
# 스케줄 백업 등록
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --schedule daily-schedule \
  --start

# 기존 작업에 스케줄 추가
zdm-cli backup update --id 1 --schedule daily-schedule

# 스케줄 제거
zdm-cli backup update --id 1 --schedule ""
```

스케줄 생성 방법은 [Schedule Management](/zdm/cli/docs/schedules) 참조

</details>

---

## 스크립트 실행

<details markdown="1" open>
<summary><strong>백업 전후 스크립트</strong></summary>

```bash
# 백업 전 스크립트 실행
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --scriptPath /scripts/pre-backup.sh \
  --scriptRun before

# 백업 후 스크립트 실행
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --scriptPath /scripts/post-backup.sh \
  --scriptRun after

# 기존 작업 스크립트 추가
zdm-cli backup update --id 1 --scriptPath /scripts/backup.sh --scriptRun before
```

**주의사항:**
- 스크립트는 서버에 미리 업로드되어 있어야 함
- 절대 경로 사용
- 실행 권한 확인

</details>

---