{%- comment -%}
Schedule Object Include
도메인 페이지(backup·recovery·replication·os-replication 등록/수정)의 `schedule` 필드 공통 설명.
타입별 구조·필드 규칙은 쓰지 않고 스케줄 개요로 링크한다.

사용법:
{% include zdm/schedule-object.md %}              - type 0~11, advanced 포함 (smart 지원 도메인)
{% include zdm/schedule-object.md smart=false %}  - type 0~6, advanced 없음 (basic 전용 도메인)

링크용 base_path 는 이 include 안에서 만든다(본문에서 이미 만들었어도 같은 값이라 무해).
표 머리와 구분선 사이에 빈 줄이 생기면 표가 갈라지므로 행은 공백 제어 없이 줄바꿈으로만 잇는다.
{%- endcomment -%}
{%- include zdm/base-path.html -%}
{%- assign schedule_smart = true -%}
{%- if include.smart == false or include.smart == "false" -%}{%- assign schedule_smart = false -%}{%- endif -%}
`schedule` 은 기존 스케줄 ID(number) 또는 스케줄 객체(object)입니다. 객체는 다음 필드로 이루어집니다.

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
{% if schedule_smart -%}
| `type` | number | 필수 | 스케줄 타입 번호 (`0`~`11`) |
| `basic` | object \| number | 필수 | 기본 스케줄. 스케줄 객체 또는 기존 스케줄 ID |
| `advanced` | object \| number | 선택 | 추가 스케줄. smart 타입(`7`~`11`)에서만 사용. 스케줄 객체 또는 기존 스케줄 ID |
{% else -%}
| `type` | number | 필수 | 스케줄 타입 번호 (`0`~`6`) |
| `basic` | object \| number | 필수 | 기본 스케줄. 스케줄 객체 또는 기존 스케줄 ID |

smart 스케줄(`7`~`11`)은 지원하지 않습니다.
{% endif %}
타입별 구조·필드 규칙은 [스케줄 개요]({{ base_path }}/docs/schedule/overview)를 참고하세요.
