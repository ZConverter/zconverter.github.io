---
layout: docs
title: ZDM Documentation
section_title: ZDM Documentation
navigation: ko-zdm
lang: ko
---

<style>
.service-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
  margin: 1.5rem 0;
}
@media (max-width: 780px) {
  .service-grid {
    grid-template-columns: 1fr;
  }
}
.service-card {
  border: 1px solid #e1e4e8;
  border-radius: 8px;
  padding: 1.5rem;
  background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
}
.service-card.cli { border-top: 4px solid #2c3e50; }
.service-card.api { border-top: 4px solid #3498db; }
.service-card h3 { margin-top: 0; }
.service-card table { margin-top: 1rem; }
.service-card td, .service-card th { padding: 0.5rem 0.75rem; white-space: nowrap; }
.service-card td:first-child { font-weight: bold; color: #2c3e50; }
.service-card .sub-desc { color: #7f8c8d; font-size: 0.9rem; }
.service-card .link-group a { margin-right: 0.5rem; }
</style>

## ZDM 소개

ZDM은 백업, 복구, 시스템 관리를 위한 통합 솔루션입니다.

---

## 제공 서비스

<div class="service-grid">

{% assign cli_latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first %}
{% assign api_latest = site.data.zdm.common.versions.api | where: "status", "latest" | first %}

<div class="service-card cli">
<h3>ZDM-CLI</h3>
<p>백업, 복구, 시스템 관리를 위한 <strong>CLI 툴</strong></p>
<table>
<tr><td>현재 버전</td><td><code>{{ cli_latest.version }}</code></td></tr>
<tr><td>문서</td><td><a href="/zdm/ko/cli/{{ cli_latest.docs | default: cli_latest.version }}/index">바로가기</a></td></tr>
<tr><td>다운로드</td><td>{% if cli_latest.downloads.size > 0 %}{% for dl in cli_latest.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %} · {% endif %}<a href="/zdm/ko/downloads">전체 버전</a></td></tr>
<tr><td>호환성</td><td><a href="/zdm/ko/compatibility">OS 호환성 정보</a></td></tr>
<tr><td>업데이트</td><td>{{ site.time | date: "%Y-%m-%d" }}</td></tr>
</table>
</div>

<div class="service-card api">
<h3>ZDM-API</h3>
<p>백업, 복구, 시스템 관리를 위한 <strong>API 서버</strong><br><span class="sub-desc">Linux 전용 · Ubuntu 22.04 이상 권장</span></p>
<table>
<tr><td>현재 버전</td><td><code>{{ api_latest.version }}</code></td></tr>
<tr><td>문서</td><td><a href="/zdm/ko/api/{{ api_latest.docs | default: api_latest.version }}/index">바로가기</a></td></tr>
<tr><td>다운로드</td><td>{% if api_latest.downloads.size > 0 %}{% for dl in api_latest.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %} · {% endif %}<a href="/zdm/ko/downloads">전체 버전</a></td></tr>
<tr><td>업데이트</td><td>{{ site.time | date: "%Y-%m-%d" }}</td></tr>
</table>
</div>

</div>

---

## 업데이트 목록

### ZDM-API

<details markdown="1">
<summary><strong>v1.3.0</strong> <span style="color: #7f8c8d; font-size: 0.85rem;">(2026-04-08)</span></summary>

{% include zdm/ko/api/changelog/1.3.0.md %}

[v1.3.0 문서 바로가기](/zdm/ko/api/1.3.0/index)

</details>

<details markdown="1">
<summary><strong>v1.2.0</strong> <span style="color: #7f8c8d; font-size: 0.85rem;">(2026-03-25)</span></summary>

{% include zdm/ko/api/changelog/1.2.0.md %}

[v1.2.0 문서 바로가기](/zdm/ko/api/1.2.0/index)

</details>

<details markdown="1">
<summary><strong>v1.1.0</strong> <span style="color: #7f8c8d; font-size: 0.85rem;">(2026-03-04)</span></summary>

{% include zdm/ko/api/changelog/1.1.0.md %}

[v1.1.0 문서 바로가기](/zdm/ko/api/1.1.0/index)

</details>

<details markdown="1">
<summary><strong>v1.0.3</strong></summary>

{% include zdm/ko/api/changelog/1.0.3.md %}

[v1.0.3 문서 바로가기](/zdm/ko/api/1.0.3/index)

</details>

### ZDM-CLI

<details markdown="1">
<summary><strong>v1.2.0</strong> <span style="color: #7f8c8d; font-size: 0.85rem;">(2026-04-09)</span></summary>

{% include zdm/ko/cli/changelog/1.2.0.md %}

[v1.2.0 문서 바로가기](/zdm/ko/cli/1.2.0/index)

</details>

<details markdown="1">
<summary><strong>v1.0.4</strong> <span style="color: #7f8c8d; font-size: 0.85rem;">(2026-03-04)</span></summary>

{% include zdm/ko/cli/changelog/1.0.4.md %}

[v1.0.4 문서 바로가기](/zdm/ko/cli/1.0.4/index)

</details>

<details markdown="1">
<summary><strong>v1.0.3</strong></summary>

{% include zdm/ko/cli/changelog/1.0.3.md %}

[v1.0.3 문서 바로가기](/zdm/ko/cli/1.0.3/index)

</details>
