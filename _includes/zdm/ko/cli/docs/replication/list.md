
Replication 목록 및 정보를 조회하는 명령어입니다.

---

## `replication list` {#replication-list}

> * Replication 작업의 목록 또는 특정 작업의 상세 정보를 조회합니다.
> * **v3.0.0 (BREAKING)** — `--server` 옵션이 제거되었습니다. Replication 작업 정보에는 서버 컬럼이 없어 이 옵션은 실제로는 Center 이름으로 거르는 필터였으므로, ID·이름을 모두 받는 `--center` 로 대체하세요. CLI 는 알 수 없는 옵션을 허용하지 않으므로 `--server` 를 그대로 둔 스크립트는 조용히 무시되지 않고 파싱 단계에서 즉시 실패합니다 (도움말이 출력되고 종료 코드 1).

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

# 특정 Center의 Replication 목록 조회
zdm-cli replication list --center 9

# 여러 Center의 Replication 목록 조회 (콤마 구분)
zdm-cli replication list --center 9,10

# Center 이름으로 조회
zdm-cli replication list --center center01

# 작업 이름으로 조회
zdm-cli replication list --name repl01

# 작업 ID로 특정 Replication 조회
zdm-cli replication list --id 123

# 모드 및 Unit 타입으로 필터링
zdm-cli replication list --mode full --unit backup

# 상태로 필터링
zdm-cli replication list --status complete

# 상세 정보 포함 조회
zdm-cli replication list --id 123 --detail

# 오름차순 정렬 및 JSON 형식으로 출력
zdm-cli replication list --asc --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | - | string | Optional | - | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --name | - | string | Optional | - | 작업 이름 | - |
| --id | - | number | Optional | - | 작업 ID | - |
| --mode | - | string | Optional | - | Replication 모드 | `full`, `increment`, `sync` |
| --unit | - | string | Optional | - | Unit 타입 | `backup`, `repository`, `server` |
| --status | - | string | Optional | - | 작업 상태 | {% include zdm/job-status.md %} |
| --detail | - | boolean | Optional | false | 상세 정보 조회 | - |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Info Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
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
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

</details>

---
