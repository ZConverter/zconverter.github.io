---
layout: docs
title: schedule list
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

등록된 Schedule 목록 또는 상세 정보를 조회합니다.

---

## `schedule list` {#schedule-list}

> * ZDM 서버에 등록된 Schedule 목록을 조회하는 명령어입니다.
> * ID를 지정하면 단일 Schedule의 상세 정보를 조회합니다.
> * Type 또는 상태(State)로 필터링하여 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Schedule 목록 조회
zdm-cli schedule list

# 특정 ID의 Schedule 조회
zdm-cli schedule list --id 123

# Type별 Schedule 조회 (daily)
zdm-cli schedule list --type 3

# 활성화된 Schedule만 조회
zdm-cli schedule list --state enabled

# 비활성화된 Schedule만 조회
zdm-cli schedule list --state disabled

# Type과 상태 조합 조회
zdm-cli schedule list --type 4 --state enabled

# JSON 형식으로 출력
zdm-cli schedule list --output json

# 테이블 형식으로 출력
zdm-cli schedule list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Optional | - | 조회할 Schedule ID (해당 옵션 사용시 단일 조회) | - |
| --type | - | number | Optional | - | 조회할 Schedule Type | {% include zdm/schedule-types.md inline=true %} |
| --state | - | string | Optional | - | 조회할 Schedule 상태 | {% include zdm/schedule-state.md %} |

</details>

<details markdown="1" open>
<summary><strong>Schedule Types</strong></summary>

{% include zdm/schedule-types.md number=true %}

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본) - 목록 조회:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Schedule list retrieved successfully
timestamp : 2025-01-06 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Schedule 1]
id          : 1
center.id   : center-001
center.name : ZDM Center
type        : daily
state       : enabled
jobName     : backup-job-01
lastRunTime : 2025-01-05T12:00:00Z
description : Daily backup schedule

[Schedule 2]
id          : 2
center.id   : center-001
center.name : ZDM Center
type        : weekly
state       : disabled
jobName     : backup-job-02
lastRunTime : 2025-01-03T14:00:00Z
description : Weekly backup schedule

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Text 형식 - 단일 조회:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Schedule Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Schedule info retrieved successfully
timestamp : 2025-01-06 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

id          : 1
center.id   : center-001
center.name : ZDM Center
type        : daily
state       : enabled
jobName     : backup-job-01
lastRunTime : 2025-01-05T12:00:00Z
description : Daily backup schedule

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Schedule list retrieved successfully",
  "success": true,
  "data": [
    {
      "id": 1,
      "center": {
        "id": "center-001",
        "name": "ZDM Center"
      },
      "type": "daily",
      "state": "enabled",
      "jobName": "backup-job-01",
      "lastRunTime": "2025-01-05T12:00:00Z",
      "description": "Daily backup schedule"
    },
    {
      "id": 2,
      "center": {
        "id": "center-001",
        "name": "ZDM Center"
      },
      "type": "weekly",
      "state": "disabled",
      "jobName": "backup-job-02",
      "lastRunTime": "2025-01-03T14:00:00Z",
      "description": "Weekly backup schedule"
    }
  ],
  "timestamp": "2025-01-06 12:00:00"
}
```

</details>

---
