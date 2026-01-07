{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `win` | Windows |
| `lin` | Linux |
| `cloud` | Cloud (API only) |
{%- else -%}
`win`, `lin`{% if include.cloud %}, `cloud`{% endif %}
{%- endif -%}