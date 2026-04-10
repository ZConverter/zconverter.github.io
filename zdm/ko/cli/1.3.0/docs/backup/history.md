---
layout: docs
title: backup history
section_title: ZDM CLI Documentation
navigation: ko-cli-1.3.0
lang: ko
---

Backup 실행 히스토리를 조회하는 명령어입니다.

---

## `backup history` {#backup-history}

> * 백업 작업의 실행 이력(히스토리)을 조회합니다.
> * 필터 옵션을 통해 특정 조건의 히스토리만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup history [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 백업 히스토리 조회
zdm-cli backup history

# 작업 이름으로 필터링
zdm-cli backup history --job-name daily-backup

# 서버 + 결과 필터링
zdm-cli backup history --server web01 --result success

# 파티션 필터링
zdm-cli backup history --server web01 --partition "C:"

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
| --job-id | - | number | Optional | - | 작업 ID 필터 | - |
| --job-name | - | string | Optional | - | 작업 이름 필터 | - |
| --server | - | string | Optional | - | 서버 이름 필터 | - |
| --partition | - | string | Optional | - | 드라이브/파티션 필터 | - |
| --result | - | string | Optional | - | 결과 상태 필터 | `success`, `failed` |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup History Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-03-04 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Backup History 1]
id                : 1
system.name       : server-01
job.name          : daily-backup
job.id            : 10
job.backupType    : Full Backup
job.drive         : C:
job.repositoryPath: \\nas\backup
result.status     : COMPLETE
result.description: Backup completed successfully
time.start        : 2026-03-04 02:00:00
time.end          : 2026-03-04 02:30:00
time.elapsed      : 00:30:00

[Backup History 2]
id                : 2
system.name       : server-02
job.name          : weekly-backup
job.id            : 20
job.backupType    : Increment Backup
job.drive         : /
job.repositoryPath: /backup/server-02
result.status     : FAIL
result.description: Disk space insufficient
time.start        : 2026-03-04 03:00:00
time.end          : 2026-03-04 03:05:00
time.elapsed      : 00:05:00

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
      "id": 1,
      "system": {
        "name": "server-01"
      },
      "job": {
        "name": "daily-backup",
        "id": 10,
        "backupType": "Full Backup",
        "drive": "C:",
        "repositoryPath": "\\\\nas\\backup"
      },
      "result": {
        "status": "COMPLETE",
        "description": "Backup completed successfully"
      },
      "time": {
        "start": "2026-03-04 02:00:00",
        "end": "2026-03-04 02:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "timestamp": "2026-03-04 12:00:00"
}
```

</details>

---
