{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `sun` | 일요일 |
| `mon` | 월요일 |
| `tue` | 화요일 |
| `wed` | 수요일 |
| `thu` | 목요일 |
| `fri` | 금요일 |
| `sat` | 토요일 |
{%- elsif include.number %}
| 값 | 숫자 | 설명 |
|------|------|------|
| `sun` | 0 | 일요일 |
| `mon` | 1 | 월요일 |
| `tue` | 2 | 화요일 |
| `wed` | 3 | 수요일 |
| `thu` | 4 | 목요일 |
| `fri` | 5 | 금요일 |
| `sat` | 6 | 토요일 |
{%- else -%}
`sun`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`
{%- endif -%}