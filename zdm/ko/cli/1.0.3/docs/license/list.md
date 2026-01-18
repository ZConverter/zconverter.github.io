---
layout: docs
title: license list
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

License 목록 및 정보를 조회하는 명령어입니다.

---

## `license list` {#license-list}

> * License 목록(정보)을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 라이센스 목록 조회
zdm-cli license list

# 특정 ID의 라이센스 조회
zdm-cli license list --id 123

# 특정 이름의 라이센스 조회
zdm-cli license list --name "Production License"
zdm-cli license list -n "Production License"

# 특정 타입의 라이센스 조회
zdm-cli license list --type "zdm(backup)"

# 특정 만료일의 라이센스 조회
zdm-cli license list --expiration-date 2025-12-31
zdm-cli license list -expd 2025-12-31

# 특정 생성일의 라이센스 조회
zdm-cli license list --create-date 2024-01-01
zdm-cli license list --cre 2024-01-01

# 여러 조건으로 조회
zdm-cli license list --type "zdm(dr)" -expd 2025-12-31

# JSON 형식으로 출력
zdm-cli license list --output json

# 테이블 형식으로 출력
zdm-cli license list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional | - | 조회할 License ID | - |
| --name | -n | string | Optional | - | 조회할 License 이름 | - |
| --type | - | string | Optional | - | 조회할 License Type | {% include zdm/license-categories.md %} |
| --expiration-date | -expd | string | Optional | - | 라이센스 만료 날짜 (format: YYYY-MM-DD) | - |
| --create-date | -cre | string | Optional | - | 라이센스 생성 일자 (format: YYYY-MM-DD) | - |
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
message   : License list retrieved successfully
timestamp : 2024-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[License 1]
name                : Production License
key                 : XXXX-XXXX-XXXX-XXXX
category            : zdm(backup)
description         : Main production license
copies.total        : 10
copies.used         : 5
copies.available    : 5
copies.usage        : 50%
dates.created       : 2024-01-01
dates.expires       : 2025-12-31
dates.daysRemaining : 365

[License 2]
name                : DR License
key                 : YYYY-YYYY-YYYY-YYYY
category            : zdm(dr)
description         : Disaster recovery license
copies.total        : 5
copies.used         : 2
copies.available    : 3
copies.usage        : 40%
dates.created       : 2024-06-01
dates.expires       : 2025-06-01
dates.daysRemaining : 180

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "License list retrieved successfully",
  "success": true,
  "data": [
    {
      "name": "Production License",
      "key": "XXXX-XXXX-XXXX-XXXX",
      "category": "zdm(backup)",
      "description": "Main production license",
      "copies": {
        "total": 10,
        "used": 5,
        "available": 5,
        "usage": "50%"
      },
      "dates": {
        "created": "2024-01-01",
        "expires": "2025-12-31",
        "daysRemaining": 365
      }
    },
    {
      "name": "DR License",
      "key": "YYYY-YYYY-YYYY-YYYY",
      "category": "zdm(dr)",
      "description": "Disaster recovery license",
      "copies": {
        "total": 5,
        "used": 2,
        "available": 3,
        "usage": "40%"
      },
      "dates": {
        "created": "2024-06-01",
        "expires": "2025-06-01",
        "daysRemaining": 180
      }
    }
  ],
  "timestamp": "2024-01-15 10:30:00"
}
```

</details>

---
