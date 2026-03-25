{%- comment -%}
Replication Modes Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-modes" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-modes" format="inline" -%}
{%- endif -%}