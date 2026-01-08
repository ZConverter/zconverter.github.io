{%- comment -%}
Platforms Include (Wrapper)
{%- endcomment -%}
{%- if include.baremetal -%}
  {%- assign type = "cli" -%}
{%- else -%}
  {%- assign type = "api" -%}
{%- endif -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="platforms" type=type version="0.2.0" format="table" show_desc=true -%}
{%- elsif include.inline -%}
{%- include zdm/enum.html name="platforms" type=type version="0.2.0" format="inline" -%}
{%- else -%}
{%- include zdm/enum.html name="platforms" type=type version="0.2.0" format="table" show_desc=false -%}
{%- endif -%}