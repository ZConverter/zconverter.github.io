---
layout: docs
title: ZDM API Documentation v1.1.0
section_title: ZDM API Documentation
navigation: ko-api-1.1.0
lang: ko
---

{% capture changelog %}
<details markdown="1" open>
<summary><strong>신규 엔드포인트</strong></summary>

- **GET /backups/histories** — 백업 히스토리 목록 조회
- **GET /backups/histories/:identifier** — 백업 히스토리 단건 조회
- **GET /recoveries/histories** — 복구 히스토리 목록 조회
- **GET /recoveries/histories/:identifier** — 복구 히스토리 단건 조회

</details>

<details markdown="1" open>
<summary><strong>DB 스키마 변경</strong></summary>

> v1.0.3 대비 DB 스키마 일부 변경이 있으므로, 해당 버전의 DB 환경에서 사용하세요.

</details>
{% endcapture %}

{% include zdm/ko/api/index.md version="1.1.0" changelog=changelog changelog_title="변경 사항" %}
