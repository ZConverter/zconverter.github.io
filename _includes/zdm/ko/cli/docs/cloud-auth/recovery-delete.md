
Recovery 클라우드 인증을 삭제하는 명령어입니다.

---

## `cloud-auth recovery-delete` {#cloud-auth-recovery-delete}

> * 등록된 Recovery 클라우드 인증을 삭제합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth recovery-delete [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli cloud-auth recovery-delete -c center01 --id 1
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | Center ID 또는 이름 | - |
| --id | - | number | Required | - | Recovery 인증 ID | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Recovery Auth Delete Result]
id          : 1
displayName : AWS Seoul Production
```

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "state": "success",
    "cloudInfo": {
      "id": 1,
      "displayName": "AWS Seoul Production"
    }
  }
}
```

</details>

---
