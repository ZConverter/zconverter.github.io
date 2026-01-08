{%- comment -%}
License Assign Status Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="license-assign-status" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="license-assign-status" format="inline" -%}
{%- endif -%}