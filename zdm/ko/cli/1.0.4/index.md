---
layout: docs
title: ZDM CLI Documentation v1.0.4
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.4
lang: ko
---

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [ZDM CLI v1.0.4 소개](#zdm-cli-v104-소개)
- [v1.0.3 대비 변경 사항](#v103-대비-변경-사항)

</details>

---

## ZDM CLI v1.0.4 소개

ZDM CLI v1.0.4는 백업/복구 히스토리 조회 기능이 추가된 버전입니다.

> v1.0.3의 모든 기능을 포함하며, 아래 신규 서브커맨드가 추가되었습니다.

---

## v1.0.3 대비 변경 사항

<details markdown="1" open>
<summary><strong>신규 서브커맨드</strong></summary>

- **backup history** — 백업 실행 히스토리 조회
  - 필터 옵션: `--job-id`, `--job-name`, `--server`, `--partition`, `--result`, `--asc`
- **recovery history** — 복구 실행 히스토리 조회
  - 필터 옵션: `--job-id`, `--job-name`, `--server`, `--server-type`, `--partition`, `--result`, `--asc`

</details>

<details markdown="1" open>
<summary><strong>기존 커맨드</strong></summary>

위 신규 서브커맨드를 제외한 나머지 커맨드(Backup, Recovery, Server, Schedule, Token, Config, File, License, ZDM)는 [v1.0.3 문서](/zdm/ko/cli/1.0.3/index)와 동일합니다.

</details>

---
