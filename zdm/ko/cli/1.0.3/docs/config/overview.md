---
layout: docs
title: Config 개요
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

CLI 설정 파일 및 설정 관리에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [설정 파일](#설정-파일)
- [설정 우선순위](#설정-우선순위)
- [참고사항](#참고사항)

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

## 설정 우선순위

CLI 명령 실행 시 설정 값의 우선순위는 다음과 같습니다:

<details markdown="1" open>
<summary><strong>우선순위 순서</strong></summary>

1. **명령줄 파라미터** - 가장 높은 우선순위
2. **설정 파일** - 두 번째 우선순위
3. **기본값** - 가장 낮은 우선순위

**예시:**
```bash
# 설정 파일에 zdm-repo-id: 1 이 저장되어 있지만
# 명령줄에서 다른 값을 지정하면 명령줄 값이 사용됨
zdm-cli backup regist --server web-01 --mode full --repository-id 2
```

</details>

---

## 참고사항

- CLI를 처음 실행하면 자동으로 설정 디렉토리와 파일이 생성됩니다.

---
