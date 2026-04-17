
OS Replication 작업을 등록하는 명령어입니다.

---

## `os-replication regist` {#os-replication-regist}

> * OS Replication 작업을 신규 등록합니다.
> * Cloud Auth Key, ZOS Repository, Repository가 사전에 등록되어 있어야 합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli os-replication regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# Upload 타입 Replication 등록
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full

# Download 타입 Replication 등록 (자동 시작)
zdm-cli os-replication regist --rt download --ck 1 --zri 1 --ri 1 --mode full --start

# 폴더 이름 및 네트워크 제한 설정
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --fn my-folder --nl 1000

# 스케줄 설정과 함께 등록
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --schedule-id 1234

# 신규 파일만 업로드 설정
zdm-cli os-replication regist --rt upload --ck 1 --zri 1 --ri 1 --mode full --upload-newly newly_only
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

**필수**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --replication-type | -rt | string | Required | - | 복제 타입 | `upload`, `download` |
| --cloud-key-id | -ck | number | Required | - | 클라우드 인증 키 ID | - |
| --zos-repository-id | -zri | number | Required | - | ZOS Repository ID | - |
| --repository-id | -ri | number | Required | - | Repository ID | - |
| --mode | - | string | Required | - | 복제 모드 | `full`, `incremental` |

**선택**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config 설정값 | Center ID or name | - |
| --job-name | -jn | string | Optional | - | 작업 이름 | - |
| --repository-path | -rp | string | Optional | - | Repository 경로 | - |
| --folder-name | -fn | string | Optional | - | 폴더 이름 | - |
| --network-limit | -nl | number | Optional | 0 | 네트워크 속도 제한 (0: 무제한) | - |
| --file-filter | -ff | string | Optional | - | 파일 필터 패턴 | - |
| --start | - | boolean | Optional | - | 자동 시작 | - |

**스케줄**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --schedule | -sc | string | Optional | - | 스케줄 JSON 문자열 | - |
| --schedule-id | -sc-id | number | Optional | - | 기존 스케줄 ID | - |
| --schedule-file | -sc-f | string | Optional | - | 스케줄 JSON 파일 경로 | - |

**업로드/다운로드 옵션**

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --upload-newly | - | string | Optional | disabled | 신규 파일만 업로드 (upload 타입) | `disabled`, `newly_only` |
| --download-type | - | string | Optional | all | 다운로드 타입 (download 타입) | `all`, `folder` |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
[Registration Summary]
total      : 1
successful : 1
failed     : 0

[Job 1]
state           : success
jobName         : upload-daily
unitType        : upload
replicationMode : full
autoStart       : start
```

**JSON 형식**
```json
{
  "success": true,
  "data": {
    "results": [{
      "state": "success",
      "jobName": "upload-daily",
      "unitType": "upload",
      "replicationMode": "full",
      "autoStart": "start"
    }],
    "summary": { "total": 1, "successful": 1, "failed": 0 }
  }
}
```

</details>

---
