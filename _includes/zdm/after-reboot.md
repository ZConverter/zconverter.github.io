{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `reboot` | 재부팅 |
| `shutdown` | 종료 |
| `maintain` | 현재 상태 유지 |
{%- else -%}
`reboot`, `shutdown`, `maintain`
{%- endif -%}