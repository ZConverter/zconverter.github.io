---
layout: docs
title: ZDM API Documentation v1.2.0
section_title: ZDM API Documentation
navigation: ko-api-1.2.0
lang: ko
---

{% capture changelog %}
<details markdown="1" open>
<summary><strong>신규 엔드포인트</strong></summary>

- **GET /replications** — 복제 작업 목록 조회
- **GET /replications/:identifier** — 복제 작업 단건 조회
- **POST /replications** — 복제 작업 등록
- **PUT /replications/:identifier** — 복제 작업 수정
- **DELETE /replications/:identifier** — 복제 작업 삭제
- **GET /replications/histories** — 복제 히스토리 목록 조회
- **GET /replications/histories/:identifier** — 복제 히스토리 단건 조회
- **GET /replications/monitoring/job/:identifier** — 복제 작업 모니터링

</details>

<details markdown="1" open>
<summary><strong>복제 단위 유형</strong></summary>

> Replication API는 3가지 복제 단위 유형을 지원합니다.
> - **backup** — 백업 작업 기반 복제
> - **repository** — 레포지토리 기반 복제
> - **server** — 서버 기반 복제

</details>
{% endcapture %}

{% include zdm/ko/api/index.md version="1.2.0" changelog=changelog changelog_title="변경 사항" %}
