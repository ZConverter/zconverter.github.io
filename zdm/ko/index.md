---
layout: docs
title: ZDM Documentation
section_title: ZDM Documentation
navigation: ko-zdm
lang: ko
---

## ZDM 소개

ZDM은 백업, 복구, 시스템 관리를 위한 통합 솔루션입니다.

---

## 제공 서비스

<div class="service-grid">

{% assign cli_latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first %}
{% assign api_latest = site.data.zdm.common.versions.api | where: "status", "latest" | first %}

{% assign cli_auto_docs = site.data.zdm.common.doc_mtimes.cli[cli_latest.version] %}
{% assign cli_docs_date = cli_auto_docs | default: cli_latest.docs_updated %}
{% assign api_auto_docs = site.data.zdm.common.doc_mtimes.api[api_latest.version] %}
{% assign api_docs_date = api_auto_docs | default: api_latest.docs_updated %}

<div class="service-card cli">
<h3>ZDM-CLI</h3>
<p>백업, 복구, 시스템 관리를 위한 <strong>CLI 툴</strong></p>
<table>
<tr><td>현재 버전</td><td><code>{{ cli_latest.version }}</code></td></tr>
<tr><td>문서</td><td><a href="/zdm/ko/cli/{{ cli_latest.version }}/index">바로가기</a></td></tr>
<tr><td>다운로드</td><td>{% if cli_latest.downloads.size > 0 %}{% for dl in cli_latest.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %} · {% endif %}<a href="/zdm/ko/downloads">전체 버전</a></td></tr>
<tr><td>호환성</td><td><a href="/zdm/ko/compatibility">OS 호환성 정보</a></td></tr>
{%- if cli_latest.downloads.size > 0 -%}
  {%- for dl in cli_latest.downloads -%}
    {%- assign sf = site.static_files | where: "path", dl.file | first -%}
    {%- if sf -%}
<tr><td>프로그램 ({{ dl.os }})</td><td>{{ sf.modified_time | date: "%Y-%m-%d" }}</td></tr>
    {%- endif -%}
  {%- endfor -%}
{%- elsif cli_latest.released -%}
<tr><td>프로그램 업데이트</td><td>{{ cli_latest.released }}</td></tr>
{%- else -%}
<tr><td>프로그램 업데이트</td><td>-</td></tr>
{%- endif %}
<tr><td>문서 업데이트</td><td>{{ cli_docs_date | default: "-" }}</td></tr>
</table>
</div>

<div class="service-card api">
<h3>ZDM-API</h3>
<p>백업, 복구, 시스템 관리를 위한 <strong>API 서버</strong><br><span class="sub-desc">Linux 전용 · Ubuntu 22.04 이상 권장</span></p>
<table>
<tr><td>현재 버전</td><td><code>{{ api_latest.version }}</code></td></tr>
<tr><td>문서</td><td><a href="/zdm/ko/api/{{ api_latest.version }}/index">바로가기</a></td></tr>
<tr><td>다운로드</td><td>{% if api_latest.downloads.size > 0 %}{% for dl in api_latest.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %} · {% endif %}<a href="/zdm/ko/downloads">전체 버전</a></td></tr>
{%- if api_latest.downloads.size > 0 -%}
  {%- for dl in api_latest.downloads -%}
    {%- assign sf = site.static_files | where: "path", dl.file | first -%}
    {%- if sf -%}
<tr><td>프로그램 ({{ dl.os }})</td><td>{{ sf.modified_time | date: "%Y-%m-%d" }}</td></tr>
    {%- endif -%}
  {%- endfor -%}
{%- elsif api_latest.released -%}
<tr><td>프로그램 업데이트</td><td>{{ api_latest.released }}</td></tr>
{%- else -%}
<tr><td>프로그램 업데이트</td><td>-</td></tr>
{%- endif %}
<tr><td>문서 업데이트</td><td>{{ api_docs_date | default: "-" }}</td></tr>
</table>
</div>

</div>

---

## 더 보기

<div class="service-grid">

<a class="feature-card" href="/zdm/ko/downloads">
<h3>다운로드</h3>
<p>버전별 바이너리와 배포일을 확인합니다.</p>
</a>

<a class="feature-card" href="/zdm/ko/changelog">
<h3>변경 사항</h3>
<p>ZDM-API · ZDM-CLI 의 버전별 변경 이력과 BREAKING 항목을 확인합니다.</p>
</a>

</div>
