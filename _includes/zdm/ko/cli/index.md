
<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [ZDM CLI 소개](#zdm-cli-소개)
- [주요 기능](#주요-기능)
{% if include.changelog %}- [{{ include.changelog_title }}](#변경-사항)
{% endif %}- [공통 옵션](#공통-옵션)
- [참고사항](#참고사항)

</details>

---

## ZDM CLI 소개

ZDM CLI는 ZDM 서비스를 명령줄에서 관리할 수 있는 도구입니다.

---

## 주요 기능

<details markdown="1" open>
<summary><strong>핵심 기능</strong></summary>

- **토큰 기반 인증** - API 접근을 위한 토큰 발급 및 관리
- **설정 관리** - CLI 환경 설정 관리
- **서버 관리** - 서버 조회 및 관리
- **백업/복구** - 백업 및 복구 작업 등록, 조회, 수정, 삭제
{% if include.version == "1.0.4" %}- **백업/복구 히스토리** - 백업 및 복구 실행 히스토리 조회 **(v1.0.4 신규)**
{% endif %}- **스케줄링** - 정기적인 작업 스케줄 관리
- **파일 관리** - 파일 업로드 및 다운로드
- **라이선스 관리** - 라이선스 등록 및 할당
- **ZDM 센터 관리** - ZDM 센터 조회 및 관리
- **모니터링** - 작업 진행 상황 실시간 모니터링

</details>

{% if include.changelog %}
---

## {{ include.changelog_title }}

{{ include.changelog }}
{% endif %}

---

## 공통 옵션

모든 커맨드에서 사용 가능한 공통 옵션입니다.

<details markdown="1" open>
<summary><strong>출력 형식 옵션</strong></summary>

| 옵션 | 별칭 | 타입 | 설명 | 선택값 |
|------|------|------|------|--------|
| `--output` | `-o` | string | 출력 형식 지정 | `text`, `json`, `table` |

**사용 예시:**

```bash
# JSON 형식으로 출력
zdm-cli server list --output json

# 테이블 형식으로 출력
zdm-cli backup list --output table

# 텍스트 형식으로 출력 (기본값)
zdm-cli license list
```

</details>

---

## 참고사항

- 모든 커맨드는 사전에 `token issue`로 인증 토큰을 발급받아야 사용 가능합니다
- `--output` 옵션으로 결과 출력 형식을 변경할 수 있습니다
- 기본 설정값은 `config set` 명령으로 미리 설정하면 매번 입력할 필요가 없습니다
- JSON 문자열 파라미터는 작은따옴표로 감싸서 입력합니다
- 스크립트 파일은 사전에 ZDM 서버에 업로드되어 있어야 합니다
