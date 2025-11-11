---
layout: docs
title: Authentication
section_title: ZDM CLI Documentation
sidebar:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/cli/docs_kr"
      - title: "Overview"
        url: "/zdm/cli/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/cli/docs_kr/authentication"
        sublinks:
          - title: "토큰 발급"
            url: "/zdm/cli/docs_kr/authentication#token-issue"
      - title: "Config Management"
        url: "/zdm/cli/docs_kr/config"
      - title: "ZDM Center Management"
        url: "/zdm/cli/docs_kr/zdm-centers"
      - title: "Server Management"
        url: "/zdm/cli/docs_kr/servers"
      - title: "License Management"
        url: "/zdm/cli/docs_kr/licenses"
      - title: "Backup Management"
        url: "/zdm/cli/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/cli/docs_kr/recoveries"
      - title: "Schedule Management"
        url: "/zdm/cli/docs_kr/schedules"
      - title: "File Management"
        url: "/zdm/cli/docs_kr/files"
---

모든 CLI 명령 실행에는 인증 토큰이 필요합니다. 토큰은 자동으로 설정 파일에 저장되어 이후 모든 API 호출에 사용됩니다.

---

## Token Commands

### `token issue` {#token-issue}

API 접근을 위한 인증 토큰을 발급받습니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 사용
zdm-cli token issue -m admin@example.com -p password

# 이메일 입력 없이 (config.json 파일입력값 자동으로 가져감)
zdm-cli token issue -p password
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--user-mail` | `-m` | string | Optional | 포털 로그인 ID (이메일) |
| `--user-pwd` | `-p` | string | Required | 포털 로그인 비밀번호 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "Token issued successfully",
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresAt": "2025-12-31T23:59:59.000Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---

## 토큰 저장

발급된 토큰은 자동으로 CLI 설정 파일에 저장됩니다.

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

</details>

---