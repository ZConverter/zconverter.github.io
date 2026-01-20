---
layout: docs
title: ZDM CLI Documentation v1.0.3
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

## ZDM CLI 소개

ZDM CLI는 ZDM 서비스를 명령줄에서 관리할 수 있는 도구입니다.

---

## 주요 기능

<details markdown="1" open>
<summary><strong>핵심 기능</strong></summary>

- **토큰 기반 인증** - API 접근을 위한 토큰 발급 및 관리
- **설정 관리** - CLI 환경 설정 관리
- **서버 관리** - 서버 조회 및 관리
- **백업/복구** - 백업 및 복구 작업 등록, 조회, 수정, 삭제
- **스케줄링** - 정기적인 작업 스케줄 관리
- **파일 관리** - 파일 업로드 및 다운로드
- **라이선스 관리** - 라이선스 등록 및 할당
- **ZDM 센터 관리** - ZDM 센터 조회 및 관리
- **모니터링** - 작업 진행 상황 실시간 모니터링

</details>

---

## Quick Start

### 1. 토큰 발급

모든 CLI 명령 실행에는 인증 토큰이 필요합니다.

<details markdown="1" open>
<summary><strong>토큰 발급 예시</strong></summary>

```bash
zdm-cli token issue -m user@example.com -p your-password
```

**토큰이 자동으로 설정 파일에 저장됩니다.**

</details>

### 2. 기본 설정

ZDM 서버 정보를 설정합니다.

<details markdown="1" open>
<summary><strong>기본 설정 예시</strong></summary>

```bash
# ZDM IP 주소 설정
zdm-cli config set --zdm-ip 192.168.1.100

# ZDM ID 설정
zdm-cli config set --zdm-id zdm-center-01

# Repository ID 설정
zdm-cli config set --zdm-repo-id 1
```

</details>

### 3. CLI 명령 실행

설정이 완료되면 다양한 CLI 명령을 실행할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령 실행 예시</strong></summary>

```bash
# 서버 목록 조회
zdm-cli server list

# 백업 작업 등록
zdm-cli backup regist --server web-server-01 --mode full
```

</details>

---

## 기본 사용법

```bash
zdm-cli <command> <subcommand> [options]
```

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
  "timestamp": "2025-01-15 10:30:00"
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
  "timestamp": "2025-01-15 10:30:00"
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

## 버전 정보

```bash
# 버전 확인
zdm-cli --version

# 도움말 확인
zdm-cli --help
```

---

## 참고사항

- 모든 커맨드는 사전에 `token issue`로 인증 토큰을 발급받아야 사용 가능합니다
- `--output` 옵션으로 결과 출력 형식을 변경할 수 있습니다
- 기본 설정값은 `config set` 명령으로 미리 설정하면 매번 입력할 필요가 없습니다
- JSON 문자열 파라미터는 작은따옴표로 감싸서 입력합니다
- 스크립트 파일은 사전에 ZDM 서버에 업로드되어 있어야 합니다
