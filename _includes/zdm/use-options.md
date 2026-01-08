{%- comment -%}
Use Options Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="use-options" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="use-options" format="inline" -%}
{%- endif -%}