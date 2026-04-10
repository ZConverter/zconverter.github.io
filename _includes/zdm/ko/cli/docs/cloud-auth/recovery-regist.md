
Recovery 클라우드 인증을 등록하는 명령어입니다.

---

## `cloud-auth recovery-regist` {#cloud-auth-recovery-regist}

> * Recovery 클라우드 인증 정보를 등록합니다.
> * AWS와 GCP를 지원하며, 플랫폼에 따라 필요한 파라미터가 다릅니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth recovery-regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# AWS 인증 등록
zdm-cli cloud-auth recovery-regist --ct aws \
  --aws-access-key AKIAIOSFODNN7EXAMPLE \
  --aws-secret-key wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY \
  --aws-region us-east-1 \
  --aws-display-region "US East (N. Virginia)"

# GCP 인증 등록
zdm-cli cloud-auth recovery-regist --ct gcp \
  --gcp-service-account sa@my-project.iam.gserviceaccount.com \
  --gcp-project my-project \
  --gcp-region asia-northeast3 \
  --file /path/to/service-key.json

# 표시 이름 지정
zdm-cli cloud-auth recovery-regist --ct aws \
  --aws-access-key AKIA... --aws-secret-key ... \
  --aws-region ap-northeast-2 --aws-display-region "Asia Pacific (Seoul)" \
  --dn "AWS Seoul Production"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**공통**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | Center ID or name | - |
| --cloud-type | -ct | string | Required | - | 클라우드 타입 | `aws`, `gcp` |
| --display-name | -dn | string | Optional | 자동 생성 | 표시 이름 | - |

**AWS 전용 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --aws-access-key | - | string | Required (aws) | - | AWS Access Key |
| --aws-secret-key | - | string | Required (aws) | - | AWS Secret Key |
| --aws-region | - | string | Required (aws) | - | AWS 리전 코드 |
| --aws-display-region | - | string | Required (aws) | - | AWS 리전 표시 이름 |

**GCP 전용 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| --gcp-service-account | - | string | Required (gcp) | - | GCP 서비스 계정 이메일 |
| --gcp-project | - | string | Required (gcp) | - | GCP 프로젝트 ID |
| --gcp-region | - | string | Required (gcp) | - | GCP 리전 코드 |
| --gcp-region-sub | - | string | Optional | 자동 설정 | GCP 리전 서브존 |
| --file | -f | string | Optional | - | GCP 서비스 키 JSON 파일 |

| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> `cloud-auth region` 커맨드로 사용 가능한 리전 목록을 확인할 수 있습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Registration Result]
state       : success
id          : 1
displayName : AWS Seoul Production
cloudType   : aws
```

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "state": "success",
    "cloudInfo": {
      "id": 1,
      "displayName": "AWS Seoul Production",
      "cloudType": "aws"
    }
  }
}
```

</details>

---
