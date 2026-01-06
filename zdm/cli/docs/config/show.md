---
layout: docs
title: config show
section_title: ZDM CLI Documentation
navigation: cli
---

Config 파일의 현재 설정 내용을 조회합니다.

---

## `config show` {#config-show}

> * Config 파일에 저장된 설정 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli config show [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 사용 (text 형식 출력)
zdm-cli config show

# JSON 형식으로 출력
zdm-cli config show --output json

# Table 형식으로 출력
zdm-cli config show --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--output` | `-o` | string | Optional | `text` | 출력 형식 지정 | `text`, `json`, `table` |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 출력:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Config File Contents [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[info]

config path  : /path/to/.zdm-cli.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

zconverter_dir_path    : /ZConverterManager
user.mail              : admin@example.com
token                  : eyJhbGciOiJIUzI1NiIs...
zdm.ip                 : 192.168.1.100
zdm.port               : 53307
zdm.id                 : 1
zdm.repository.id      : 1
zdm.repository.path    : /backup
zdm.zos_repository.id  : -
zdm.zos_repository.platform : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 출력:**
```json
{
  "zconverter_dir_path": "/ZConverterManager",
  "user": {
    "mail": "admin@example.com"
  },
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "zdm": {
    "ip": "192.168.1.100",
    "port": 53307,
    "id": 1,
    "repository": {
      "id": 1,
      "path": "/backup"
    },
    "zos_repository": {
      "id": null,
      "platform": null
    }
  }
}
```

</details>

---
