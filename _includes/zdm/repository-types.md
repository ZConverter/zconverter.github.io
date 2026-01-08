{%- comment -%}
Repository Types Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="repository-types" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="repository-types" format="inline" -%}
{%- endif -%}