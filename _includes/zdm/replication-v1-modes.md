{%- comment -%}
Replication V1 Modes Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-v1-modes" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-v1-modes" format="inline" -%}
{%- endif -%}