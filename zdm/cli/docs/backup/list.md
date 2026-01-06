---
layout: docs
title: backup list
section_title: ZDM CLI Documentation
navigation: cli
---

백업 작업 목록을 조회합니다.

---

## `backup list` {#backup-list}

> * 백업 작업 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 백업 작업 목록 조회
zdm-cli backup list

# 특정 백업 작업 조회 (ID)
zdm-cli backup list --id 1

# 특정 백업 작업 조회 (이름)
zdm-cli backup list --name daily-backup

# 특정 서버의 백업 작업 조회
zdm-cli backup list --server web-server-01

# 작업 모드로 필터링
zdm-cli backup list --mode full

# 작업 상태로 필터링
zdm-cli backup list --status complete

# Repository 경로로 필터링
zdm-cli backup list --repository-path /backup/repo01

# 상세 정보 조회
zdm-cli backup list --detail --output table

# 여러 필터 조합
zdm-cli backup list --server web-server-01 --mode full --status complete
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--server` | - | string | Optional | - | 작업 대상 Server | - |
| `--name` | - | string | Optional | - | 작업 이름 | - |
| `--id` | - | number | Optional | - | 작업 ID | - |
| `--mode` | - | string | Optional | - | 작업 모드 | `full`, `increment`, `smart` |
| `--status` | - | string | Optional | - | 작업 상태 | `run`, `complete`, `start`, `waiting`, `cancel`, `schedule` |
| `--repository-path` | `rp` | string | Optional | - | 작업에 사용한 repository path | - |
| `--repository-type` | `rt` | string | Optional | - | 작업에 사용한 repository type | `smb`, `nfs` |
| `--detail` | - | boolean | Optional | - | 상세 정보 조회 | - |

</details>

---

## 백업 모드

<details markdown="1" open>
<summary><strong>백업 모드 설명</strong></summary>

| 모드 | 설명 | 동작 방식 |
|------|------|--------------|
| `full` | 전체 백업 | 전체 백업 |
| `increment` | 증분 백업 | 변경된 데이터만 백업 |
| `smart` | 스마트 백업 | 스케쥴에 따라 전체와 증분 백업 복합적으로 진행 |

</details>

---

## 백업 상태

<details markdown="1" open>
<summary><strong>작업 상태 값</strong></summary>

| 상태 | 설명 |
|------|------|
| `waiting` | 대기 중 |
| `start` | 시작됨 |
| `run` | 실행 중 |
| `complete` | 완료 |
| `cancel` | 취소됨 |
| `schedule` | 예약됨 |

</details>

---
