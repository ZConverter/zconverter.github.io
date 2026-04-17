
Replication 작업을 등록하는 명령어입니다.

---

## `replication regist` {#replication-regist}

> * 새로운 Replication 작업을 등록합니다.
> * v2.0.0에서는 `--source-center`/`--target-center`로 소스와 타겟 센터를 개별 지정합니다.
> * `--unit-type`에 따라 필요한 추가 파라미터가 다릅니다.
> * `--schedule`, `--schedule-id`, `--schedule-file` 중 하나로 스케줄을 설정할 수 있습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# backup 타입 Replication 등록 (소스 센터: srcconm, 타겟 센터: destconm)
zdm-cli replication regist --sc srcconm --tc destconm --ut backup --tri 44 -j 91

# repository 타입 Replication 등록
zdm-cli replication regist --sc 9 --tc 10 --ut repository --sri 43 --tri 44

# server 타입 Replication 등록
zdm-cli replication regist --sc srcconm --tc destconm --ut server -s "ca-rocky810_172.25.0.48" --tri 44

# 타겟 IP와 포트 지정
zdm-cli replication regist --sc srcconm --tc destconm --ut server -s 91 --tri 44 --ip 210.90.169.60 --port 22

# increment 모드 및 압축 활성화
zdm-cli replication regist --sc srcconm --tc destconm --ut backup -j 91 --tri 44 --mode increment --comp

# 스케줄과 자동 시작 설정
zdm-cli replication regist --sc srcconm --tc destconm --ut backup -j 91 --tri 44 --schedule-id 1234 --start

# 여러 백업 작업을 한번에 등록 (콤마 구분)
zdm-cli replication regist --sc srcconm --tc destconm --ut backup -j "91,92,93" --tri 44

# 여러 서버를 한번에 등록 (콤마 구분)
zdm-cli replication regist --sc srcconm --tc destconm --ut server -s "ca-rocky810_172.25.0.48,web02" --tri 44

# 소스 센터 생략 (config 설정값 사용)
zdm-cli replication regist --tc destconm --ut backup -j 91 --tri 44

# JSON 형식으로 결과 출력
zdm-cli replication regist --sc srcconm --tc destconm --ut backup -j 91 --tri 44 --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**필수**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --target-center | --tc | string | Required | - | 타겟 Center ID 또는 이름 | - |
| --unit-type | --ut | string | Required | - | Replication Unit 타입 | `backup`, `repository`, `server` |
| --target-repository-id | --tri | number | Required | - | 타겟 Repository ID | - |

**작업 정보**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --source-center | --sc | string | Optional | config 설정값 | 소스 Center ID 또는 이름 | - |
| --job-name | --jn | string | Optional | - | 작업 이름 | - |
| --ip | - | string | Optional | - | 타겟 IP 주소 | - |
| --port | - | number | Optional | 22 | 타겟 SSH 포트 (0 입력 시 비활성화) | - |
| --mode | - | string | Optional | full | Replication 모드 | `full`, `increment`, `sync` |

**unit-type=backup 전용**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --job | -j | string | Optional | - | 백업 작업 ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |

**unit-type=repository 전용**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --source-repository-id | --sri | string | Optional | - | 소스 Repository ID (콤마로 구분하여 복수 지정 가능) | - |

**unit-type=server 전용**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --server | -s | string | Optional | - | 서버 ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |

**옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --compression | --comp | boolean | Optional | - | 압축 사용 여부 | - |
| --network-limit | --nl | number | Optional | 0 | 네트워크 속도 제한 | - |
| --start | - | boolean | Optional | - | 작업 자동 시작 | - |

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | - | string | Optional | - | 스케줄 JSON 문자열 | - |
| --schedule-id | - | number | Optional | - | 기존 스케줄 ID | - |
| --schedule-file | - | string | Optional | - | 스케줄 JSON 파일 경로 | - |

**출력**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Registration Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Replication registered successfully
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Registration Summary]
total      : 1
successful : 1
failed     : 0

[Registration Details]

[Job 1]
state           : success
jobName         : repl_job_01
unitType        : backup
replicationMode : full
autoStart       : use
schedule        : 0 2 * * *

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "550e8400-e29b-41d4-a716-446655440000",
  "message": "Replication registered successfully",
  "success": true,
  "data": {
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    },
    "results": [
      {
        "state": "success",
        "jobName": "repl_job_01",
        "unitType": "backup",
        "replicationMode": "full",
        "autoStart": "use",
        "schedule": "0 2 * * *"
      }
    ]
  },
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
