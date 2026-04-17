
Replication 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [개요](#개요)
- [하위 커맨드](#하위-커맨드)
- [Replication Unit 타입](#replication-unit-타입)

</details>

---

## 개요

`replication` 커맨드 그룹은 Replication 작업의 등록, 조회, 수정, 삭제, 모니터링, 히스토리 조회 기능을 제공합니다.

v2.0.0에서는 3가지 unit-type(`backup`, `repository`, `server`)을 지원하며, 등록 시 `--source-center`/`--target-center` 파라미터를 사용하여 소스와 타겟 센터를 개별 지정합니다.

---

## 하위 커맨드

<details markdown="1" open>
<summary><strong>하위 커맨드 목록</strong></summary>

| 커맨드 | 설명 |
|--------|------|
| `replication regist` | 새로운 Replication 작업을 등록합니다 |
| `replication list` | Replication 작업 목록 및 상세 정보를 조회합니다 |
| `replication update` | Replication 작업의 설정을 수정합니다 |
| `replication delete` | Replication 작업을 삭제합니다 |
| `replication monit` | Replication 작업의 실시간 진행 상태를 모니터링합니다 |
| `replication history` | Replication 작업의 실행 이력을 조회합니다 |

</details>

---

## Replication Unit 타입

<details markdown="1" open>
<summary><strong>Unit 타입 설명</strong></summary>

| Unit 타입 | 설명 |
|-----------|------|
| `backup` | 백업 작업 기반 복제. `--job` 파라미터로 백업 작업 ID 또는 이름을 지정합니다. |
| `repository` | 저장소 기반 복제. `--source-repository-id` 파라미터로 소스 Repository ID를 지정합니다. |
| `server` | 서버 기반 복제. `--server` 파라미터로 서버 ID 또는 이름을 지정합니다. |

</details>

---
