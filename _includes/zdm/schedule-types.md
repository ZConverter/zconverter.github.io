{%- comment -%}
Schedule Types Include (Wrapper)
{%- endcomment -%}
{%- if include.inline -%}
{%- include zdm/enum.html name="schedule-types" format="inline" -%}
{%- elsif include.number and include.category -%}
{%- include zdm/enum.html name="schedule-types" format="table" show_desc=true show_number=true show_category=true -%}
{%- elsif include.category -%}
{%- include zdm/enum.html name="schedule-types" format="table" show_desc=true show_category=true -%}
{%- else -%}
{%- include zdm/enum.html name="schedule-types" format="table" show_desc=true -%}
{%- endif -%}