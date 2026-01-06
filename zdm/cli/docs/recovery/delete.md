---
layout: docs
title: recovery delete
section_title: ZDM CLI Documentation
navigation: cli
---

복구 작업을 삭제합니다.

---

## `recovery delete` {#recovery-delete}

> * 복구 작업을 삭제합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery delete --id &lt;id&gt; | --name &lt;name&gt;</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ID로 삭제
zdm-cli recovery delete --id 1

# 이름으로 삭제
zdm-cli recovery delete --name disaster-recovery
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--name` | - | string | Optional<span class="required-note">*</span> | - | 작업 이름 | - |
| `--id` | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |

> <span class="required-note">*</span> 둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

</details>

---
