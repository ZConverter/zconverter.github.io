
저장소에 저장된 backup image **파일 목록**을 조회하는 명령어입니다.

---

## `backup image list` {#backup-image-list}

> * 저장소에 남아 있는 backup image **파일명**을 찾는 것이 목적입니다 — 찾은 파일명은 [`recovery image-regist`](/zdm/ko/cli/3.0.0/docs/recovery/image-regist) 의 `--backup-file` 값으로 그대로 사용합니다.
> * 조회 범위는 네 가지입니다 — 모든 center 의 모든 저장소, 여러 center, 특정 center(기본값은 config 의 `zdm.id`), 특정 center 의 특정 저장소.
> * **저장소마다 데몬이 직접 스캔**하므로 시간이 걸립니다. `--repository-id` 로 저장소 하나로 좁히면 왕복이 1회로 줄어 빨라집니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli backup image list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# config 기본 center(zdm.id)의 모든 저장소 조회
zdm-cli backup image list

# 모든 center 의 모든 저장소 조회
zdm-cli backup image list --all-centers

# 여러 center 의 모든 저장소 조회 (콤마 구분)
zdm-cli backup image list --center zdm-a,zdm-b

# 특정 center 의 특정 저장소만 조회 (스캔 왕복 1회 — 가장 빠름)
zdm-cli backup image list --center zdm --repository-id 9

# 특정 서버의 이미지만 필터링
zdm-cli backup image list --server web01

# 파일명만 콤마로 이어 한 줄 출력 (recovery image-regist --backup-file 값으로 바로 사용)
zdm-cli backup image list --server web01 --names-only

# Table 형식으로 출력
zdm-cli backup image list --output table

# 찾은 파일명을 그대로 image 복구 등록에 사용
zdm-cli recovery image-regist --backup-file "$(zdm-cli backup image list --server web01 --names-only)" --target t1 --platform openstack --mode full --repository-id 9
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --center | -c | string | Optional | config의 zdm.id | Center ID 또는 이름 (콤마로 구분하여 복수 지정 가능) | - |
| --all-centers | -ac | boolean | Optional | false | 모든 center 의 모든 저장소 조회 (`--center` 와 함께 사용 불가) | - |
| --repository-id | -ri | number | Optional | - | 저장소 ID (지정 시 스캔 왕복이 1회로 줄어 빠름) | - |
| --repository-type | -rt | string | Optional | - | 저장소 타입 | {% include zdm/repository-types.md %} |
| --repository-path | -rp | string | Optional | - | 저장소 경로 | - |
| --server | - | string | Optional | - | 소스 서버 (ID 또는 이름) | - |
| --job-name | -jn | string | Optional | - | Backup 작업 이름 | - |
| --partition | - | string | Optional | - | 대상 파티션 또는 드라이브 (예: `/data`, `C`, `C:`) | - |
| --names-only | -no | boolean | Optional | false | 파일명만 콤마로 이어 한 줄 출력 (`recovery image-regist --backup-file` 값으로 바로 사용 가능) | - |
| --page | - | number | Optional | - (전체 목록) | 페이지 번호 | - |
| --limit | - | number | Optional | - (전체 목록) | 페이지당 항목 수 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

> `--center` 와 `--all-centers` 는 함께 사용할 수 없습니다.<br>
> `--center` 를 입력하지 않으면 config 의 `zdm.id` 가 기본값으로 사용됩니다 (`--all-centers` 사용 시는 예외).<br>
> `--page`/`--limit` 를 모두 생략하면 페이지네이션 없이 전체 목록이 나옵니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

### 기본 출력 (Text 형식)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Image List Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-08-10 07:07:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Image 1]
image file   : localhost.localdomain_192.168.2.170_ROOT.ZIA
backup name  : localhost.localdomain_192.168.2.170_ROOT
server       : localhost.localdomain_192.168.2.170 (Rocky Linux release 9.7 ...)
partition    : /
device       : /dev/mapper/rl-root
type         : Full
size         :
  original   : 2838429696 (2.64 GB)
  compressed : 1715490005 (1.60 GB)
  ratio      : 39.56%
  level      : Default
created      : 2026-08-10 07:07:27
repository   : /zconverter_3_126 (25)
comment      : -

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> Windows 서버의 이미지는 `partition`/`device` 행 대신 `drive` 행으로 표시됩니다.<br>
> `--page`/`--limit` 를 지정한 경우 목록 끝에 `[Page 1/3] total 25 images (10 per page)` 형태의 페이지 정보가 한 줄 더 붙습니다.

### Table 형식 (`--output table`)

파일명이 길면 표 폭이 깨지므로, 표에는 파일명을 넣지 않고 표 아래 `[Files]` 목록으로 따로 뺍니다. 표의 행 번호와 `[Files]` 의 번호가 서로 대응합니다.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Image List Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: table]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-08-10 07:08:10

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

* [Backup Images]
┌─────────┬───────────────────────────────────────┬───────────┬──────┬────────────┬──────────────────────┬──────┐
│ (index) │ server                                 │ partition │ type │ size       │ created              │ repo │
├─────────┼───────────────────────────────────────┼───────────┼──────┼────────────┼──────────────────────┼──────┤
│ 1       │ localhost.localdomain_192.168.2.170    │ /         │ Full │ 1.60 GB    │ 2026-08-10 07:07:27  │ 25   │
│ 2       │ localhost.localdomain_192.168.2.170    │ /boot     │ Full │ 100.00 MB  │ 2026-08-10 07:08:03  │ 25   │
└─────────┴───────────────────────────────────────┴───────────┴──────┴────────────┴──────────────────────┴──────┘

[Files]
1: localhost.localdomain_192.168.2.170_ROOT.ZIA
2: localhost.localdomain_192.168.2.170_boot.ZIA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### `--names-only` 출력

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Backup Image List Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Success
timestamp : 2026-08-10 07:08:10

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]
localhost.localdomain_192.168.2.170_ROOT.ZIA,localhost.localdomain_192.168.2.170_boot.ZIA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> `--names-only` 는 **text/table 형식에서만 적용됩니다.** `--output json` 에서는 무시되고 전체 JSON 이 그대로 나옵니다 — JSON 에서 파일명만 뽑고 싶다면 `jq` 로 추출하세요 (예: `zdm-cli backup image list -o json | jq -r '.data[].image.name'`).

**JSON 형식 (`--output json`)**

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "Success",
  "success": true,
  "data": [
    {
      "image": {
        "name": "localhost.localdomain_192.168.2.170_ROOT.ZIA",
        "jobName": "localhost.localdomain_192.168.2.170_ROOT",
        "type": "Full",
        "size": {
          "original": { "raw": 2838429696, "formatted": "2.64 GB" },
          "compressed": { "raw": 1715490005, "formatted": "1.60 GB" }
        },
        "createdAt": "2026-08-10T07:07:27+09:00",
        "compression": {
          "level": "Default",
          "ratio": { "percent": 39.56, "formatted": "39.56%" }
        },
        "comment": null,
        "repository": {
          "id": 25,
          "path": "/zconverter_3_126"
        }
      },
      "server": {
        "name": "localhost.localdomain_192.168.2.170",
        "os": "Rocky Linux release 9.7 (Blue Onyx)"
      },
      "partition": {
        "mountPoint": "/",
        "device": "/dev/mapper/rl-root"
      }
    },
    {
      "image": {
        "name": "localhost.localdomain_192.168.2.170_boot.ZIA",
        "jobName": "localhost.localdomain_192.168.2.170_boot",
        "type": "Full",
        "size": {
          "original": { "raw": 314572800, "formatted": "300.00 MB" },
          "compressed": { "raw": 104857600, "formatted": "100.00 MB" }
        },
        "createdAt": "2026-08-10T07:08:03+09:00",
        "compression": {
          "level": "Default",
          "ratio": { "percent": 66.67, "formatted": "66.67%" }
        },
        "comment": null,
        "repository": {
          "id": 25,
          "path": "/zconverter_3_126"
        }
      },
      "server": {
        "name": "localhost.localdomain_192.168.2.170",
        "os": "Rocky Linux release 9.7 (Blue Onyx)"
      },
      "partition": {
        "mountPoint": "/boot",
        "device": "/dev/sda1"
      }
    }
  ],
  "timestamp": "2026-08-10T07:08:10.000+09:00"
}
```

> `--page`/`--limit` 를 지정하면 `data` 가 배열이 아니라 `{ data: [...], pagination: {...} }` 봉투로 옵니다.

</details>

<details markdown="1" open>
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
