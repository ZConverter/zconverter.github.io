---
layout: docs
title: schedule regist
section_title: ZDM CLI Documentation
navigation: cli
---

새로운 스케줄을 등록합니다.

---

## `schedule regist` {#schedule-regist}

> * 새로운 스케줄을 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule regist --path &lt;path&gt;</code>
</div>

</details>

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

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--path` | - | string | Required | - | 스케줄 정의 JSON 파일 경로 | - |

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
