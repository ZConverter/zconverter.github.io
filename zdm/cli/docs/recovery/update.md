---
layout: docs
title: recovery update
section_title: ZDM CLI Documentation
navigation: cli
---

복구 작업 정보를 수정합니다.

---

## `recovery update` {#recovery-update}

> * 복구 작업 정보를 수정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery update --id &lt;id&gt; | --name &lt;name&gt; [options]</code>
</div>

</details>

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
| `--id` | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| `--name` | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| `--changeName` | `chn` | string | Optional | - | 변경할 작업 이름 | - |
| `--platform` | `pf` | string | Optional | - | 변경할 플랫폼 | `oci`, `ncp`, `gcp`, `aws`, `azure`, `vmware`, `scp`, `openstack`, `cloudstack`, `kt`, `nhn`, `nutanix`, `proxmox`, `kvm`, `hyperv`, `xenserver` |
| `--schedule` | `sc` | string | Optional | - | 작업에 사용할 Schedule | - |
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment` |
| `--afterReboot` | `ar` | string | Optional | - | 작업 완료 후 부팅 모드 | `reboot`, `shutdown`, `maintain` |
| `--mailEvent` | `me` | string | Optional | - | 작업 이벤트 수신 mail | - |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | - |
| `--scriptPath` | `sp` | string | Optional | - | 작업 스크립트 경로 | - |
| `--scriptRun` | `sr` | string | Optional | - | 작업 스크립트 실행 타이밍 | `before`, `after` |
| `--status` | - | string | Optional | - | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--partition` | `pt` | string | Optional | - | 변경할 작업 대상 파티션 | - |

> <span class="required-note">*</span> 둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

</details>

---
