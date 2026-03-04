---
layout: docs
title: recovery history
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.4
lang: ko
---

Recovery 실행 히스토리를 조회하는 명령어입니다.

---

## `recovery history` {#recovery-history}

> * 복구 작업의 실행 이력(히스토리)을 조회합니다.
> * 필터 옵션을 통해 특정 조건의 히스토리만 조회할 수 있습니다.
> * `--server-type` 옵션으로 소스/타겟 서버를 구분하여 필터링할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery history [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 복구 히스토리 조회
zdm-cli recovery history

# 작업 이름으로 필터링
zdm-cli recovery history --job-name daily-recovery

# 타겟 서버로 필터링 (기본값: target)
zdm-cli recovery history --server target-server

# 소스 서버로 필터링
zdm-cli recovery history --server source-server --server-type source

# 타겟 서버 + 결과 필터링
zdm-cli recovery history --server web01 --server-type target --result failed

# 파티션 필터링
zdm-cli recovery history --partition "C:"

# 오름차순 정렬
zdm-cli recovery history --asc

# JSON 형식으로 출력
zdm-cli recovery history --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --job-id | - | number | Optional | - | 작업 ID 필터 | - |
| --job-name | - | string | Optional | - | 작업 이름 필터 | - |
| --server | - | string | Optional | - | 서버 이름 필터 (`--server-type`에 따라 소스/타겟 구분) | - |
| --server-type | - | string | Optional | target | 서버 타입 (`--server`와 함께 사용) | `source`, `target` |
| --partition | - | string | Optional | - | 드라이브/파티션 필터 | - |
| --result | - | string | Optional | - | 결과 상태 필터 | `success`, `failed` |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> **참고:**
> - `--server-type`이 `target`(기본값)이면 `--server`는 복구 대상(타겟) 서버를, `source`이면 소스 서버를 기준으로 필터링합니다.
> - `--partition`은 콤마 구분된 복구 드라이브 목록에서 개별 항목을 정확히 매칭합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Recovery History Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-03-04 12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Recovery History 1]
id                     : 1
system.name            : source-server
job.name               : daily-recovery
job.id                 : 10
job.recoverySystemName : target-server
job.recoverDrive       : C:, D:
result.status          : COMPLETE
result.description     : Recovery completed successfully
time.start             : 2026-03-04 10:00:00
time.end               : 2026-03-04 10:30:00
time.elapsed           : 00:30:00

[Recovery History 2]
id                     : 2
system.name            : linux-server
job.name               : weekly-recovery
job.id                 : 20
job.recoverySystemName : target-linux
job.recoverDrive       : /
result.status          : FAIL
result.description     : Target server unreachable
time.start             : 2026-03-04 11:00:00
time.end               : 2026-03-04 11:05:00
time.elapsed           : 00:05:00

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
        "name": "source-server"
      },
      "job": {
        "name": "daily-recovery",
        "id": 10,
        "recoverySystemName": "target-server",
        "recoverDrive": ["C:", "D:"]
      },
      "result": {
        "status": "COMPLETE",
        "description": "Recovery completed successfully"
      },
      "time": {
        "start": "2026-03-04 10:00:00",
        "end": "2026-03-04 10:30:00",
        "elapsed": "00:30:00"
      }
    }
  ],
  "timestamp": "2026-03-04 12:00:00"
}
```

</details>

---
