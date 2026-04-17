
Recovery(복구) 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>하위 커맨드</strong></summary>

| 커맨드 | 설명 |
|--------|------|
| `recovery regist` | Recovery 작업 등록 |
| `recovery list` | Recovery 작업 목록 조회 |
| `recovery update` | Recovery 작업 수정 |
| `recovery delete` | Recovery 작업 삭제 |
| `recovery monit` | Recovery 작업 모니터링 |
| `recovery history` | Recovery 실행 히스토리 조회 |

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

<details markdown="1" open>
<summary><strong>물리 서버</strong></summary>

| 플랫폼 | 코드 |
|--------|------|
| Bare Metal | `baremetal` |

</details>

---

## 공통 파라미터

<details markdown="1" open>
<summary><strong>v2.0.0 공통 파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 설명 |
|----------|------|------|------|
| --center | -c | string | 작업 대상 Center (v2.0.0 추가) |
| --output | -o | string | 출력 형식 ({% include zdm/output-formats.md %}) |

> `--center` 파라미터는 모든 recovery 하위 커맨드에서 사용 가능합니다. 미지정시 config 설정값을 사용합니다.

</details>

---
