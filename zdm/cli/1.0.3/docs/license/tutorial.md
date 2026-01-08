---
layout: docs
title: License 튜토리얼
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

라이센스 관리 기능의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [라이센스 할당 절차](#라이센스-할당-절차)

</details>

---

## 라이센스 할당 절차

<details markdown="1" open>
<summary><strong>기본 절차</strong></summary>

```bash
# 1. 라이센스 등록
zdm-cli license regist -c "zdm-center-01" -k "XXXX-XXXX-XXXX-XXXX"

# 2. 라이센스 목록 확인
zdm-cli license list

# 3. 서버에 라이센스 할당
zdm-cli license assign -l "my-license" -s "server-01"
```

</details>

---
