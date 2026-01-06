---
layout: docs
title: license regist
section_title: ZDM CLI Documentation
navigation: cli
---

라이센스를 등록합니다.

---

## `license regist` {#license-regist}

> * 라이센스를 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license regist --center &lt;center&gt; --key &lt;key&gt; [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 라이센스 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345

# 이름과 설명을 포함하여 등록
zdm-cli license regist --center zdm-center-01 --key LICENSE-KEY-12345 --name "Production License" --description "Production environment license"

# 사용자 정보를 포함하여 등록
zdm-cli license regist --center 1 --key LICENSE-KEY-12345 --user admin@example.com

# 모든 옵션을 포함한 등록
zdm-cli license regist \
  --center zdm-center-01 \
  --key LICENSE-KEY-12345 \
  --name "Production Backup License" \
  --description "License for production backup operations" \
  --user admin@example.com
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--center` | `-c` | string | Required | - | License를 등록할 센터 ID 또는 Name | - |
| `--key` | `-k` | string | Required | - | 등록할 License Key | - |
| `--user` | `-u` | string | Optional | - | 요청 사용자 ID 또는 메일 | - |
| `--name` | `-n` | string | Optional | - | 등록할 License Name | - |
| `--description` | `-d` | string | Optional | - | 등록할 License 설명 | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "License registered successfully",
  "success": true,
  "data": {
    "licenseId": 1,
    "key": "LICENSE-KEY-12345",
    "name": "Production License",
    "type": "backup",
    "expiresAt": "2025-12-31T23:59:59.000Z",
    "createdAt": "2025-01-15T10:30:00Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
