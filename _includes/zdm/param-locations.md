{%- comment -%}
Param Locations Include (Wrapper) - API Only
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="param-locations" type="api" version="v1_0_3" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="param-locations" type="api" version="v1_0_3" format="inline" -%}
{%- endif -%}