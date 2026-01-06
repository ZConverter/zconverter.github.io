---
layout: docs
title: Backup 개요
section_title: ZDM CLI Documentation
navigation: cli
---

백업 기능에 대한 개요입니다.

---

## 백업 모드

<details markdown="1" open>
<summary><strong>백업 모드 설명</strong></summary>

| 모드 | 설명 |
|------|------|
| `full` | 전체 백업 |
| `increment` | 증분 백업 (변경된 데이터만) |
| `smart` | 스마트 백업 (스케줄에 따라 전체/증분 복합) |

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

## Repository 타입

<details markdown="1" open>
<summary><strong>저장소 타입</strong></summary>

| 타입 | 설명 |
|------|------|
| `nfs` | NFS 네트워크 저장소 |
| `smb` | SMB/CIFS 네트워크 저장소 |

</details>

---
