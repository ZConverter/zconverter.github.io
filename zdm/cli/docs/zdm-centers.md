---
layout: docs
title: ZDM Center Management
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
        sublinks:
          - title: "ZDM 목록 조회"
            url: "/zdm/cli/docs/zdm-centers#zdm-list"
      - title: "Server Management"
        url: "/zdm/cli/docs/servers"
      - title: "License Management"
        url: "/zdm/cli/docs/licenses"
      - title: "Backup Management"
        url: "/zdm/cli/docs/backups"
      - title: "Recovery Management"
        url: "/zdm/cli/docs/recoveries"
      - title: "Schedule Management"
        url: "/zdm/cli/docs/schedules"
      - title: "File Management"
        url: "/zdm/cli/docs/files"
---

ZDM 센터 정보를 조회하고 관리합니다.

---

## ZDM Commands

### `zdm list` {#zdm-list}

ZDM 센터 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 ZDM 목록 조회
zdm-cli zdm list

# 특정 ZDM 조회 (ID)
zdm-cli zdm list --id 1

# 특정 ZDM 조회 (이름)
zdm-cli zdm list --name zdm-center-01

# 연결된 ZDM만 조회
zdm-cli zdm list --connection connect

# Repository 정보 포함 조회
zdm-cli zdm list --repository

# 상세 정보 조회
zdm-cli zdm list --detail

# 여러 필터 조합
zdm-cli zdm list --connection connect --activation ok --repository --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--name` | | string | Optional | 조회할 ZDM 이름 (단일 조회) | |
| `--id` | | number | Optional | 조회할 ZDM ID (단일 조회) | |
| `--connection` | `conn` | string | Optional | ZDM 연결 상태 | `connect`, `disconnect` |
| `--activation` | `active` | string | Optional | ZDM 활성화 상태 | `ok`, `fail` |
| `--repository` | `repo` | boolean | Optional | Repository 정보 추가조회 | |
| `--repository-only` | `ro` | boolean | Optional | Repository 정보만 조회 | |
| `--detail` | | boolean | Optional | 상세 정보 조회 | |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**기본 출력 (text):**
```text
ZDM Centers:
  ID: 1
  Name: zdm-center-01
  IP Address: 192.168.1.100
  Connection: connect
  Activation: ok
  Created At: 2025-01-15 10:30:00

  ID: 2
  Name: zdm-center-02
  IP Address: 192.168.1.101
  Connection: disconnect
  Activation: fail
  Created At: 2025-01-16 11:00:00
```

**Repository 정보 포함:**
```text
ZDM Centers:
  ID: 1
  Name: zdm-center-01
  IP Address: 192.168.1.100
  Connection: connect
  Activation: ok
  Repositories:
    - ID: 1, Path: /backup/repo01, Type: nfs
    - ID: 2, Path: /backup/repo02, Type: smb
```

</details>

---

## 연결 상태

<details markdown="1" open>
<summary><strong>연결 상태 값</strong></summary>

| 상태 | 설명 |
|------|------|
| `connect` | ZDM 센터에 정상적으로 연결됨 |
| `disconnect` | ZDM 센터 연결 끊김 |

</details>

<details markdown="1" open>
<summary><strong>활성화 상태 값</strong></summary>

| 상태 | 설명 |
|------|------|
| `ok` | ZDM 센터가 정상적으로 활성화됨 |
| `fail` | ZDM 센터 활성화 실패 |

</details>

---

## Repository 정보

<details markdown="1" open>
<summary><strong>Repository 조회</strong></summary>

Repository는 백업 데이터를 저장하는 저장소입니다.

```bash
# Repository 정보 포함 조회
zdm-cli zdm list --repository

# Repository 정보만 조회
zdm-cli zdm list --repository-only --id 1

# 특정 ZDM의 Repository 상세 조회
zdm-cli zdm list --name zdm-center-01 --repository --detail
```

**Repository 타입:**
- `nfs`: NFS 네트워크 저장소
- `smb`: SMB/CIFS 네트워크 저장소

</details>

---

## 조회 필터링

<details markdown="1" open>
<summary><strong>연결 상태별 조회</strong></summary>

```bash
# 연결된 ZDM만 조회
zdm-cli zdm list --connection connect

# 연결 끊긴 ZDM만 조회
zdm-cli zdm list --connection disconnect
```

</details>

<details markdown="1" open>
<summary><strong>활성화 상태별 조회</strong></summary>

```bash
# 활성화된 ZDM만 조회
zdm-cli zdm list --activation ok

# 활성화 실패한 ZDM만 조회
zdm-cli zdm list --activation fail
```

</details>

<details markdown="1" open>
<summary><strong>복합 필터링</strong></summary>

```bash
# 연결되고 활성화된 ZDM만 조회
zdm-cli zdm list --connection connect --activation ok

# 연결되고 활성화된 ZDM의 Repository 정보 조회
zdm-cli zdm list --connection connect --activation ok --repository --output table
```

</details>

---

## 출력 형식

<details markdown="1" open>
<summary><strong>출력 옵션</strong></summary>

```bash
# Text 형식 (기본값)
zdm-cli zdm list

# JSON 형식
zdm-cli zdm list --output json

# Table 형식
zdm-cli zdm list --output table
```

**Table 형식 예시:**
```text
+----+----------------+---------------+------------+------------+
| ID | Name           | IP Address    | Connection | Activation |
+----+----------------+---------------+------------+------------+
| 1  | zdm-center-01  | 192.168.1.100 | connect    | ok         |
| 2  | zdm-center-02  | 192.168.1.101 | disconnect | fail       |
+----+----------------+---------------+------------+------------+
```

</details>

---

## 사용 시나리오

<details markdown="1" open>
<summary><strong>ZDM 센터 현황 파악</strong></summary>

```bash
# 모든 ZDM 센터 상태 확인
zdm-cli zdm list --output table

# 문제가 있는 ZDM 센터 확인
zdm-cli zdm list --connection disconnect
zdm-cli zdm list --activation fail

# 특정 ZDM의 상세 정보 및 Repository 확인
zdm-cli zdm list --name zdm-center-01 --repository --detail
```

</details>

<details markdown="1" open>
<summary><strong>백업 전 확인</strong></summary>

```bash
# 사용 가능한 ZDM 센터 확인
zdm-cli zdm list --connection connect --activation ok

# Repository 용량 확인
zdm-cli zdm list --repository --detail --output json
```

</details>

---
