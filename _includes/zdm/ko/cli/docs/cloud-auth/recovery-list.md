
Recovery 클라우드 인증 목록을 조회하는 명령어입니다.

---

## `cloud-auth recovery-list` {#cloud-auth-recovery-list}

> * 등록된 Recovery 클라우드 인증 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth recovery-list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 전체 Recovery 인증 목록 조회
zdm-cli cloud-auth recovery-list

# 클라우드 타입으로 필터링
zdm-cli cloud-auth recovery-list --ct aws

# GCP 인증만 조회
zdm-cli cloud-auth recovery-list --ct gcp
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --display-name | -dn | string | Optional | - | 표시 이름 필터 | - |
| --cloud-type | -ct | string | Optional | - | 클라우드 타입 필터 | `aws`, `gcp` |
| --page | - | number | Optional | 1 | 페이지 번호 | - |
| --limit | - | number | Optional | 20 | 페이지당 항목 수 | - |
| --asc | - | boolean | Optional | - | 오름차순 정렬 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Recovery Auth 1]
id            : 1
displayName   : AWS Seoul
cloudType     : aws
accessKey     : AKIA****EXAMPLE
region        : ap-northeast-2
displayRegion : Asia Pacific (Seoul)

[Recovery Auth 2]
id              : 2
displayName     : GCP Tokyo
cloudType       : gcp
serviceAccount  : sa@my-project.iam.gserviceaccount.com
project         : my-project
region          : asia-northeast1
displayRegion   : Tokyo
```

</details>

---
