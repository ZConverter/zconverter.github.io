
{% if include.changelog %}
---

## {{ include.changelog_title }}

{{ include.changelog }}
{% endif %}

<details markdown="1">
<summary><strong>목차</strong></summary>

- [ZDM API 소개](#zdm-api-소개)
- [주요 기능](#주요-기능)
- [Base URL](#base-url)
- [참고사항](#참고사항)

</details>

---

## ZDM API 소개

ZDM-API는 백업, 복구, 시스템 관리를 위한 **API 서버**입니다.

---

## 주요 기능

| 기능 | 설명 | 엔드포인트 |
|------|------|------------|
| **인증** | 안전한 API 접근 제어 | {% if include.version >= "2.0.0" %}`POST /token/issue`{% else %}`POST /auth/issue`{% endif %} |
| **사용자** | 사용자 계정 및 권한 관리 | `GET /users`, `PUT /users/:id` |
| **서버** | 시스템 리소스 통합 관리 | `GET /servers`, `DELETE /servers/:id` |
| **백업** | 자동화된 데이터 보호 | `GET /backups`, `POST /backups`, `PUT`, `DELETE` |
| **복구** | 데이터 복원 | `GET /recoveries`, `POST /recoveries`, `PUT`, `DELETE` |
{% if include.version >= "1.1.0" %}| **히스토리** | 백업/복구 실행 이력 조회 | `GET /backups/histories`, `GET /recoveries/histories` |
{% endif %}{% if include.version >= "1.2.0" %}| **복제** | Replication 작업 관리 | `GET /replications`, `POST`, `PUT`, `DELETE` |
{% endif %}{% if include.version >= "1.3.0" %}| **Cloud 인증** | 클라우드 인증 관리 (ZOS, Recovery) | `POST /cloud-auth/*`, `GET`, `DELETE` |
| **OS 복제** | OS 복제 작업 관리 | `POST /os-replications`, `GET`, `PUT`, `DELETE` |
{% endif %}| **스케줄** | 정기적인 백업 작업 예약 | `GET /schedules`, `POST /schedules` |
| **파일** | 백업 파일 업로드/다운로드 | `POST /files/upload`, `GET /files/download` |
| **라이선스** | 라이선스 발급 및 할당 | `GET /licenses`, `POST /licenses`, `PUT /licenses/assign` |
| **ZDM 센터** | 멀티 센터 환경 관리 | `GET /zdms` |

---

## Base URL

```
/api
```

모든 API 엔드포인트는 위 Base URL을 기준으로 합니다.

---

## 참고사항

- 모든 API 호출에는 {% if include.version >= "2.0.0" %}`POST /token/issue`{% else %}`POST /auth/issue`{% endif %}로 발급받은 인증 토큰이 필요합니다
- 요청 헤더에 `Authorization: Bearer <token>` 형식으로 토큰을 포함해야 합니다
{% if include.version >= "3.0.0" %}
- **조회(query) 파라미터는 선언된 이름만 허용됩니다 (3.0.0 변경).** 오타이거나 제거된 파라미터를 보내면
  조용히 무시되지 않고 `DTO-VALIDATION-03` (400) 으로 거절되며, `details` 에 문제 파라미터 이름이 담깁니다.
  종전에는 미지의 키가 버려져 **필터가 빠진 더 넓은 결과가 200 으로** 나갔습니다
- **열거형 query 값은 대소문자를 구분하지 않습니다 (3.0.0 변경).** 조회·모니터링의 `status` / `mode` /
  `platform` / `repositoryType` / `serverType` 이 해당합니다. 응답에 실린 `Processing` 을 그대로 필터로
  되돌려 보내도 통과합니다 — 종전에는 응답값을 그대로 쓰면 400 이었습니다
{% endif %}
