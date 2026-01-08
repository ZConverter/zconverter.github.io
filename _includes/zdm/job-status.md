{%- comment -%}
Job Status Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="job-status" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="job-status" format="inline" -%}
{%- endif -%}