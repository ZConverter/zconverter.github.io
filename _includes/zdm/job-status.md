{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `run` | 실행 중 |
| `complete` | 완료 |
| `start` | 시작 |
| `waiting` | 대기 중 |
| `cancel` | 취소됨 |
| `schedule` | 스케줄 대기 |
{%- else -%}
`run`, `complete`, `start`, `waiting`, `cancel`, `schedule`
{%- endif -%}