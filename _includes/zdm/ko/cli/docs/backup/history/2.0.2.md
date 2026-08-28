
Backup 실행 히스토리를 조회하는 명령어입니다.

---

## `backup history` {#backup-history}

> * Backup 작업의 실행 이력을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup history [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Backup 히스토리 조회
zdm-cli backup history

# Center 지정하여 히스토리 조회
zdm-cli backup history --center 9

# 여러 Center의 히스토리 조회 (콤마 구분)
zdm-cli backup history --center 9,srcconm

# 작업 ID로 필터링
zdm-cli backup history --job-id 123

# 작업 이름으로 필터링
zdm-cli backup history --job-name "daily_backup"

# 서버로 필터링
zdm-cli backup history --server ca-rocky810_172.25.0.48

# 파티션으로 필터링
zdm-cli backup history --partition "/"

# 결과 상태로 필터링
zdm-cli backup history --result success

# 서버 및 결과로 필터링
zdm-cli backup history --server ca-rocky810_172.25.0.48 --result failed

# 오름차순 정렬
zdm-cli backup history --asc

# JSON 형식으로 출력
zdm-cli backup history --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | - | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --job-id | - | number | Optional | - | 작업 ID로 필터링 | - |
| --job-name | - | string | Optional | - | 작업 이름으로 필터링 | - |
| --server | - | string | Optional | - | 서버 이름으로 필터링 | - |
| --partition | - | string | Optional | - | 파티션으로 필터링 | - |
| --result | - | string | Optional | - | 결과 상태로 필터링 | `success`, `failed` |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup History Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Backup History 1]
id               : 456
system.name      : ca-rocky810_172.25.0.48
job.name         : backup_job_01
job.id           : 123
job.mode         : full
job.partition    : /
result.status    : success
result.description : Backup completed successfully
size.total       : 1073741824
size.backed      : 1073741824
count.total      : 150
count.backed     : 150
time.start       : 2025-01-15T10:00:00Z
time.end         : 2025-01-15T10:15:00Z
time.elapsed     : 00:15:00

[Backup History 2]
id               : 457
system.name      : ca-rocky810_172.25.0.48
job.name         : backup_job_02
job.id           : 124
job.mode         : increment
job.partition    : /home
result.status    : failed
result.description : Disk space insufficient
size.total       : 2147483648
size.backed      : 536870912
count.total      : 300
count.backed     : 75
time.start       : 2025-01-15T10:20:00Z
time.end         : 2025-01-15T10:25:00Z
time.elapsed     : 00:05:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식:**

```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "Success",
  "success": true,
  "data": [
    {
      "id": 456,
      "system": {
        "name": "ca-rocky810_172.25.0.48"
      },
      "job": {
        "name": "backup_job_01",
        "id": 123,
        "mode": "full",
        "partition": "/"
      },
      "result": {
        "status": "success",
        "description": "Backup completed successfully"
      },
      "size": {
        "total": 1073741824,
        "backed": 1073741824
      },
      "count": {
        "total": 150,
        "backed": 150
      },
      "time": {
        "start": "2025-01-15T10:00:00Z",
        "end": "2025-01-15T10:15:00Z",
        "elapsed": "00:15:00"
      }
    },
    {
      "id": 457,
      "system": {
        "name": "ca-rocky810_172.25.0.48"
      },
      "job": {
        "name": "backup_job_02",
        "id": 124,
        "mode": "increment",
        "partition": "/home"
      },
      "result": {
        "status": "failed",
        "description": "Disk space insufficient"
      },
      "size": {
        "total": 2147483648,
        "backed": 536870912
      },
      "count": {
        "total": 300,
        "backed": 75
      },
      "time": {
        "start": "2025-01-15T10:20:00Z",
        "end": "2025-01-15T10:25:00Z",
        "elapsed": "00:05:00"
      }
    }
  ],
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
