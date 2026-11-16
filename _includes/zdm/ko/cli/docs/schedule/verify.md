
Schedule JSON 파일의 유효성을 검증합니다.

---

## `schedule verify` {#schedule-verify}

> * `schedule create` 명령어로 생성한 JSON 파일의 유효성을 검증하는 명령어입니다.
> * 서버에 등록하기 전에 파일 형식과 필수 필드, Type별 요구사항을 검증합니다.
> * JSON 파일 형식만 지원합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli schedule verify [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Schedule 파일 검증
zdm-cli schedule verify -p /path/to/schedule.json

# 절대 경로 사용
zdm-cli schedule verify --path /home/user/schedules/daily-schedule.json

# 상대 경로 사용
zdm-cli schedule verify -p ./Basic_schedule-20250106120000.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --path | -p | string | Required | - | 검증할 Schedule File Path | - |

</details>

<details markdown="1" open>
<summary><strong>검증 항목</strong></summary>

| 검증 항목 | 설명 |
|-----------|------|
| 파일 존재 | 지정된 경로에 파일이 존재하는지 확인 |
| JSON 형식 | 유효한 JSON 형식인지 확인 |
| type 필드 | type 필드가 존재하고 0~12 범위의 정수인지 확인 |
| basic 필드 | basic 필드가 존재하는지 확인 |
| Type별 검증 | Schedule Type에 따른 필수 필드 및 형식 검증 |
| Advanced 검증 | Smart Schedule (Type 7~11)의 경우 advanced 필드 검증 |

</details>

<details markdown="1" open>
<summary><strong>Type별 필수 필드</strong></summary>

| Type | Basic 필수 필드 | Advanced 필수 필드 |
|------|----------------|-------------------|
| 0 (once) | year, month, day, time | - |
| 1 (every minute) | time, interval.minute | - |
| 2 (hourly) | time, interval.hour | - |
| 3 (daily) | time | - |
| 4 (weekly) | day, time | - |
| 5 (monthly on specific week) | week, day, time | - |
| 6 (monthly on specific day) | day, time | - |
| 7 (smart weekly) | day, time | day, time |
| 8 (smart monthly week) | week, day, time | week, day, time |
| 9 (smart monthly date) | day, time | day, time |
| 10 (smart custom monthly week) | month, week, day, time | month, week, day, time |
| 11 (smart custom monthly date) | month, day, time | month, day, time |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

> **참고:** `schedule verify`는 로컬 파일 검증 명령어로, API 호출 없이 결과 메시지만 출력합니다.
> `--output json` 을 지원합니다. 검증에 실패하면 종료 코드 `2` 로 끝납니다.
> 시간 필드(`time`)는 `HH:MM`(24시간) 형식이어야 하며 `99:99` 는 실패합니다.

**Text 형식:**

**검증 성공 (종료 코드 0):**

```
* Schedule data is valid.
```

**JSON 형식 (`-o json`):**

```json
{"status":"success","message":"Schedule data is valid."}
```

**검증 실패 (종료 코드 2):**

실패 메시지는 표준에러에 `* [ERROR] <메시지>` 형태로 출력됩니다. `-o json` 이면 표준에러에 실패 응답(`error.code` 포함)이 출력됩니다.

| 실패 사유 | 메시지 |
|-----------|--------|
| 파일 없음 | `file not found: /path/to/schedule.json` |
| JSON 형식 오류 | `invalid JSON format` |
| 객체가 아닌 내용 (`null`, 배열 등) | `schedule data must be a JSON object` |
| type 필드 누락 | `missing type field` |
| type 범위 오류 | `type must be a number between 0 and 12` |
| basic 필드 누락 | `missing basic field` |
| 필수 필드 누락 | `[basic] Type:3 requires basic-time` |
| 시간 형식 오류 | `basic-time must be in HH:MM format. current input: 99:99` |

</details>

---
