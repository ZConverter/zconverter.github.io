API 가 에러 응답의 `error.code` 로 반환하는 코드 목록입니다.

---

## 에러 코드 총람 {#error-codes}

> * **`error.code` 는 안정 식별자입니다.** 클라이언트는 `error.message` 문자열이 아니라 이 값으로 분기하세요. 메시지 문구는 예고 없이 바뀔 수 있습니다.
> * 데이터베이스 내부 오류는 스키마 정보 노출을 막기 위해 `INTERNAL_SERVER_ERROR` 로 치환되어 전달됩니다. 상세 원인은 서버 로그에만 기록됩니다.
> * 이 표는 서버 코드에서 생성한 파생본입니다. 표와 실제 응답이 다르면 **서버 동작이 정본**입니다.
> * **`(현재 발생하지 않음 — 정의만 존재)`** 로 표시된 코드는 서버에 정의돼 있으나 **어떤 경로에서도 반환되지 않습니다.** 클라이언트가 분기를 만들 필요가 없습니다(2026-09-07 확인).
> * **`error.message` 는 영문으로 반환됩니다.** 아래 표의 설명은 한국어 안내이며 실제 응답 문구와 다릅니다.

<details markdown="1" open>
<summary><strong>응답 형식</strong></summary>

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-13",
    "message": "Specified drive/partition does not exist on the server."
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

| 필드 | 타입 | 설명 |
|------|------|------|
| `error.code` | string | 분기용 안정 식별자 |
| `error.message` | string | 사람이 읽는 설명 (영문) |
| `error.details` | object | 필드별 상세 (`DTO-VALIDATION-01` · `-02` · `-03` 요청 검증 실패에만 포함. 그 외 에러에는 이 키가 없습니다) |
| `traceId` | string | 서버 로그와 대조할 추적 ID. 문의 시 함께 전달하세요 |

</details>

<details markdown="1">
<summary><strong>공통</strong> (17건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `FILTER_OPTIONS_EXTRACTION_FAILED` | 400 | 필터 조건을 해석하지 못했습니다. |
| `BAD_REQUEST` | 400 | 잘못된 요청입니다. |
| `UNAUTHORIZED` | 401 | 인증이 필요합니다. |
| `FORBIDDEN` | 403 | 접근 권한이 없습니다. |
| `NOT_FOUND` | 404 | 요청한 리소스를 찾을 수 없습니다. |
| `METHOD_NOT_ALLOWED` | 405 | 허용되지 않은 HTTP 메서드입니다. |
| `CONFLICT` | 409 | 현재 리소스 상태와 충돌하는 요청입니다. |
| `UNPROCESSABLE_ENTITY` | 422 | 요청 형식은 올바르나 처리할 수 없습니다. |
| `TOO_MANY_REQUESTS` | 429 | 요청이 너무 많습니다. 잠시 후 다시 시도하세요. |
| `INTERNAL_SERVER_ERROR` | 500 | 서버 내부 오류입니다. |
| `NOT_IMPLEMENTED` | 501 | 구현되지 않은 기능입니다. |
| `BAD_GATEWAY` | 502 | 게이트웨이 오류입니다. |
| `SERVICE_UNAVAILABLE` | 503 | 서비스를 사용할 수 없습니다. |
| `GATEWAY_TIMEOUT` | 504 | 게이트웨이 응답 시간이 초과됐습니다. |
| `TIMEOUT_ERROR` | 408 | 요청 처리 시간이 초과됐습니다. |
| `INVALID_JSON` | 400 | JSON 형식이 잘못됐습니다. 요청 본문을 확인하세요. |
| `RATE-LIMIT-01` | 429 | 인증 시도가 너무 많습니다. 잠시 후 다시 시도하세요. |

</details>

<details markdown="1">
<summary><strong>Center</strong> (2건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `CENTER-ERROR-01` | 403 | 해당 데이터가 지정한 center 에 속하지 않습니다. |
| `CENTER-ERROR-02` | 400 | center 를 정확히 하나만 지정해야 합니다. |

</details>

<details markdown="1">
<summary><strong>File</strong> (7건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `FILE-ERROR-01` | 404 | 파일을 찾을 수 없습니다. |
| `FILE-ERROR-02` | 500 | 파일 쓰기에 실패했습니다. |
| `FILE-ERROR-03` | 500 | JSON 파일 쓰기에 실패했습니다. |
| `FILE-ERROR-04` | 400 | 파일 크기가 제한을 초과했습니다. |
| `FILE-ERROR-05` | 400 | 파일 업로드 중 오류가 발생했습니다. |
| `FILE-ERROR-10` | 422 | 유효하지 않은 JSON 파일입니다. |
| `FILE-ERROR-11` | 400 | 파일 경로가 유효하지 않습니다. |

</details>

<details markdown="1">
<summary><strong>설정</strong> (3건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `CONFIG-ERROR-01` | 500 | 필수 설정값이 누락됐습니다. |
| `CONFIG-ERROR-02` | 500 | 설정값 검증에 실패했습니다. |
| `CONFIG-ERROR-03` | 500 | 운영 환경 설정 파일을 찾을 수 없습니다. |

</details>

<details markdown="1">
<summary><strong>Repository</strong> (2건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `REPOSITORY-ERROR-10` | 400 | 저장소 경로 오류입니다. (SMB 형식 불일치) |
| `REPOSITORY-ERROR-11` | 400 | 저장소 경로 오류입니다. (NFS 형식 불일치) |

</details>

<details markdown="1">
<summary><strong>ZDM</strong> (1건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `ZDM-ERROR-01` | 404 | ZDM 을 찾을 수 없습니다. |

</details>

<details markdown="1">
<summary><strong>ZDM Repository</strong> (1건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `ZDM-REPOSITORY-ERROR-01` | 404 | ZDM 저장소를 찾을 수 없습니다. |

</details>

<details markdown="1">
<summary><strong>Schedule</strong> (44건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `SCHEDULE-ERROR-01` | 404 | 스케줄을 찾을 수 없습니다. |
| `SCHEDULE-ERROR-02` | 400 | 유효하지 않은 스케줄입니다. |
| `SCHEDULE-ERROR-10` | 422 | 스케줄 설명 변환에 실패했습니다. |
| `SCHEDULE-ERROR-11` | 422 | 스케줄의 day 변환에 실패했습니다. |
| `SCHEDULE-ERROR-12` | 422 | 스케줄의 요일 변환에 실패했습니다. |
| `SCHEDULE-ERROR-13` | 422 | 스케줄의 week 변환에 실패했습니다. |
| `SCHEDULE-ERROR-14` | 422 | 스케줄의 month 변환에 실패했습니다. |
| `SCHEDULE-ERROR-15` | 400 | time 값이 누락됐습니다. |
| `SCHEDULE-ERROR-16` | 400 | time 은 'HH:mm' 형식(00:00 ~ 23:59)이어야 합니다. |
| `SCHEDULE-ERROR-17` | 400 | day 값이 누락됐습니다. |
| `SCHEDULE-ERROR-18` | 422 | day 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-19` | 400 | day 는 1 ~ 31 사이여야 합니다. |
| `SCHEDULE-ERROR-20` | 409 | 이 스케줄 타입은 day 를 복수로 선택할 수 없습니다. |
| `SCHEDULE-ERROR-21` | 400 | day 값이 누락됐습니다. |
| `SCHEDULE-ERROR-22` | 422 | day 값이 유효하지 않습니다. (mon, tue, wed, thu, fri, sat, sun 중 하나) |
| `SCHEDULE-ERROR-23` | 409 | 이 스케줄 타입은 요일을 복수로 선택할 수 없습니다. |
| `SCHEDULE-ERROR-24` | 400 | week 값이 누락됐습니다. |
| `SCHEDULE-ERROR-25` | 422 | week 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-26` | 400 | week 는 1 ~ 5 사이여야 합니다. |
| `SCHEDULE-ERROR-27` | 409 | 이 스케줄 타입은 week 를 복수로 선택할 수 없습니다. |
| `SCHEDULE-ERROR-28` | 400 | month 값이 누락됐습니다. |
| `SCHEDULE-ERROR-29` | 422 | month 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-30` | 400 | month 는 1 ~ 12 사이여야 합니다. |
| `SCHEDULE-ERROR-31` | 409 | 이 스케줄 타입은 month 를 복수로 선택할 수 없습니다. |
| `SCHEDULE-ERROR-32` | 400 | year 값이 누락됐습니다. |
| `SCHEDULE-ERROR-33` | 422 | year 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-34` | 400 | year 는 0000 ~ 9999 사이여야 합니다. |
| `SCHEDULE-ERROR-35` | 400 | minute 값이 누락됐습니다. |
| `SCHEDULE-ERROR-36` | 422 | minute 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-37` | 400 | hour 값이 누락됐습니다. |
| `SCHEDULE-ERROR-38` | 422 | hour 값이 유효하지 않습니다. |
| `SCHEDULE-ERROR-39` | 422 | ONCE 타입의 필수 필드가 누락됐습니다. (sYear, sMonth, sDay) |
| `SCHEDULE-ERROR-40` | 422 | EVERY_MINUTE 타입의 필수 필드가 누락됐습니다. (nPeriodMinute) |
| `SCHEDULE-ERROR-41` | 422 | HOURLY 타입의 필수 필드가 누락됐습니다. (nPeriodHour) |
| `SCHEDULE-ERROR-42` | 422 | DAILY 타입에 불필요한 필드가 포함돼 있습니다. |
| `SCHEDULE-ERROR-43` | 422 | WEEKLY 타입의 필수 필드가 누락됐습니다. (sDayweek) |
| `SCHEDULE-ERROR-44` | 422 | MONTHLY_BY_WEEK 타입의 필수 필드가 누락됐습니다. (sDayweek, sWeek) |
| `SCHEDULE-ERROR-45` | 422 | MONTHLY_BY_DAY 타입의 필수 필드가 누락됐습니다. (sDate) |
| `SCHEDULE-ERROR-46` | 422 | SMART_WEEKLY 타입의 필수 필드가 누락됐습니다. (sDayweek) |
| `SCHEDULE-ERROR-47` | 422 | SMART_MONTHLY_BY_WEEKDAY 타입의 필수 필드가 누락됐습니다. (sDayweek, sWeek) |
| `SCHEDULE-ERROR-48` | 422 | SMART_MONTHLY_BY_DATE 타입의 필수 필드가 누락됐습니다. (sDate) |
| `SCHEDULE-ERROR-49` | 422 | SMART_CUSTOM_MONTHLY_BY_WEEKDAY 타입의 필수 필드가 누락됐습니다. (sDayweek, sWeek, sMonths) |
| `SCHEDULE-ERROR-50` | 422 | SMART_CUSTOM_MONTHLY_BY_DATE 타입의 필수 필드가 누락됐습니다. (sDate, sMonths) |
| `SCHEDULE-ERROR-51` | 409 | 사용 중인 스케줄이라 삭제할 수 없습니다. |

</details>

<details markdown="1">
<summary><strong>User</strong> (5건 정의 · <strong>실제 발생 3건</strong>)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `USER-ERROR-01` | 404 | 사용자를 찾을 수 없습니다. |
| `USER-ERROR-02` | 404 | 지정한 이메일의 사용자를 찾을 수 없습니다. |
| `USER-ERROR-03` | 404 | 지정한 ID 의 사용자를 찾을 수 없습니다. |
| `USER-ERROR-04` | 409 | 이미 존재하는 사용자입니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `USER-ERROR-05` | 401 | 인증 정보가 올바르지 않습니다. **(현재 발생하지 않음 — 정의만 존재)** |

</details>

<details markdown="1">
<summary><strong>Server</strong> (3건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `SERVER-ERROR-01` | 404 | 서버를 찾을 수 없습니다. |
| `SERVER-ERROR-02` | 404 | 서버가 연결돼 있지 않습니다. |
| `SERVER-ERROR-03` | 404 | 지정한 파티션이 서버에 존재하지 않습니다. |

</details>

<details markdown="1">
<summary><strong>요청 검증</strong> (5건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `DTO-VALIDATION-01` | 422 | 요청 본문 검증에 실패했습니다. |
| `DTO-VALIDATION-02` | 400 | URL 파라미터 검증에 실패했습니다. |
| `DTO-VALIDATION-03` | 400 | 쿼리 파라미터 검증에 실패했습니다. |
| `DTO-VALIDATION-04` | 500 | 데이터 변환 중 오류가 발생했습니다. |
| `DTO-CREATION-01` | 500 | 응답 데이터 생성 중 오류가 발생했습니다. |

> **선언되지 않은 query 파라미터 (since 3.0.0)**
>
> 조회 엔드포인트는 스키마에 선언된 파라미터만 받습니다. 오타이거나 제거된 이름을 보내면
> `DTO-VALIDATION-03` (400) 으로 거절되고, `details` 의 **key 가 문제 파라미터 이름**입니다.
> 종전에는 미지의 키가 조용히 버려져 필터가 빠진 더 넓은 결과가 200 으로 나갔습니다.
>
> ```json
> {
>   "success": false,
>   "error": {
>     "code": "DTO-VALIDATION-03",
>     "message": "Query parameter validation failed.",
>     "details": {
>       "sort": ["sort is not a supported parameter. Check for a typo or a parameter that has been removed."]
>     }
>   }
> }
> ```
>
> 같은 응답에 필수 누락과 미지의 키가 함께 있으면 각자 제 메시지를 유지합니다.

</details>

<details markdown="1">
<summary><strong>작업 공통</strong> (22건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `JOB-ERROR-01` | 404 | 작업을 찾을 수 없습니다. |
| `JOB-ERROR-18` | 500 | 작업 데이터 초기화에 실패했습니다. |
| `JOB-ERROR-19` | 500 | 작업 데이터 등록에 실패했습니다. |
| `JOB-ERROR-05` | 500 | 작업 데이터 삭제에 실패했습니다. |
| `JOB-ERROR-06` | 500 | 작업 데이터 수정에 실패했습니다. |
| `JOB-ERROR-02` | 404 | 작업 대상 서버를 찾을 수 없습니다. |
| `JOB-ERROR-03` | 404 | 작업의 center 를 찾을 수 없습니다. |
| `JOB-ERROR-04` | 404 | 작업 대상 사용자를 찾을 수 없습니다. |
| `JOB-ERROR-07` | 409 | 같은 이름의 작업이 이미 존재합니다. |
| `JOB-ERROR-08` | 404 | 작업 이름 변경에 실패했습니다. |
| `JOB-ERROR-09` | 404 | 작업 상태 변경에 실패했습니다. |
| `JOB-ERROR-10` | 400 | 파티션 경로 해석에 실패했습니다. 파티션 경로를 확인하세요. |
| `JOB-ERROR-11` | 500 | 작업 이름 자동 생성 중 오류가 발생했습니다. |
| `JOB-ERROR-12` | 404 | 저장소를 찾을 수 없습니다. |
| `JOB-ERROR-13` | 404 | 지정한 드라이브/파티션이 서버에 존재하지 않습니다. |
| `JOB-ERROR-14` | 400 | 등록할 작업이 없습니다. 파티션/드라이브 정보를 확인하세요. |
| `JOB-ERROR-15` | 500 | 데이터 처리 중 오류가 발생했습니다. |
| `JOB-ERROR-16` | 500 | 작업 정보 처리 중 오류가 발생했습니다. |
| `JOB-ERROR-17` | 500 | 상세 데이터 처리 중 오류가 발생했습니다. |
| `JOB-ERROR-20` | 400 | 작업 데이터가 불완전합니다. |
| `JOB-ERROR-21` | 500 | 작업 객체 생성에 실패했습니다. |
| `JOB-ERROR-22` | 400 | 필수 파라미터가 누락됐습니다. |

</details>

<details markdown="1">
<summary><strong>작업 스케줄</strong> (9건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `JOB-ERROR-100` | 404 | 지정한 스케줄을 찾을 수 없습니다. |
| `JOB-ERROR-101` | 400 | full/increment 작업은 스케줄에 basic 만 포함해야 합니다. |
| `JOB-ERROR-102` | 400 | smart 작업은 스케줄에 basic 과 advanced 를 모두 포함해야 합니다. |
| `JOB-ERROR-103` | 400 | full/increment 작업의 스케줄 타입은 0 ~ 6 이어야 합니다. |
| `JOB-ERROR-104` | 400 | smart 작업의 스케줄 타입은 7 ~ 11 이어야 합니다. |
| `JOB-ERROR-105` | 400 | basic 과 advanced 의 스케줄 타입이 일치하지 않습니다. |
| `JOB-ERROR-106` | 500 | 스케줄 수정에 실패했습니다. |
| `JOB-ERROR-107` | 400 | Smart Backup 은 스케줄이 필수입니다. |
| `JOB-ERROR-108` | 400 | 스케줄 모드가 일치하지 않습니다. (basic/advanced) |

</details>

<details markdown="1">
<summary><strong>Recovery</strong> (17건)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `JOB-ERROR-52` | 404 | 복구에 사용할 백업 데이터를 찾을 수 없습니다. |
| `JOB-ERROR-53` | 400 | 복구에 사용할 백업 파일이 유효하지 않습니다. |
| `JOB-ERROR-54` | 400 | 복구 대상 서버의 디스크 공간이 부족합니다. |
| `JOB-ERROR-55` | 400 | 파티션/디스크가 중복으로 사용됐습니다. |
| `JOB-ERROR-56` | 409 | 파티션 덮어쓰기 설정이 충돌합니다. |
| `JOB-ERROR-57` | 400 | 파일시스템이 일치하지 않습니다. |
| `JOB-ERROR-58` | 400 | source 와 target 의 OS 가 일치하지 않습니다. |
| `JOB-ERROR-59` | 400 | jobList 검증에 실패했습니다. |
| `JOB-ERROR-60` | 500 | PDD 코드 생성에 실패했습니다. pdd 파일을 확인하세요. |
| `JOB-ERROR-61` | 500 | PDD 경로 생성에 실패했습니다. pdd 파일을 확인하세요. |
| `JOB-ERROR-62` | 404 | 서버의 파티션 정보를 찾을 수 없습니다. |
| `JOB-ERROR-63` | 400 | listOnly 가 true 이면 jobList 가 필수입니다. |
| `JOB-ERROR-64` | 409 | 대상 서버에서 이미 복구 작업이 진행 중입니다. 복구 **실행** 요청(`PUT /recoveries/:identifier` 의 `status: "start"`)에서만 발생하며, 복구 등록은 이 사유로 거부되지 않습니다. |
| `JOB-ERROR-65` | 400 | 복구를 지원하지 않는 서버 OS 입니다. |
| `JOB-ERROR-66` | 400 | 저장소 경로 형식이 올바르지 않습니다. |
| `JOB-ERROR-67` | 400 | 지정한 백업 작업은 복구에 사용할 수 없습니다. |
| `JOB-ERROR-68` | 500 | 백업 이미지 조회에 실패했습니다. ZDBackup 데몬과 저장소 마운트 상태를 확인하세요. |

</details>

<details markdown="1">
<summary><strong>License</strong> (10건 정의 · <strong>실제 발생 2건</strong>)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `LICENSE-ERROR-01` | 404 | 라이선스를 찾을 수 없습니다. 단건 조회(`GET /licenses/:identifier` · `GET /licenses/key/:key`)와 라이선스 할당에서 발생합니다. `GET /licenses/:identifier` 는 라이선스가 있어도 조회 조건(`category` · `exp` · `created`)과 맞지 않으면 이 코드입니다. |
| `LICENSE-ERROR-02` | 409 | 이미 할당된 라이선스입니다. |
| `LICENSE-ERROR-03` | 400 | 만료된 라이선스입니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-04` | 400 | 라이선스 사용 한도를 초과했습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-05` | 400 | 라이선스 카테고리가 유효하지 않습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-06` | 500 | 라이선스 할당에 실패했습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-07` | 500 | 라이선스 이력 생성에 실패했습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-08` | 500 | 라이선스 처리 결과를 해석하지 못했습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-09` | 400 | 라이선스 키 형식이 올바르지 않습니다. **(현재 발생하지 않음 — 정의만 존재)** |
| `LICENSE-ERROR-10` | 500 | 라이선스 삭제에 실패했습니다. **(현재 발생하지 않음 — 정의만 존재)** |

</details>

<details markdown="1">
<summary><strong>Cloud Auth</strong> (2건 정의 · <strong>실제 발생 0건</strong>)</summary>

| 코드 | HTTP | 설명 |
|------|------|------|
| `CLOUD-AUTH-ERROR-01` | 400 | 파일 크기가 제한을 초과했습니다. (최대 10MB) **(현재 발생하지 않음 — 정의만 존재)** |
| `CLOUD-AUTH-ERROR-02` | 400 | 파일 업로드 중 오류가 발생했습니다. **(현재 발생하지 않음 — 정의만 존재)** |

</details>

---

