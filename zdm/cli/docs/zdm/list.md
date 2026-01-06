---
layout: docs
title: zdm list
section_title: ZDM CLI Documentation
navigation: cli
---

ZDM 목록 및 상세 정보를 조회합니다.

---

## `zdm list` {#zdm-list}

> * 등록된 ZDM 목록을 조회하거나 특정 ZDM의 상세 정보를 조회합니다.
> * ID 또는 이름을 지정하면 단일 ZDM 정보를 조회하고, 지정하지 않으면 전체 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli zdm list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 ZDM 목록 조회
zdm-cli zdm list

# 특정 ZDM ID로 조회
zdm-cli zdm list --id 123

# 특정 ZDM 이름으로 조회
zdm-cli zdm list --name "my-zdm"

# 연결된 ZDM만 조회
zdm-cli zdm list --connection connect

# 연결이 끊어진 ZDM만 조회
zdm-cli zdm list --connection disconnect

# 활성화된 ZDM만 조회
zdm-cli zdm list --activation ok

# Repository 정보 포함하여 조회
zdm-cli zdm list --repository

# Repository 정보만 조회
zdm-cli zdm list --repository-only

# 상세 정보 조회
zdm-cli zdm list --detail

# JSON 형식으로 출력
zdm-cli zdm list --output json

# 테이블 형식으로 출력
zdm-cli zdm list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --name | - | string | Optional | - | 조회할 ZDM 이름 (해당 옵션 사용시 단일 조회) | - |
| --id | - | number | Optional | - | 조회할 ZDM ID (해당 옵션 사용시 단일 조회) | - |
| --connection | -conn | string | Optional | - | ZDM 연결 상태 | connect, disconnect |
| --activation | -active | string | Optional | - | ZDM 활성화 상태 | ok, fail |
| --repository | -repo | boolean | Optional | false | Repository 정보 추가조회 | - |
| --repository-only | -ro | boolean | Optional | false | 대상 ZDM의 Repository 정보만 조회 | - |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --output | -o | string | Optional | text | 출력 형식 | text, json, table |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center     : zdm-center-01
name.host       : zdm-host-01
id.center       : 1
id.install      : install-001
os.version      : Ubuntu 22.04
ip.public       : 203.0.113.1
ip.private      : 192.168.1.10
status.connect  : connected
status.activate : ok
path.logFile    : /var/log/zdm
path.install    : /opt/zdm
lastUpdated     : 2025-01-06T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Success",
  "success": true,
  "data": [
    {
      "name": {
        "center": "zdm-center-01",
        "host": "zdm-host-01"
      },
      "id": {
        "center": 1,
        "install": "install-001"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "203.0.113.1",
        "private": ["192.168.1.10"]
      },
      "status": {
        "connect": "connected",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "lastUpdated": "2025-01-06T10:30:00Z"
    }
  ],
  "timestamp": "2025-01-06 10:30:00"
}
```

### 상세 출력(detail 옵션 사용)

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center            : zdm-center-01
name.host              : zdm-host-01
id.center              : 1
id.install             : install-001
id.machine             : machine-001
os.version             : Ubuntu 22.04
ip.public              : 203.0.113.1
ip.private             : 192.168.1.10
status.connect         : connected
status.activate        : ok
path.logFile           : /var/log/zdm
path.install           : /opt/zdm
resources.model        : Virtual Machine
resources.cpu          : Intel Xeon
resources.cpuCount     : 4
resources.memory       : 16GB
resources.kernel       : 5.15.0-generic
resources.systemType   : x86_64
resources.organization : MyOrg
lastUpdated            : 2025-01-06T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Success",
  "success": true,
  "data": [
    {
      "name": {
        "center": "zdm-center-01",
        "host": "zdm-host-01"
      },
      "id": {
        "center": 1,
        "install": "install-001",
        "machine": "machine-001"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "203.0.113.1",
        "private": ["192.168.1.10"]
      },
      "status": {
        "connect": "connected",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "resources": {
        "model": "Virtual Machine",
        "cpu": "Intel Xeon",
        "cpuCount": 4,
        "memory": "16GB",
        "kernel": "5.15.0-generic",
        "systemType": "x86_64",
        "organization": "MyOrg"
      },
      "lastUpdated": "2025-01-06T10:30:00Z"
    }
  ],
  "timestamp": "2025-01-06 10:30:00"
}
```

</details>

---
