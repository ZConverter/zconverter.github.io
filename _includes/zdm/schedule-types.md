{%- comment -%}
Schedule Types Include
데이터 소스: _data/zdm/api_0_3/schedule-types.yml

사용법:
{% include zdm/schedule-types.md %}              - 테이블 (Type, 이름, 설명)
{% include zdm/schedule-types.md inline=true %}  - 인라인 (0, 1, 2, ...)
{%- endcomment -%}
{%- assign schedule_types = site.data.zdm.api.v1_0_3.schedule-types -%}
{%- if include.inline -%}
{%- for item in schedule_types -%}
`{{ item.type }}`{%- unless forloop.last -%}, {% endunless -%}
{%- endfor -%}
{%- else -%}
| Type | 이름 | 설명 |
|------|------|------|
{% for item in schedule_types -%}
| {{ item.type }} | {{ item.name }} | {{ item.desc }} |
{% endfor -%}
{%- endif -%}