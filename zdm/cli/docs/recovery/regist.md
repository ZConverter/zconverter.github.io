---
layout: docs
title: recovery regist
section_title: ZDM CLI Documentation
navigation: cli
---

새로운 복구 작업을 등록합니다.

---

## `recovery regist` {#recovery-regist}

> * 새로운 복구 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery regist --source &lt;server&gt; --target &lt;server&gt; --platform &lt;platform&gt; --mode &lt;mode&gt; [options]</code>
</div>

</details>

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
| `--center` | - | string | Optional | - | 작업 등록 Center (config 기본값 사용) | - |
| `--source` | - | string | Required | - | 작업 대상 Source 서버 | - |
| `--target` | - | string | Required | - | 작업 대상 Target 서버 | - |
| `--platform` | - | string | Required | - | Target 서버 플랫폼 | `oci`, `ncp`, `gcp`, `aws`, `azure`, `vmware`, `scp`, `openstack`, `cloudstack`, `kt`, `nhn`, `nutanix`, `proxmox`, `kvm`, `hyperv`, `xenserver` |
| `--mode` | - | string | Required | - | 작업 모드 | `full`, `increment`, `smart` |
| `--repository-id` | `ri` | number | Optional | - | Repository ID (config 기본값 사용) | - |
| `--repository-path` | `rp` | string | Optional | - | Repository Path | - |
| `--jobName` | `name` | string | Optional | - | 작업 이름 | - |
| `--user` | - | string | Optional | - | 사용자 ID 또는 메일 | - |
| `--schedule` | `sc` | string | Optional | - | 작업에 사용할 Schedule | - |
| `--description` | `desc` | string | Optional | - | 작업 설명 | - |
| `--excludePartition` | `exp` | string | Optional | - | 작업 제외 partition | - |
| `--mailEvent` | - | string | Optional | - | 작업 이벤트 수신 mail | - |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | - |
| `--start` | - | boolean | Optional | - | 작업 자동시작 여부 | - |
| `--scriptPath` | `sp` | string | Optional | - | 실행할 스크립트 파일 경로 | - |
| `--scriptRun` | `sr` | string | Optional | - | 스크립트 실행 타이밍 | `before`, `after` |
| `--overwrite` | - | string | Optional | - | 파티션 오버라이트 허용 여부 (linux 전용) | `allow`, `notAllow` |
| `--afterReboot` | - | string | Optional | `reboot` | 복구 완료 후 동작 | `reboot`, `shutdown`, `maintain` |
| `--cloudAuth` | - | string | Optional | - | 클라우드 인증정보 ID 또는 Name | - |
| `--listOnly` | - | boolean | Optional | - | jobList에 지정된 파티션만 작업 등록 | - |
| `--jobList` | - | string | Optional | - | 사용자 커스텀 작업 등록 (JSON 문자열) | - |

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
```

스케줄 생성 방법은 [schedule create](/zdm/cli/docs/schedule/create) 참조

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
