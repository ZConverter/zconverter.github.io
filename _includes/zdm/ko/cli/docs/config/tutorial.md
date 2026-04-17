
CLI 설정 관리의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [초기 설정 절차](#초기-설정-절차)

</details>

---

## 초기 설정 절차

<details markdown="1" open>
<summary><strong>Step 1: ZDM 서버 IP/포트 설정</strong></summary>

ZDM API 서버에 접속하기 위한 IP 주소와 포트 번호를 설정합니다.

```bash
zdm-cli config set --zdm-ip 121.189.21.220 --zdm-port 53307
```

</details>

<details markdown="1" open>
<summary><strong>Step 2: 사용자 이메일 설정</strong></summary>

포털 로그인에 사용하는 이메일을 설정합니다. 이후 토큰 발급 시 자동으로 사용됩니다.

```bash
zdm-cli config set --user-mail admin@example.com
```

</details>

<details markdown="1" open>
<summary><strong>Step 3: 토큰 발급</strong></summary>

{% assign url_parts = page.url | split: '/' %}
{% assign base_path = '/' | append: url_parts[1] | append: '/' | append: url_parts[2] | append: '/' | append: url_parts[3] | append: '/' | append: url_parts[4] %}

API 호출에 필요한 인증 토큰을 발급합니다. 발급된 토큰은 설정 파일에 자동 저장됩니다.
자세한 내용은 [Token 개요]({{ base_path }}/docs/token/overview)를 참조하세요.

```bash
zdm-cli token issue -p your-password
```

</details>

<details markdown="1" open>
<summary><strong>Step 4: Center ID 설정</strong></summary>

v2.0.0부터 멀티 Center 지원을 위해 기본 Center ID 설정이 필요합니다.
먼저 ZDM 목록에서 사용할 Center의 ID를 확인합니다.

```bash
# ZDM 목록 조회
zdm-cli zdm list
```

조회된 목록에서 사용할 Center의 ID를 확인한 후 설정합니다.

```bash
# 기본 Center ID 설정
zdm-cli config set --zdm-id 9
```

</details>

<details markdown="1" open>
<summary><strong>Step 5: Repository 설정</strong></summary>

백업/복구에 사용할 Repository를 설정합니다.
먼저 해당 Center에 등록된 Repository 목록을 확인합니다.

```bash
# Repository 목록 조회
zdm-cli zdm list --repo-only
```

조회된 목록에서 사용할 Repository의 ID를 확인한 후 설정합니다.
`--auto` 옵션을 사용하면 API에서 경로를 자동으로 조회하여 설정합니다.

```bash
# Repository ID 설정 (path 자동 조회)
zdm-cli config set --zdm-repo-id 43 --auto
```

</details>

<details markdown="1" open>
<summary><strong>Step 6: 설정 확인</strong></summary>

모든 설정이 완료되면 최종 설정 값을 확인합니다.

```bash
zdm-cli config show
```

</details>

<details markdown="1" open>
<summary><strong>전체 설정 요약</strong></summary>

```bash
# 1. ZDM 서버 IP/포트 설정
zdm-cli config set --zdm-ip 121.189.21.220 --zdm-port 53307

# 2. 사용자 이메일 설정
zdm-cli config set --user-mail admin@example.com

# 3. 토큰 발급
zdm-cli token issue -p your-password

# 4. ZDM 목록에서 기본으로 사용할 Center ID 확인
zdm-cli zdm list

# 5. 기본 Center ID 설정
zdm-cli config set --zdm-id 9

# 6. 해당 Center에 등록된 Repository 목록 확인
zdm-cli zdm list --repo-only

# 7. 기본 Repository ID 및 Path 설정
zdm-cli config set --zdm-repo-id 43 --auto

# 8. 최종 설정값 확인
zdm-cli config show
```

</details>

---
