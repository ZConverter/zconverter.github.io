---
layout: docs
title: Config 튜토리얼
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

CLI 설정 관리의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [초기 설정 절차](#초기-설정-절차)

</details>

---

## 초기 설정 절차

<details markdown="1" open>
<summary><strong>권장 초기 설정</strong></summary>

```bash
# 1. 토큰 발급
zdm-cli token issue -m admin@example.com -p password

# 2. ZDM 서버 정보 설정
zdm-cli config set --zdm-ip 192.168.1.100

# 3. ZDM Center ID 설정
zdm-cli config set --zdm-id zdm-center-01

# 4. 기본 Repository 설정
zdm-cli config set --zdm-repo-id 1

# 5. 설정 확인
zdm-cli config show
```

</details>

---
