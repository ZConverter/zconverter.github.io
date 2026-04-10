
ZOS 인증 키 파일을 다운로드하는 명령어입니다.

---

## `cloud-auth zos-download` {#cloud-auth-zos-download}

> * 등록된 ZOS 인증 키 파일을 로컬로 다운로드합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth zos-download [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 현재 디렉토리에 다운로드
zdm-cli cloud-auth zos-download --fn key.json

# 특정 디렉토리에 다운로드
zdm-cli cloud-auth zos-download --fn key.json --sp /tmp
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --file-name | -fn | string | Required | - | 다운로드할 파일명 | - |
| --save-path | -sp | string | Optional | 현재 디렉토리 | 저장 경로 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
File downloaded: /home/user/aws-key.json
```

</details>

---
