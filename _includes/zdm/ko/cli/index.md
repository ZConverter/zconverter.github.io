
{% if include.changelog %}
---

## {{ include.changelog_title }}

{{ include.changelog }}
{% endif %}

<details markdown="1">
<summary><strong>목차</strong></summary>

- [ZDM CLI 소개](#zdm-cli-소개)
- [주요 기능](#주요-기능)
- [참고사항](#참고사항)

</details>

---

## ZDM CLI 소개

ZDM CLI는 ZDM 서비스를 명령줄에서 관리할 수 있는 도구입니다.

---

## 주요 기능

| 기능 | 설명 | 커맨드 |
|------|------|--------|
| **인증** | API 접근을 위한 토큰 발급 및 관리 | `token issue` |
| **설정** | CLI 환경 설정 관리 | `config show`, `config set` |
| **서버** | 서버 조회 및 관리 | `server list`, `server delete` |
| **백업** | 백업 작업 등록, 조회, 수정, 삭제, 모니터링 | `backup list`, `regist`, `update`, `delete`, `monit` |
| **복구** | 복구 작업 등록, 조회, 수정, 삭제, 모니터링 | `recovery list`, `regist`, `update`, `delete`, `monit` |
{% if include.version >= "1.0.4" %}| **히스토리** | 백업/복구 실행 이력 조회 | `backup history`, `recovery history` |
{% endif %}{% if include.version >= "1.2.0" %}| **복제** | Replication 작업 등록, 조회, 수정, 삭제, 모니터링 | `replication list`, `regist`, `update`, `delete`, `monit`, `history` |
{% endif %}| **스케줄** | 정기적인 작업 스케줄 관리 | `schedule create`, `regist`, `list`, `verify` |
| **파일** | 파일 업로드 및 다운로드 | `file list`, `upload`, `download` |
| **라이선스** | 라이선스 등록 및 할당 | `license list`, `regist`, `assign` |
| **ZDM 센터** | ZDM 센터 조회 및 관리 | `zdm list` |

---

## 참고사항

- 모든 커맨드는 사전에 `token issue`로 인증 토큰을 발급받아야 사용 가능합니다
- `--output` 옵션으로 결과 출력 형식을 변경할 수 있습니다 (`text`, `json`, `table`)
- 기본 설정값은 `config set` 명령으로 미리 설정하면 매번 입력할 필요가 없습니다
