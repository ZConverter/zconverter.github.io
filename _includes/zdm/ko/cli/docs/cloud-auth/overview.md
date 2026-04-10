
Cloud Auth (클라우드 인증) 관리 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [인증 타입](#인증-타입)
- [지원 플랫폼](#지원-플랫폼)
- [서브커맨드](#서브커맨드)

</details>

---

## 인증 타입

<details markdown="1" open>
<summary><strong>인증 타입 설명</strong></summary>

| 타입 | 설명 |
|------|------|
| ZOS | Object Storage 인증 (OS Replication에서 사용) |
| Recovery | 복구 클라우드 인증 (Cloud Recovery에서 사용) |

</details>

---

## 지원 플랫폼

<details markdown="1" open>
<summary><strong>플랫폼별 지원</strong></summary>

**ZOS 인증**

| 플랫폼 | 설명 |
|--------|------|
| `oci` | Oracle Cloud Infrastructure |
| `nhn` | NHN Cloud |
| `ncp` | Naver Cloud Platform |
| `aws` | Amazon Web Services |
| `azure` | Microsoft Azure |
| `minio` | MinIO |

**Recovery 인증**

| 플랫폼 | 설명 |
|--------|------|
| `aws` | Amazon Web Services |
| `gcp` | Google Cloud Platform |

</details>

---

## 서브커맨드

<details markdown="1" open>
<summary><strong>서브커맨드 목록</strong></summary>

**ZOS 인증 관리**

| 커맨드 | 설명 |
|--------|------|
| `cloud-auth zos-list` | ZOS 인증 목록 조회 |
| `cloud-auth zos-regist` | ZOS 인증 등록 (키 파일 업로드) |
| `cloud-auth zos-delete` | ZOS 인증 삭제 |
| `cloud-auth zos-download` | ZOS 인증 키 파일 다운로드 |

**Recovery 인증 관리**

| 커맨드 | 설명 |
|--------|------|
| `cloud-auth recovery-list` | Recovery 인증 목록 조회 |
| `cloud-auth recovery-regist` | Recovery 인증 등록 (AWS/GCP) |
| `cloud-auth recovery-delete` | Recovery 인증 삭제 |

**공통**

| 커맨드 | 설명 |
|--------|------|
| `cloud-auth region` | 클라우드 플랫폼 리전 목록 조회 |

</details>

---
