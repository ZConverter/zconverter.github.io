
ZDM Center 목록 및 상세 정보를 조회합니다.

---

## `zdm list` {#zdm-list}

> * 등록된 ZDM Center 목록을 조회하거나 특정 Center의 상세 정보를 조회합니다.
> * ID 또는 이름을 지정하면 단일 Center 정보를 조회하고, 지정하지 않으면 전체 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli zdm list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 ZDM Center 목록 조회
zdm-cli zdm list

# 특정 ZDM ID로 조회
zdm-cli zdm list --id 9

# 특정 ZDM 이름으로 조회
zdm-cli zdm list --name srcconm

# 연결된 ZDM만 조회
zdm-cli zdm list --connection connect

# 활성화된 ZDM만 조회
zdm-cli zdm list --activation ok

# Repository 정보 포함하여 조회
zdm-cli zdm list --repo

# Repository 정보만 조회
zdm-cli zdm list --repo-only

# Disk 정보 포함하여 조회
zdm-cli zdm list --disk

# Network 정보 포함하여 조회
zdm-cli zdm list --net

# Partition(Drive) 정보 포함하여 조회
zdm-cli zdm list --partition

# ZOS Repository 정보 포함하여 조회
zdm-cli zdm list --zos-repo

# 부가 정보를 한 번에 포함하여 조회
zdm-cli zdm list --disk --net --partition --repo --zos-repo

# 상세 정보 조회
zdm-cli zdm list --detail

# 오름차순 정렬
zdm-cli zdm list --asc

# JSON 형식으로 출력
zdm-cli zdm list --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--name` | - | string | Optional | - | 조회할 ZDM 이름 (해당 옵션 사용시 단일 조회) | - |
| `--id` | - | number | Optional | - | 조회할 ZDM ID (해당 옵션 사용시 단일 조회) | - |
| `--connection` | `-conn` | string | Optional | - | ZDM 연결 상태 필터 | `connect`, `disconnect` |
| `--activation` | `-active` | string | Optional | - | ZDM 활성화 상태 필터 | `ok`, `fail` |
| `--disk` | - | boolean | Optional | `false` | Disk 정보 추가조회 | - |
| `--partition` | - | boolean | Optional | `false` | Partition(Drive) 정보 추가조회 | - |
| `--network` | `-net` | boolean | Optional | `false` | Network 정보 추가조회 | - |
| `--repository` | `-repo` | boolean | Optional | `false` | Repository 정보 추가조회 | - |
| `--repository-only` | `-repo-only` | boolean | Optional | `false` | 대상 ZDM의 Repository 정보만 조회 | - |
| `--zos-repository` | `-zos-repo` | boolean | Optional | `false` | ZOS Repository 정보 추가조회 | - |
| `--detail` | - | boolean | Optional | `false` | 상세 정보(`resources`) 조회 | - |
| `--asc` | - | boolean | Optional | `false` | 오름차순 정렬 (기본값: 내림차순) | - |
| `--output` | `-o` | string | Optional | `text` | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-04-17 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center     : srcconm
name.host       : zdm-host-src
id.center       : 9
id.install      : install-009
os.version      : Ubuntu 22.04
ip.public       : 121.189.21.220
ip.private      : 192.168.1.10
status.connect  : connected
status.activate : ok
path.logFile    : /var/log/zdm
path.install    : /opt/zdm
lastUpdated     : 2026-04-17T10:30:00Z

[ZDM 2]
name.center     : destconm
name.host       : zdm-host-dest
id.center       : 10
id.install      : install-010
os.version      : Ubuntu 22.04
ip.public       : 121.189.21.221
ip.private      : 192.168.1.20
status.connect  : connected
status.activate : ok
path.logFile    : /var/log/zdm
path.install    : /opt/zdm
lastUpdated     : 2026-04-17T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**
```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Success",
  "success": true,
  "data": [
    {
      "name": {
        "center": "srcconm",
        "host": "zdm-host-src"
      },
      "id": {
        "center": "9",
        "install": "install-009",
        "machine": "4c4c4544-0037-5310-8043-b7c04f503732"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "121.189.21.220",
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
      "lastUpdated": "2026-04-17T10:30:00Z"
    },
    {
      "name": {
        "center": "destconm",
        "host": "zdm-host-dest"
      },
      "id": {
        "center": "10",
        "install": "install-010",
        "machine": "4c4c4544-0038-5310-8043-b7c04f503733"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "121.189.21.221",
        "private": ["192.168.1.20"]
      },
      "status": {
        "connect": "connected",
        "activate": "ok"
      },
      "path": {
        "logFile": "/var/log/zdm",
        "install": "/opt/zdm"
      },
      "lastUpdated": "2026-04-17T10:30:00Z"
    }
  ],
  "timestamp": "2026-04-17T10:30:00.000+09:00"
}
```

### 부가 정보 포함 출력 (--disk --net)

`--disk` · `--partition` · `--network` · `--zos-repository` 는 **포함 플래그**입니다 — 지정한 항목만
응답에 실립니다. 지정하지 않으면 해당 블록은 나오지 않습니다.

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-04-17 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center     : srcconm
name.host       : zdm-host-src
id.center       : 9
id.install      : install-009
os.version      : Ubuntu 22.04
ip.public       : 121.189.21.220
ip.private      : 192.168.1.10
status.connect  : connected
status.activate : ok
path.logFile    : /var/log/zdm
path.install    : /opt/zdm
lastUpdated     : 2026-04-17T10:30:00Z
disk           :
  [Disk 1]
    type        : SSD
    size        : 500.0 GB
    caption     : /dev/sda
    lastUpdated : 2026-04-17T10:30:00Z
network        :
  [Network 1]
    ipAddress   : 192.168.1.10
    subNet      : 255.255.255.0
    gateWay     : 192.168.1.1
    macAddress  : 00:1a:2b:3c:4d:5e
    lastUpdated : 2026-04-17T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### 상세 정보 출력 (--detail)

`--detail` 은 하드웨어·시스템 정보인 `resources` 블록을 덧붙입니다.

> **v3.0.0 참고**: 이 옵션은 한때 응답에 아무것도 추가하지 않았습니다. v3.0.0 부터 아래 7개 항목이
> 실제로 실립니다.

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-04-17 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center            : srcconm
name.host              : zdm-host-src
id.center              : 9
id.install             : install-009
id.machine             : 4c4c4544-0037-5310-8043-b7c04f503732
os.version             : Ubuntu 22.04
ip.public              : 121.189.21.220
ip.private             : 192.168.1.10
status.connect         : connected
status.activate        : ok
path.logFile           : /var/log/zdm
path.install           : /opt/zdm
resources.model        : PowerEdge R740
resources.cpu          : Intel(R) Xeon(R) Gold 6248
resources.cpuCount     : 2
resources.memory       : 34359738368 (32.00 GB)
resources.kernel       : 5.15.0-91-generic
resources.systemType   : x86_64
resources.organization : ZConverter
lastUpdated            : 2026-04-17T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식 (`resources` 부분):**
```json
{
  "resources": {
    "model": "PowerEdge R740",
    "cpu": "Intel(R) Xeon(R) Gold 6248",
    "cpuCount": "2",
    "memory": "34359738368 (32.00 GB)",
    "kernel": "5.15.0-91-generic",
    "systemType": "x86_64",
    "organization": "ZConverter"
  }
}
```

`memory` 는 `원값 (읽기 쉬운 값)` 형식입니다. 장비에 따라 원값이 이미 읽기 쉬운 형식인 경우에는
그 값을 그대로 표시합니다.

---

### Repository 정보 포함 출력 (--repo)

**Text 형식:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* ZDM Info Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-04-17 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[ZDM 1]
name.center     : srcconm
name.host       : zdm-host-src
id.center       : 9
id.install      : install-009
os.version      : Ubuntu 22.04
ip.public       : 121.189.21.220
ip.private      : 192.168.1.10
status.connect  : connected
status.activate : ok
path.logFile    : /var/log/zdm
path.install    : /opt/zdm
lastUpdated     : 2026-04-17T10:30:00Z
repository      :
  [Repository 1]
    id          : 43
    type        : nfs
    size        : 500.0 GB, used: 100.0 GB, free: 400.0 GB (20%)
    remotePath  : /mnt/backup
    localPath   : /backup
    ipAddress   : 192.168.1.100
    port        : 2049
    lastUpdated : 2026-04-17T10:30:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**
```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Success",
  "success": true,
  "data": [
    {
      "name": {
        "center": "srcconm",
        "host": "zdm-host-src"
      },
      "id": {
        "center": "9",
        "install": "install-009",
        "machine": "4c4c4544-0037-5310-8043-b7c04f503732"
      },
      "os": {
        "version": "Ubuntu 22.04"
      },
      "ip": {
        "public": "121.189.21.220",
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
      "repository": [
        {
          "id": "43",
          "type": "nfs",
          "size": {
            "raw": 536870912000,
            "formatted": "500.0 GB"
          },
          "used": {
            "raw": 107374182400,
            "formatted": "100.0 GB"
          },
          "free": {
            "raw": 429496729600,
            "formatted": "400.0 GB"
          },
          "usage": 20,
          "remotePath": "/mnt/backup",
          "localPath": "/backup",
          "ipAddress": ["192.168.1.100"],
          "port": "2049",
          "lastUpdated": "2026-04-17T10:30:00Z"
        }
      ],
      "lastUpdated": "2026-04-17T10:30:00Z"
    }
  ],
  "timestamp": "2026-04-17T10:30:00.000+09:00"
}
```

</details>

---
