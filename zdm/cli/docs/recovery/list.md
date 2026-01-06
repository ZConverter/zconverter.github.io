---
layout: docs
title: recovery list
section_title: ZDM CLI Documentation
navigation: cli
---

복구 작업 목록을 조회합니다.

---

## `recovery list` {#recovery-list}

> * 복구 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery list [options]</code>
</div>

</details>

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

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--source` | - | string | Optional | - | 작업 대상 Source 서버 | - |
| `--target` | - | string | Optional | - | 작업 대상 Target 서버 | - |
| `--name` | - | string | Optional | - | 작업 이름 | - |
| `--id` | - | number | Optional | - | 작업 ID | - |
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment` |
| `--status` | - | string | Optional | - | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--repository-path` | `rp` | string | Optional | - | 작업에 사용한 repository path | - |
| `--detail` | - | boolean | Optional | - | 상세 정보 조회 | - |

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
