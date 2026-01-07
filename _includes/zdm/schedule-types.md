{%- if include.number and include.category %}
| 번호 | 타입 | 설명 | 카테고리 |
|------|------|------|----------|
| 0 | `once` | 한 번 실행 | Basic |
| 1 | `every minute` | 매분 실행 | Basic |
| 2 | `hourly` | 매시간 실행 | Basic |
| 3 | `daily` | 매일 실행 | Basic |
| 4 | `weekly` | 매주 실행 | Basic |
| 5 | `monthly on specific week` | 매월 특정 주 | Basic |
| 6 | `monthly on specific day` | 매월 특정 일 | Basic |
| 7 | `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment) | Smart |
| 8 | `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment) | Smart |
| 9 | `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment) | Smart |
| 10 | `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment) | Smart |
| 11 | `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment) | Smart |
{%- elsif include.category %}
| 타입 | 설명 | 카테고리 |
|------|------|----------|
| `once` | 한 번 실행 | Basic |
| `every minute` | 매분 실행 | Basic |
| `hourly` | 매시간 실행 | Basic |
| `daily` | 매일 실행 | Basic |
| `weekly` | 매주 실행 | Basic |
| `monthly on specific week` | 매월 특정 주 | Basic |
| `monthly on specific day` | 매월 특정 일 | Basic |
| `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment) | Smart |
| `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment) | Smart |
| `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment) | Smart |
| `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment) | Smart |
| `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment) | Smart |
{%- else %}
| 타입 | 설명 |
|------|------|
| `once` | 한 번 실행 |
| `every minute` | 매분 실행 |
| `hourly` | 매시간 실행 |
| `daily` | 매일 실행 |
| `weekly` | 매주 실행 |
| `monthly on specific week` | 매월 특정 주 |
| `monthly on specific day` | 매월 특정 일 |
| `smart weekly on specific day` | 매주 특정 요일(full) + 매주 특정 요일(increment) |
| `smart monthly on specific week and day` | 매달 특정 주 특정 요일(full) + 매달 특정 주 특정 요일(increment) |
| `smart monthly on specific date` | 매달 특정 일(full) + 매달 특정 일(increment) |
| `smart custom monthly on specific month, week and day` | 매년 특정 월 특정 주 특정 요일(full) + 매년 특정 월 특정 주 특정 요일(increment) |
| `smart custom monthly on specific month and date` | 매년 특정 월 특정 일(full) + 매년 특정 월 특정 일(increment) |
{%- endif -%}