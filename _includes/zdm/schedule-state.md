{%- comment -%}
Schedule State Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="schedule-state" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="schedule-state" format="inline" -%}
{%- endif -%}