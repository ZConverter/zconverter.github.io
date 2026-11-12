{% include zdm/base-path.html %}

스케줄 기능의 전체 워크플로우를 단계별로 설명합니다.

## 스케줄 생성 절차

<details markdown="1" open>
<summary><strong>기본 절차</strong></summary>

```bash
# 1. 스케줄 타입 선택
#    - Basic (0~6): 단일 주기 스케줄
#    - Smart (7~11): Full + Increment 복합 스케줄 (Backup 작업에서만 사용)

# 2. 스케줄 생성 (예: 매일 12:00 실행)
zdm-cli schedule create -t 3 --basic-time 12:00

# 3. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json

# 4. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json
```

</details>

---

## 스케줄 검증 절차

<details markdown="1" open>
<summary><strong>기본 절차</strong></summary>

```bash
# 1. 스케줄 파일 검증
zdm-cli schedule verify -p /path/to/schedule.json

# 2. 절대 경로 사용
zdm-cli schedule verify --path /home/user/schedules/daily-schedule.json

# 3. 상대 경로 사용
zdm-cli schedule verify -p ./Basic_schedule-20250106120000.json

# 4. 검증 성공 시 출력
# * Schedule 데이터가 유효합니다

# 5. 검증 실패 시 출력 예시
# * 파일을 찾을 수 없습니다: /path/to/schedule.json
# * 유효하지 않은 JSON 형식입니다
# * type 필드가 없습니다
# * basic.time은 필수 입력 항목입니다
```

</details>

---

## 스케줄 등록 절차

> `schedule create` 는 파일 저장과 함께 서버 등록까지 수행합니다. 아래 `schedule regist` 단계는 직접 작성했거나 다른 곳에서 가져온 JSON 파일을 등록할 때 사용합니다. `create` 로 만든 파일을 다시 `regist` 하면 같은 내용의 스케줄이 하나 더 등록됩니다.

<details markdown="1" open>
<summary><strong>스케줄 서버 등록</strong></summary>

```bash
# 1. 스케줄 생성 (매일 12:00 실행)
zdm-cli schedule create -t 3 --basic-time 12:00

# 2. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json

# 3. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json

# 4. 스케줄 서버 등록
zdm-cli schedule regist -p /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106120000.json

# 5. 등록된 스케줄 확인
zdm-cli schedule list
```

</details>

<details markdown="1">
<summary><strong>백업 작업에 스케줄 등록</strong></summary>

```bash
# 1. 스케줄 생성 (매일 02:00 백업)
zdm-cli schedule create -t 3 --basic-time 02:00

# 2. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106020000.json

# 3. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106020000.json

# 4. 스케줄 등록 후 ID 확인
zdm-cli schedule regist -p /home/user/.zconverter/zdm-cli-data/schedule/Basic_schedule-20250106020000.json
zdm-cli schedule list

# 5. 백업 작업 등록 시 스케줄 ID 지정 (입력한 ID 의 내용이 복사되어 새 스케줄로 연결됨)
zdm-cli backup regist --server "server-01" --mode full --repository-id 1 --schedule-id <스케줄 ID>

# 6. 등록 결과 확인
zdm-cli backup list
```

</details>

<details markdown="1">
<summary><strong>복구 작업에 스케줄 등록</strong></summary>

```bash
# 1. 스케줄 생성 (매주 일요일 03:00 복구, 사용자 지정 경로)
zdm-cli schedule create -t 4 --basic-day sun --basic-time 03:00 -p /tmp/weekly-schedule.json

# 2. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /tmp/weekly-schedule.json

# 3. 스케줄 검증
zdm-cli schedule verify -p /tmp/weekly-schedule.json

# 4. 복구 작업 등록 시 스케줄 파일 경로 지정 (--schedule-file)
zdm-cli recovery regist --source "source-server" --target "target-server" --platform "aws" --mode full --repository-id 1 --schedule-file "/tmp/weekly-schedule.json"

# 5. 등록 결과 확인
zdm-cli recovery list
```

</details>

---

## 자동 등록을 활용한 간편 절차

<details markdown="1" open>
<summary><strong>create 명령어로 생성과 등록을 동시에</strong></summary>

`schedule create` 명령어는 스케줄 파일 생성과 ZDM 서버 등록을 자동으로 수행합니다.
별도의 `verify` + `regist` 과정 없이 한 번에 처리할 수 있습니다.

```bash
# 1. 스케줄 생성 + 자동 등록 (센터 지정)
zdm-cli schedule create -t 3 --basic-time 02:00 --center 9

# 2. 등록된 스케줄 확인
zdm-cli schedule list --center 9

# 3. 백업 작업에 스케줄 연결 (list 에서 확인한 ID 사용)
zdm-cli backup regist --server "server-01" --mode full --repository-id 1 --schedule-id <스케줄 ID>
```

</details>

---

작업 종류별 스케줄 옵션과 JSON 형식은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참고하세요.
