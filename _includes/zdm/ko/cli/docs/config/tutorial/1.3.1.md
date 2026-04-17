
CLI 설정 관리의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [초기 설정 절차](#초기-설정-절차)

</details>

---

## 초기 설정 절차

<details markdown="1" open>
<summary><strong>권장 초기 설정</strong></summary>

{% assign url_parts = page.url | split: '/' %}
{% assign base_path = '/' | append: url_parts[1] | append: '/' | append: url_parts[2] | append: '/' | append: url_parts[3] | append: '/' | append: url_parts[4] %}

> 토큰 발급이 완료되지 않은 경우, [Token 개요]({{ base_path }}/docs/token/overview)를 참조하세요.

```bash
# 1. 토큰 발급
zdm-cli token issue -p your-password

# 2. ZDM 목록에서 기본으로 사용할 ZDM의 ID 확인
zdm-cli zdm list

# 3. 기본 ZDM ID 설정
zdm-cli config set --zdm-id 1

# 4. 해당 ZDM에 등록된 Repository 목록에서 기본으로 사용할 Repository의 ID 확인
zdm-cli zdm list --repo-only

# 5. 기본 Repository ID 및 Path 설정
zdm-cli config set --zdm-repo-id 2 --zdm-repo-path /backup

# 6. 최종 설정값 확인
zdm-cli config show
```

</details>

---
