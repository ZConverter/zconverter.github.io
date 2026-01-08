{%- comment -%}
Overwrite Options Include (Wrapper)
{%- endcomment -%}
{%- if include.api -%}
  {%- assign type = "api" -%}
{%- elsif include.cli -%}
  {%- assign type = "cli" -%}
{%- else -%}
  {%- assign type = "api" -%}
{%- endif -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="overwrite-options" type=type version="0.2.0" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="overwrite-options" type=type version="0.2.0" format="inline" -%}
{%- endif -%}