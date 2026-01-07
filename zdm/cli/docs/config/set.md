---
layout: docs
title: config set
section_title: ZDM CLI Documentation
navigation: cli
---

Config 파일의 설정 값을 수정합니다.

---

## `config set` {#config-set}

> * Config 파일에 저장된 설정 정보를 수정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli config set [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ZDM 서버 IP 설정
zdm-cli config set --zdm-ip 192.168.1.100

# ZDM 서버 포트 설정
zdm-cli config set --zdm-port 53307

# 사용자 이메일 설정
zdm-cli config set --user-mail admin@example.com

# Linux 환경에서 ZConverter 디렉토리 경로 설정
zdm-cli config set --zcon-dir-path /ZConverterManager

# Windows 환경에서 ZConverter 디렉토리 경로 설정
zdm-cli config set --zcon-dir-path "C:\Program Files (x86)\ZConverter_CloudAgent"

# 여러 설정 동시 변경
zdm-cli config set --zdm-ip 192.168.1.100 --zdm-port 53307 --zdm-id 1

# Repository 설정
zdm-cli config set --zdm-repo-id 1 --zdm-repo-path /backup
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
| `--zdm-ip` | `-ip` | string | Optional | - | Portal IP 주소 | - |
| `--zdm-port` | `-port` | number | Optional | - | API Server 포트 번호 (숫자만 입력 가능) | - |
| `--zdm-id` | `-zi` | number | Optional | - | Portal ID (숫자만 입력 가능) | - |
| `--zcon-dir-path` | `-zdp` | string | Optional | - | ZConverter 설치 디렉토리 경로 (Linux: /ZConverterManager, Windows: C:\Program Files (x86)\ZConverter_CloudAgent) | - |
| `--output` | `-o` | string | Optional | `text` | 출력 형식 지정 | `text`, `json`, `table` |

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (Text format)</strong></summary>

**Text 형식:**

**변경 성공 시:**
```
----- result -----
업데이트된 항목: zdm-ip, zdm-port
------------------
```

**변경 사항 없음:**
```
----- result -----
변경된 항목이 없습니다 (모든 값이 기존과 동일합니다)
------------------
```

</details>

<details markdown="1" open>
<summary><strong>출력 예시 (JSON format)</strong></summary>

**JSON 형식:**

```json
{
  "updated_keys": ["zdm-ip", "zdm-port"]
}
```

</details>

---
