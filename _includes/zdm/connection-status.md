{%- comment -%}
Connection Status Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="connection-status" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="connection-status" format="inline" -%}
{%- endif -%}