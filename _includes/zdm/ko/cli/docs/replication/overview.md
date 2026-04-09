
Replication 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [Replication 모드](#replication-모드)
- [Replication Unit 타입](#replication-unit-타입)
- [버전별 차이](#버전별-차이)

</details>

---

## Replication 모드

<details markdown="1" open>
<summary><strong>Replication 모드 설명</strong></summary>

| 모드 | 버전 | 설명 |
|------|------|------|
| `full` | v1, v2 | 전체 복제 |
| `increment` | v1, v2 | 증분 복제 (변경된 데이터만) |
| `sync` | v2 | 동기화 복제 |

</details>

---

## Replication Unit 타입

<details markdown="1" open>
<summary><strong>Unit 타입 설명</strong></summary>

| Unit 타입 | 버전 | 설명 |
|-----------|------|------|
| `image` | v1 | 이미지 기반 복제 |
| `backup` | v2 | 백업 기반 복제 |
| `repository` | v1, v2 | 저장소 기반 복제 |
| `server` | v2 | 서버 기반 복제 |

</details>

---

## 버전별 차이

<details markdown="1" open>
<summary><strong>Replication v1 vs v2</strong></summary>

| 항목 | v1 | v2 |
|------|----|----|
| Unit 타입 | image, repository | backup, repository, server |
| 모드 | full, increment | full, increment, sync |
| 백업 지정 | backup-name, transfer-backup-name | backup-job-name |
| 서버 지정 | - | source-server-id, source-server-name |

> Replication 버전은 `zdm-cli-config.json`의 `replication.version` 설정에 따라 결정됩니다.

</details>

---
