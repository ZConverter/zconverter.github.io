---
layout: docs
title: token issue
section_title: ZDM CLI Documentation
navigation: cli
---

API 사용을 위한 인증 토큰을 발급받습니다.

---

## `token issue` {#token-issue}

> * API 사용을 위한 인증 토큰을 발급받습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli token issue -m &lt;email&gt; -p &lt;password&gt;</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 사용
zdm-cli token issue -m admin@example.com -p password

# 이메일 입력 없이 (config.json 파일 입력값을 자동으로 가져갑니다.)
zdm-cli token issue -p password
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--user-mail` | `-m` | string | Optional | - | 포털 로그인 ID (이메일) | - |
| `--user-pwd` | `-p` | string | Required | - | 포털 로그인 비밀번호 | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

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
