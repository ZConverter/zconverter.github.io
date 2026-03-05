---
layout: docs
title: 다운로드
section_title: ZDM Documentation
navigation: ko-zdm
lang: ko
---

<style>
.download-section {
  margin: 1.5rem 0;
}
.download-section h3 {
  border-bottom: 2px solid #e1e4e8;
  padding-bottom: 0.5rem;
}
.download-table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}
.download-table th,
.download-table td {
  padding: 0.6rem 1rem;
  border: 1px solid #e1e4e8;
  text-align: left;
}
.download-table th {
  background: #f6f8fa;
}
.badge {
  display: inline-block;
  padding: 0.15rem 0.5rem;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
  margin-left: 0.4rem;
}
.badge-latest { background: #dafbe1; color: #1a7f37; }
.badge-stable { background: #ddf4ff; color: #0969da; }
.no-download { color: #8b949e; font-style: italic; }
</style>

## 다운로드

버전별 다운로드 파일 목록입니다. 바이너리가 준비되지 않은 버전은 다운로드 링크가 표시되지 않습니다.

---

<details markdown="1" open>
<summary><strong>ZDM-CLI</strong></summary>

<table class="download-table">
<thead>
<tr><th>버전</th><th>상태</th><th>다운로드</th><th>문서</th></tr>
</thead>
<tbody>
{% for v in site.data.zdm.common.versions.cli %}
<tr>
<td><strong>v{{ v.version }}</strong></td>
<td>{% if v.status == "latest" %}<span class="badge badge-latest">latest</span>{% elsif v.status == "stable" %}<span class="badge badge-stable">stable</span>{% else %}{{ v.status }}{% endif %}</td>
<td>{% if v.downloads.size > 0 %}{% for dl in v.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}{% else %}<span class="no-download">준비 중</span>{% endif %}</td>
<td><a href="/zdm/ko/cli/{{ v.version }}/index">v{{ v.version }} 문서</a></td>
</tr>
{% endfor %}
</tbody>
</table>

</details>

<details markdown="1" open>
<summary><strong>ZDM-API</strong></summary>

<table class="download-table">
<thead>
<tr><th>버전</th><th>상태</th><th>다운로드</th><th>문서</th></tr>
</thead>
<tbody>
{% for v in site.data.zdm.common.versions.api %}
<tr>
<td><strong>v{{ v.version }}</strong></td>
<td>{% if v.status == "latest" %}<span class="badge badge-latest">latest</span>{% elsif v.status == "stable" %}<span class="badge badge-stable">stable</span>{% else %}{{ v.status }}{% endif %}</td>
<td>{% if v.downloads.size > 0 %}{% for dl in v.downloads %}<a href="{{ dl.file }}">{{ dl.os }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}{% else %}<span class="no-download">준비 중</span>{% endif %}</td>
<td><a href="/zdm/ko/api/{{ v.version }}/index">v{{ v.version }} 문서</a></td>
</tr>
{% endfor %}
</tbody>
</table>

</details>
