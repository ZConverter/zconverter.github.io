---
layout: docs
title: 다운로드
section_title: ZDM Documentation
navigation: ko-zdm
lang: ko
---

## 다운로드

버전별 다운로드 파일 목록입니다. 바이너리가 준비되지 않은 버전은 다운로드 링크가 표시되지 않습니다.

---

<details markdown="1" open>
<summary><strong>ZDM-CLI</strong></summary>

<table class="download-table">
<thead>
<tr><th>버전</th><th>상태</th><th>다운로드</th><th>배포일</th><th>문서</th><th>문서 갱신일</th></tr>
</thead>
<tbody>
{% for v in site.data.zdm.common.versions.cli %}
{% assign auto_docs = site.data.zdm.common.doc_mtimes.cli[v.version] %}
{% assign docs_date = auto_docs | default: v.docs_updated %}
<tr>
<td><strong>v{{ v.version }}</strong></td>
<td>{% if v.status == "latest" %}<span class="badge badge-latest">latest</span>{% elsif v.status == "stable" %}<span class="badge badge-stable">stable</span>{% else %}{{ v.status }}{% endif %}</td>
<td>{% if v.downloads.size > 0 %}{% for dl in v.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}{% else %}<span class="no-download">준비 중</span>{% endif %}</td>
<td>
{%- if v.downloads.size > 0 -%}
  {%- for dl in v.downloads -%}
    {%- assign sf = site.static_files | where: "path", dl.file | first -%}
    {%- if sf -%}<div>{{ dl.os }} · <span class="date-cell">{{ sf.modified_time | date: "%Y-%m-%d" }}</span></div>{%- endif -%}
  {%- endfor -%}
{%- elsif v.released -%}<span class="date-cell">{{ v.released }}</span>
{%- else -%}<span class="no-download">-</span>
{%- endif -%}
</td>
<td><a href="/zdm/ko/cli/{{ v.version }}/index">v{{ v.version }} 문서</a></td>
<td>{% if docs_date %}<span class="date-cell">{{ docs_date }}</span>{% else %}<span class="no-download">-</span>{% endif %}</td>
</tr>
{% endfor %}
</tbody>
</table>

</details>

<details markdown="1" open>
<summary><strong>ZDM-API</strong></summary>

<table class="download-table">
<thead>
<tr><th>버전</th><th>상태</th><th>다운로드</th><th>배포일</th><th>문서</th><th>문서 갱신일</th></tr>
</thead>
<tbody>
{% for v in site.data.zdm.common.versions.api %}
{% assign auto_docs = site.data.zdm.common.doc_mtimes.api[v.version] %}
{% assign docs_date = auto_docs | default: v.docs_updated %}
<tr>
<td><strong>v{{ v.version }}</strong></td>
<td>{% if v.status == "latest" %}<span class="badge badge-latest">latest</span>{% elsif v.status == "stable" %}<span class="badge badge-stable">stable</span>{% else %}{{ v.status }}{% endif %}</td>
<td>{% if v.downloads.size > 0 %}{% for dl in v.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}{% else %}<span class="no-download">준비 중</span>{% endif %}</td>
<td>
{%- if v.downloads.size > 0 -%}
  {%- for dl in v.downloads -%}
    {%- assign sf = site.static_files | where: "path", dl.file | first -%}
    {%- if sf -%}<div>{{ dl.os }} · <span class="date-cell">{{ sf.modified_time | date: "%Y-%m-%d" }}</span></div>{%- endif -%}
  {%- endfor -%}
{%- elsif v.released -%}<span class="date-cell">{{ v.released }}</span>
{%- else -%}<span class="no-download">-</span>
{%- endif -%}
</td>
<td><a href="/zdm/ko/api/{{ v.version }}/index">v{{ v.version }} 문서</a></td>
<td>{% if docs_date %}<span class="date-cell">{{ docs_date }}</span>{% else %}<span class="no-download">-</span>{% endif %}</td>
</tr>
{% endfor %}
</tbody>
</table>

</details>
