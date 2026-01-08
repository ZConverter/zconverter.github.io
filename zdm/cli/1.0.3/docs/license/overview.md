---
layout: docs
title: License 개요
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

라이센스 관리 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [라이센스 타입](#라이센스-타입)
- [라이센스 정보 구조](#라이센스-정보-구조)

</details>

---

## 라이센스 타입

<details markdown="1" open>
<summary><strong>라이센스 타입 설명</strong></summary>

| 타입 | 설명 | 용도 |
|------|------|------|
| `zdm(backup)` | 백업 라이센스 | 서버 백업 작업용 |
| `zdm(dr)` | DR 라이센스 | 재해 복구 작업용 |
| `zdm(migration)` | 마이그레이션 라이센스 | 서버 마이그레이션 작업용 |

</details>

---

## 라이센스 정보 구조

<details markdown="1" open>
<summary><strong>라이센스 데이터 필드</strong></summary>

| 필드 | 설명 |
|------|------|
| `name` | 라이센스 이름 |
| `key` | 라이센스 키 (XXXX-XXXX-XXXX-XXXX 형식) |
| `category` | 라이센스 타입 |
| `description` | 라이센스 설명 |
| `copies.total` | 총 라이센스 수량 |
| `copies.used` | 사용 중인 수량 |
| `copies.available` | 사용 가능한 수량 |
| `copies.usage` | 사용률 (%) |
| `dates.created` | 생성 날짜 |
| `dates.expires` | 만료 날짜 |
| `dates.daysRemaining` | 남은 일수 |

</details>

---
