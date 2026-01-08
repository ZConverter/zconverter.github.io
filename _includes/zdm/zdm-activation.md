{%- comment -%}
ZDM Activation Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="zdm-activation" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="zdm-activation" format="inline" -%}
{%- endif -%}