{%- comment -%}
Script Timing Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="script-timing" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="script-timing" format="inline" -%}
{%- endif -%}