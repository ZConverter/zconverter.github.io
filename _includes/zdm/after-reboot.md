{%- comment -%}
After Reboot Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="after-reboot" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="after-reboot" format="inline" -%}
{%- endif -%}