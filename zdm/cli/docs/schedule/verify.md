---
layout: docs
title: schedule verify
section_title: ZDM CLI Documentation
navigation: cli
---

스케줄 JSON 파일을 검증합니다.

---

## `schedule verify` {#schedule-verify}

> * 스케줄 JSON 파일을 검증합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule verify --path &lt;path&gt;</code>
</div>

</details>

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

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--path` | `-p` | string | Required | - | 검증할 Schedule File Path | - |

</details>

---
