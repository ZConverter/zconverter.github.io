{%- comment -%}
OS Types Include (Wrapper)
{%- endcomment -%}
{%- if include.cloud -%}
  {%- assign type = "api" -%}
{%- else -%}
  {%- assign type = "cli" -%}
{%- endif -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="os-types" type=type version="0.2.0" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="os-types" type=type version="0.2.0" format="inline" -%}
{%- endif -%}