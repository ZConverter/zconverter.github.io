---
layout: docs
title: server list
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

Server 목록 및 상세 정보를 조회합니다.

---

## `server list` {#server-list}

> * 등록된 Server 목록을 조회하거나 특정 Server의 상세 정보를 조회합니다.
> * ID 또는 이름을 지정하면 단일 Server 정보를 조회하고, 지정하지 않으면 전체 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli server list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Server 목록 조회
zdm-cli server list

# 특정 Server ID로 조회
zdm-cli server list --id 123

# 특정 Server 이름으로 조회
zdm-cli server list --name "my-server"

# Linux Server만 조회
zdm-cli server list --os lin

# Source 모드 Server만 조회
zdm-cli server list --mode source

# 라이센스가 할당된 Server만 조회
zdm-cli server list --license-assign-only

# 라이센스가 할당되지 않은 Server만 조회
zdm-cli server list --license-un-assign-only

# Partition 정보 포함하여 조회
zdm-cli server list --partition

# 상세 정보 조회
zdm-cli server list --detail

# JSON 형식으로 출력
zdm-cli server list --output json

# 테이블 형식으로 출력
zdm-cli server list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --name | - | string | Optional | - | 조회할 Server 이름 (해당 옵션 사용시 단일 조회) | - |
| --id | - | number | Optional | - | 조회할 Server ID (해당 옵션 사용시 단일 조회) | - |
| --os | - | string | Optional | - | 조회할 Server OS | {% include zdm/os-types.md %} |
| --mode | - | string | Optional | - | 조회할 Server 모드 | {% include zdm/server-modes.md %} |
| --license | - | number | Optional | - | Server에 할당된 License ID | - |
| --license-assign-only | -lao | boolean | Optional | false | 라이센스가 할당된 Server만 조회 | - |
| --license-un-assign-only | -luao | boolean | Optional | false | 라이센스가 할당되지 않은 Server만 조회 | - |
| --partition | - | boolean | Optional | false | Partition 정보 추가조회 | - |
| --partition-only | -po | boolean | Optional | false | 대상 Server의 Partition 정보만 조회 | - |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Server Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server 1]
name           : server-01
id             : 1
agent.mode     : source
os.version     : Ubuntu 22.04
ip.public      : 203.0.113.1
ip.private     : 192.168.1.10
license.id     : 100
status.connect : connected
lastUpdated    : 2025-01-06T10:30:00Z

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
      "name": "server-01",
      "id": 1,
      "agent": {
        "mode": "source",
        "version": "1.0.0"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "203.0.113.1",
        "private": ["192.168.1.10"]
      },
      "license": {
        "id": 100
      },
      "status": {
        "connect": "connected"
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
* Server Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server 1]
name                   : server-01
id                     : 1
agent.mode             : source
agent.version          : 1.0.0
os.version             : Ubuntu 22.04
ip.public              : 203.0.113.1
ip.private             : 192.168.1.10
license.id             : 100
status.connect         : connected
resources.model        : Virtual Machine
resources.type         : x86_64
resources.manufacturer : VMware
resources.kernel       : 5.15.0-generic
resources.cpu          : Intel Xeon
resources.cpuCount     : 4
resources.memory       : 16GB
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
      "name": "server-01",
      "id": 1,
      "agent": {
        "mode": "source",
        "version": "1.0.0"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "203.0.113.1",
        "private": ["192.168.1.10"]
      },
      "license": {
        "id": 100
      },
      "status": {
        "connect": "connected"
      },
      "resources": {
        "model": "Virtual Machine",
        "type": "x86_64",
        "manufacturer": "VMware",
        "kernel": "5.15.0-generic",
        "cpu": "Intel Xeon",
        "cpuCount": 4,
        "memory": "16GB"
      },
      "lastUpdated": "2025-01-06T10:30:00Z"
    }
  ],
  "timestamp": "2025-01-06 10:30:00"
}
```

### Partition 정보 포함 출력(partition 옵션 사용)

> **참고**: 파티션 정보의 첫 번째 필드는 OS에 따라 다르게 표시됩니다.
> - **Linux/Unix**: `mountPoint` (마운트 포인트, 예: `/`, `/home`)
> - **Windows**: `drive` (드라이브 문자, 예: `C:`, `D:`)

**Text 형식 (Linux):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Server Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server 1]
name           : server-01
id             : 1
agent.mode     : source
os.version     : Ubuntu 22.04
ip.public      : 203.0.113.1
ip.private     : 192.168.1.10
license.id     : 100
status.connect : connected
lastUpdated    : 2025-01-06T10:30:00Z

[Partition Information]
  [Partition 1]
    mountPoint  : /
    device      : /dev/sda1
    size        : 100.0 GB, used: 45.0 GB, free: 55.0 GB (45%)
    fileSystem  : ext4
    lastUpdated : 2025-01-06T10:30:00Z

  [Partition 2]
    mountPoint  : /home
    device      : /dev/sda2
    size        : 500.0 GB, used: 200.0 GB, free: 300.0 GB (40%)
    fileSystem  : ext4
    lastUpdated : 2025-01-06T10:30:00Z

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
      "name": "server-01",
      "id": 1,
      "agent": {
        "mode": "source"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "203.0.113.1",
        "private": ["192.168.1.10"]
      },
      "license": {
        "id": 100
      },
      "status": {
        "connect": "connected"
      },
      "partition": [
        {
          "system": "server-01",
          "device": "/dev/sda1",
          "letter": "/",
          "size": {
            "raw": 107374182400,
            "formatted": "100.0 GB"
          },
          "used": {
            "raw": 48318382080,
            "formatted": "45.0 GB"
          },
          "free": {
            "raw": 59055800320,
            "formatted": "55.0 GB"
          },
          "usage": 45,
          "fileSystem": "ext4",
          "lastUpdated": "2025-01-06T10:30:00Z"
        },
        {
          "system": "server-01",
          "device": "/dev/sda2",
          "letter": "/home",
          "size": {
            "raw": 536870912000,
            "formatted": "500.0 GB"
          },
          "used": {
            "raw": 214748364800,
            "formatted": "200.0 GB"
          },
          "free": {
            "raw": 322122547200,
            "formatted": "300.0 GB"
          },
          "usage": 40,
          "fileSystem": "ext4",
          "lastUpdated": "2025-01-06T10:30:00Z"
        }
      ],
      "lastUpdated": "2025-01-06T10:30:00Z"
    }
  ],
  "timestamp": "2025-01-06 10:30:00"
}
```

**Text 형식 (Windows):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Server Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-06 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server 1]
name           : win-server-01
id             : 2
agent.mode     : source
os.version     : Windows Server 2022
ip.public      : 203.0.113.2
ip.private     : 192.168.1.20
license.id     : 101
status.connect : connected
lastUpdated    : 2025-01-06T10:30:00Z

[Partition Information]
  [Partition 1]
    drive       : C:
    device      : \\.\PhysicalDrive0
    size        : 500.0 GB, used: 200.0 GB, free: 300.0 GB (40%)
    fileSystem  : NTFS
    lastUpdated : 2025-01-06T10:30:00Z

  [Partition 2]
    drive       : D:
    device      : \\.\PhysicalDrive1
    size        : 1000.0 GB, used: 400.0 GB, free: 600.0 GB (40%)
    fileSystem  : NTFS
    lastUpdated : 2025-01-06T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---

## 참조

<details markdown="1">
<summary><strong>OS 타입</strong></summary>

{% include zdm/os-types.md desc=true %}

</details>

<details markdown="1">
<summary><strong>서버 모드</strong></summary>

{% include zdm/server-modes.md desc=true %}

</details>

<details markdown="1">
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
