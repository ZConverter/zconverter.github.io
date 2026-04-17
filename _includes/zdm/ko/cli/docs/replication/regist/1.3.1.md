
Replication 작업을 등록하는 명령어입니다.

---

## `replication regist` {#replication-regist}

> * 새로운 Replication 작업을 등록합니다.
> * Replication 버전(v1/v2)에 따라 사용 가능한 옵션이 다릅니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# (v1) image 타입 Replication 등록
zdm-cli replication regist --tc center1 --ut image --bn daily-backup --tri 1

# (v2) backup 타입 Replication 등록
zdm-cli replication regist --tc center1 --ut backup --bjn daily-backup --tri 1

# repository 타입 Replication 등록
zdm-cli replication regist --tc center1 --ut repository --sri 1 --tri 2

# (v2) server 타입 Replication 등록
zdm-cli replication regist --tc center1 --ut server --ssi 1 --tri 1

# 스케줄과 자동 시작 옵션 추가
zdm-cli replication regist --tc center1 --ut backup --bjn daily-backup --tri 1 --schedule-id 1234 --start
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**필수**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --target-center | --tc | string | Required | - | 타겟 센터 | - |
| --unit-type | --ut | string | Required | - | Unit 타입 | v1: image, repository / v2: backup, repository, server |

**작업 정보**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --source-center | --sc | string | Optional | config 값 | 소스 센터 | - |
| --job-name | --jn | string | Optional | - | 작업 이름 | - |
| --ip | - | string | Optional | - | 타겟 IP | - |
| --port | - | number | Optional | - | 타겟 포트 | - |
| --mode | - | string | Optional | full | Replication 모드 | v1: full, increment / v2: full, increment, sync |

**타겟 Repository**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --target-repository-id | --tri | number | Optional | config 값 | 타겟 Repository ID |
| --target-repository-path | --trp | string | Optional | config 값 | 타겟 Repository 경로 |

**V1 전용 (unit-type=image)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --backup-name | --bn | string | Optional | - | 백업 이름 |
| --transfer-backup-name | --tbn | string | Optional | - | 전송 백업 이름 |

**V2 전용 (unit-type=backup)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --backup-job-name | --bjn | string | Optional | - | 백업 작업 이름 (쉼표 구분) |

**소스 Repository (unit-type=repository)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --source-repository-id | --sri | number | Optional | - | 소스 Repository ID |
| --source-repository-path | --srp | string | Optional | - | 소스 Repository 경로 |

**V2 전용 (unit-type=server)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --source-server-id | --ssi | number | Optional | - | 소스 서버 ID |
| --source-server-name | --ssn | string | Optional | - | 소스 서버 이름 |

**옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --compression | --comp | boolean | Optional | - | 압축 사용 여부 |
| --network-limit | --nl | number | Optional | 0 | 네트워크 속도 제한 |
| --schedule | - | string | Optional | - | 스케줄 JSON 문자열 |
| --schedule-id | - | number | Optional | - | 기존 스케줄 ID |
| --schedule-file | - | string | Optional | - | 스케줄 JSON 파일 경로 |
| --start | - | boolean | Optional | - | 자동 시작 |
| --output | -o | string | Optional | text | 출력 형식 |

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

</details>

---
