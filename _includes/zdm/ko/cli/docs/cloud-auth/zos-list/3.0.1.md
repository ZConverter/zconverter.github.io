
ZOS 클라우드 인증 목록을 조회하는 명령어입니다.

---

## `cloud-auth zos-list` {#cloud-auth-zos-list}

> * 등록된 ZOS 클라우드 인증 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth zos-list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 ZOS 인증 목록 조회
zdm-cli cloud-auth zos-list

# 플랫폼으로 필터링
zdm-cli cloud-auth zos-list --cp aws

# 표시 이름으로 필터링
zdm-cli cloud-auth zos-list --dn "Production"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | - | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --display-name | -dn | string | Optional | - | 표시 이름 필터 | - |
| --cloud-platform | -cp | string | Optional | - | 클라우드 플랫폼 필터 | `oci`, `nhn`, `ncp`, `aws`, `azure`, `minio` |
| --page | - | number | Optional | 1 | 페이지 번호 | - |
| --limit | - | number | Optional | 20 | 페이지당 항목 수 | - |
| --asc | - | boolean | Optional | false | 오름차순 정렬 (기본값: 내림차순) | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[ZOS Auth 1]
id            : 1
displayName   : AWS Production Key
cloudPlatform : aws
fileName      : aws-key.json
filePath      : /cloud-auth/zos/aws-key.json
createDate    : 2026-04-10 10:00:00
```

**JSON 형식**
```json
{
  "success": true,
  "data": [{
    "id": 1,
    "displayName": "AWS Production Key",
    "cloudPlatform": "aws",
    "fileName": "aws-key.json",
    "filePath": "/cloud-auth/zos/aws-key.json",
    "createDate": "2026-04-10 10:00:00"
  }]
}
```

</details>

---
