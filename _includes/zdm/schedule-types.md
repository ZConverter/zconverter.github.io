{%- comment -%}
Schedule Types Include
데이터 소스: _data/zdm/common/enums.yml 의 schedule-types (number / value / description / category / basic)

사용법:
{% include zdm/schedule-types.md %}                           - 테이블 (Type, 이름, 설명)
{% include zdm/schedule-types.md number=true %}               - 위와 같음 (Type 열은 기본 표시)
{% include zdm/schedule-types.md number=true category=true %} - 테이블 + 분류 열 (Basic / Smart)
{% include zdm/schedule-types.md inline=true %}               - 인라인 (0, 1, 2, ...)
{% include zdm/schedule-types.md inline_names=true %}         - 인라인 이름 (`Once`, `Every Minute`, ...) — 응답 type 표시 이름(value)

enum.html 에 위임하지 않는 이유: enum.html 의 table 형식은 헤더 행 뒤에 빈 줄이 생겨
헤더가 별도 표로 갈라진다. 같은 데이터를 읽어 여기서 직접 그린다.
{%- endcomment -%}
{%- assign schedule_types = site.data.zdm.common.enums.schedule-types -%}
{%- if include.inline_names -%}
{%- for item in schedule_types -%}
`{{ item.value }}`{%- unless forloop.last -%}, {% endunless -%}
{%- endfor -%}
{%- elsif include.inline -%}
{%- for item in schedule_types -%}
`{{ item.number }}`{%- unless forloop.last -%}, {% endunless -%}
{%- endfor -%}
{%- else -%}
| Type | 이름 | 설명 |{% if include.category %} 분류 |{% endif %}
|------|------|------|{% if include.category %}------|{% endif %}
{% for item in schedule_types -%}
| {{ item.number }} | {{ item.value }} | {{ item.description }} |{% if include.category %} {{ item.category }} |{% endif %}
{% endfor -%}
{%- endif -%}
