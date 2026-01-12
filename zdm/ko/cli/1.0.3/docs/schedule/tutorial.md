---
layout: docs
title: Schedule 튜토리얼
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

스케줄 기능의 전체 워크플로우를 단계별로 설명합니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [스케줄 생성 절차](#스케줄-생성-절차)
- [스케줄 검증 절차](#스케줄-검증-절차)
- [스케줄 등록 절차](#스케줄-등록-절차)

</details>

---

## 스케줄 생성 절차

<details markdown="1" open>
<summary><strong>기본 절차</strong></summary>

```bash
# 1. 스케줄 타입 선택
#    - Basic (0~6): 단일 주기 스케줄
#    - Smart (7~11): Full + Increment 복합 스케줄

# 2. 스케줄 생성 (예: 매일 12:00 실행)
zdm-cli schedule create -t 3 --basic-time 12:00

# 3. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

# 4. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json
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

<details markdown="1" open>
<summary><strong>스케줄 서버 등록</strong></summary>

```bash
# 1. 스케줄 생성 (매일 12:00 실행)
zdm-cli schedule create -t 3 --basic-time 12:00

# 2. 생성된 파일 경로 확인 (출력 예시)
# [info]
#
# saved to  : /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

# 3. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

# 4. 스케줄 서버 등록
zdm-cli schedule regist -p /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106120000.json

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
# saved to  : /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106020000.json

# 3. 스케줄 검증
zdm-cli schedule verify -p /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106020000.json

# 4. 스케줄 등록 후 ID 확인
zdm-cli schedule regist -p /home/user/.zconverter/zdm-cli/schedule/Basic_schedule-20250106020000.json
zdm-cli schedule list

# 5. 백업 작업 등록 시 스케줄 ID 지정
zdm-cli backup regist --server "server-01" --mode full --repository-id 1 --schedule "schedule_id"

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

# 4. 복구 작업 등록 시 스케줄 파일 경로 지정
zdm-cli recovery regist --source "source-server" --target "target-server" --platform "aws" --mode full --repository-id 1 --schedule "/tmp/weekly-schedule.json"

# 5. 등록 결과 확인
zdm-cli recovery list
```

</details>

---
