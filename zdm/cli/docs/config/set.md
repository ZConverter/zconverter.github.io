---
layout: docs
title: config set
section_title: ZDM CLI Documentation
navigation: cli
---

CLI 설정 값을 변경합니다.

---

## `config set` {#config-set}

> * CLI 설정 값을 변경합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli config set [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# ZDM IP 주소 설정
zdm-cli config set --zdm-ip 192.168.1.100

# ZDM ID 설정
zdm-cli config set --zdm-id zdm-center-01

# Repository ID 설정
zdm-cli config set --zdm-repo-id 1

# API 포트 설정
zdm-cli config set --zdm-api-port 53307

# 여러 값 동시 설정
zdm-cli config set --zdm-ip 192.168.1.100 --zdm-id zdm-center-01 --zdm-repo-id 1
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--zdm-ip` | - | string | Optional | - | ZDM 서버 IP 주소 | - |
| `--zdm-id` | - | string | Optional | - | ZDM Center ID | - |
| `--zdm-repo-id` | - | number | Optional | - | 기본 Repository ID | - |
| `--zdm-api-port` | - | number | Optional | - | ZDM API 포트 번호 | - |

</details>

---

## 설정 우선순위

CLI 명령 실행 시 설정 값의 우선순위는 다음과 같습니다:

<details markdown="1" open>
<summary><strong>우선순위 순서</strong></summary>

1. **명령줄 파라미터** - 가장 높은 우선순위
2. **설정 파일** - 두 번째 우선순위
3. **기본값** - 가장 낮은 우선순위

**예시:**
```bash
# 설정 파일에 zdm-repo-id: 1 이 저장되어 있지만
# 명령줄에서 다른 값을 지정하면 명령줄 값이 사용됨
zdm-cli backup regist --server web-01 --mode full --repository-id 2
```

</details>

---

## 설정 관리 팁

<details markdown="1" open>
<summary><strong>권장 설정 방법</strong></summary>

**초기 설정:**
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

## 참고사항

- CLI를 처음 실행하면 자동으로 설정 디렉토리와 파일이 생성됩니다.

---
