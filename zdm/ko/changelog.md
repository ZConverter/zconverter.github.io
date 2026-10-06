---
layout: docs
title: 변경 사항
section_title: ZDM Documentation
navigation: ko-zdm
lang: ko
---

{% assign cli_latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first %}
{% assign api_latest = site.data.zdm.common.versions.api | where: "status", "latest" | first %}
{% assign cli_docs_date = site.data.zdm.common.doc_mtimes.cli[cli_latest.version] | default: cli_latest.docs_updated %}
{% assign api_docs_date = site.data.zdm.common.doc_mtimes.api[api_latest.version] | default: api_latest.docs_updated %}

ZDM-API 와 ZDM-CLI 의 버전별 변경 이력입니다. 두 제품은 같은 버전 번호로 함께 배포되므로 한 페이지에 둡니다.
특정 버전의 상세 문서는 각 행의 **문서 바로가기** 를 따라가세요.

<div class="breaking-note" markdown="1">
**BREAKING** 이 붙은 항목은 **이전 버전 기준으로 작성한 요청·스크립트가 수정 없이는 동작하지 않습니다.**
응답 필드의 이름·타입·형식이 바뀌거나, 요청 파라미터·옵션이 사라지거나, 같은 요청의 동작이 달라진 경우에 표시합니다.
해당 버전으로 올리기 전에 펼쳐서 항목을 확인하세요.

배지의 숫자는 그 버전의 BREAKING 항목 **개수**입니다.
</div>

## ZDM-API

<p class="product-meta"><span class="badge badge-latest">latest v{{ api_latest.version }}</span> <span class="update-date">{{ api_docs_date | default: "-" }}</span></p>

<div class="update-rows" markdown="1">

{% assign b_3_0_0 = site.data.zdm.common.changelog_stats.api["3.0.0"].breaking | default: 0 %}
{% assign brk_total = b_3_0_0 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v3.0.0</span><span class="ur-date">2026-08-28</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v3.0.0 문서 바로가기](/zdm/ko/api/3.0.0/index)

{% include zdm/ko/api/changelog/3.0.0.md %}

</details>

{% assign b_2_0_2 = site.data.zdm.common.changelog_stats.api["2.0.2"].breaking | default: 0 %}
{% assign brk_total = b_2_0_2 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v2.0.2</span><span class="ur-date">2026-06-01</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v2.0.2 문서 바로가기](/zdm/ko/api/2.0.2/index)

{% include zdm/ko/api/changelog/2.0.2.md %}

</details>

{% assign b_2_0_0 = site.data.zdm.common.changelog_stats.api["2.0.0"].breaking | default: 0 %}
{% assign b_2_0_1 = site.data.zdm.common.changelog_stats.api["2.0.1"].breaking | default: 0 %}
{% assign brk_total = b_2_0_0 | plus: b_2_0_1 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v2.0.0</span><span class="ur-date">2026-04-17</span><span class="ur-badges"><span class="badge badge-patch">patch v2.0.1</span>{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v2.0.0 문서 바로가기](/zdm/ko/api/2.0.0/index)

{% include zdm/ko/api/changelog/2.0.0.md %}

{% include zdm/ko/api/changelog/2.0.1.md %}

</details>

{% assign b_1_3_0 = site.data.zdm.common.changelog_stats.api["1.3.0"].breaking | default: 0 %}
{% assign b_1_3_1 = site.data.zdm.common.changelog_stats.api["1.3.1"].breaking | default: 0 %}
{% assign brk_total = b_1_3_0 | plus: b_1_3_1 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.3.0</span><span class="ur-date">2026-04-08</span><span class="ur-badges"><span class="badge badge-patch">patch v1.3.1</span>{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.3.0 문서 바로가기](/zdm/ko/api/1.3.0/index)

{% include zdm/ko/api/changelog/1.3.0.md %}

{% include zdm/ko/api/changelog/1.3.1.md %}

</details>

{% assign b_1_2_0 = site.data.zdm.common.changelog_stats.api["1.2.0"].breaking | default: 0 %}
{% assign brk_total = b_1_2_0 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.2.0</span><span class="ur-date">2026-03-25</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.2.0 문서 바로가기](/zdm/ko/api/1.2.0/index)

{% include zdm/ko/api/changelog/1.2.0.md %}

</details>

{% assign b_1_1_0 = site.data.zdm.common.changelog_stats.api["1.1.0"].breaking | default: 0 %}
{% assign brk_total = b_1_1_0 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.1.0</span><span class="ur-date">2026-03-04</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.1.0 문서 바로가기](/zdm/ko/api/1.1.0/index)

{% include zdm/ko/api/changelog/1.1.0.md %}

</details>

{% assign b_1_0_3 = site.data.zdm.common.changelog_stats.api["1.0.3"].breaking | default: 0 %}
{% assign brk_total = b_1_0_3 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.0.3</span><span class="ur-date"></span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.0.3 문서 바로가기](/zdm/ko/api/1.0.3/index)

{% include zdm/ko/api/changelog/1.0.3.md %}

</details>

</div>

## ZDM-CLI

<p class="product-meta"><span class="badge badge-latest">latest v{{ cli_latest.version }}</span> <span class="update-date">{{ cli_docs_date | default: "-" }}</span></p>

<div class="update-rows" markdown="1">

{% assign b_3_0_0 = site.data.zdm.common.changelog_stats.cli["3.0.0"].breaking | default: 0 %}
{% assign brk_total = b_3_0_0 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v3.0.0</span><span class="ur-date">2026-08-28</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v3.0.0 문서 바로가기](/zdm/ko/cli/3.0.0/index)

{% include zdm/ko/cli/changelog/3.0.0.md %}

</details>

{% assign b_2_0_0 = site.data.zdm.common.changelog_stats.cli["2.0.0"].breaking | default: 0 %}
{% assign b_2_0_1 = site.data.zdm.common.changelog_stats.cli["2.0.1"].breaking | default: 0 %}
{% assign b_2_0_2 = site.data.zdm.common.changelog_stats.cli["2.0.2"].breaking | default: 0 %}
{% assign brk_total = b_2_0_0 | plus: b_2_0_1 | plus: b_2_0_2 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v2.0.0</span><span class="ur-date">2026-04-17</span><span class="ur-badges"><span class="badge badge-patch">patch v2.0.1</span><span class="badge badge-patch">patch v2.0.2</span>{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v2.0.2 문서 바로가기](/zdm/ko/cli/2.0.2/index) · [v2.0.0 문서 바로가기](/zdm/ko/cli/2.0.0/index)

{% include zdm/ko/cli/changelog/2.0.2.md %}

{% include zdm/ko/cli/changelog/2.0.1.md %}

{% include zdm/ko/cli/changelog/2.0.0.md %}

</details>

{% assign b_1_3_0 = site.data.zdm.common.changelog_stats.cli["1.3.0"].breaking | default: 0 %}
{% assign b_1_3_1 = site.data.zdm.common.changelog_stats.cli["1.3.1"].breaking | default: 0 %}
{% assign brk_total = b_1_3_0 | plus: b_1_3_1 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.3.0</span><span class="ur-date">2026-04-10</span><span class="ur-badges"><span class="badge badge-patch">patch v1.3.1</span>{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.3.1 문서 바로가기](/zdm/ko/cli/1.3.1/index)

{% include zdm/ko/cli/changelog/1.3.1.md %}

{% include zdm/ko/cli/changelog/1.3.0.md %}

</details>

{% assign b_1_2_0 = site.data.zdm.common.changelog_stats.cli["1.2.0"].breaking | default: 0 %}
{% assign b_1_2_1 = site.data.zdm.common.changelog_stats.cli["1.2.1"].breaking | default: 0 %}
{% assign brk_total = b_1_2_0 | plus: b_1_2_1 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.2.0</span><span class="ur-date">2026-04-09</span><span class="ur-badges"><span class="badge badge-patch">patch v1.2.1</span>{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.2.0 문서 바로가기](/zdm/ko/cli/1.2.0/index)

{% include zdm/ko/cli/changelog/1.2.1.md %}

{% include zdm/ko/cli/changelog/1.2.0.md %}

</details>

{% assign b_1_0_4 = site.data.zdm.common.changelog_stats.cli["1.0.4"].breaking | default: 0 %}
{% assign brk_total = b_1_0_4 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.0.4</span><span class="ur-date">2026-03-04</span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.0.4 문서 바로가기](/zdm/ko/cli/1.0.4/index)

{% include zdm/ko/cli/changelog/1.0.4.md %}

</details>

{% assign b_1_0_3 = site.data.zdm.common.changelog_stats.cli["1.0.3"].breaking | default: 0 %}
{% assign brk_total = b_1_0_3 %}
<details class="update-row" markdown="1">
<summary><span class="ur-ver">v1.0.3</span><span class="ur-date"></span><span class="ur-badges">{% if brk_total > 0 %}<span class="badge badge-breaking">BREAKING {{ brk_total }}</span>{% endif %}</span></summary>

[v1.0.3 문서 바로가기](/zdm/ko/cli/1.0.3/index)

{% include zdm/ko/cli/changelog/1.0.3.md %}

</details>

</div>
