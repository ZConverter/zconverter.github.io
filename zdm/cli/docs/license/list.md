---
layout: docs
title: license list
section_title: ZDM CLI Documentation
navigation: cli
---

라이센스 목록을 조회합니다.

---

## `license list` {#license-list}

> * 라이센스 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 라이센스 목록 조회
zdm-cli license list

# 특정 라이센스 조회 (ID)
zdm-cli license list --license-id 1

# 특정 타입 라이센스 조회
zdm-cli license list --type backup

# 만료 날짜로 조회
zdm-cli license list --expiration-date 2025-12-31

# 생성 날짜로 조회
zdm-cli license list --create-date 2025-01-01

# 여러 필터 조합
zdm-cli license list --type backup --expiration-date 2025-12-31 --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--license-id` | - | number | Optional | - | 라이센스 ID | - |
| `--type` | - | string | Optional | - | 라이센스 타입 | - |
| `--expiration-date` | - | string | Optional | - | 만료 날짜 (YYYY-MM-DD) | - |
| `--create-date` | - | string | Optional | - | 생성 날짜 (YYYY-MM-DD) | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```text
Licenses:
  ID: 1
  Type: backup
  Key: LICENSE-KEY-12345
  Name: Production License
  Description: Production environment license
  Created: 2025-01-15
  Expires: 2025-12-31
  Status: Active
  Assigned Server: web-server-01

  ID: 2
  Type: backup
  Key: LICENSE-KEY-67890
  Name: Development License
  Created: 2025-01-20
  Expires: 2025-06-30
  Status: Active
  Assigned Server: None
```

</details>

---

## 라이센스 타입

<details markdown="1" open>
<summary><strong>라이센스 타입 설명</strong></summary>

| 타입 | 설명 | 용도 |
|------|------|------|
| `backup` | 백업 라이센스 | 서버 백업 작업용 |
| `recovery` | 복구 라이센스 | 서버 복구 작업용 |

</details>

---

## 라이센스 상태

<details markdown="1" open>
<summary><strong>라이센스 상태 값</strong></summary>

| 상태 | 설명 |
|------|------|
| `Active` | 활성 라이센스 (사용 가능) |
| `Expired` | 만료된 라이센스 |
| `Assigned` | 서버에 할당된 라이센스 |
| `Unassigned` | 미할당 라이센스 (할당 가능) |
| `Invalid` | 유효하지 않은 라이센스 |

</details>

---

## 라이센스 조회

<details markdown="1" open>
<summary><strong>날짜별 조회</strong></summary>

```bash
# 특정 날짜에 생성된 라이센스
zdm-cli license list --create-date 2025-01-15

# 특정 날짜에 만료되는 라이센스
zdm-cli license list --expiration-date 2025-12-31

# 곧 만료될 라이센스 확인 (수동 필터링 필요)
zdm-cli license list --output json
```

</details>

<details markdown="1" open>
<summary><strong>타입별 조회</strong></summary>

```bash
# 백업 라이센스만 조회
zdm-cli license list --type backup

# 복구 라이센스만 조회
zdm-cli license list --type recovery

# 전체 라이센스 조회
zdm-cli license list --type full
```

</details>

<details markdown="1" open>
<summary><strong>할당 상태 확인</strong></summary>

```bash
# 모든 라이센스와 할당 정보 조회
zdm-cli license list --output table

# 특정 라이센스의 할당 서버 확인
zdm-cli license list --license-id 1

# JSON 형식으로 상세 정보 확인
zdm-cli license list --output json
```

</details>

---

## 출력 형식

<details markdown="1" open>
<summary><strong>출력 옵션</strong></summary>

```bash
# Text 형식 (기본값)
zdm-cli license list

# JSON 형식
zdm-cli license list --output json

# Table 형식
zdm-cli license list --output table
```

**Table 형식 예시:**
```text
+----+--------+-------------------+----------+------------+----------------+
| ID | Type   | Name              | Expires  | Status     | Assigned To    |
+----+--------+-------------------+----------+------------+----------------+
| 1  | backup | Production        | 2025-12-31| Active     | web-server-01  |
| 2  | backup | Development       | 2025-06-30| Active     | None           |
| 3  | full   | Enterprise        | 2026-12-31| Active     | db-server-01   |
+----+--------+-------------------+----------+------------+----------------+
```

</details>

---
