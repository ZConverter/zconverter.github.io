
OS Replication 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [OS Replication 타입](#os-replication-타입)
- [모드](#모드)
- [주요 구성 요소](#주요-구성-요소)
- [서브커맨드](#서브커맨드)

</details>

---

## OS Replication 타입

<details markdown="1" open>
<summary><strong>타입 설명</strong></summary>

| 타입 | 설명 |
|------|------|
| `upload` | 로컬 저장소 → 클라우드 저장소로 복제 |
| `download` | 클라우드 저장소 → 로컬 저장소로 복제 |

</details>

---

## 모드

<details markdown="1" open>
<summary><strong>모드 설명</strong></summary>

| 모드 | 설명 |
|------|------|
| `full` | 전체 복제 |
| `incremental` | 증분 복제 (변경된 데이터만) |

</details>

---

## 주요 구성 요소

<details markdown="1" open>
<summary><strong>구성 요소</strong></summary>

| 구성 요소 | 설명 |
|-----------|------|
| Cloud Auth Key | 클라우드 스토리지 접근을 위한 인증 키 (`cloud-auth zos-regist`로 등록) |
| ZOS Repository | 클라우드 측 저장소 |
| Repository | 로컬 측 저장소 |

</details>

---

## 서브커맨드

<details markdown="1" open>
<summary><strong>서브커맨드 목록</strong></summary>

| 커맨드 | 설명 |
|--------|------|
| `os-replication list` | OS Replication 목록/정보 조회 |
| `os-replication regist` | OS Replication 등록 |
| `os-replication update` | OS Replication 수정 |
| `os-replication delete` | OS Replication 삭제 |
| `os-replication monit` | OS Replication 모니터링 |
| `os-replication history` | OS Replication 실행 이력 조회 |

</details>

---
