{%- comment -%}
Replication V1 Unit Types Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-v1-unit-types" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-v1-unit-types" format="inline" -%}
{%- endif -%}