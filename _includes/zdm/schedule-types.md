{%- if include.inline -%}
`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`
{%- elsif include.number and include.category %}
| 번호 | 타입 | 설명 | 카테고리 |
|------|------|------|----------|
| 0 | `once` | 한 번 실행 | Basic |
| 1 | `every minute` | 매분 실행 | Basic |
| 2 | `hourly` | 매시간 실행 | Basic |
| 3 | `daily` | 매일 실행 | Basic |
| 4 | `weekly` | 매주 실행 (요일 복수선택 가능) | Basic |
| 5 | `monthly on specific week` | 매월 특정 주 (주 복수선택 가능) | Basic |
| 6 | `monthly on specific day` | 매월 특정 일 (날짜 복수선택 가능) | Basic |
| 7 | `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment)(요일 복수선택 가능) | Smart |
| 8 | `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment)(주, 요일 복수선택 가능)) | Smart |
| 9 | `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment)(날짜 복수선택 가능) | Smart |
| 10 | `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment)(월 복수선택 가능|주 복수선택 가능|요일 복수선택 가능) | Smart |
| 11 | `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment)(월 복수선택 가능|일 복수선택 가능) | Smart |
{%- elsif include.category %}
| 타입 | 설명 | 카테고리 |
|------|------|----------|
| `once` | 한 번 실행 | Basic |
| `every minute` | 매분 실행 | Basic |
| `hourly` | 매시간 실행 | Basic |
| `daily` | 매일 실행 | Basic |
| `weekly` | 매주 실행 (요일 복수선택 가능) | Basic |
| `monthly on specific week` | 매월 특정 주 (주 복수선택 가능) | Basic |
| `monthly on specific day` | 매월 특정 일 (날짜 복수선택 가능) | Basic |
| `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment)(요일 복수선택 가능) | Smart |
| `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment)(주, 요일 복수선택 가능) | Smart |
| `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment)(날짜 복수선택 가능) | Smart |
| `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment)(월 복수선택 가능|주 복수선택 가능|요일 복수선택 가능) | Smart |
| `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment)(월 복수선택 가능|일 복수선택 가능) | Smart |
{%- else %}
| 타입 | 설명 |
|------|------|
| `once` | 한 번 실행 |
| `every minute` | 매분 실행 |
| `hourly` | 매시간 실행 |
| `daily` | 매일 실행 |
| `weekly` | 매주 실행 (요일 복수선택 가능) |
| `monthly on specific week` | 매월 특정 주 (주 복수선택 가능) |
| `monthly on specific day` | 매월 특정 일 (날짜 복수선택 가능) |
| `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment)(요일 복수선택 가능) |
| `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment)(주, 요일 복수선택 가능)) |
| `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment)(날짜 복수선택 가능) |
| `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment)(월 복수선택 가능|주 복수선택 가능|요일 복수선택 가능) |
| `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment)(월 복수선택 가능|일 복수선택 가능) |
{%- endif -%}