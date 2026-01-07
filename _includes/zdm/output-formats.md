{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `text` | 텍스트 형식 (기본값) |
| `json` | JSON 형식 |
| `table` | 테이블 형식 |
{%- else -%}
`text`, `json`, `table`
{%- endif -%}