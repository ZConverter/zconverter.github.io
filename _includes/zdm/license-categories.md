{%- comment -%}
License Categories Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="license-categories" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="license-categories" format="inline" -%}
{%- endif -%}