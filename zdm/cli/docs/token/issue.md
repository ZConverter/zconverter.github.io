---
layout: docs
title: token issue
section_title: ZDM CLI Documentation
navigation: cli
---

API 인증을 위한 토큰을 발급합니다.

---

## `token issue` {#token-issue}

> * ZDM API 호출에 필요한 인증 토큰을 발급합니다.
> * 발급된 토큰은 설정 파일에 자동으로 저장되어 이후 API 호출에 사용됩니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli token issue [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 이메일과 비밀번호로 토큰 발급
zdm-cli token issue -m "user@example.com" -p "mypassword"

# 설정된 기본 이메일을 사용하여 토큰 발급
zdm-cli token issue -p "mypassword"

# 별칭 사용
zdm-cli token i -m "user@example.com" -p "mypassword"

# JSON 형식으로 출력
zdm-cli token issue -m "user@example.com" -p "mypassword" --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --user-mail | -m | string | Optional | 설정 파일의 기본값 | 포털 로그인 ID (이메일) | - |
| --user-pwd | -p | string | Required | - | 포털 로그인 비밀번호 | - |
| --output | -o | string | Optional | text | 출력 형식 | text, json, table |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 출력:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Token Issue Result [requestID: 912ba6eb-c160-4613-8574-c3cf47ea22a5] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Token issued successfully.
timestamp : 2026-01-06 05:47:25

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

token     : eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
expiresAt : 2026-01-06 06:47:25

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 출력:**
```json
{
  "requestID": "effe6d48-84d4-4d54-a3b6-567556c84ff5",
  "message": "Token issued successfully.",
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresAt": "2026-01-06 06:48:16"
  },
  "timestamp": "2026-01-06 05:48:16",
  "userMail": "admin@zconverter.com"
}
```

</details>

---
