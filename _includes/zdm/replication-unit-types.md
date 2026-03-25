{%- comment -%}
Replication Unit Types Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-unit-types" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-unit-types" format="inline" -%}
{%- endif -%}