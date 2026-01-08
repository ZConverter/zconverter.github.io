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
{%- include zdm/enum.html name="overwrite-options" type=type version="1.0.3" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="overwrite-options" type=type version="1.0.3" format="inline" -%}
{%- endif -%}