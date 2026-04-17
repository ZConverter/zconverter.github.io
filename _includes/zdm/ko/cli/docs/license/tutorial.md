
라이센스 관리 기능의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [라이센스 등록부터 할당까지](#라이센스-등록부터-할당까지)
- [라이센스 할당 절차](#라이센스-할당-절차)

</details>

---

## 라이센스 등록부터 할당까지

<details markdown="1" open>
<summary><strong>전체 워크플로우</strong></summary>

라이센스 관리는 다음 3단계로 진행됩니다:

1. **라이센스 키 등록** - 발급받은 라이센스 키를 ZDM 서버에 등록합니다.
2. **라이센스 목록 확인** - 등록된 라이센스 정보(이름, 수량, 만료일 등)를 조회합니다.
3. **서버에 라이센스 할당** - 등록된 라이센스를 대상 서버에 할당합니다.

```bash
# Step 1: 라이센스 등록
zdm-cli license regist -k "XXXX-XXXX-XXXX-XXXX" -n "Production License"

# Step 2: 라이센스 목록 확인
zdm-cli license list

# Step 3: 서버에 라이센스 할당
zdm-cli license assign -l "Production License" -s "server-01"
```

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

<details markdown="1">
<summary><strong>센터별 라이센스 관리</strong></summary>

```bash
# 1. 특정 센터에 라이센스 등록
zdm-cli license regist -c "zdm-center-01" -k "XXXX-XXXX-XXXX-XXXX" -n "Backup License"

# 2. 해당 센터의 라이센스만 조회
zdm-cli license list --center "zdm-center-01"

# 3. 라이센스 타입별 조회
zdm-cli license list --type "zdm(backup)"

# 4. 만료일 기준 조회
zdm-cli license list --expiration-date 2026-12-31
```

</details>

---
