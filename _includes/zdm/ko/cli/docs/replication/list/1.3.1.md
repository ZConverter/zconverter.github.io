
Replication 목록 및 정보를 조회하는 명령어입니다.

---

## `replication list` {#replication-list}

> * Replication 작업의 목록 또는 특정 작업의 상세 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Replication 목록 조회
zdm-cli replication list

# 특정 서버의 Replication 목록 조회
zdm-cli replication list --server web01

# 작업 ID로 특정 Replication 조회
zdm-cli replication list --id 123

# (v2) 모드/Unit 타입으로 필터링
zdm-cli replication list --mode full --unit backup

# (v1) Unit 타입으로 필터링
zdm-cli replication list --unit image

# 상세 정보 포함 조회
zdm-cli replication list --id 123 --detail

# JSON 형식으로 출력
zdm-cli replication list --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --server | - | string | Optional | - | 대상 서버 | - |
| --name | - | string | Optional | - | 작업 이름 | - |
| --id | - | number | Optional | - | 작업 ID | - |
| --mode | - | string | Optional | - | Replication 모드 | v1: full, increment / v2: full, increment, sync |
| --unit | - | string | Optional | - | Unit 타입 | v1: image, repository / v2: backup, repository, server |
| --status | - | string | Optional | - | 작업 상태 | {% include zdm/job-status.md %} |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --asc | - | boolean | Optional | false | 오름차순 정렬 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Info Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Replication 1]
name                    : repl_job_01
id                      : 123
unitType                : backup
replicationMode         : full
status(current)         : complete
system.name             : web01
targetRepository.path   : /replication/repo
targetRepository.type   : nfs
targetRepository.ip     : 10.0.0.2
start                   : 2025-01-15T10:00:00Z
elapsed                 : 00:15:00
end                     : 2025-01-15T10:15:00Z
lastUpdated             : 2025-01-15T10:15:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Success",
  "success": true,
  "data": [
    {
      "system": {
        "name": "web01"
      },
      "job": {
        "info": {
          "name": "repl_job_01",
          "id": "123",
          "unitType": "backup",
          "replicationMode": "full",
          "status": {
            "current": "complete",
            "time": {
              "start": "2025-01-15T10:00:00Z",
              "elapsed": "00:15:00",
              "end": "2025-01-15T10:15:00Z"
            }
          }
        },
        "lastUpdated": "2025-01-15T10:15:00Z"
      },
      "targetRepository": {
        "path": "/replication/repo",
        "type": "nfs",
        "ip": "10.0.0.2"
      }
    }
  ],
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
