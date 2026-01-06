---
layout: docs
title: backup monit
section_title: ZDM CLI Documentation
navigation: cli
---

백업 작업 진행 상황을 모니터링합니다.

---

## `backup monit` {#backup-monit}

> * 백업 작업 진행 상황을 모니터링합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup monit --job-id &lt;id&gt; | --job-name &lt;name&gt; | --server-id &lt;id&gt; | --server-name &lt;name&gt; [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli backup monit --job-id 123

# 작업 이름으로 상세 모니터링
zdm-cli backup monit --job-name "daily-backup" --detail

# 서버 ID로 모니터링
zdm-cli backup monit --server-id 456

# 서버 이름으로 상태 필터링 모니터링
zdm-cli backup monit --server-name "MyServer" --status running

# 작업 ID와 모드로 필터링 모니터링
zdm-cli backup monit --job-id 789 --mode full

# 서버와 저장소 경로로 모니터링
zdm-cli backup monit --server-name "DB-Server" --repository-path "/backup/db"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--job-id` | `ji` | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| `--job-name` | `jn` | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| `--server-id` | `si` | number | Optional<span class="required-note">*</span> | - | 작업 대상 Server ID | - |
| `--server-name` | `sn` | string | Optional<span class="required-note">*</span> | - | 작업 대상 Server Name | - |
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | - | string | Optional | - | 작업 상태 | - |
| `--repository-path` | `rp` | string | Optional | - | Repository Path | - |
| `--detail` | - | boolean | Optional | - | 상세 정보 조회 | - |

> <span class="required-note">*</span> job-id/job-name 또는 server-id/server-name 중 하나는 필수이며, job과 server는 동시에 사용할 수 없습니다.

</details>

---
