---
layout: docs
title: recovery monit
section_title: ZDM CLI Documentation
navigation: cli
---

복구 작업 진행 상황을 모니터링합니다.

---

## `recovery monit` {#recovery-monit}

> * 복구 작업 진행 상황을 모니터링합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery monit --job-id &lt;id&gt; | --job-name &lt;name&gt; | --server-id &lt;id&gt; | --server-name &lt;name&gt; [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 ID로 모니터링
zdm-cli recovery monit --job-id 123

# 작업 이름으로 상세 모니터링
zdm-cli recovery monit --job-name "disaster-recovery" --detail

# 서버 ID로 모니터링
zdm-cli recovery monit --server-id 456

# 서버 이름으로 상태 필터링 모니터링
zdm-cli recovery monit --server-name "RecoveryServer" --mode full

# 작업 ID와 파티션으로 필터링 모니터링
zdm-cli recovery monit --job-id 789 --partition /

# 서버와 드라이브로 모니터링 (Windows)
zdm-cli recovery monit --server-name "WinServer" --drive C
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
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment` |
| `--partition` | - | string | Optional | - | 파티션 (Linux) | - |
| `--drive` | - | string | Optional | - | 드라이브 (Windows) | - |
| `--server-type` | `st` | string | Optional | - | 서버 타입 | `source`, `target` |
| `--detail` | - | boolean | Optional | - | 상세 정보 조회 | - |

> <span class="required-note">*</span> job-id/job-name 또는 server-id/server-name 중 하나는 필수이며, job과 server는 동시에 사용할 수 없습니다.

</details>

---
