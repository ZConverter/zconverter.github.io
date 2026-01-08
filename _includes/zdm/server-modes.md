{%- comment -%}
Server Modes Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="server-modes" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="server-modes" format="inline" -%}
{%- endif -%}