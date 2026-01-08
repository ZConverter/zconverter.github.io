---
layout: docs
title: ZDM Documentation
section_title: ZDM Documentation
navigation: zdm
---

## ZDM 소개

ZDM은 백업, 복구, 시스템 관리를 위한 통합 솔루션입니다.

---

## 제공 서비스

### ZDM-CLI

백업, 복구, 시스템 관리를 위한 CLI 툴

<summary><strong>문서 및 버전 정보</strong></summary>

| 항목 | 내용 |
|------|------|
| 문서 | [ZDM-CLI 문서 바로가기](/zdm/cli/1.0.3/index) |
| 다운로드 | [Windows](/downloads/zdm-cli/1.0.3/zdm-cli-windows.zip) · [Linux](/downloads/zdm-cli/1.0.3/zdm-cli-linux.tar.gz) |
| 현재 버전 | 1.0.3 |
| 최종 업데이트 | {{ site.time | date: "%Y-%m-%d" }} |

<details markdown="1">
<summary><strong>버전별 문서</strong></summary>

| 버전 | 상태 | 문서 | 다운로드 |
|------|------|------|----------|
{% for ver in site.data.zdm.common.versions.cli -%}
| {{ ver.version }} | {{ ver.status }} | [바로가기](/zdm/cli/{{ ver.version }}/index) | [Windows](/downloads/zdm-cli/{{ ver.version }}/zdm-cli-windows.zip) · [Linux](/downloads/zdm-cli/{{ ver.version }}/zdm-cli-linux.tar.gz) |
{% endfor %}

</details>

---

### ZDM-API

백업, 복구, 시스템 관리를 위한 API 서버 .<br>
API 서버는 Linux만 지원합니다.<br>
Ubuntu 22.04 이상 권장

<summary><strong>문서 및 버전 정보</strong></summary>

| 항목 | 내용 |
|------|------|
| 문서 | [ZDM-API 문서 바로가기](/zdm/api/1.0.3/index) |
| 다운로드 | [Linux](/downloads/zdm-api/1.0.3/zdm-api-linux.tar.gz) |
| 현재 버전 | 1.0.3 |
| 최종 업데이트 | {{ site.time | date: "%Y-%m-%d" }} |

<details markdown="1">
<summary><strong>버전별 문서</strong></summary>

| 버전 | 상태 | 문서 | 다운로드 |
|------|------|------|----------|
{% for ver in site.data.zdm.common.versions.api -%}
| {{ ver.version }} | {{ ver.status }} | [바로가기](/zdm/api/{{ ver.version }}/index) | [Linux](/downloads/zdm-api/{{ ver.version }}/zdm-api-linux.tar.gz) |
{% endfor %}

</details>