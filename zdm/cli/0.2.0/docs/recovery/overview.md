---
layout: docs
title: Recovery 개요
section_title: ZDM CLI Documentation
navigation: cli-0.2.0
---

복구 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [복구 모드](#복구-모드)
- [복구 상태](#복구-상태)
- [지원 플랫폼](#지원-플랫폼)

</details>

---

## 복구 모드

<details markdown="1" open>
<summary><strong>복구 모드 설명</strong></summary>

| 모드 | 설명 |
|------|------|
| `full` | 전체 복구 |
| `inc` | 증분 복구 |

</details>

---

## 복구 상태

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

## 지원 플랫폼

<details markdown="1" open>
<summary><strong>클라우드 플랫폼</strong></summary>

| 플랫폼 | 코드 |
|--------|------|
| Oracle Cloud Infrastructure | `oci` |
| Naver Cloud Platform | `ncp` |
| Google Cloud Platform | `gcp` |
| Amazon Web Services | `aws` |
| Microsoft Azure | `azure` |
| Samsung Cloud Platform | `scp` |
| KT Cloud | `kt` |
| NHN Cloud | `nhn` |

</details>

<details markdown="1" open>
<summary><strong>가상화 플랫폼</strong></summary>

| 플랫폼 | 코드 |
|--------|------|
| VMware | `vmware` |
| OpenStack | `openstack` |
| CloudStack | `cloudstack` |
| Nutanix | `nutanix` |
| Proxmox | `proxmox` |
| KVM | `kvm` |
| Hyper-V | `hyperv` |
| XenServer | `xenserver` |

</details>

---
