---
layout: docs
title: Schedule Management
section_title: ZDM CLI Documentation
navigation: cli
---

스케줄을 생성, 등록, 조회, 검증합니다.

---

## Schedule Commands

### `schedule list` {#schedule-list}

스케줄 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 스케줄 목록 조회
zdm-cli schedule list

# 특정 스케줄 조회 (ID)
zdm-cli schedule list --id 1

# 스케줄 타입으로 필터링
zdm-cli schedule list --type 3

# 스케줄 상태로 필터링
zdm-cli schedule list --state active

# 여러 필터 조합
zdm-cli schedule list --type 3 --state active --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 | 선택값 |
|----------|------|------|------|------|--------|
| `--id` | | number | Optional | 스케줄 ID | |
| `--type` | | number | Optional | 스케줄 타입 번호 | 0~11 |
| `--state` | | string | Optional | 스케줄 상태 | |

</details>

---

### `schedule regist` {#schedule-regist}

새로운 스케줄을 등록합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# JSON 파일로 스케줄 등록
zdm-cli schedule regist --path ./schedules/daily-schedule.json

# 다른 경로의 스케줄 파일 등록
zdm-cli schedule regist --path /etc/zdm/schedules/backup-schedule.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--path` | | string | Required | 스케줄 정의 JSON 파일 경로 |

</details>

---

### `schedule create` {#schedule-create}

스케줄 데이터를 생성합니다. (JSON 파일 생성)

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Type 0 (한 번 실행) 스케줄 생성
zdm-cli schedule create --type 0 --basic-year 2025 --basic-month 12 --basic-day 31 --basic-time 23:59

# Type 3 (매일 실행) 스케줄 생성
zdm-cli schedule create --type 3 --basic-time 02:00

# Type 4 (매주 실행) 스케줄 생성
zdm-cli schedule create --type 4 --basic-day 1 --basic-time 03:00

# 센터와 사용자 정보를 포함한 생성
zdm-cli schedule create --type 3 --basic-time 01:00 --center zdm-center-01 --user admin@example.com

# 저장 경로 지정
zdm-cli schedule create --type 3 --basic-time 02:00 --path ./schedules/backup-schedule.json

# Type 7 (스마트 주간) 스케줄 생성
zdm-cli schedule create --type 7 --basic-day 1 --basic-time 02:00 --advanced-day 5 --advanced-time 14:00
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--type` | `-t` | number | Required | Schedule Type (0~11, 아래 스케줄 타입 참조) |
| `--path` | `-p` | string | Optional | 생성된 Schedule File 저장 Path |
| `--center` | `-c` | string | Optional | Schedule 등록 Center |
| `--user` | `-u` | string | Optional | Schedule 등록 User |
| `--basic-year` | `by` | string | Optional | Basic Schedule - 년도 설정 |
| `--basic-month` | `bm` | string | Optional | Basic Schedule - 월 설정 |
| `--basic-week` | `bw` | string | Optional | Basic Schedule - 주 설정 |
| `--basic-day` | `bd` | string | Optional | Basic Schedule - 일 설정 |
| `--basic-time` | `bt` | string | Optional | Basic Schedule - 시간 설정 |
| `--basic-interval-hour` | `bih` | string | Optional | Basic Schedule - 간격 시간 |
| `--basic-interval-minute` | `bim` | string | Optional | Basic Schedule - 간격 분 |
| `--advanced-year` | `ay` | string | Optional | Advanced Schedule - 년도 설정 (Smart Schedule용) |
| `--advanced-month` | `am` | string | Optional | Advanced Schedule - 월 설정 (Smart Schedule용) |
| `--advanced-week` | `aw` | string | Optional | Advanced Schedule - 주 설정 (Smart Schedule용) |
| `--advanced-day` | `ad` | string | Optional | Advanced Schedule - 일 설정 (Smart Schedule용) |
| `--advanced-time` | `at` | string | Optional | Advanced Schedule - 시간 설정 (Smart Schedule용) |
| `--advanced-interval-hour` | `aih` | string | Optional | Advanced Schedule - 간격 시간 (Smart Schedule용) |
| `--advanced-interval-minute` | `aim` | string | Optional | Advanced Schedule - 간격 분 (Smart Schedule용) |

</details>

---

### `schedule verify` {#schedule-verify}

스케줄 JSON 파일을 검증합니다.

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 스케줄 파일 검증
zdm-cli schedule verify --path ./schedules/daily-schedule.json

# 다른 경로의 스케줄 파일 검증
zdm-cli schedule verify --path /etc/zdm/schedules/backup-schedule.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--path` | `-p` | string | Required | 검증할 Schedule File Path |

</details>

---

## 스케줄 타입

<details markdown="1" open>
<summary><strong>스케줄 타입 목록</strong></summary>

| 번호 | 타입 | 설명 | 카테고리 |
|------|------|------|----------|
| 0 | once | 한 번 실행 | Basic |
| 1 | every minute | 매분 실행 | Basic |
| 2 | hourly | 매시간 실행 | Basic |
| 3 | daily | 매일 실행 | Basic |
| 4 | weekly | 매주 실행 | Basic |
| 5 | monthly on specific week | 매월 특정 주 | Basic |
| 6 | monthly on specific day | 매월 특정 일 | Basic |
| 7 | smart weekly on specific day | 스마트 주간 특정 요일 | Smart |
| 8 | smart monthly on specific week and day | 스마트 월간 특정 주+요일 | Smart |
| 9 | smart monthly on specific date | 스마트 월간 특정 날짜 | Smart |
| 10 | smart custom monthly on specific month, week and day | 스마트 커스텀 월간 (월+주+요일) | Smart |
| 11 | smart custom monthly on specific month and date | 스마트 커스텀 월간 (월+날짜) | Smart |

</details>

---

## Basic Schedule (Type 0-6)

<details markdown="1" open>
<summary><strong>Type 0: Once (한 번 실행)</strong></summary>

특정 날짜와 시간에 한 번만 실행됩니다.

```bash
zdm-cli schedule create \
  --type 0 \
  --basic-year 2025 \
  --basic-month 12 \
  --basic-day 31 \
  --basic-time 23:59
```

**필수 파라미터:**
- `basic-year`: 년도 (예: 2025)
- `basic-month`: 월 (1-12)
- `basic-day`: 일 (1-31)
- `basic-time`: 시간 (HH:MM 형식)

</details>

<details markdown="1" open>
<summary><strong>Type 1: Every Minute (매분 실행)</strong></summary>

매분마다 실행됩니다.

```bash
zdm-cli schedule create --type 1
```

**필수 파라미터:** 없음

</details>

<details markdown="1" open>
<summary><strong>Type 2: Hourly (매시간 실행)</strong></summary>

매시간 특정 분에 실행됩니다.

```bash
zdm-cli schedule create --type 2 --basic-interval-minute 30
```

**필수 파라미터:**
- `basic-interval-minute`: 분 (0-59)

**예시:**
- `30`: 매시간 30분에 실행 (예: 01:30, 02:30, 03:30, ...)

</details>

<details markdown="1" open>
<summary><strong>Type 3: Daily (매일 실행)</strong></summary>

매일 특정 시간에 실행됩니다.

```bash
zdm-cli schedule create --type 3 --basic-time 02:00
```

**필수 파라미터:**
- `basic-time`: 시간 (HH:MM 형식)

**예시:**
- `02:00`: 매일 오전 2시에 실행
- `14:30`: 매일 오후 2시 30분에 실행

</details>

<details markdown="1" open>
<summary><strong>Type 4: Weekly (매주 실행)</strong></summary>

매주 특정 요일과 시간에 실행됩니다.

```bash
zdm-cli schedule create --type 4 --basic-day 1 --basic-time 03:00
```

**필수 파라미터:**
- `basic-day`: 요일 (0=일요일, 1=월요일, ..., 6=토요일)
- `basic-time`: 시간 (HH:MM 형식)

**예시:**
- `--basic-day 1 --basic-time 03:00`: 매주 월요일 오전 3시
- `--basic-day 0 --basic-time 02:00`: 매주 일요일 오전 2시

</details>

<details markdown="1" open>
<summary><strong>Type 5: Monthly on Specific Week (매월 특정 주)</strong></summary>

매월 특정 주의 특정 요일에 실행됩니다.

```bash
zdm-cli schedule create --type 5 --basic-week 1 --basic-day 1 --basic-time 02:00
```

**필수 파라미터:**
- `basic-week`: 주차 (1=첫째주, 2=둘째주, 3=셋째주, 4=넷째주)
- `basic-day`: 요일 (0-6)
- `basic-time`: 시간 (HH:MM 형식)

**예시:**
- `--basic-week 1 --basic-day 1`: 매월 첫째주 월요일
- `--basic-week 3 --basic-day 5`: 매월 셋째주 금요일

</details>

<details markdown="1" open>
<summary><strong>Type 6: Monthly on Specific Day (매월 특정 일)</strong></summary>

매월 특정 날짜에 실행됩니다.

```bash
zdm-cli schedule create --type 6 --basic-day 15 --basic-time 02:00
```

**필수 파라미터:**
- `basic-day`: 일 (1-31)
- `basic-time`: 시간 (HH:MM 형식)

**예시:**
- `--basic-day 1`: 매월 1일
- `--basic-day 15`: 매월 15일

**주의사항:**
- 해당 월에 지정한 날짜가 없으면 실행되지 않음 (예: 31일이 없는 월)

</details>

---

## Smart Schedule (Type 7-11)

Smart Schedule은 기본 일정(Basic)과 고급 일정(Advanced)을 조합하여 유연한 스케줄링을 제공합니다.

<details markdown="1" open>
<summary><strong>Type 7: Smart Weekly (스마트 주간)</strong></summary>

주중과 주말에 다른 시간에 실행됩니다.

```bash
# 평일 오전 2시, 주말 오후 2시
zdm-cli schedule create \
  --type 7 \
  --basic-day 1 \
  --basic-time 02:00 \
  --advanced-day 0 \
  --advanced-time 14:00
```

**필수 파라미터:**
- `basic-day`: 평일 요일 (1-5)
- `basic-time`: 평일 시간
- `advanced-day`: 주말 요일 (0 또는 6)
- `advanced-time`: 주말 시간

**사용 예:**
- 평일: 업무 시간 외 백업
- 주말: 업무 시간 내 백업

</details>

<details markdown="1" open>
<summary><strong>Type 8: Smart Monthly Week (스마트 월간 주+요일)</strong></summary>

매월 특정 주의 요일과 다른 주의 요일에 실행됩니다.

```bash
# 첫째주 월요일과 셋째주 금요일
zdm-cli schedule create \
  --type 8 \
  --basic-week 1 \
  --basic-day 1 \
  --basic-time 02:00 \
  --advanced-week 3 \
  --advanced-day 5 \
  --advanced-time 02:00
```

**필수 파라미터:**
- `basic-week`: 첫 번째 주차
- `basic-day`: 첫 번째 요일
- `basic-time`: 첫 번째 시간
- `advanced-week`: 두 번째 주차
- `advanced-day`: 두 번째 요일
- `advanced-time`: 두 번째 시간

</details>

<details markdown="1" open>
<summary><strong>Type 9: Smart Monthly Date (스마트 월간 날짜)</strong></summary>

매월 두 개의 특정 날짜에 실행됩니다.

```bash
# 매월 1일과 15일
zdm-cli schedule create \
  --type 9 \
  --basic-day 1 \
  --basic-time 02:00 \
  --advanced-day 15 \
  --advanced-time 02:00
```

**필수 파라미터:**
- `basic-day`: 첫 번째 날짜
- `basic-time`: 첫 번째 시간
- `advanced-day`: 두 번째 날짜
- `advanced-time`: 두 번째 시간

**사용 예:**
- 매월 초와 중순 백업
- 급여일 전후 백업

</details>

<details markdown="1" open>
<summary><strong>Type 10: Smart Custom Monthly (월+주+요일)</strong></summary>

특정 월의 특정 주, 요일에 실행됩니다.

```bash
# 3월과 9월의 첫째주 월요일
zdm-cli schedule create \
  --type 10 \
  --basic-month 3 \
  --basic-week 1 \
  --basic-day 1 \
  --basic-time 02:00 \
  --advanced-month 9 \
  --advanced-week 1 \
  --advanced-day 1 \
  --advanced-time 02:00
```

**필수 파라미터:**
- `basic-month`: 첫 번째 월
- `basic-week`: 첫 번째 주차
- `basic-day`: 첫 번째 요일
- `basic-time`: 첫 번째 시간
- `advanced-month`: 두 번째 월
- `advanced-week`: 두 번째 주차
- `advanced-day`: 두 번째 요일
- `advanced-time`: 두 번째 시간

</details>

<details markdown="1" open>
<summary><strong>Type 11: Smart Custom Monthly (월+날짜)</strong></summary>

특정 월의 특정 날짜에 실행됩니다.

```bash
# 6월 30일과 12월 31일
zdm-cli schedule create \
  --type 11 \
  --basic-month 6 \
  --basic-day 30 \
  --basic-time 02:00 \
  --advanced-month 12 \
  --advanced-day 31 \
  --advanced-time 02:00
```

**필수 파라미터:**
- `basic-month`: 첫 번째 월
- `basic-day`: 첫 번째 날짜
- `basic-time`: 첫 번째 시간
- `advanced-month`: 두 번째 월
- `advanced-day`: 두 번째 날짜
- `advanced-time`: 두 번째 시간

**사용 예:**
- 반기 백업
- 분기 백업

</details>

---

## 스케줄 워크플로우

<details markdown="1" open>
<summary><strong>스케줄 생성 및 등록</strong></summary>

**1단계: 스케줄 생성**
```bash
# 매일 오전 2시 실행 스케줄 생성
zdm-cli schedule create \
  --type 3 \
  --basic-time 02:00 \
  --path ./daily-schedule.json
```

**2단계: 스케줄 검증**
```bash
# 생성된 스케줄 파일 검증
zdm-cli schedule verify --path ./daily-schedule.json
```

**3단계: 스케줄 등록**
```bash
# 스케줄을 ZDM에 등록
zdm-cli schedule regist --path ./daily-schedule.json
```

**4단계: 등록 확인**
```bash
# 등록된 스케줄 확인
zdm-cli schedule list
```

**5단계: 백업/복구 작업에 적용**
```bash
# 백업 작업에 스케줄 적용
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --schedule daily-schedule
```

</details>

---

## 사용 시나리오

<details markdown="1" open>
<summary><strong>일일 백업 스케줄</strong></summary>

```bash
# 매일 새벽 2시 백업
zdm-cli schedule create --type 3 --basic-time 02:00 --path ./daily-backup.json
zdm-cli schedule regist --path ./daily-backup.json
zdm-cli backup regist --server web-01 --mode smart --schedule daily-backup
```

</details>

<details markdown="1" open>
<summary><strong>주간 전체 백업</strong></summary>

```bash
# 매주 일요일 새벽 1시 전체 백업
zdm-cli schedule create --type 4 --basic-day 0 --basic-time 01:00 --path ./weekly-full.json
zdm-cli schedule regist --path ./weekly-full.json
zdm-cli backup regist --server web-01 --mode full --schedule weekly-full
```

</details>

<details markdown="1" open>
<summary><strong>월간 백업 스케줄</strong></summary>

```bash
# 매월 1일 새벽 3시 전체 백업
zdm-cli schedule create --type 6 --basic-day 1 --basic-time 03:00 --path ./monthly-backup.json
zdm-cli schedule regist --path ./monthly-backup.json
zdm-cli backup regist --server db-01 --mode full --schedule monthly-backup
```

</details>

<details markdown="1" open>
<summary><strong>평일/주말 다른 시간 백업</strong></summary>

```bash
# 평일 새벽 2시, 주말 오후 2시 백업
zdm-cli schedule create \
  --type 7 \
  --basic-day 1 \
  --basic-time 02:00 \
  --advanced-day 0 \
  --advanced-time 14:00 \
  --path ./smart-weekly.json
zdm-cli schedule regist --path ./smart-weekly.json
zdm-cli backup regist --server app-01 --mode smart --schedule smart-weekly
```

</details>

---

## JSON 파일 형식

<details markdown="1" open>
<summary><strong>스케줄 JSON 예시</strong></summary>

**Type 3 (Daily):**
```json
{
  "type": 3,
  "center": "zdm-center-01",
  "user": "admin@example.com",
  "basic": {
    "time": "02:00"
  }
}
```

**Type 4 (Weekly):**
```json
{
  "type": 4,
  "center": "zdm-center-01",
  "user": "admin@example.com",
  "basic": {
    "day": 1,
    "time": "03:00"
  }
}
```

**Type 7 (Smart Weekly):**
```json
{
  "type": 7,
  "center": "zdm-center-01",
  "user": "admin@example.com",
  "basic": {
    "day": 1,
    "time": "02:00"
  },
  "advanced": {
    "day": 0,
    "time": "14:00"
  }
}
```

</details>

---
