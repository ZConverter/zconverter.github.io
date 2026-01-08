{%- comment -%}
Output Formats Include (Wrapper) - CLI Only
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="output-formats" type="cli" version="0.2.0" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="output-formats" type="cli" version="0.2.0" format="inline" -%}
{%- endif -%}