
Recovery 작업의 실시간 진행 상태를 모니터링합니다.

---

## `recovery monit` {#recovery-monit}

> * Recovery 작업의 실시간 진행 상태 및 로그를 조회합니다.
> * 작업 ID/이름 또는 서버 ID/이름을 기준으로 모니터링할 수 있습니다.
> * **파티션/드라이브별 진행률은 기본 출력에 포함됩니다.** `--detail` 은 파티션 **메타데이터**(대상 디스크·크기·복구 방식 등)와 **작업 로그**를 더하는 옵션입니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery monit [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링 (파티션별 진행률 포함)
zdm-cli recovery monit --job-id 123

# 특정 Center 지정하여 모니터링
zdm-cli recovery monit --center 9 --job-id 123

# 복수 Center 조회 (콤마 구분)
zdm-cli recovery monit --center 9,10 --job-name "my-recovery"

# 작업 이름으로 모니터링
zdm-cli recovery monit --job-name "my-recovery"

# 파티션 메타데이터와 작업 로그까지 함께 보기
zdm-cli recovery monit --job-name "MyRecovery" --detail

# 서버 ID로 모니터링
zdm-cli recovery monit --server-id 456

# 서버 이름으로 모니터링
zdm-cli recovery monit --server-name "MyServer"

# 서버 타입 지정 모니터링
zdm-cli recovery monit --server-name "MyServer" --server-type source

# 작업 ID와 모드로 필터링 모니터링
zdm-cli recovery monit --job-id 789 --mode full

# 상태로 필터링 모니터링
zdm-cli recovery monit --server-name "MyServer" --status processing

# 작업 이름이 정확히 일치하는 작업만 남겨 모니터링
zdm-cli recovery monit --server-name "MyServer" --job-name-filter "daily-recovery"

# 첫 페이지 20건만 모니터링
zdm-cli recovery monit --server-name "MyServer" --page 1 --limit 20

# 서버와 파티션으로 모니터링 (--detail 없이도 해당 파티션의 진행률이 나옵니다)
zdm-cli recovery monit --server-name "DB-Server" --partition "/dev/sda1"

# 드라이브로 필터링 (Windows)
zdm-cli recovery monit --job-id 123 --drive "C:"

# JSON 형식 출력
zdm-cli recovery monit --job-id 123 --output json

# 테이블 형식 출력
zdm-cli recovery monit --server-id 456 --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | - | 작업 대상 Center (콤마 구분 복수 지정 가능) | - |
| --job-id | -ji | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| --job-name | -jn | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| --job-name-filter | -jnf | string | Optional | - | 반환된 job 목록을 작업 이름이 **정확히 일치**하는 것만 남겨 거름 (서버 기준 조회 전용) | - |
| --server-id | -si | number | Optional<span class="required-note">*</span> | - | 작업 대상 Server ID | - |
| --server-name | -sn | string | Optional<span class="required-note">*</span> | - | 작업 대상 Server Name | - |
| --mode | - | string | Optional | - | 복구 방식으로 파티션/드라이브 행을 좁힘 | {% include zdm/job-modes.md recovery=true %} |
| --status | - | string | Optional | - | 작업 상태로 목록을 거름 (서버 기준 조회 전용) | {% include zdm/job-status.md %} |
| --partition | - | string | Optional | - | 파티션 (Linux). 파티션/드라이브 행을 좁힘 | - |
| --drive | - | string | Optional | - | 드라이브 (Windows). 파티션/드라이브 행을 좁힘 | - |
| --server-type | -st | string | Optional | - | 서버 타입 (서버 기준 조회 전용) | `source`, `target` |
| --page | - | number | Optional | - (전체 목록) | job 목록 페이지 번호 (서버 기준 조회 전용) | - |
| --limit | - | number | Optional | - (전체 목록) | 페이지당 작업 수 (서버 기준 조회 전용) | - |
| --detail | - | boolean | Optional | false | 파티션/드라이브 **메타데이터**(대상 디스크·크기·복구 방식·디스크 번호·덮어쓰기)와 **작업 로그**(작업 기준 조회 전용) 추가 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> <span class="required-note">*</span> `job-id`/`job-name` 또는 `server-id`/`server-name` 중 하나는 필수로 입력해야 합니다.<br>
> <span class="required-note">*</span> ID와 Name은 동시에 입력할 수 없습니다.<br>
> <span class="required-note">*</span> job과 server 파라미터는 동시에 사용할 수 없습니다.<br>
> <span class="required-note">*</span> `--partition` 과 `--drive` 는 같은 대상을 가리키는 하나의 필터입니다. 함께 지정하면 실행 전에 거부됩니다. 값 형식은 서버가 정규화하므로 `C`, `C:`, `/data` 를 그대로 쓸 수 있습니다.<br>
> <span class="required-note">*</span> **`--detail` 은 파티션별 진행률을 켜는 옵션이 아닙니다.** 파티션/드라이브별 `status` · `percent` · `message` · 시간 정보는 `--detail` 없이도 출력됩니다. `--detail` 이 더하는 것은 각 파티션의 **메타데이터**(대상 디스크·크기·복구 방식·디스크 번호·덮어쓰기)와, 작업 기준 조회의 **작업 로그**뿐입니다. 서버 기준 조회는 `--detail` 을 지정해도 로그를 출력하지 않습니다.<br>
> <span class="required-note">*</span> `--mode` 는 **`--detail` 에서만 보이는 필드로 행을 거릅니다.** `--detail` 없이 `--mode` 를 지정하면 행이 줄어든 근거가 출력에 나타나지 않습니다. 걸러진 이유까지 확인하려면 `--detail` 과 함께 쓰세요.<br>
> <span class="required-note">*</span> `--status` · `--server-type` · `--job-name-filter` · `--page` · `--limit` 은 서버 기준 조회 전용이며 작업 기준 조회에서는 전송되지 않습니다.<br>
> <span class="required-note">*</span> `--job-name` 은 모니터링할 작업을 지목하는 값이고, `--job-name-filter` 는 서버 기준 조회로 돌아온 job 목록에서 이름이 정확히 일치하는 작업만 남기는 필터입니다 — 서로 다른 옵션입니다.

</details>

<details markdown="1" open>
<summary><strong>출력 구조</strong></summary>

**응답의 구조** — `--output json` 은 API 응답을 그대로 출력합니다.

```
data.job                        (작업 기준은 객체, 서버 기준은 배열)
├─ info      { id, name, source, target, role }
├─ progress  { status, percent, message, partitions[] }
├─ timeInfo  { start, elapsed, end }
└─ log[]                                              ← --detail · 작업 기준 조회 전용
```

`progress.partitions[]` 의 각 원소가 파티션(Linux) 또는 드라이브(Windows) 하나의 진행입니다. **한 원소는 (파티션, 백업 작업, 백업 이미지) 조합**이므로 같은 파티션이 백업 이미지별로 여러 번 나올 수 있으며, `backupFile` 이 그 행들을 구분합니다.

| 항목 | 기본 출력 | `--detail` |
|---|:---:|:---:|
| 파티션(`partition`) 또는 드라이브(`drive`) · `backupFile` | O | O |
| 파티션별 `status` · `percent` · `message` · 시간 정보 | O | O |
| `targetDisk` · `size` · `mode` | - | O |
| `diskNumber` (Windows) · `overwrite` (Linux) | - | O |
| 작업 로그 | - | O (작업 기준 조회 전용) |

> **파티션마다 값이 실제로 다릅니다.** 한 작업 안에서 어떤 파티션은 완료(`Complete` · `100%`), 어떤 파티션은 진행 중(`Processing` · `62%`), 어떤 파티션은 아직 시작 전(`Registered` · `-`)인 것이 정상입니다. 시작 전 행은 `percent` 가 `0%` 가 아니라 `-` 이고 `message` · 시간 정보도 모두 `-` 입니다.
>
> **작업 단위 `message` 와 파티션 `message` 의 형태가 다릅니다.** 작업 단위는 데몬이 기록한 원문 그대로라 `[source-server_home]` 같은 작업명 접두어가 붙고, 파티션 쪽은 그 접두어가 제거된 형태입니다.
>
> **작업 단위 `percent` 와 `overallProgress` 를 파티션 행으로 계산하지 마세요.** 두 값은 데몬이 세어 둔 복구 완료 개수에서 나옵니다. 아래 예시의 `daily-recovery` 는 3행 중 1행이 완료(33%)인데 작업 진행률이 `45%` 이며, 이는 오류가 아닙니다 — 출처가 다릅니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

> 아래 text 예시는 **어떤 정보가 어떤 순서로 출력되는지**를 보여 줍니다. 각 항목의 정확한 필드 구성은 `--output json` 예시로 확인하세요 — JSON 은 **API 응답을 그대로** 출력하므로 `timeInfo` 도 중첩된 원래 모양 그대로입니다.

### 기본 출력 - 작업 기준

`--detail` 없이도 **작업 단위 진행 상태 + 파티션/드라이브별 진행률**이 출력됩니다. 파티션 메타데이터와 작업 로그는 출력되지 않습니다.

> 작업 기준 조회에는 `role` 값이 없어 `-` 로 출력됩니다. `role` 은 서버 기준 조회에서만 채워집니다.

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery information retrieved
timestamp : 2025-01-15T10:45:00.000+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Job Information]
id      : 12
name    : daily-recovery
source  : source-server
target  : target-server
role    : -
status  : Processing
percent : 45%
message : [source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start   : 2025-01-15 10:30:00
elapsed : 00:15:00
end     : -

  [Partition 1]
partition  : /
backupFile : daily-backup_20250114_020000.ZIA
status     : Complete
percent    : 100%
message    : Recovery completed.
start      : 2025-01-15 10:30:05
elapsed    : 00:06:20
end        : 2025-01-15 10:36:25
  [Partition 2]
partition  : /home
backupFile : daily-backup_20250114_020000.ZIA
status     : Processing
percent    : 62%
message    : 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start      : 2025-01-15 10:36:30
elapsed    : 00:08:30
end        : -
  [Partition 3]
partition  : /home
backupFile : weekly-backup_20250112_030000.ZIA
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

* `role` 은 작업 기준 조회에서 값이 없어 `-` 로 나옵니다 — JSON 은 키 자체를 싣지 않습니다.
* 파티션 블록은 파티션 수만큼 이어지며, 진행 값은 **행마다 다릅니다**. 위 예시의 세 번째 행처럼
  아직 시작하지 않은 파티션은 `Registered` 에 시각이 `-` 입니다.
* 파티션의 `message` 는 작업 단위 메시지에서 **`[백업작업명]` 접두어만** 뗀 값입니다
  (`[source-server_home] 62%, …` → `62%, …`). 진행률 표기는 그대로 남습니다.
* Windows 대상이면 블록 제목과 키가 함께 바뀝니다 — `[Drive 1]` / `drive : C:`.
* text 출력에서는 응답의 `timeInfo` 가 `start` · `elapsed` · `end` 로 **평탄화**되어 나옵니다.

**JSON 형식:**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "job": {
      "info": {
        "id": 12,
        "name": "daily-recovery",
        "source": "source-server",
        "target": "target-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "45%",
        "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
        "partitions": [
          {
            "partition": "/",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed.",
            "timeInfo": {
              "start": "2025-01-15 10:30:05",
              "elapsed": "00:06:20",
              "end": "2025-01-15 10:36:25"
            }
          },
          {
            "partition": "/home",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "status": "Processing",
            "percent": "62%",
            "message": "62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
            "timeInfo": {
              "start": "2025-01-15 10:36:30",
              "elapsed": "00:08:30",
              "end": "-"
            }
          },
          {
            "partition": "/home",
            "backupFile": "weekly-backup_20250112_030000.ZIA",
            "status": "Registered",
            "percent": "-",
            "message": "-",
            "timeInfo": {
              "start": "-",
              "elapsed": "-",
              "end": "-"
            }
          }
        ]
      },
      "timeInfo": {
        "start": "2025-01-15 10:30:00",
        "elapsed": "00:15:00",
        "end": "-"
      }
    }
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

### 기본 출력 - 서버 기준

`--page` · `--limit` 을 지정하지 않으면 서버에 걸린 복구 작업을 **모두** 출력합니다. `[Jobs Summary]` 는 필터를 통과한 전체 작업 기준이며, 상태 버킷의 합은 항상 `total` 과 같습니다. 각 작업마다 파티션별 진행이 함께 나옵니다.

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery information retrieved
timestamp : 2025-01-15T10:45:00.000+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server Information]
name : target-server

[Jobs Summary]
total           : 3
completed       : 1
inProgress      : 1
failed          : 0
canceled        : 0
pending         : 1
overallProgress : 45%

[Job 1]
id      : 12
name    : daily-recovery
source  : source-server
target  : target-server
role    : target
status  : Processing
percent : 45%
message : [source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start   : 2025-01-15 10:30:00
elapsed : 00:15:00
end     : -

  [Partition 1]
partition  : /
backupFile : daily-backup_20250114_020000.ZIA
status     : Complete
percent    : 100%
message    : Recovery completed.
start      : 2025-01-15 10:30:05
elapsed    : 00:06:20
end        : 2025-01-15 10:36:25
  [Partition 2]
partition  : /home
backupFile : daily-backup_20250114_020000.ZIA
status     : Processing
percent    : 62%
message    : 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start      : 2025-01-15 10:36:30
elapsed    : 00:08:30
end        : -
  [Partition 3]
partition  : /home
backupFile : weekly-backup_20250112_030000.ZIA
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

[Job 2]
id      : 9
name    : weekly-recovery
source  : source-server
target  : target-server
role    : target
status  : Complete
percent : 100%
message : -
start   : 2025-01-14 02:00:00
elapsed : 00:42:10
end     : 2025-01-14 02:42:10

  [Partition 1]
partition  : /
backupFile : weekly-backup_20250112_030000.ZIA
status     : Complete
percent    : 100%
message    : -
start      : -
elapsed    : -
end        : -

[Job 3]
id      : 7
name    : dr-drill-recovery
source  : target-server
target  : dr-server
role    : source
status  : Registered
percent : -
message : -
start   : -
elapsed : -
end     : -

  [Partition 1]
partition  : /data
backupFile : data-backup_20250113_040000.ZIA
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

작업 블록은 작업 기준 조회의 `[Job Information]` 대신 **`[Job 1]` · `[Job 2]` …** 로 번호가 붙고,
각 작업 아래에 그 작업의 파티션 블록이 이어집니다. `role` 은 조회한 서버가 그 작업에서 맡은 쪽입니다 —
위 예시의 `[Job 3]` 처럼 조회 서버가 **source** 인 작업도 함께 반환됩니다.

**JSON 형식:**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 12,
          "name": "daily-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
        },
        "progress": {
          "status": "Processing",
          "percent": "45%",
          "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
          "partitions": [
            {
              "partition": "/",
              "backupFile": "daily-backup_20250114_020000.ZIA",
              "status": "Complete",
              "percent": "100%",
              "message": "Recovery completed.",
              "timeInfo": {
                "start": "2025-01-15 10:30:05",
                "elapsed": "00:06:20",
                "end": "2025-01-15 10:36:25"
              }
            },
            {
              "partition": "/home",
              "backupFile": "daily-backup_20250114_020000.ZIA",
              "status": "Processing",
              "percent": "62%",
              "message": "Processed Size: 5.680 MB | Speed: 36.83 MB/s",
              "timeInfo": {
                "start": "2025-01-15 10:36:30",
                "elapsed": "00:08:30",
                "end": "-"
              }
            },
            {
              "partition": "/home",
              "backupFile": "weekly-backup_20250112_030000.ZIA",
              "status": "Registered",
              "percent": "-",
              "message": "-",
              "timeInfo": {
                "start": "-",
                "elapsed": "-",
                "end": "-"
              }
            }
          ]
        },
        "timeInfo": {
          "start": "2025-01-15 10:30:00",
          "elapsed": "00:15:00",
          "end": "-"
        }
      },
      {
        "info": {
          "id": 9,
          "name": "weekly-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
        },
        "progress": {
          "status": "Complete",
          "percent": "100%",
          "message": "-",
          "partitions": [
            {
              "partition": "/",
              "backupFile": "weekly-backup_20250112_030000.ZIA",
              "status": "Complete",
              "percent": "100%",
              "message": "-",
              "timeInfo": {
                "start": "-",
                "elapsed": "-",
                "end": "-"
              }
            }
          ]
        },
        "timeInfo": {
          "start": "2025-01-14 02:00:00",
          "elapsed": "00:42:10",
          "end": "2025-01-14 02:42:10"
        }
      },
      {
        "info": {
          "id": 7,
          "name": "dr-drill-recovery",
          "source": "target-server",
          "target": "dr-server",
          "role": "source"
        },
        "progress": {
          "status": "Registered",
          "percent": "-",
          "message": "-",
          "partitions": [
            {
              "partition": "/data",
              "backupFile": "data-backup_20250113_040000.ZIA",
              "status": "Registered",
              "percent": "-",
              "message": "-",
              "timeInfo": {
                "start": "-",
                "elapsed": "-",
                "end": "-"
              }
            }
          ]
        },
        "timeInfo": {
          "start": "-",
          "elapsed": "-",
          "end": "-"
        }
      }
    ]
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> `dr-drill-recovery` 처럼 **아직 실행된 적 없는 작업**과, `weekly-recovery` 처럼 **진행 정보가 정리된 완료 작업**은 각 행이 작업 상태를 그대로 물려받습니다. 후자는 `status` 가 `Complete` · `percent` 가 `100%` 이면서 `message` 와 시간 정보는 `-` 인데, 그 행에 남아 있는 진행 정보가 없기 때문이며 모순이 아닙니다.

### 페이지 지정 출력 - 서버 기준

`--page` · `--limit` 을 지정하면 `[Jobs Summary]` 다음에 `[Jobs Page]` 블록이 붙습니다. `[Jobs Summary]` 는 필터를 통과한 **전체**를 세고, 이어지는 작업 블록은 그중 **한 페이지**입니다. 따라서 `total` 과 출력된 작업 수는 다를 수 있습니다.

> **페이지네이션은 작업 목록만 자릅니다.** 남은 작업의 파티션 진행은 그대로 전부 출력되므로, 파티션이 많은 서버에서는 `--limit` 을 작게 잡는 편이 출력량을 줄이는 데 효과적입니다.
>
> text 출력의 `[Jobs Page]` 에는 `currentPage` · `totalPages` · `totalItems` · `itemsPerPage` 만 나옵니다. 키-값 블록은 문자열·숫자 값만 싣기 때문이며, `hasNextPage` · `hasPreviousPage` 는 `--output json` 의 `data.pagination` 에 그대로 들어 있습니다.

**JSON 형식:** (전체 3건에 `--page 2 --limit 2` 를 지정한 경우)

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 7,
          "name": "dr-drill-recovery",
          "source": "target-server",
          "target": "dr-server",
          "role": "source"
        },
        "progress": {
          "status": "Registered",
          "percent": "-",
          "message": "-",
          "partitions": [
            {
              "partition": "/data",
              "backupFile": "data-backup_20250113_040000.ZIA",
              "status": "Registered",
              "percent": "-",
              "message": "-",
              "timeInfo": {
                "start": "-",
                "elapsed": "-",
                "end": "-"
              }
            }
          ]
        },
        "timeInfo": {
          "start": "-",
          "elapsed": "-",
          "end": "-"
        }
      }
    ],
    "pagination": {
      "currentPage": 2,
      "totalPages": 2,
      "totalItems": 3,
      "itemsPerPage": 2,
      "hasNextPage": false,
      "hasPreviousPage": true
    }
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

### 범위를 넘긴 페이지 출력 - 서버 기준

마지막 페이지보다 큰 번호를 지정하면 **오류가 아니라 정상 응답(200)** 입니다. `job` 만 비고 `summary` 는 필터를 통과한 전체를 그대로 셉니다 — 즉 `job: []` 이면서 `summary.total > 0` 인 것이 정상입니다.

> 아래는 전체 3건에 `--page 5 --limit 2` 를 지정한 경우입니다. `[Jobs Page]` 는 빈 목록 안내(`[Jobs]` · `No jobs found.`)보다 **먼저** 출력됩니다. 결과가 비어도 현재 페이지 번호와 전체 페이지 수를 확인할 수 있어야, 조건에 맞는 작업이 없는 것인지 페이지 번호가 범위를 넘긴 것인지 구분할 수 있기 때문입니다.

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery information retrieved
timestamp : 2025-01-15T10:45:00.000+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server Information]
name : target-server

[Jobs Summary]
total           : 3
completed       : 1
inProgress      : 1
failed          : 0
canceled        : 0
pending         : 1
overallProgress : 45%

[Jobs Page]
currentPage  : 5
totalPages   : 2
totalItems   : 3
itemsPerPage : 2

[Jobs]
No jobs found.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [],
    "pagination": {
      "currentPage": 5,
      "totalPages": 2,
      "totalItems": 3,
      "itemsPerPage": 2,
      "hasNextPage": false,
      "hasPreviousPage": true
    }
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

### 메타데이터·로그 포함 출력(`--detail`) - 작업 기준

`--detail` 을 지정하면 각 파티션 블록에 **메타데이터**가 더해지고, 작업 로그가 함께 출력됩니다. **파티션 개수와 진행 값은 기본 출력과 같습니다** — 늘어나는 것은 행마다의 필드와 로그뿐입니다. **로그는 작업 기준 조회에서만** 나옵니다.

> Linux 대상이면 `overwrite` 가, Windows 대상이면 `diskNumber` 가 실립니다. Windows 응답은 `partition` 대신 **`drive` 키**를 씁니다.

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery information retrieved
timestamp : 2025-01-15T10:45:00.000+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Job Information]
id      : 12
name    : daily-recovery
source  : source-server
target  : target-server
role    : -
status  : Processing
percent : 45%
message : [source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start   : 2025-01-15 10:30:00
elapsed : 00:15:00
end     : -

  [Partition 1]
partition  : /
backupFile : daily-backup_20250114_020000.ZIA
targetDisk : /dev/sda1
size       : 51200
mode       : Full Recovery
overwrite  : Overwritten
status     : Complete
percent    : 100%
message    : Recovery completed.
start      : 2025-01-15 10:30:05
elapsed    : 00:06:20
end        : 2025-01-15 10:36:25
  [Partition 2]
partition  : /home
backupFile : daily-backup_20250114_020000.ZIA
targetDisk : /dev/sda2
size       : 102400
mode       : Full Recovery
overwrite  : Not overwritten
status     : Processing
percent    : 62%
message    : 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start      : 2025-01-15 10:36:30
elapsed    : 00:08:30
end        : -
  [Partition 3]
partition  : /home
backupFile : weekly-backup_20250112_030000.ZIA
targetDisk : /dev/sda2
size       : 102400
mode       : Incremental Recovery
overwrite  : Not overwritten
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

[Job Logs]
1: [2025-01-15 10:30:00]Recovery job started.
2: [2025-01-15 10:30:12]Mounting repository.
3: [2025-01-15 10:36:25]Partition / recovery completed.
4: [2025-01-15 10:36:30]Restoring partition /home

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

메타데이터는 각 파티션 블록의 `backupFile` **다음**에 삽입되고, 진행 값(`status` 이하)은 기본 출력과 같은 자리에 그대로 남습니다.
`mode` · `overwrite` 는 코드값이 아니라 표시용 문구(`Full Recovery` · `Not overwritten`)로 나옵니다.
작업 로그는 `1:` 부터 번호가 붙어 마지막에 이어집니다.

**JSON 형식:**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "job": {
      "info": {
        "id": 12,
        "name": "daily-recovery",
        "source": "source-server",
        "target": "target-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "45%",
        "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
        "partitions": [
          {
            "partition": "/",
            "targetDisk": "/dev/sda1",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "size": 51200,
            "mode": "Full Recovery",
            "overwrite": "Overwritten",
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed.",
            "timeInfo": {
              "start": "2025-01-15 10:30:05",
              "elapsed": "00:06:20",
              "end": "2025-01-15 10:36:25"
            }
          },
          {
            "partition": "/home",
            "targetDisk": "/dev/sda2",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "size": 102400,
            "mode": "Full Recovery",
            "overwrite": "Not overwritten",
            "status": "Processing",
            "percent": "62%",
            "message": "62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
            "timeInfo": {
              "start": "2025-01-15 10:36:30",
              "elapsed": "00:08:30",
              "end": "-"
            }
          },
          {
            "partition": "/home",
            "targetDisk": "/dev/sda2",
            "backupFile": "weekly-backup_20250112_030000.ZIA",
            "size": 102400,
            "mode": "Incremental Recovery",
            "overwrite": "Not overwritten",
            "status": "Registered",
            "percent": "-",
            "message": "-",
            "timeInfo": {
              "start": "-",
              "elapsed": "-",
              "end": "-"
            }
          }
        ]
      },
      "timeInfo": {
        "start": "2025-01-15 10:30:00",
        "elapsed": "00:15:00",
        "end": "-"
      },
      "log": [
        "[2025-01-15 10:30:00]Recovery job started.",
        "[2025-01-15 10:30:12]Mounting repository.",
        "[2025-01-15 10:36:25]Partition / recovery completed.",
        "[2025-01-15 10:36:30]Restoring partition /home"
      ]
    }
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

### 메타데이터 포함 출력(`--detail`) - 서버 기준

작업마다 파티션 메타데이터가 붙습니다. 서버 기준 조회는 `--detail` 을 지정해도 **로그를 출력하지 않습니다** — 작업 수만큼 로그를 읽는 비용을 목록 조회에 지우지 않기 위함입니다.

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery Monit Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery information retrieved
timestamp : 2025-01-15T10:45:00.000+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Server Information]
name : target-server

[Jobs Summary]
total           : 3
completed       : 1
inProgress      : 1
failed          : 0
canceled        : 0
pending         : 1
overallProgress : 45%

[Job 1]
id      : 12
name    : daily-recovery
source  : source-server
target  : target-server
role    : target
status  : Processing
percent : 45%
message : [source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start   : 2025-01-15 10:30:00
elapsed : 00:15:00
end     : -

  [Partition 1]
partition  : /
backupFile : daily-backup_20250114_020000.ZIA
targetDisk : /dev/sda1
size       : 51200
mode       : Full Recovery
overwrite  : Overwritten
status     : Complete
percent    : 100%
message    : Recovery completed.
start      : 2025-01-15 10:30:05
elapsed    : 00:06:20
end        : 2025-01-15 10:36:25
  [Partition 2]
partition  : /home
backupFile : daily-backup_20250114_020000.ZIA
targetDisk : /dev/sda2
size       : 102400
mode       : Full Recovery
overwrite  : Not overwritten
status     : Processing
percent    : 62%
message    : 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s
start      : 2025-01-15 10:36:30
elapsed    : 00:08:30
end        : -
  [Partition 3]
partition  : /home
backupFile : weekly-backup_20250112_030000.ZIA
targetDisk : /dev/sda1
size       : 51200
mode       : Incremental Recovery
overwrite  : Not overwritten
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

[Job 2]
id      : 9
name    : weekly-recovery
source  : source-server
target  : target-server
role    : target
status  : Complete
percent : 100%
message : -
start   : 2025-01-14 02:00:00
elapsed : 00:42:10
end     : 2025-01-14 02:42:10

  [Partition 1]
partition  : /
backupFile : weekly-backup_20250112_030000.ZIA
targetDisk : /dev/sda1
size       : 51200
mode       : Incremental Recovery
overwrite  : Not overwritten
status     : Complete
percent    : 100%
message    : -
start      : -
elapsed    : -
end        : -

[Job 3]
id      : 7
name    : dr-drill-recovery
source  : target-server
target  : dr-server
role    : source
status  : Registered
percent : -
message : -
start   : -
elapsed : -
end     : -

  [Partition 1]
partition  : /data
backupFile : data-backup_20250113_040000.ZIA
targetDisk : /dev/sdb1
size       : 204800
mode       : Full Recovery
overwrite  : Not overwritten
status     : Registered
percent    : -
message    : -
start      : -
elapsed    : -
end        : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

작업 기준 `--detail` 과 달리 **`[Job Logs]` 블록이 없습니다.**

**JSON 형식:** (작업 1건만 발췌)

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Recovery information retrieved",
  "success": true,
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 1,
      "completed": 0,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 0,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 12,
          "name": "daily-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
        },
        "progress": {
          "status": "Processing",
          "percent": "45%",
          "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
          "partitions": [
            {
              "partition": "/",
              "targetDisk": "/dev/sda1",
              "backupFile": "daily-backup_20250114_020000.ZIA",
              "size": 51200,
              "mode": "Full Recovery",
              "overwrite": "Overwritten",
              "status": "Complete",
              "percent": "100%",
              "message": "Recovery completed.",
              "timeInfo": {
                "start": "2025-01-15 10:30:05",
                "elapsed": "00:06:20",
                "end": "2025-01-15 10:36:25"
              }
            },
            {
              "partition": "/home",
              "targetDisk": "/dev/sda2",
              "backupFile": "daily-backup_20250114_020000.ZIA",
              "size": 102400,
              "mode": "Full Recovery",
              "overwrite": "Not overwritten",
              "status": "Processing",
              "percent": "62%",
              "message": "Processed Size: 5.680 MB | Speed: 36.83 MB/s",
              "timeInfo": {
                "start": "2025-01-15 10:36:30",
                "elapsed": "00:08:30",
                "end": "-"
              }
            }
          ]
        },
        "timeInfo": {
          "start": "2025-01-15 10:30:00",
          "elapsed": "00:15:00",
          "end": "-"
        }
      }
    ]
  },
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

</details>

---
