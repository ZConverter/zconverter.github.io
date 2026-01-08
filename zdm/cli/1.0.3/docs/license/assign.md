---
layout: docs
title: license assign
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

특정 Server에 License를 할당하는 명령어입니다.

---

## `license assign` {#license-assign}

> * 특정 Server에 License를 할당합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license assign [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 특정 라이센스를 서버에 할당
zdm-cli license assign --license "my-license" --server "server-01"

# 별칭을 사용한 할당
zdm-cli license assign -l "my-license" -s "server-01"

# JSON 형식으로 출력
zdm-cli license assign --license "my-license" --server "server-01" --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --license | -l | string | Required | - | 할당할 라이센스 | - |
| --server | -s | string | Required | - | 라이센스 할당할 서버 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* License Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : License assigned successfully
timestamp : 2024-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

name                : my-license
key                 : XXXX-XXXX-XXXX-XXXX
category            : zdm(backup)
description         : Production License
copies.total        : 10
copies.used         : 1
copies.available    : 9
copies.usage        : 10%
dates.created       : 2024-01-01
dates.expires       : 2025-12-31
dates.daysRemaining : 365

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "License assigned successfully",
  "success": true,
  "data": {
    "name": "my-license",
    "key": "XXXX-XXXX-XXXX-XXXX",
    "category": "zdm(backup)",
    "description": "Production License",
    "copies": {
      "total": 10,
      "used": 1,
      "available": 9,
      "usage": "10%"
    },
    "dates": {
      "created": "2024-01-01",
      "expires": "2025-12-31",
      "daysRemaining": 365
    }
  },
  "timestamp": "2024-01-15 10:30:00"
}
```

</details>

---
