---
layout: docs
title: ZDM CLI Documentation
section_title: ZDM CLI Documentation
navigation: ko-cli
lang: ko
---
{%- comment -%}
이 페이지는 ZDM-CLI 의 latest 버전 intro 로 리다이렉트하는 라우터입니다.

새 버전 출시 시 본 파일은 별도 갱신이 필요 없습니다.
`_data/zdm/common/versions.yml` 의 cli 항목 중 `status: latest` 인 것이
아래 `latest` Liquid 변수에 자동 반영됩니다.
(참고: jekyll-redirect-from 플러그인 미사용 — frontmatter `redirect_to:` 는 동작하지 않으므로 제거됨)
{%- endcomment -%}
{%- assign latest = site.data.zdm.common.versions.cli | where: "status", "latest" | first -%}
{%- assign latest_url = '/zdm/ko/cli/' | append: latest.version | append: '/index' -%}

<script>
  window.location.href = "{{ latest_url | relative_url }}";
</script>

<noscript>
  <meta http-equiv="refresh" content="0; url={{ latest_url | relative_url }}">
</noscript>

이 페이지는 [최신 CLI 문서]({{ latest_url }})로 리다이렉트됩니다.
