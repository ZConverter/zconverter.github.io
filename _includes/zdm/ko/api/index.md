
<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [ZDM API 소개](#zdm-api-소개)
- [주요 기능](#주요-기능)
{% if include.changelog %}- [{{ include.changelog_title }}](#변경-사항)
{% endif %}- [Base URL](#base-url)
- [참고사항](#참고사항)

</details>

---

## ZDM API 소개

ZDM-API는 백업, 복구, 시스템 관리를 위한 **API 서버**입니다.

---

## 주요 기능

<details markdown="1" open>
<summary><strong>핵심 기능</strong></summary>

- **토큰 기반 인증** - 안전한 API 접근 제어
- **사용자 관리** - 사용자 계정 및 권한 관리
- **서버 관리** - 시스템 리소스 통합 관리
- **백업/복구** - 자동화된 데이터 보호 및 복원
{% if include.version == "1.1.0" %}- **백업/복구 히스토리** - 백업 및 복구 실행 히스토리 조회 **(v1.1.0 신규)**
{% endif %}- **스케줄링** - 정기적인 백업 작업 예약
- **파일 관리** - 백업 파일 업로드/다운로드
- **라이선스 관리** - 라이선스 발급 및 할당
- **ZDM 센터** - 멀티 센터 환경 관리

</details>

{% if include.changelog %}
---

## {{ include.changelog_title }}

{{ include.changelog }}
{% endif %}

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
