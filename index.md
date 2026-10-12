---
layout: home
title: Home
---

{% assign cli_latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first %}
{% assign api_latest = site.data.zdm.common.versions.api | where: "status", "latest" | first %}
{% assign cli_docs_date = site.data.zdm.common.doc_mtimes.cli[cli_latest.version] | default: cli_latest.docs_updated %}
{% assign api_docs_date = site.data.zdm.common.doc_mtimes.api[api_latest.version] | default: api_latest.docs_updated %}

<section class="home-section" markdown="1">

## 제품 문서

<p class="section-sub">제품별 레퍼런스 — 커맨드와 엔드포인트 전체를 다룹니다.</p>

<div class="feature-grid">

<a class="feature-card" href="/zdm/ko/cli/{{ cli_latest.version }}/index">
<h3>ZDM-CLI <span class="badge badge-latest">latest</span></h3>
<p>커맨드 라인에서 백업·복구 작업을 등록하고 모니터링합니다.</p>
<div class="feature-foot"><span class="badge badge-patch">v{{ cli_latest.version }}</span> 문서 갱신 {{ cli_docs_date | default: "-" }}</div>
</a>

<a class="feature-card" href="/zdm/ko/api/{{ api_latest.version }}/index">
<h3>ZDM-API <span class="badge badge-latest">latest</span></h3>
<p>REST API 로 백업·복구·시스템 관리를 자동화합니다.</p>
<div class="feature-foot"><span class="badge badge-patch">v{{ api_latest.version }}</span> 문서 갱신 {{ api_docs_date | default: "-" }}</div>
</a>

</div>

</section>

<section class="home-section home-band" markdown="1">

## 가이드

<p class="section-sub">시나리오별 구축·운영 절차를 처음부터 끝까지 안내합니다.</p>

<div class="feature-grid">

<a class="feature-card" href="/guides/ko/serverless-dr/ncp/index">
<h3>서버리스 복구 자동화 <span class="badge badge-stable">NCP</span></h3>
<p>Target ZDM 없이 백업 이미지로부터 복구를 자동화합니다.</p>
<div class="feature-foot">Naver Cloud Platform · 6개 장</div>
</a>

<a class="feature-card" href="/guides/">
<h3>전체 가이드</h3>
<p>클라우드·시나리오별 가이드 목록을 확인합니다.</p>
<div class="feature-foot">가이드 홈</div>
</a>

</div>

</section>

<section class="home-section" markdown="1">

## 지원

문서 관련 문의사항이나 기술 지원이 필요하시면 [dev@zconverter.com](mailto:dev@zconverter.com)로 연락주세요.

</section>
