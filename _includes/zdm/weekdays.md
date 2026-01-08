{%- comment -%}
Weekdays Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="weekdays" format="table" show_desc=true show_number=include.number -%}
{%- elsif include.number -%}
{%- include zdm/enum.html name="weekdays" format="table" show_desc=true show_number=true -%}
{%- else -%}
{%- include zdm/enum.html name="weekdays" format="inline" -%}
{%- endif -%}