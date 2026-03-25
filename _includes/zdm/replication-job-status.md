{%- comment -%}
Replication Job Status Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="replication-job-status" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="replication-job-status" format="inline" -%}
{%- endif -%}