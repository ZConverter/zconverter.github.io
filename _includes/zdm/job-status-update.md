{%- comment -%}
Job Status Update Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="job-status-update" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="job-status-update" format="inline" -%}
{%- endif -%}
