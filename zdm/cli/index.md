---
layout: docs
title: ZDM CLI Documentation
section_title: ZDM CLI Documentation
navigation: cli
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

**예시:**
- `zdm-cli token issue -m user@example.com -p password`
- `zdm-cli server list --os lin`
- `zdm-cli backup regist --server web-01 --mode full`

---

## 환경 설정

<details markdown="1" open>
<summary><strong>설정 파일 위치</strong></summary>

| 운영체제 | 경로 |
|---------|------|
| Linux/macOS | `~/.zdm-cli/config.json` |
| Windows | `%USERPROFILE%\.zdm-cli\config.json` |

</details>

<details markdown="1" open>
<summary><strong>설정 파일 구조</strong></summary>

```json
{
  "zdmIpAddress": "192.168.1.100",
  "zdmApiPort": 53307,
  "zdmId": "zdm-center-01",
  "zdmRepoId": 1,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

</details>

---

## 버전 정보

```bash
# 버전 확인
zdm-cli --version

# 도움말 확인
zdm-cli --help
```
