{%- if include.api -%}
{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `allow` | 덮어쓰기 허용 |
| `not allow` | 덮어쓰기 불허 |
{%- else -%}
`allow`, `not allow`
{%- endif -%}
{%- elsif include.cli -%}
{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `allow` | 덮어쓰기 허용 |
| `notAllow` | 덮어쓰기 불허 |
{%- else -%}
`allow`, `notAllow`
{%- endif -%}
{%- else -%}
{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `allow` | 덮어쓰기 허용 |
| `not allow` / `notAllow` | 덮어쓰기 불허 |
{%- else -%}
`allow`, `not allow`
{%- endif -%}
{%- endif -%}