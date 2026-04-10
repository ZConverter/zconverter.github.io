
ZOS 클라우드 인증을 삭제하는 명령어입니다.

---

## `cloud-auth zos-delete` {#cloud-auth-zos-delete}

> * 등록된 ZOS 클라우드 인증을 삭제합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth zos-delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli cloud-auth zos-delete --id 1

# 파일명으로 삭제
zdm-cli cloud-auth zos-delete --fn key.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional<span class="required-note">*</span> | - | ZOS 인증 ID | - |
| --file-name | -fn | string | Optional<span class="required-note">*</span> | - | ZOS 인증 파일명 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> --id 또는 --file-name 중 정확히 하나를 입력해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[ZOS Auth Delete Result]
id          : 1
displayName : AWS Production Key
fileName    : aws-key.json
```

</details>

---
