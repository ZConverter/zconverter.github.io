{%- comment -%}
Job Modes Include (Wrapper)
기존 호환성 유지를 위한 래퍼 - 새 템플릿 호출

사용법:
  {% include zdm/job-modes.md %}
  {% include zdm/job-modes.md backup=true %}
  {% include zdm/job-modes.md recovery=true %}
  {% include zdm/job-modes.md backup=true desc=true %}
{%- endcomment -%}
{%- if include.backup -%}
  {%- assign context = "backup" -%}
{%- elsif include.recovery -%}
  {%- assign context = "recovery" -%}
{%- else -%}
  {%- assign context = "recovery" -%}
{%- endif -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="job-modes" type="api" version="v1_0_3" context=context format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="job-modes" type="api" version="v1_0_3" context=context format="inline" -%}
{%- endif -%}