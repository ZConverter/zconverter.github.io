
Replication 작업을 수정하는 명령어입니다.

---

## `replication update` {#replication-update}

> * Replication 작업의 설정을 수정합니다.
> * 작업 ID 또는 이름으로 대상을 지정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli replication update [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Replication 모드 변경
zdm-cli replication update --id 123 --mode full

# 작업 시작
zdm-cli replication update --name repl01 --status start

# 작업 이름 변경
zdm-cli replication update --id 123 --cn new-repl-name

# 압축 및 네트워크 제한 설정
zdm-cli replication update --id 123 --comp --nl 1000

# 스케줄 설정
zdm-cli replication update --id 123 --schedule-id 1234
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**대상 지정 (하나 필수)**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --id | - | number | Required* | - | 작업 ID | - |
| --name | - | string | Required* | - | 작업 이름 | - |

> \* `--id` 또는 `--name` 중 하나는 반드시 입력해야 합니다.

**작업 정보**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --change-name | --cn | string | Optional | - | 새 작업 이름 | - |
| --mode | - | string | Optional | - | Replication 모드 | v1: full, increment / v2: full, increment, sync |
| --status | - | string | Optional | - | 작업 상태 변경 | start, stop, cancel |
| --transfer-type | --tt | string | Optional | - | 전송 타입 (v2 전용) | - |

**Repository**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --target-repository-id | --tri | number | Optional | - | 타겟 Repository ID |
| --target-repository-path | --trp | string | Optional | - | 타겟 Repository 경로 |

**작업 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --compression | --comp | boolean | Optional | - | 압축 사용 여부 |
| --encryption | --enc | boolean | Optional | - | 암호화 사용 여부 |
| --network-limit | --nl | number | Optional | - | 네트워크 속도 제한 |
| --mail-event | --me | string | Optional | - | 이벤트 메일 수신 주소 |
| --schedule | - | string | Optional | - | 스케줄 JSON 문자열 |
| --schedule-id | - | number | Optional | - | 기존 스케줄 ID |
| --schedule-file | - | string | Optional | - | 스케줄 JSON 파일 경로 |
| --exclude | --ex | string | Optional | - | 제외 패턴 (v2 전용) |
| --output | -o | string | Optional | text | 출력 형식 |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본)**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Replication Update Result [requestID: 550e8400-e29b-41d4-a716-446655440000] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Replication updated successfully
timestamp : 2025-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Replication Info]
id   : 123
name : repl01

[Changed Fields]
[Change 1]
field : replicationMode
value : increment -> full

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
