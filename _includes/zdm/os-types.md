{%- comment -%}
OS Types Include (Wrapper)
{%- endcomment -%}
{%- if include.cloud -%}
  {%- assign type = "api" -%}
{%- else -%}
  {%- assign type = "cli" -%}
{%- endif -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="os-types" type=type version="v1_0_3" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="os-types" type=type version="v1_0_3" format="inline" -%}
{%- endif -%}