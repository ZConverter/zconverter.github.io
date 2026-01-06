---
layout: docs
title: schedule list
section_title: ZDM CLI Documentation
navigation: cli
---

스케줄 목록을 조회합니다.

---

## `schedule list` {#schedule-list}

> * 스케줄 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule list [options]</code>
</div>

</details>

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

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--id` | - | number | Optional | - | 스케줄 ID | - |
| `--type` | - | number | Optional | - | 스케줄 타입 번호 | 0~11 |
| `--state` | - | string | Optional | - | 스케줄 상태 | - |

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
