
ZOS 클라우드 인증을 등록하는 명령어입니다.

---

## `cloud-auth zos-regist` {#cloud-auth-zos-regist}

> * ZOS 클라우드 인증 키 파일을 업로드하고 등록합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth zos-regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# AWS 인증 키 등록
zdm-cli cloud-auth zos-regist --cp aws --file /path/to/key.json

# OCI 인증 키 등록 (표시 이름 지정)
zdm-cli cloud-auth zos-regist --cp oci --file /path/to/key.pem --dn "OCI Production"

# MinIO 인증 키 등록
zdm-cli cloud-auth zos-regist --cp minio --file /path/to/credentials.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | Center ID or name | - |
| --cloud-platform | -cp | string | Required | - | 클라우드 플랫폼 | `oci`, `nhn`, `ncp`, `aws`, `azure`, `minio` |
| --display-name | -dn | string | Optional | 자동 생성 | 표시 이름 | - |
| --file | -f | string | Required | - | 인증 키 파일 경로 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Registration Result]
state         : success
id            : 1
displayName   : AWS Production Key
cloudPlatform : aws
fileName      : aws-key.json
filePath      : /cloud-auth/zos/aws-key.json
```

</details>

---
