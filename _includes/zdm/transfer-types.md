{%- comment -%}
Transfer Types Include (Wrapper)
{%- endcomment -%}
{%- if include.desc -%}
{%- include zdm/enum.html name="transfer-types" format="table" show_desc=true -%}
{%- else -%}
{%- include zdm/enum.html name="transfer-types" format="inline" -%}
{%- endif -%}