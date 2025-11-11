---
layout: docs
title: Recovery Management
section_title: ZDM CLI Documentation
sidebar:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/cli/docs_kr"
      - title: "Overview"
        url: "/zdm/cli/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/cli/docs_kr/authentication"
      - title: "Config Management"
        url: "/zdm/cli/docs_kr/config"
      - title: "ZDM Center Management"
        url: "/zdm/cli/docs_kr/zdm-centers"
      - title: "Server Management"
        url: "/zdm/cli/docs_kr/servers"
      - title: "License Management"
        url: "/zdm/cli/docs_kr/licenses"
      - title: "Backup Management"
        url: "/zdm/cli/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/cli/docs_kr/recoveries"
        sublinks:
          - title: "복구 목록 조회"
            url: "/zdm/cli/docs_kr/recoveries#recovery-list"
          - title: "복구 작업 등록"
            url: "/zdm/cli/docs_kr/recoveries#recovery-regist"
          - title: "복구 작업 삭제"
            url: "/zdm/cli/docs_kr/recoveries#recovery-delete"
          - title: "복구 작업 수정"
            url: "/zdm/cli/docs_kr/recoveries#recovery-update"
          - title: "복구 모니터링"
            url: "/zdm/cli/docs_kr/recoveries#recovery-monit"
      - title: "Schedule Management"
        url: "/zdm/cli/docs_kr/schedules"
      - title: "File Management"
        url: "/zdm/cli/docs_kr/files"
---

복구 작업을 등록, 조회, 수정, 삭제하고 모니터링합니다.

---

## Recovery Commands

### `recovery list` {#recovery-list}

복구 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 복구 작업 목록 조회
zdm-cli recovery list

# 특정 복구 작업 조회 (ID)
zdm-cli recovery list --id 1

# 특정 복구 작업 조회 (이름)
zdm-cli recovery list --name disaster-recovery

# 특정 소스 서버의 복구 작업 조회
zdm-cli recovery list --source web-server-01

# 특정 타겟 서버의 복구 작업 조회
zdm-cli recovery list --target recovery-server

# 작업 모드로 필터링
zdm-cli recovery list --mode full

# 작업 상태로 필터링
zdm-cli recovery list --status complete

# 상세 정보 조회
zdm-cli recovery list --detail --output table

# 여러 필터 조합
zdm-cli recovery list --source web-server-01 --mode full --status complete
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `recovery regist` {#recovery-regist}

새로운 복구 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

# 모든 옵션 포함
zdm-cli recovery regist \
  --source web-server-01 \
  --target recovery-server \
  --platform aws \
  --mode full \
  --jobName "disaster-recovery" \
  --description "Disaster recovery to AWS" \
  --afterReboot reboot \
  --overwrite allow \
  --networkLimit 1000 \
  --schedule weekly \
  --start
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `recovery delete` {#recovery-delete}

복구 작업을 삭제합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli recovery delete --id 1

# 이름으로 삭제
zdm-cli recovery delete --name disaster-recovery
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

### `recovery update` {#recovery-update}

복구 작업 정보를 수정합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

# 여러 옵션 동시 변경
zdm-cli recovery update \
  --id 1 \
  --platform aws \
  --afterReboot reboot \
  --networkLimit 1000 \
  --schedule daily
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

### `recovery monit` {#recovery-monit}

복구 작업 진행 상황을 모니터링합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

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

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

---

## 복구 모드

<details markdown="1" open>
<summary><strong>복구 모드 설명</strong></summary>

| 모드 | 설명 | 동작 방식 |
|------|------|--------------|
| `full` | 전체 복구 | 전체 시스템 복구 |
| `increment` | 증분 복구 | 변경된 데이터만 복구 |

</details>

---

## 지원 플랫폼

<details markdown="1" open>
<summary><strong>클라우드 플랫폼</strong></summary>

| 플랫폼 | 코드 | 설명 |
|--------|------|------|
| Oracle Cloud Infrastructure | `oci` | OCI |
| Naver Cloud Platform | `ncp` | NCP |
| Google Cloud Platform | `gcp` | GCP |
| Amazon Web Services | `aws` | AWS |
| Microsoft Azure | `azure` | Azure |
| Samsung Cloud Platform | `scp` | SCP |
| KT Cloud | `kt` | KT |
| NHN Cloud | `nhn` | NHN |

</details>

<details markdown="1" open>
<summary><strong>가상화 플랫폼</strong></summary>

| 플랫폼 | 코드 | 설명 |
|--------|------|------|
| VMware | `vmware` | VMware vSphere |
| OpenStack | `openstack` | OpenStack |
| CloudStack | `cloudstack` | CloudStack |
| Nutanix | `nutanix` | Nutanix AHV |
| Proxmox | `proxmox` | Proxmox VE |
| KVM | `kvm` | KVM |
| Hyper-V | `hyperv` | Microsoft Hyper-V |
| XenServer | `xenserver` | Citrix XenServer |

</details>

---

## 복구 옵션

<details markdown="1" open>
<summary><strong>부팅 모드 (afterReboot)</strong></summary>

| 모드 | 설명 | 사용 시나리오 |
|------|------|--------------|
| `reboot` | 재부팅 | 정상 복구 후 자동 재부팅 |
| `shutdown` | 종료 | 복구 후 확인 필요 시 |
| `maintain` | 유지 | 추가 작업 필요 시 |

```bash
# 재부팅 (기본값)
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --afterReboot reboot

# 종료
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --afterReboot shutdown

# 유지
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --afterReboot maintain
```

</details>

<details markdown="1" open>
<summary><strong>파티션 오버라이트 (overwrite)</strong></summary>

Linux 전용 옵션입니다.

| 값 | 설명 |
|----|------|
| `allow` | 기존 파티션 덮어쓰기 허용 |
| `notAllow` | 기존 파티션 보호 |

```bash
# 오버라이트 허용
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --overwrite allow

# 오버라이트 금지
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --overwrite notAllow
```

**주의사항:**
- `allow` 사용 시 taget 서버에 동일한 파티션이 없는경우 "/" 파티션에 강제 통합됨 ( `Linux` 전용 )

</details>

<details markdown="1" open>
<summary><strong>클라우드 인증 (cloudAuth)</strong></summary>

클라우드 플랫폼 복구 시 필요한 인증 정보입니다.

```bash
# 클라우드 인증 정보와 함께 복구
zdm-cli recovery regist \
  --source web-01 \
  --target oci-instance \
  --platform oci \
  --mode full \
  --cloudAuth oci-auth-01

# AWS 인증
zdm-cli recovery regist \
  --source db-01 \
  --target aws-instance \
  --platform aws \
  --mode full \
  --cloudAuth aws-credentials
```

**인증 정보 사전 등록:**
- 웹 포털에서 클라우드 인증 정보 등록
- 인증 정보 ID 또는 Name 사용

</details>

<details markdown="1" open>
<summary><strong>네트워크 제한</strong></summary>

```bash
# 네트워크 속도 제한 (KB/s)
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --networkLimit 1000

# 제한 없음 (기본값)
zdm-cli recovery regist --source web-01 --target recovery-01 --platform aws --mode full --networkLimit 0
```

</details>

---

## 스케줄 복구

<details markdown="1" open>
<summary><strong>예약 복구</strong></summary>

```bash
# 스케줄 복구 등록
zdm-cli recovery regist \
  --source web-01 \
  --target recovery-01 \
  --platform aws \
  --mode full \
  --schedule weekly-recovery \
  --start

# 기존 작업에 스케줄 추가
zdm-cli recovery update --id 1 --schedule weekly-recovery
```

스케줄 생성 방법은 [Schedule Management](/zdm/cli/docs_kr/schedules) 참조

</details>

---

## 스크립트 실행

<details markdown="1" open>
<summary><strong>복구 전후 스크립트</strong></summary>

```bash
# 복구 전 스크립트 실행
zdm-cli recovery regist \
  --source web-01 \
  --target recovery-01 \
  --platform aws \
  --mode full \
  --scriptPath /scripts/pre-recovery.sh \
  --scriptRun before

# 복구 후 스크립트 실행
zdm-cli recovery regist \
  --source web-01 \
  --target recovery-01 \
  --platform aws \
  --mode full \
  --scriptPath /scripts/post-recovery.sh \
  --scriptRun after
```

</details>

---