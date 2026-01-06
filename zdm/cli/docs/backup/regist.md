---
layout: docs
title: backup regist
section_title: ZDM CLI Documentation
navigation: cli
---

새로운 백업 작업을 등록합니다.

---

## `backup regist` {#backup-regist}

> * 새로운 백업 작업을 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup regist --server &lt;server&gt; --mode &lt;mode&gt; [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 기본 백업 작업 등록
zdm-cli backup regist --server web-server-01 --mode full

# 특정 파티션만 백업
zdm-cli backup regist --server web-server-01 --mode full --partition /,/home

# 암호화 백업 등록
zdm-cli backup regist --server web-server-01 --mode full --encryption

# 압축 없이 백업
zdm-cli backup regist --server web-server-01 --mode full --no-compression

# 스케줄과 함께 등록
zdm-cli backup regist --server web-server-01 --mode full --schedule daily-schedule --start

# 스크립트와 함께 등록
zdm-cli backup regist --server web-server-01 --mode full --scriptPath /scripts/pre-backup.sh --scriptRun before

# Repository 지정
zdm-cli backup regist --server web-server-01 --mode full --repository-id 1

# 작업 이름 및 설명 추가
zdm-cli backup regist --server web-server-01 --mode full --jobName daily-backup --description "Daily backup job"

# 모든 옵션 포함
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --jobName "production-backup" \
  --description "Production server full backup" \
  --partition /,/home,/var \
  --encryption \
  --rotation 5 \
  --networkLimit 1000 \
  --repository-id 1 \
  --schedule daily-schedule \
  --start
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--center` | - | string | Optional | - | 작업 등록 Center (config 기본값 사용) | - |
| `--server` | - | string | Required | - | 작업 대상 Server | - |
| `--mode` | - | string | Required | - | 작업 모드 | `full`, `increment`, `smart` |
| `--repository-id` | `ri` | number | Optional | - | Repository ID (config 기본값 사용) | - |
| `--repository-path` | `rp` | string | Optional | - | Repository Path | - |
| `--partition` | - | string | Optional | - | 작업 대상 파티션 (쉼표로 구분) | - |
| `--jobName` | `name` | string | Optional | - | 작업 이름 | - |
| `--schedule` | `sc` | string | Optional | - | 작업에 사용할 Schedule | - |
| `--description` | `desc` | string | Optional | - | 작업 설명 | - |
| `--rotation` | `rot` | number | Optional | 1 | 작업 반복횟수 | - |
| `--no-compression` | `ncomp` | boolean | Optional | - | 작업 압축 안함 | - |
| `--encryption` | `enc` | boolean | Optional | - | 작업 암호화 | - |
| `--excludeDir` | `exd` | string | Optional | - | 작업 제외 폴더 | - |
| `--excludePartition` | `exp` | string | Optional | - | 작업 제외 partition | - |
| `--networkLimit` | `nl` | number | Optional | 0 | 작업 Network 제한 속도 | - |
| `--start` | - | boolean | Optional | - | 작업 자동시작 여부 | - |
| `--scriptPath` | `sp` | string | Optional | - | 작업시 사용할 script full path | - |
| `--scriptRun` | `sr` | string | Optional | - | 스크립트 실행 타이밍 | `before`, `after` |
| `--individual` | `ind` | string | Optional | - | 파티션별 개별 설정 (JSON 문자열) | - |

</details>

---

## 백업 옵션

<details markdown="1" open>
<summary><strong>압축 옵션</strong></summary>

```bash
# 압축 활성화 (기본값)
zdm-cli backup regist --server web-server-01 --mode full

# 압축 비활성화
zdm-cli backup regist --server web-server-01 --mode full --no-compression
```

</details>

<details markdown="1" open>
<summary><strong>암호화 옵션</strong></summary>

```bash
# 암호화 백업
zdm-cli backup regist --server web-server-01 --mode full --encryption
```

</details>

<details markdown="1" open>
<summary><strong>파티션 선택</strong></summary>

```bash
# 특정 파티션만 백업
zdm-cli backup regist --server web-server-01 --mode full --partition /,/home

# 특정 파티션 제외
zdm-cli backup regist --server web-server-01 --mode full --excludePartition /tmp,/var/tmp

# 특정 디렉토리 제외
zdm-cli backup regist --server web-server-01 --mode full --excludeDir /home/user/temp,/var/cache
```

</details>

<details markdown="1" open>
<summary><strong>네트워크 제한</strong></summary>

```bash
# 네트워크 속도 제한 (KB/s)
zdm-cli backup regist --server web-server-01 --mode full --networkLimit 1000

# 제한 없음 (기본값)
zdm-cli backup regist --server web-server-01 --mode full --networkLimit 0
```

</details>

<details markdown="1" open>
<summary><strong>Rotation (반복횟수)</strong></summary>

```bash
# Rotation 설정
zdm-cli backup regist --server web-server-01 --mode full --rotation 5
```

</details>

---

## 스케줄 백업

<details markdown="1" open>
<summary><strong>스케줄과 함께 등록</strong></summary>

```bash
# 스케줄 백업 등록
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --schedule daily-schedule \
  --start
```

스케줄 생성 방법은 [schedule create](/zdm/cli/docs/schedule/create) 참조

</details>

---

## 스크립트 실행

<details markdown="1" open>
<summary><strong>백업 전후 스크립트</strong></summary>

```bash
# 백업 전 스크립트 실행
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --scriptPath /scripts/pre-backup.sh \
  --scriptRun before

# 백업 후 스크립트 실행
zdm-cli backup regist \
  --server web-server-01 \
  --mode full \
  --scriptPath /scripts/post-backup.sh \
  --scriptRun after
```

**주의사항:**
- 스크립트는 서버에 미리 업로드되어 있어야 함
- 절대 경로 사용
- 실행 권한 확인

</details>

---
