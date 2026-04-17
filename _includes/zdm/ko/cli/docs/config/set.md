
Config 파일의 설정 값을 수정합니다.

---

## `config set` {#config-set}

> * Config 파일에 저장된 설정 정보를 수정합니다.
> * 최소 하나 이상의 설정 파라미터를 지정해야 합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli config set [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ZDM 서버 IP 및 포트 설정
zdm-cli config set --zdm-ip 121.189.21.220 --zdm-port 53307

# 사용자 이메일 설정
zdm-cli config set --user-mail admin@example.com

# 기본 Center ID 설정 (v2.0.0 신규)
zdm-cli config set --zdm-id 9

# 여러 설정 동시 변경
zdm-cli config set --zdm-ip 121.189.21.220 --zdm-port 53307 --zdm-id 9

# Repository ID로 path 자동 조회 설정
zdm-cli config set --zdm-repo-id 43 --auto

# Repository 수동 설정
zdm-cli config set --zdm-repo-id 43 --zdm-repo-path /backup

# SMB Repository 경로 설정 (Windows 공유 경로)
zdm-cli config set --zdm-repo-path "\\\\192.168.2.108\\ZConverter"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--user-mail` | `-mail` | string | Optional | - | 포털 로그인 ID (유효한 이메일 형식 필요) | - |
| `--token` | - | string | Optional | - | API Server 인증 토큰 | - |
| `--zdm-repo-id` | `-zri` | number | Optional | - | 기본으로 사용할 ZDM Repository ID (숫자만 입력 가능) | - |
| `--zdm-repo-path` | `-zrp` | string | Optional | - | 기본으로 사용할 ZDM Repository 경로 | - |
| `--auto` | - | boolean | Optional | - | `--zdm-repo-id`와 함께 사용 시 API에서 repository path 자동 조회 | - |
| `--zdm-ip` | `-ip` | string | Optional | - | ZDM API 서버 IP 주소 | - |
| `--zdm-port` | `-port` | number | Optional | - | ZDM API 서버 포트 번호 (숫자만 입력 가능) | - |
| `--zdm-id` | `-zi` | number | Optional | - | 기본 Center ID (숫자만 입력 가능) | - |
| `--output` | `-o` | string | Optional | `text` | 출력 형식 지정 | {% include zdm/output-formats.md %} |

> 최소 하나 이상의 설정 파라미터를 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

**변경 성공 시:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Config Update Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Update Summary]
state : success

[Changed Fields]
[Change 1]
field : zdm-ip
value : 192.168.1.1 -> 121.189.21.220

[Change 2]
field : zdm-id
value : 1 -> 9

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**변경 사항 없음:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Config Update Result [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Update Summary]
state : no_change

변경된 항목이 없습니다 (모든 값이 기존과 동일합니다)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (JSON format)</strong></summary>

**변경 성공 시:**
```json
{
  "state": "success",
  "changedFields": [
    {
      "field": "zdm-ip",
      "previous": "192.168.1.1",
      "new": "121.189.21.220"
    },
    {
      "field": "zdm-id",
      "previous": 1,
      "new": 9
    }
  ]
}
```

**변경 사항 없음:**
```json
{
  "state": "no_change",
  "message": "변경된 항목이 없습니다",
  "changedFields": []
}
```

</details>

---
