---
layout: docs
title: backup update
section_title: ZDM CLI Documentation
navigation: cli
---

백업 작업 정보를 수정합니다.

---

## `backup update` {#backup-update}

> * 백업 작업 정보를 수정합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup update --id &lt;id&gt; | --name &lt;name&gt; [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 작업 이름 변경
zdm-cli backup update --id 1 --changeName new-backup-name

# 작업 모드 변경
zdm-cli backup update --name daily-backup --mode increment

# 압축 및 암호화 활성화
zdm-cli backup update --id 1 --compression --encryption

# 반복횟수 및 네트워크 제한 설정
zdm-cli backup update --name daily-backup --rotation 5 --networkLimit 1000

# 스케줄 변경
zdm-cli backup update --id 1 --schedule weekly-schedule

# Repository 변경
zdm-cli backup update --id 1 --repository-id 2

# 스크립트 설정
zdm-cli backup update --id 1 --scriptPath /scripts/backup.sh --scriptRun before

# 여러 옵션 동시 변경
zdm-cli backup update \
  --id 1 \
  --mode increment \
  --compression \
  --rotation 10 \
  --networkLimit 500
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--id` | - | number | Optional<span class="required-note">*</span> | - | 작업 ID | - |
| `--name` | - | string | Optional<span class="required-note">*</span> | - | 작업 Name | - |
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | - | string | Optional | - | 작업 상태 | - |
| `--repository-id` | `ri` | number | Optional | - | Repository ID | - |
| `--repository-path` | `rp` | string | Optional | - | Repository Path | - |
| `--changeName` | `chn` | string | Optional | - | 변경할 작업 이름 | - |
| `--schedule` | `sc` | string | Optional | - | 작업에 사용할 Schedule | - |
| `--description` | `desc` | string | Optional | - | 작업 설명 | - |
| `--rotation` | `rot` | number | Optional | 1 | 작업 반복횟수 | - |
| `--compression` | `comp` | boolean | Optional | - | 작업 압축 | - |
| `--encryption` | `enc` | boolean | Optional | - | 작업 암호화 | - |
| `--excludeDir` | `exd` | string | Optional | - | 작업 제외 폴더 | - |
| `--scriptPath` | `sp` | string | Optional | - | 작업시 사용할 script full path | - |
| `--scriptRun` | `sr` | string | Optional | - | 스크립트 실행 타이밍 | `before`, `after` |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | - |

> <span class="required-note">*</span> 둘 중 하나는 필수이며, 동시에 사용할 수 없습니다.

</details>

---

## 스케줄 관리

<details markdown="1" open>
<summary><strong>스케줄 변경</strong></summary>

```bash
# 기존 작업에 스케줄 추가
zdm-cli backup update --id 1 --schedule daily-schedule

# 스케줄 제거
zdm-cli backup update --id 1 --schedule ""
```

</details>

---

## 스크립트 관리

<details markdown="1" open>
<summary><strong>스크립트 설정</strong></summary>

```bash
# 기존 작업 스크립트 추가
zdm-cli backup update --id 1 --scriptPath /scripts/backup.sh --scriptRun before
```

</details>

---
