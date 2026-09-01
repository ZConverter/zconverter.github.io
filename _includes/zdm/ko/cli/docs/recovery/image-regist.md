
Backup image 파일만으로 Recovery 작업을 등록합니다.

---

## `recovery image-regist` {#recovery-image-regist}

> * Source 서버를 지정하지 않고 **backup image 파일명만으로** 복구 작업을 등록합니다.
> * Source 서버가 ZDM 에서 삭제된 뒤에도 이미지가 저장소에 남아 있으면 복구할 수 있습니다.
> * 각 이미지의 원본 파티션과 소속 백업 작업은 저장소의 이미지 정보에서 자동으로 읽습니다.
> * `--backup-file` 에 넣을 파일명을 모른다면 [`backup image list`](/zdm/ko/cli/3.0.0/docs/backup/image-list) 로 먼저 조회하세요 (`--names-only` 로 조회하면 그대로 붙여넣을 수 있는 형식으로 나옵니다).

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli recovery image-regist [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 최소 등록 — 이미지 목록만 지정하면 파티션이 자동 매핑됩니다
zdm-cli recovery image-regist --backup-file "server01_ROOT_0262.ZIA,server01_boot_0262.ZIA" --target "t-rocky9_192.168.3.104" --platform oci --mode full --repository-id 9

# Center 지정
zdm-cli recovery image-regist --center ch-zdm --backup-file "server01_ROOT_0262.ZIA" --target "t-rocky9_192.168.3.104" --platform oci --mode full --repository-id 9

# 작업 이름 지정
zdm-cli recovery image-regist --backup-file "server01_ROOT_0262.ZIA" --target "t-rocky9_192.168.3.104" --platform oci --mode full --repository-id 9 --job-name "image-recovery"

# 등록 후 즉시 시작
zdm-cli recovery image-regist --backup-file "server01_ROOT_0262.ZIA" --target "t-rocky9_192.168.3.104" --platform oci --mode full --repository-id 9 --start

# 레포지토리 경로·타입까지 지정
zdm-cli recovery image-regist --backup-file "server01_ROOT_0262.ZIA" --target "t-rocky9_192.168.3.104" --platform oci --mode full --repository-id 9 --repository-type nfs --repository-path "192.168.0.10:/repo"
```

</details>

<details markdown="1" open>
<summary><strong>옵션</strong></summary>

| 옵션 | 축약 | 타입 | 필수 | 설명 |
|------|------|------|------|------|
| `--backup-file` | `-bf` | string | Required | 사용할 backup image 파일명. 여러 개는 `,` 로 구분 |
| `--target` | — | string | Required | 복구 대상 서버 |
| `--platform` | — | string | Required | 대상 서버 플랫폼 |
| `--mode` | — | string | Required | 복구 모드 (`full`, `increment`) |
| `--repository-id` | `-ri` | number | Required | 이미지가 저장된 레포지토리 ID |
| `--center` | — | string | Optional | 작업을 등록할 center (ID 또는 이름) |
| `--repository-type` | `-rt` | string | Optional | 레포지토리 타입 |
| `--repository-path` | `-rp` | string | Optional | 레포지토리 경로 |
| `--job-name` | `-jn` | string | Optional | 작업 이름. 미지정 시 자동 생성 |
| `--job-list` | `-jl` | string | Optional | 파티션별 상세 지정 (JSON) |
| `--list-only` | `-lo` | boolean | Optional | `--job-list` 에 지정한 항목만 등록 |
| `--overwrite` | — | boolean | Optional | 덮어쓰기 허용 |
| `--exclude-partition` | `-exp` | string | Optional | 제외할 파티션 |
| `--after-reboot` | `-ar` | string | Optional | 작업 후 부팅 방식 |
| `--start` | — | boolean | Optional | 등록 후 즉시 시작 |
| `--network-limit` | `-nl` | number | Optional | 네트워크 제한 속도 |
| `--schedule` / `--schedule-id` | `-sc` / `-sc-id` | string | Optional | 스케줄 지정 |
| `--schedule-file` | `-sc-f` | string | Optional | 스케줄 정의 파일 |
| `--script-path` / `--script-run` | `-sp` / `-sr` | string | Optional | 작업 전후 스크립트 |
| `--cloud-auth` | `-ca` | string | Optional | 플랫폼 인증정보 |
| `--mail-event` | `-me` | string | Optional | 작업 로그 수신 이메일 |
| `--user` | — | string | Optional | 작업 등록 사용자 |

</details>

<details markdown="1" open>
<summary><strong>파티션 매핑 규칙</strong></summary>

**하나의 대상 파티션은 같은 원본 파티션의 이미지를 최대 1장만 받습니다.**

같은 파티션을 서로 다른 시점에 백업한 이미지 두 장을 한 파티션에 함께 복구하면 나중 이미지가 앞선 것을 덮어씁니다. 등록 단계에서 거부됩니다.

원본이 다른 이미지는 서로 다른 데이터이므로 한 파티션에 함께 복구할 수 있습니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (`--output text`, 기본값)**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Image Recovery Registration Result [traceId: bc55dc1e4f152980efb580787d2a5402] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : Recovery job registration completed
timestamp : 2026-08-28T14:32:20.804+09:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Registration Summary]
total      : 1
successful : 1
failed     : 0

[Common Information]
state             : success
jobName           : api-image-cli
autoStart         : -
platform          : oci
bootMode          : Reboot

[Partition Details]

[Partition 1]
sourcePartition   : /
targetPartition   : /
jobMode           : Full Recovery
overwrite         : Not overwritten
fileSystem        : xfs
backup.useLatest  : yes
backup.backupFile : zia-source-rocky9-incretest_192.168.3.116_ROOT_final_0262.ZIA
backup.backupJob  : zia-source-rocky9-incretest_192.168.3.116_ROOT_final
repository.id     : 9
repository.path   : 192.168.3.118:/ZDMrepo
repository.type   : NFS

[Partition 2]
sourcePartition   : /boot
targetPartition   : /boot
jobMode           : Full Recovery
overwrite         : Not overwritten
fileSystem        : xfs
backup.useLatest  : yes
backup.backupFile : zia-source-rocky9-incretest_192.168.3.116_boot_final_0262.ZIA
backup.backupJob  : zia-source-rocky9-incretest_192.168.3.116_boot_final
repository.id     : 9
repository.path   : 192.168.3.118:/ZDMrepo
repository.type   : NFS

[Partition 3]
sourcePartition   : /boot/efi
targetPartition   : /boot/efi
jobMode           : Full Recovery
overwrite         : Not overwritten
fileSystem        : vfat
backup.useLatest  : yes
backup.backupFile : zia-source-rocky9-incretest_192.168.3.116_boot_efi_final_0262.ZIA
backup.backupJob  : zia-source-rocky9-incretest_192.168.3.116_boot_efi_final
repository.id     : 9
repository.path   : 192.168.3.118:/ZDMrepo
repository.type   : NFS

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> `[Registration Summary]` 의 `total` 은 **등록된 작업 수**이지 파티션 수가 아닙니다. 위 예시는 파티션 3개를 한 작업으로 등록한 결과입니다.
>
> `autoStart` 가 `-` 인 것은 `--start` 를 주지 않아 서버가 기본값을 적용했다는 뜻입니다.

**JSON 형식 (`--output json`)**

```json
{
  "traceId": "968d34f6065fd12a9e5637eeac160f8e",
  "message": "Recovery job registration completed",
  "success": true,
  "data": {
    "common": {
      "state": "success",
      "jobName": "api-image-cli",
      "platform": "oci",
      "bootMode": "Reboot"
    },
    "partitions": [
      {
        "sourcePartition": "/",
        "targetPartition": "/",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "xfs",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_ROOT_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_ROOT_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      },
      {
        "sourcePartition": "/boot",
        "targetPartition": "/boot",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "xfs",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_boot_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_boot_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      },
      {
        "sourcePartition": "/boot/efi",
        "targetPartition": "/boot/efi",
        "jobMode": "Full Recovery",
        "overwrite": "Not overwritten",
        "fileSystem": "vfat",
        "backup": {
          "useLatest": "yes",
          "backupFile": "zia-source-rocky9-incretest_192.168.3.116_boot_efi_final_0262.ZIA",
          "backupJob": "zia-source-rocky9-incretest_192.168.3.116_boot_efi_final"
        },
        "repository": {
          "id": "9",
          "path": "192.168.3.118:/ZDMrepo",
          "type": "NFS"
        }
      }
    ],
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    }
  },
  "timestamp": "2026-08-28T15:22:27.075+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>출력 형식</strong></summary>

{% include zdm/output-formats.md desc=true %}

</details>

---
