---
layout: docs
title: config show
section_title: ZDM CLI Documentation
navigation: cli
---

현재 설정된 CLI 설정 정보를 조회합니다.

---

## `config show` {#config-show}

> * 현재 설정된 CLI 설정 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli config show</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
zdm-cli config show
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```text
ZDM Configuration:
  ZDM IP Address: 192.168.1.100
  ZDM API Port: 53307
  ZDM ID: zdm-center-01
  ZDM Repository ID: 1
  Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

</details>

---

## 설정 파일

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
