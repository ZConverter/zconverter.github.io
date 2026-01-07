{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `Query` | URL 쿼리 파라미터 |
| `Path` | URL 경로 파라미터 |
| `Body` | 요청 본문 |
| `Header` | 요청 헤더 |
{%- else -%}
`Query`, `Path`, `Body`, `Header`
{%- endif -%}