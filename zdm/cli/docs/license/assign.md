---
layout: docs
title: license assign
section_title: ZDM CLI Documentation
navigation: cli
---

서버에 라이센스를 할당합니다.

---

## `license assign` {#license-assign}

> * 서버에 라이센스를 할당합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli license assign --license &lt;id&gt; --server &lt;server&gt;</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 라이센스 ID로 할당
zdm-cli license assign --license 1 --server web-server-01

# 서버 ID로 할당
zdm-cli license assign --license 1 --server 5

# 여러 서버에 순차적으로 할당
zdm-cli license assign --license 1 --server web-server-01
zdm-cli license assign --license 2 --server db-server-01
zdm-cli license assign --license 3 --server app-server-01
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--license` | - | number | Required | - | 할당할 라이센스 ID | - |
| `--server` | - | string | Required | - | 대상 서버 이름 또는 ID | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "License assigned successfully",
  "success": true,
  "data": {
    "licenseId": 1,
    "serverId": 5,
    "serverName": "web-server-01",
    "assignedAt": "2025-01-15T10:30:00Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
