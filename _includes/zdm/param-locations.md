{%- comment -%}
Param Locations Include (Wrapper) - API Only
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="param-locations" type="api" version="0.2.0" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="param-locations" type="api" version="0.2.0" format="inline" -%}
{%- endif -%}