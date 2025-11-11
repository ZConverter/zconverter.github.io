---
layout: docs
title: Overview
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

## 기본 사용법

```bash
zdm-cli <command> <subcommand> [options]
```

**예시:**

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 토큰 발급
zdm-cli token issue -m user@example.com -p password

# 서버 조회
zdm-cli server list --os lin

# 백업 작업 등록
zdm-cli backup regist --server web-01 --mode full
```

</details>
---

## 공통 옵션

모든 커맨드에서 사용 가능한 공통 옵션입니다.

<details markdown="1" open>
<summary><strong>출력 형식 옵션</strong></summary>

| 옵션 | 별칭 | 타입 | 설명 | 선택값 |
|------|------|------|------|--------|
| `--output` | `-o` | string | 출력 형식 지정 | `text`, `json`, `table` |

**사용 예시:**

```bash
# JSON 형식으로 출력
zdm-cli server list --output json

# 테이블 형식으로 출력
zdm-cli backup list --output table

# 텍스트 형식으로 출력 (기본값)
zdm-cli license list
```

</details>

---

## 식별자 패턴 (Identifier Pattern)

대부분의 커맨드는 유연한 식별자 해석을 지원합니다:

<details markdown="1" open>
<summary><strong>식별자 처리 방식</strong></summary>

- **숫자 값** (`1`, `123`): ID로 처리
- **문자열 값** (`"server-name"`, `"user@example.com"`): Name 또는 Email로 처리

**예시:**

```bash
# ID로 조회
zdm-cli server list --id 1

# 이름으로 조회
zdm-cli server list --name web-server-01

# 이메일로 조회
zdm-cli backup list --server user@example.com
```

</details>

---

## 응답 형식

### 성공 응답 (Success Response)

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

```json
{
  "requestID": "req-12345",
  "message": "Success",
  "success": true,
  "data": { ... },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**필드 설명:**
- `requestID`: 요청 고유 ID
- `message`: 응답 메시지
- `success`: 요청 성공 여부 (항상 `true`)
- `data`: 응답 데이터
- `timestamp`: 응답 시간 (ISO 8601 형식)

</details>

---

### 에러 응답 (Error Response)

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

```json
{
  "requestID": "req-12345",
  "message": "Error message",
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "details": { ... }
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

**필드 설명:**
- `success`: 요청 성공 여부 (항상 `false`)
- `error.code`: 에러 코드
- `error.details`: 상세 에러 정보

</details>

---

## 환경 설정

### 설정 파일 위치

<details markdown="1" open>
<summary><strong>운영체제별 경로</strong></summary>

| 운영체제 | 경로 |
|---------|------|
| Linux/macOS | `~/.zdm-cli/config.json` |
| Windows | `%USERPROFILE%\.zdm-cli\config.json` |

</details>

### 설정 파일 구조

<details markdown="1" open>
<summary><strong>JSON 구조</strong></summary>

```json
{
  "type": "",
  "zconverter_dir_path": "",
  "token": "abcdefg...",
  "user": {
    "mail": "user@zconverter.com"
  },
  "zdm": {
    "ip": "127.0.0.1",
    "port": 53307,
    "id": 1,
    "repository": {
      "id": 2,
      "path": ""
    },
    "zos_repository": {
      "id": null,
      "platform": ""
    }
  }
}
```

**필드 설명:**
- `zdm.ip`: ZDM 서버의 IP 주소
- `zdm.port`: ZDM API 서버 포트 (기본값: 53307)
- `zdm.id`: 기본으로 사용할 ZDM Center ID
- `zdm.repository.id`: 기본으로 사용할 Repository ID
- `zdm.repository.path`: 기본으로 사용할 Repository Path
- `zdm.zos_repository.id`: 기본으로 사용할 Repository ID
- `zdm.zos_repository.platform`: 기본으로 사용할 Object Storage 제공 Platform
- `token`: 인증 토큰 (자동 저장)

</details>
---

## 참고사항

- 모든 커맨드는 사전에 `token issue`로 인증 토큰을 발급받아야 사용 가능합니다
- `--output` 옵션으로 결과 출력 형식을 변경할 수 있습니다
- 기본 설정값은 `config set` 명령으로 미리 설정하면 매번 입력할 필요가 없습니다
- JSON 문자열 파라미터는 작은따옴표로 감싸서 입력합니다
- 스크립트 파일은 사전에 ZDM 서버에 업로드되어 있어야 합니다
