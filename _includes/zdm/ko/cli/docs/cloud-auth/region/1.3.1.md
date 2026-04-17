
클라우드 플랫폼별 사용 가능한 리전 목록을 조회하는 명령어입니다.

---

## `cloud-auth region` {#cloud-auth-region}

> * AWS 또는 GCP의 사용 가능한 리전 목록을 조회합니다.
> * `recovery-regist` 시 리전 코드를 확인하는 데 활용합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth region [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# AWS 리전 목록 조회
zdm-cli cloud-auth region --platform aws

# GCP 리전 목록 조회
zdm-cli cloud-auth region -p gcp

# JSON 형식으로 출력
zdm-cli cloud-auth region -p aws --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --platform | -p | string | Required | - | 클라우드 플랫폼 | `aws`, `gcp` |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값) — AWS**
```text
us-east-1      — US East (N. Virginia)
us-west-2      — US West (Oregon)
ap-northeast-2 — Asia Pacific (Seoul)
eu-west-1      — Europe (Ireland)
```

**Text 형식 — GCP**
```text
asia-northeast3 — Seoul (zones: asia-northeast3-a, asia-northeast3-b, asia-northeast3-c)
us-central1     — Iowa (zones: us-central1-a, us-central1-b, us-central1-c, us-central1-f)
europe-west1    — Belgium (zones: europe-west1-b, europe-west1-c, europe-west1-d)
```

**JSON 형식 — AWS**
```json
{
  "success": true,
  "data": [
    { "code": "us-east-1", "name": "US East (N. Virginia)" },
    { "code": "ap-northeast-2", "name": "Asia Pacific (Seoul)" }
  ]
}
```

**JSON 형식 — GCP**
```json
{
  "success": true,
  "data": [
    {
      "code": "asia-northeast3",
      "name": "Seoul",
      "zones": ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
    }
  ]
}
```

</details>

---
