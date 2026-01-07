{%- if include.backup and include.desc %}
| 값 | 설명 |
|------|------|
| `full` | 전체 백업/복구 |
| `increment` | 증분 백업/복구 |
| `smart` | 스마트 백업 (Full + Increment 조합) |
{%- elsif include.recovery and include.desc %}
| 값 | 설명 |
|------|------|
| `full` | 전체 복구 |
| `increment` | 증분 복구 |
{%- elsif include.backup -%}
`full`, `increment`, `smart`
{%- else -%}
`full`, `increment`
{%- endif -%}