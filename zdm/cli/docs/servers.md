---
layout: docs
title: Server Management
section_title: ZDM CLI Documentation
navigation: cli
---

서버 목록을 조회하고 관리합니다.

---

## Server Commands

### `server list` {#server-list}

서버 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 서버 목록 조회
zdm-cli server list

# 특정 서버 조회 (ID)
zdm-cli server list --id 1

# 특정 서버 조회 (이름)
zdm-cli server list --name web-server-01

# Linux 서버만 조회
zdm-cli server list --os lin

# Windows 서버만 조회
zdm-cli server list --os win

# Source 모드 서버만 조회
zdm-cli server list --mode source

# Target 모드 서버만 조회
zdm-cli server list --mode target

# 라이센스 할당된 서버만 조회
zdm-cli server list --license-assign-only

# 라이센스 미할당 서버만 조회
zdm-cli server list --license-un-assign-only

# Partition 정보 포함 조회
zdm-cli server list --partition

# Partition 정보만 조회
zdm-cli server list --id 1 --partition-only

# 상세 정보 조회
zdm-cli server list --detail --output table

# 여러 필터 조합
zdm-cli server list --os lin --mode source --license-assign-only --partition
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

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

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**기본 출력 (text):**
```text
Servers:
  ID: 1
  Name: web-server-01
  OS: Linux
  Mode: source
  IP Address: 192.168.1.10
  License: Assigned (ID: 5)
  Status: Active
  Created At: 2025-01-15 10:30:00

  ID: 2
  Name: db-server-01
  OS: Windows
  Mode: source
  IP Address: 192.168.1.20
  License: Not Assigned
  Status: Active
  Created At: 2025-01-16 11:00:00
```

**Partition 정보 포함:**
```text
Servers:
  ID: 1
  Name: web-server-01
  OS: Linux
  Partitions:
    - Mount: /, Size: 100GB, Used: 45GB, Available: 55GB
    - Mount: /home, Size: 500GB, Used: 200GB, Available: 300GB
```

</details>

---

## 서버 OS 타입

<details markdown="1" open>
<summary><strong>OS 타입</strong></summary>

| 값 | 설명 |
|----|------|
| `win` | Windows 서버 |
| `lin` | Linux 서버 |

</details>

---

## 서버 모드

<details markdown="1" open>
<summary><strong>서버 모드 설명</strong></summary>

| 모드 | 설명 | 용도 |
|------|------|------|
| `source` | 원본 서버 | 백업 대상 서버 |
| `target` | 대상 서버 | 복구 대상 서버 |

**Source 서버:**
- 백업 작업의 원본
- 실제 운영 중인 서버
- 라이센스가 할당되어야 백업 가능

**Target 서버:**
- 복구 작업의 대상
- 새로운 서버 또는 복구용 서버
- 클라우드 인스턴스 또는 가상 머신

</details>

---

## 라이센스 관리

<details markdown="1" open>
<summary><strong>라이센스 상태별 조회</strong></summary>

```bash
# 라이센스가 할당된 서버만 조회
zdm-cli server list --license-assign-only

# 라이센스가 없는 서버만 조회
zdm-cli server list --license-un-assign-only

# 특정 라이센스가 할당된 서버 조회
zdm-cli server list --license 5

# 백업 가능한 서버 확인 (라이센스 할당 + Source 모드)
zdm-cli server list --license-assign-only --mode source
```

</details>

<details markdown="1" open>
<summary><strong>라이센스 할당</strong></summary>

서버에 라이센스를 할당하려면 License 명령을 사용합니다:

```bash
# 라이센스 할당
zdm-cli license assign --license 1 --server web-server-01

# 할당 확인
zdm-cli server list --name web-server-01
```

자세한 내용은 [License Management](/zdm/cli/docs/licenses) 참조

</details>

---

## Partition 정보

<details markdown="1" open>
<summary><strong>Partition 조회</strong></summary>

```bash
# 서버와 함께 Partition 정보 조회
zdm-cli server list --partition

# 특정 서버의 Partition만 조회
zdm-cli server list --name web-server-01 --partition-only

# 상세 Partition 정보
zdm-cli server list --id 1 --partition-only --detail
```

</details>

---

## 조회 필터링

<details markdown="1" open>
<summary><strong>OS별 조회</strong></summary>

```bash
# Linux 서버만 조회
zdm-cli server list --os lin

# Windows 서버만 조회
zdm-cli server list --os win

# Linux Source 서버만 조회
zdm-cli server list --os lin --mode source
```

</details>

<details markdown="1" open>
<summary><strong>모드별 조회</strong></summary>

```bash
# Source 서버만 조회
zdm-cli server list --mode source

# Target 서버만 조회
zdm-cli server list --mode target

# Source 서버 중 라이센스 할당된 서버
zdm-cli server list --mode source --license-assign-only
```

</details>

<details markdown="1" open>
<summary><strong>복합 필터링</strong></summary>

```bash
# 백업 가능한 Linux 서버 조회
zdm-cli server list --os lin --mode source --license-assign-only

# 복구 대상 Windows 서버 조회
zdm-cli server list --os win --mode target

# Partition 정보와 함께 상세 조회
zdm-cli server list --os lin --partition --detail --output table
```

</details>

---

## 출력 형식

<details markdown="1" open>
<summary><strong>출력 옵션</strong></summary>

```bash
# Text 형식 (기본값)
zdm-cli server list

# JSON 형식
zdm-cli server list --output json

# Table 형식
zdm-cli server list --output table
```

**Table 형식 예시:**
```text
+----+----------------+--------+--------+---------------+----------+--------+
| ID | Name           | OS     | Mode   | IP Address    | License  | Status |
+----+----------------+--------+--------+---------------+----------+--------+
| 1  | web-server-01  | Linux  | source | 192.168.1.10  | Assigned | Active |
| 2  | db-server-01   | Windows| source | 192.168.1.20  | None     | Active |
| 3  | recovery-01    | Linux  | target | 192.168.1.30  | None     | Active |
+----+----------------+--------+--------+---------------+----------+--------+
```

</details>

---