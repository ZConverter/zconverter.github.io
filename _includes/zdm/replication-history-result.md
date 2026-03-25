{%- comment -%}
Replication History Result Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-history-result" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-history-result" format="inline" -%}
{%- endif -%}