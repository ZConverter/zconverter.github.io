{%- comment -%}
Schedule Change Value Include
작업 수정 응답 `updatedFields` 의 스케줄 항목 값(`previous`·`new`) 구조 `{ id, type, description }` 설명.
어느 field 이름(`Schedule` / `Schedule(Basic)` / `schedule` 등)에 이 값이 실리는지, 스케줄이 없을 때
무엇이 오는지는 엔드포인트마다 달라 각 도메인 페이지에 둔다.

사용법:
{% include zdm/schedule-change-value.md %}

type 이름 목록은 schedule-types.md inline_names 로 만든다. `Unknown` 은 enums 데이터에 없어 문장에 따로 적는다.
표 머리와 구분선 사이에 빈 줄이 생기면 표가 갈라지므로 행은 공백 제어 없이 줄바꿈으로만 잇는다.
{%- endcomment -%}
스케줄 항목의 `previous`·`new` 값은 다음 필드를 가진 객체입니다.

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | number | 스케줄 ID |
| `type` | string | 스케줄 타입 이름. {% include zdm/schedule-types.md inline_names=true %} 중 하나이며, 스케줄 조회에 실패했거나 타입을 알 수 없으면 `Unknown` |
| `description` | string | 스케줄 내용을 설명하는 영문 한 줄 (예: `[Basic] Start working at 03:00 every day.`). 스케줄 조회에 실패하면 `Schedule lookup failed` |
