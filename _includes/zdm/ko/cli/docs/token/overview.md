
토큰 관리 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [토큰 발급 절차](#토큰-발급-절차)
- [토큰 저장](#토큰-저장)
- [토큰 만료](#토큰-만료)
- [하위 커맨드](#하위-커맨드)

</details>

---

## 토큰 발급 절차

<details markdown="1" open>
<summary><strong>토큰 발급 예시</strong></summary>

토큰은 모든 API 호출에 필요한 인증 수단입니다. 다음 절차에 따라 토큰을 발급합니다.

```bash
# 1. 사용자 이메일 및 ZDM 서버 IP 설정 (최초 1회)
zdm-cli config set --user-mail admin@example.com --zdm-ip 121.189.21.220

# 2. 설정값 확인
zdm-cli config show

# 3. 토큰 발급 (토큰이 자동으로 설정 파일에 저장됩니다)
zdm-cli token issue -p your-password
```

</details>

---

## 토큰 저장

<details markdown="1" open>
<summary><strong>토큰 저장 위치</strong></summary>

- 발급된 토큰은 자동으로 CLI 설정 파일에 저장됩니다.
{% assign url_parts = page.url | split: '/' %}
{% assign base_path = '/' | append: url_parts[1] | append: '/' | append: url_parts[2] | append: '/' | append: url_parts[3] | append: '/' | append: url_parts[4] %}
- 설정 파일에 대한 자세한 정보는 [Config 개요]({{ base_path }}/docs/config/overview)를 참조하세요.

</details>

---

## 토큰 만료

<details markdown="1" open>
<summary><strong>토큰 유효 기간</strong></summary>

- 토큰 발급 시 `expiresAt` 필드에 만료 시간이 표시됩니다.
- 토큰이 만료되면 `token issue` 명령어로 재발급이 필요합니다.

</details>

---

## 하위 커맨드

<details markdown="1" open>
<summary><strong>사용 가능한 하위 커맨드</strong></summary>

| 커맨드 | 설명 |
|--------|------|
| `token issue` | API 인증 토큰 발급 |

</details>

---
