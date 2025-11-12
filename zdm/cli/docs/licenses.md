---
layout: docs
title: License Management
section_title: ZDM CLI Documentation
navigation: cli
---

라이센스를 등록, 조회, 할당합니다.

---

## License Commands

### `license list` {#license-list}

라이센스 목록을 조회합니다.

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

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--license-id` | | number | Optional | 라이센스 ID |
| `--type` | | string | Optional | 라이센스 타입 |
| `--expiration-date` | | string | Optional | 만료 날짜 (YYYY-MM-DD) |
| `--create-date` | | string | Optional | 생성 날짜 (YYYY-MM-DD) |

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

### `license assign` {#license-assign}

서버에 라이센스를 할당합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 라이센스 ID로 할당
zdm-cli license assign --license 1 --server web-server-01

# 서버 ID로 할당
zdm-cli license assign --license 1 --server 5

# 여러 서버에 순차적으로 할당
zdm-cli license assign --license 1 --server web-server-01
zdm-cli license assign --license 2 --server db-server-01
zdm-cli license assign --license 3 --server app-server-01
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--license` | | number | Required | 할당할 라이센스 ID |
| `--server` | | string | Required | 대상 서버 이름 또는 ID |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "License assigned successfully",
  "success": true,
  "data": {
    "licenseId": 1,
    "serverId": 5,
    "serverName": "web-server-01",
    "assignedAt": "2025-01-15T10:30:00Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---

### `license regist` {#license-regist}

라이센스를 등록합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 라이센스 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345

# 이름과 설명을 포함하여 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345 --name "Production License" --description "Production environment license"

# 사용자 정보를 포함하여 등록
zdm-cli license regist --center 1 --key LICENSE-KEY-12345 --user admin@example.com

# 모든 옵션을 포함한 등록
zdm-cli license regist \
  --center zdm-center-01 \
  --key LICENSE-KEY-12345 \
  --name "Production Backup License" \
  --description "License for production backup operations" \
  --user admin@example.com
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--center` | `-c` | string | Required | License를 등록할 센터 ID 또는 Name |
| `--key` | `-k` | string | Required | 등록할 License Key |
| `--user` | `-u` | string | Optional | 요청 사용자 ID 또는 메일 |
| `--name` | `-n` | string | Optional | 등록할 License Name |
| `--description` | `-d` | string | Optional | 등록할 License 설명 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "License registered successfully",
  "success": true,
  "data": {
    "licenseId": 1,
    "key": "LICENSE-KEY-12345",
    "name": "Production License",
    "type": "backup",
    "expiresAt": "2025-12-31T23:59:59.000Z",
    "createdAt": "2025-01-15T10:30:00Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
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
