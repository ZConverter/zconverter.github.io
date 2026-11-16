
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
# 설정된 기본 이메일을 사용하여 토큰 발급
zdm-cli token issue -p mypassword

# 이메일과 비밀번호를 직접 지정하여 토큰 발급
zdm-cli token issue --user-mail admin@example.com -p mypassword

# JSON 형식으로 출력
zdm-cli token issue -p mypassword --output json

# 별칭 사용
zdm-cli token i -p mypassword
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--user-mail` | `-mail` | string | Optional | 설정 파일의 기본값 | 포털 로그인 ID (이메일). 직접 지정한 값은 요청 전에 형식을 검사하며, 잘못되면 `Invalid email format: <값>` 과 종료 코드 `2` 로 끝남 | - |
| `--user-pwd` | `-p` | string | Required | - | 포털 로그인 비밀번호 | - |
| `--output` | `-o` | string | Optional | `text` | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 출력:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Token Issue Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Token issued successfully.
timestamp : 2026-04-17 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

token     : eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
expiresAt : 2026-04-17 11:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 출력:**
```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Token issued successfully.",
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresAt": "2026-04-17 11:30:00"
  },
  "timestamp": "2026-04-17T10:30:00.000+09:00",
  "userMail": "admin@example.com"
}
```

> 출력의 `tokenUrl:` 줄은 더 이상 표준 출력에 나오지 않으므로 `-o json` 출력을 그대로 JSON 으로 파싱할 수 있습니다.

**토큰 저장 실패 시:**

발급은 성공했지만 설정 파일에 저장하지 못하면 원인을 담은 경고가 표준에러에 출력됩니다. 종료 코드는 `0` 이고 토큰은 결과에 출력되므로, 경고의 안내대로 `zdm-cli-config.json` 에 직접 등록하거나 `config set --token` 으로 저장합니다.

```
token save failed: <오류 메시지> (manual registration required in zdm-cli-config.json)
```

</details>

---
