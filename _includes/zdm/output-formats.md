{%- comment -%}
Output Formats Include (Wrapper) - CLI Only
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="output-formats" type="cli" version="1.0.3" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="output-formats" type="cli" version="1.0.3" format="inline" -%}
{%- endif -%}