---
layout: docs
title: license regist
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

새로운 License 정보를 등록하는 명령어입니다.

---

## `license regist` {#license-regist}

> * License 정보를 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 라이센스 등록
zdm-cli license regist --center "zdm-center-01" --key "XXXX-XXXX-XXXX-XXXX"

# 별칭을 사용한 등록
zdm-cli license regist -c "zdm-center-01" -k "XXXX-XXXX-XXXX-XXXX"

# 이름을 포함한 라이센스 등록
zdm-cli license regist -c "zdm-center-01" -k "XXXX-XXXX-XXXX-XXXX" -n "Production License"

# 사용자 정보를 포함한 등록
zdm-cli license regist --center "zdm-center-01" --key "XXXX-XXXX-XXXX-XXXX" --user "admin@example.com" --name "Production License"

# JSON 형식으로 출력
zdm-cli license regist -c "zdm-center-01" -k "XXXX-XXXX-XXXX-XXXX" --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Required | - | License를 등록할 센터 ID 또는 Name | - |
| --key | -k | string | Required | - | 등록할 License Key | - |
| --user | -u | string | Optional | - | 요청 사용자 ID 또는 메일 | - |
| --name | -n | string | Optional | - | 등록할 License Name | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* License Registration Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : License registered successfully
timestamp : 2024-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[License Registration Success]
name                : Production License
key                 : XXXX-XXXX-XXXX-XXXX
category            : zdm(backup)
description         : Main production license
copies.total        : 10
copies.used         : 0
copies.available    : 10
copies.usage        : 0%
dates.created       : 2024-01-15
dates.expires       : 2025-01-15
dates.daysRemaining : 365

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "License registered successfully",
  "success": true,
  "data": {
    "name": "Production License",
    "key": "XXXX-XXXX-XXXX-XXXX",
    "category": "zdm(backup)",
    "description": "Main production license",
    "copies": {
      "total": 10,
      "used": 0,
      "available": 10,
      "usage": "0%"
    },
    "dates": {
      "created": "2024-01-15",
      "expires": "2025-01-15",
      "daysRemaining": 365
    }
  },
  "timestamp": "2024-01-15 10:30:00"
}
```

</details>

---
