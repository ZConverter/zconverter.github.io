---
layout: docs
title: Token 개요
section_title: ZDM CLI Documentation
navigation: cli-0.2.0
---

토큰 관리 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [토큰 저장](#토큰-저장)
- [토큰 만료](#토큰-만료)

</details>

---

## 토큰 저장

<details markdown="1" open>
<summary><strong>토큰 저장 위치</strong></summary>

- 발급된 토큰은 자동으로 CLI 설정 파일에 저장됩니다.
- 설정 파일에 대한 자세한 정보는 [Config 개요](/zdm/cli/docs/config/overview)를 참조하세요.

</details>

---

## 토큰 만료

<details markdown="1" open>
<summary><strong>토큰 유효 기간</strong></summary>

- 토큰 발급 시 `expiresAt` 필드에 만료 시간이 표시됩니다.
- 토큰이 만료되면 `token issue` 명령어로 재발급이 필요합니다.

</details>

---
