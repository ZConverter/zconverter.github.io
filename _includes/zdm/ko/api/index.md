
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
| **인증** | 안전한 API 접근 제어 | `POST /auth/issue` |
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
| **ZDM 센터** | 멀티 센터 환경 관리 | `GET /zdm-centers` |

---

## Base URL

```
/api
```

모든 API 엔드포인트는 위 Base URL을 기준으로 합니다.

---

## 참고사항

- 모든 API 호출에는 `POST /auth/issue`로 발급받은 인증 토큰이 필요합니다
- 요청 헤더에 `Authorization: Bearer <token>` 형식으로 토큰을 포함해야 합니다
