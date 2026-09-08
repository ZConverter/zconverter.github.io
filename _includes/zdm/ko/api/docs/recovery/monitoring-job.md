특정 복구 작업의 진행 상황을 조회합니다.

---

## `GET /recoveries/monitoring/job/:identifier` {#get-recoveries-monitoring-job}

> * 복구 작업 ID 또는 복구 작업 이름으로, **작업 하나**의 현재 상태를 조회합니다.
> * 목록에서 작업을 선택했을 때 쓰는 **드릴다운 엔드포인트**입니다.
> * 작업 단위 진행 상태와 **파티션/드라이브별 진행률**이 함께 `job.progress` 에 담깁니다. **파티션별 진행률은 기본 응답에 있습니다** — `detail` 이 필요하지 않습니다.
> * `detail=true` 는 파티션 **메타데이터**(`targetDisk` · `size` · `mode` · `diskNumber` · `overwrite`)와 **작업 로그**를 더합니다. **로그는 이 경로에서만 제공됩니다.**

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/monitoring/job/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 복구 작업 ID로 조회 (파티션별 진행률 포함)
curl -X GET "https://api.example.com/api/recoveries/monitoring/job/12" \
  -H "Authorization: Bearer <token>"

# 복구 작업 이름으로 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/job/daily-recovery" \
  -H "Authorization: Bearer <token>"

# 파티션 메타데이터 + 작업 로그까지 포함해 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/job/daily-recovery?detail=true" \
  -H "Authorization: Bearer <token>"

# 특정 파티션만 남겨 조회 (detail 없이도 그 파티션의 진행률이 나옵니다)
curl -X GET "https://api.example.com/api/recoveries/monitoring/job/daily-recovery?partition=/home" \
  -H "Authorization: Bearer <token>"

# 다중 센터 범위 지정 (comma-separated; ID 또는 이름 혼용 가능)
curl -X GET "https://api.example.com/api/recoveries/monitoring/job/daily-recovery?center=1,zdm-b" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 복구 작업 ID (숫자) 또는 복구 작업 이름 | - |
| `detail` | Query | boolean | Optional | `false` | 파티션 **메타데이터**(`targetDisk` · `size` · `mode` · `diskNumber` · `overwrite`)와 작업 로그(`log`) 포함 여부. **파티션별 진행률은 이 값과 무관하게 항상 담깁니다** | `true`, `false` |
| `mode` | Query | string | Optional | - | 복구 방식으로 `progress.partitions[]` 를 좁힙니다 | {% include zdm/job-modes.md %} |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`drive`와 동시 지정 불가). `progress.partitions[]` 를 좁힙니다 | - |
| `drive` | Query | string | Optional | - | `partition`과 같은 대상을 가리키는 별칭 (둘 중 하나만 사용) | - |
| `center` | Query | string | Optional | - | center 식별자 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |

> **참고:**
> - `partition` / `drive` / `mode` 는 **`progress.partitions[]` 행만 좁히는 필터**입니다. 이 배열은 기본 응답에도 있으므로 **`detail` 없이도 필터 효과가 그대로 보입니다.** 경로 `identifier` 가 이미 작업 하나를 지목했으므로 **작업 자체가 감춰지지는 않습니다** — 조건에 맞는 행이 하나도 없으면 `progress.partitions: []`(빈 배열)로 응답합니다. **404가 아닙니다.**
> - **필터와 `detail` 은 서로 다른 것을 정합니다.** 필터는 **어떤 행을 실을지**, `detail` 은 **각 행에 어떤 필드를 실을지**(그리고 `log` 를 실을지)를 정합니다. `progress.partitions` 키는 `detail` 값과 무관하게 **항상 있습니다**. `detail=false` 에서 키 자체가 사라지는 것은 `log` 와 파티션 메타데이터 필드뿐입니다.
> - `mode` 는 **기본 응답에 실리지 않는 필드로 거릅니다.** `detail` 없이 `?mode=` 를 지정하면 행이 줄어든 근거가 응답에 드러나지 않습니다. 걸러진 이유까지 확인하려면 `detail=true` 로 함께 조회하세요.
> - 서버 기준 조회(`/monitoring/system/:server`)에서는 같은 필터가 다르게 작동합니다. 그쪽은 "조건에 맞는 작업 목록" 이므로 일치하는 행이 없는 작업은 `job` 배열에서 **제외**됩니다. 이 비대칭은 의도된 것입니다.
> - `partition`과 `drive`는 **같은 대상을 가리키는 하나의 필터**입니다. 두 파라미터를 함께 지정하면 400으로 거부됩니다.
> - 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`를 모두 그대로 쓸 수 있습니다. **OS에 따라 골라 쓸 필요 없이 하나만 사용**하면 됩니다.
> - `?center=`, `?partition=`처럼 **키만 보내고 값이 비어 있으면 400**입니다. 파라미터를 아예 **생략**하는 것(필터 없음)과는 다릅니다. 단 `detail` 은 예외로, `?detail` 처럼 값 없이 보내면 `true`로 해석됩니다.
> - `center`를 지정하면 **그 범위 밖의 작업은 존재하지 않는 것으로 취급**되어 404가 반환됩니다.
> - **제거된 파라미터**: `server`, `serverType`, `jobName`, `status`, `sort`. 경로 `identifier` 로 작업을 이미 지목했으므로 작업을 다시 고르는 필터는 성립하지 않습니다. 상태는 응답의 `job.progress.status` 를 그대로 읽으면 됩니다. 페이지네이션(`page`·`limit`)도 나눌 대상이 없어 받지 않습니다. 이 값들은 **더 이상 받지 않습니다** — 요청에 실으면 `400` (`DTO-VALIDATION-03`) 이고, `error.details` 에 해당 파라미터 이름이 담깁니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - <code>detail</code> 미지정</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "job": {
      "info": {
        "id": 12,
        "name": "daily-recovery",
        "source": "source-server",
        "target": "target-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "45%",
        "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
        "partitions": [
          {
            "partition": "/",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed.",
            "timeInfo": {
              "start": "2025-01-15 10:30:05",
              "elapsed": "00:06:20",
              "end": "2025-01-15 10:36:25"
            }
          },
          {
            "partition": "/home",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "status": "Processing",
            "percent": "62%",
            "message": "Processed Size: 5.680 MB | Speed: 36.83 MB/s",
            "timeInfo": {
              "start": "2025-01-15 10:36:30",
              "elapsed": "00:08:30",
              "end": "-"
            }
          },
          {
            "partition": "/home",
            "backupFile": "weekly-backup_20250112_030000.ZIA",
            "status": "Registered",
            "percent": "-",
            "message": "-",
            "timeInfo": {
              "start": "-",
              "elapsed": "-",
              "end": "-"
            }
          }
        ]
      },
      "timeInfo": {
        "start": "2025-01-15 10:30:00",
        "elapsed": "00:15:00",
        "end": "-"
      }
    }
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> **파티션별 진행률은 이 기본 응답에 이미 들어 있습니다.** 진행률만 필요한 폴링 클라이언트는 `detail` 을 지정할 이유가 없습니다.
>
> 위 예시에서 `/home` 이 두 번 나타납니다. `partitions[]` 의 한 행은 **(파티션, 백업 작업, 백업 이미지) 조합**이므로, 같은 파티션이 서로 다른 이미지로 여러 번 실릴 수 있습니다. **`backupFile` 이 그 중복을 구분하는 값**입니다 — 파티션 이름만으로 행을 식별하지 마세요.
>
> **행마다 진행 상태가 다릅니다.** 위 예시는 `/` 가 이미 끝났고, `/home`(daily 이미지)이 복구 중이며, `/home`(weekly 이미지)은 **아직 시작하지 않은** 상태입니다. 복구는 파티션을 하나씩 처리하므로 한 작업 안에서 이런 차이가 나는 것이 정상입니다. 아직 시작하지 않은 행은 `status` 가 `"Registered"` 이고 `percent` · `message` · `timeInfo` 가 모두 `"-"` 입니다.
>
> **작업 단위 `progress.message` 와 파티션 `message` 의 형태가 다릅니다.** 작업 단위는 데몬이 기록한 원문 그대로라 `[source-server_home]` 같은 **작업명 접두어**가 붙고, 파티션 행의 `message` 는 그 접두어를 **뗀** 형태입니다. 파티션 객체 안에서는 작업명이 중복이기 때문입니다.
>
> **작업 단위 `percent`(위 예시의 `"45%"`)를 `partitions[]` 로 계산하지 마세요.** 이 값은 데몬이 세어 둔 복구 완료 개수에서 나옵니다. 위 예시는 3행 중 1행이 완료(33%)인데 작업 진행률이 `"45%"` 이며, 이는 오류가 아닙니다 — 두 값의 출처가 다릅니다.

</details>

<details markdown="1">
<summary>Linux 서버 - 메타데이터 + 로그 (200 OK) - <code>detail=true</code></summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "job": {
      "info": {
        "id": 12,
        "name": "daily-recovery",
        "source": "source-server",
        "target": "target-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "45%",
        "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
        "partitions": [
          {
            "partition": "/",
            "targetDisk": "/dev/sda1",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "size": 51200,
            "mode": "Full Recovery",
            "overwrite": "Overwritten",
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed.",
            "timeInfo": {
              "start": "2025-01-15 10:30:05",
              "elapsed": "00:06:20",
              "end": "2025-01-15 10:36:25"
            }
          },
          {
            "partition": "/home",
            "targetDisk": "/dev/sda2",
            "backupFile": "daily-backup_20250114_020000.ZIA",
            "size": 102400,
            "mode": "Full Recovery",
            "overwrite": "Not overwritten",
            "status": "Processing",
            "percent": "62%",
            "message": "Processed Size: 5.680 MB | Speed: 36.83 MB/s",
            "timeInfo": {
              "start": "2025-01-15 10:36:30",
              "elapsed": "00:08:30",
              "end": "-"
            }
          },
          {
            "partition": "/home",
            "targetDisk": "/dev/sda2",
            "backupFile": "weekly-backup_20250112_030000.ZIA",
            "size": 102400,
            "mode": "Incremental Recovery",
            "overwrite": "Not overwritten",
            "status": "Registered",
            "percent": "-",
            "message": "-",
            "timeInfo": {
              "start": "-",
              "elapsed": "-",
              "end": "-"
            }
          }
        ]
      },
      "timeInfo": {
        "start": "2025-01-15 10:30:00",
        "elapsed": "00:15:00",
        "end": "-"
      },
      "log": [
        "[2025-01-15 10:30:00]Recovery job started.",
        "[2025-01-15 10:30:12]Mounting repository.",
        "[2025-01-15 10:31:05]Restoring partition /"
      ]
    }
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> 기본 응답과 **행의 개수와 진행 값은 같습니다.** `detail=true` 가 더한 것은 각 행의 `targetDisk` · `size` · `mode` · `overwrite`(Linux) 와 작업 단위 `log` 뿐입니다.
>
> 이 메타데이터는 폴링 중에 바뀌지 않는 값이므로 매 호출마다 실어 보낼 이유가 없습니다. 상세 화면 진입 시 1회만 `detail=true` 로 받고, 이후 갱신은 기본 응답으로 하세요.

</details>

<details markdown="1">
<summary>Windows 서버 - 메타데이터 + 로그 (200 OK) - <code>detail=true</code></summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "job": {
      "info": {
        "id": 21,
        "name": "daily-recovery-win",
        "source": "source-win-server",
        "target": "target-win-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "60%",
        "message": "[source-win-server_D] 38%, Processed Size: 12.400 MB | Speed: 41.05 MB/s",
        "partitions": [
          {
            "drive": "C:",
            "targetDisk": "0",
            "diskNumber": 0,
            "backupFile": "daily-backup-win_20250114_020000.ZIA",
            "size": 128000,
            "mode": "Full Recovery",
            "status": "Complete",
            "percent": "100%",
            "message": "Recovery completed.",
            "timeInfo": {
              "start": "2025-01-15 10:00:10",
              "elapsed": "00:12:40",
              "end": "2025-01-15 10:12:50"
            }
          },
          {
            "drive": "D:",
            "targetDisk": "1",
            "diskNumber": 1,
            "backupFile": "daily-backup-win_20250114_020000.ZIA",
            "size": 204800,
            "mode": "Incremental Recovery",
            "status": "Processing",
            "percent": "38%",
            "message": "Processed Size: 12.400 MB | Speed: 41.05 MB/s",
            "timeInfo": {
              "start": "2025-01-15 10:12:55",
              "elapsed": "00:07:05",
              "end": "-"
            }
          }
        ]
      },
      "timeInfo": {
        "start": "2025-01-15 10:00:00",
        "elapsed": "00:20:00",
        "end": "-"
      },
      "log": [
        "[2025-01-15 10:00:00]Recovery job started.",
        "[2025-01-15 10:00:31]Preparing target disk 0.",
        "[2025-01-15 10:02:44]Restoring drive C:"
      ]
    }
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> **Windows 응답은 `partition` 대신 `drive` 키를 씁니다.** 키 이름 자체가 갈리므로 두 이름을 모두 확인하는 코드가 필요합니다. `diskNumber` 는 Windows 에만, `overwrite` 는 Linux 에만 실리며 둘 다 `detail=true` 에서만 나옵니다.

</details>

<details markdown="1">
<summary>필터에 맞는 파티션 없음 (200 OK) - 404가 아닙니다</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "job": {
      "info": {
        "id": 12,
        "name": "daily-recovery",
        "source": "source-server",
        "target": "target-server"
      },
      "progress": {
        "status": "Processing",
        "percent": "45%",
        "message": "[source-server_home] 62%, Processed Size: 5.680 MB | Speed: 36.83 MB/s",
        "partitions": []
      },
      "timeInfo": {
        "start": "2025-01-15 10:30:00",
        "elapsed": "00:15:00",
        "end": "-"
      }
    }
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> 작업은 실제로 존재하므로 **200 + 빈 `progress.partitions`** 로 응답합니다. 404는 **작업 자체가 없을 때만** 반환됩니다.
>
> 이 응답은 `detail` 없이도 나옵니다 — 필터가 `progress.partitions[]` 를 비운 결과이며, `partitions` 키가 사라지는 것이 아니라 **빈 배열**입니다.

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

`job` 원소의 구조는 서버 기준 조회(`/monitoring/system/:server`)의 `job[]` 원소와 **동일**합니다. 다른 점은 이 경로가 원소 **하나**를 반환하고, `log` 를 제공하며, `info.role` 이 없다는 것뿐입니다.

```
job
├─ info      { id, name, source, target }
├─ progress  { status, percent, message, partitions[] }   ← partitions[] 는 기본 응답에도 있습니다
├─ timeInfo  { start, elapsed, end }
└─ log[]                                                  ← detail=true 에서만
```

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `job.info.id` | number | 항상 | 복구 작업 ID |
| `job.info.name` | string | 항상 | 복구 작업 이름 |
| `job.info.source` | string | 항상 | 복구 이미지를 제공한 원본 서버 이름 |
| `job.info.target` | string | 항상 | 복구가 이뤄지는 대상 서버 이름 |
| `job.progress.status` | string | 항상 | 계산된 작업 상태 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`). **작업 본체가 정합니다** — `partitions[]` 행이 종료 단계에 들어가도 본체가 아직 진행 중이면 `Processing` 입니다 |
| `job.progress.percent` | string | 항상 | 작업 단위 진행률 표기. 아래 **작업 단위 `percent` 표기 규칙** 참고 |
| `job.progress.message` | string | 항상 | 현재 진행 메시지. 데몬이 기록한 **원문 그대로**이며 `[source-server_home]` 같은 작업명 접두어가 붙습니다. 진행 정보가 없으면 `"-"` |
| `job.progress.partitions` | array | 항상 | 파티션/드라이브별 진행. **`detail` 과 무관하게 항상 실립니다.** 조건에 맞는 행이 없으면 빈 배열 |
| `job.progress.partitions[].partition` | string | Linux | 복구 대상 파티션. Windows 응답에는 이 키가 없습니다 |
| `job.progress.partitions[].drive` | string | Windows | 복구 대상 드라이브. Linux 응답에는 이 키가 없습니다 |
| `job.progress.partitions[].backupFile` | string | 항상 | 복구에 사용하는 백업 이미지 파일 이름. **같은 파티션이 여러 행으로 나타날 때 그 행들을 구분하는 값**입니다 |
| `job.progress.partitions[].status` | string | 항상 | **그 파티션의** 계산 상태. 값 어휘는 `job.progress.status` 와 같습니다. 판정 규칙은 아래 참고 |
| `job.progress.partitions[].percent` | string | 항상 | **그 파티션의** 진행률. 표기 규칙은 아래 참고 |
| `job.progress.partitions[].message` | string | 항상 | **그 파티션의** 진행 메시지. **작업명 접두어(`[...] `)가 제거된 형태**입니다 — 작업 단위 `progress.message` 와 원문이 같아도 앞의 대괄호 부분이 없습니다. 그 파티션의 진행 정보가 없으면 `"-"` |
| `job.progress.partitions[].timeInfo.start` | string | 항상 | 그 파티션의 시작 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job.progress.partitions[].timeInfo.elapsed` | string | 항상 | 그 파티션의 경과 시간. 값이 없으면 `"-"` |
| `job.progress.partitions[].timeInfo.end` | string | 항상 | 그 파티션의 종료 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job.progress.partitions[].targetDisk` | string | `detail=true` | 복구 대상 디스크 경로 또는 ID |
| `job.progress.partitions[].size` | number | `detail=true` | 복구 대상 디스크 크기 (신규 디스크 생성 시 사용) |
| `job.progress.partitions[].mode` | string | `detail=true` | 복구 방식 표시 문자열 — `Full Recovery`, `Incremental Recovery`, `Unknown` |
| `job.progress.partitions[].diskNumber` | number | `detail=true` · Windows | 복구 대상 디스크 번호. Linux 응답에는 이 키가 없습니다 |
| `job.progress.partitions[].overwrite` | string | `detail=true` · Linux | 파티션 덮어쓰기 상태 — `Overwritten`, `Not overwritten`. Windows 응답에는 이 키가 없습니다 |
| `job.timeInfo.start` | string | 항상 | 시작 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job.timeInfo.elapsed` | string | 항상 | 경과 시간. 값이 없으면 `"-"` |
| `job.timeInfo.end` | string | 항상 | 종료 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job.log` | string[] | `detail=true` | 가장 최근 실행분의 로그. `[시각]메시지` 형식이며 오래된 것부터 정렬됩니다. 로그가 없으면 빈 배열. `detail=false` 면 **키 자체가 없습니다** |

**기본 응답과 `detail=true` 의 경계** — `detail` 은 행을 고르는 값이 아니라 **각 행에 실릴 필드**와 **`log` 의 유무**를 정합니다.

| | 기본 응답 | `detail=true` |
|---|---|---|
| `job.info` · `job.progress.status` · `percent` · `message` · `job.timeInfo` | O | O |
| `progress.partitions[]` 배열 자체 | O | O |
| 행의 `partition` / `drive` · `backupFile` | O | O |
| 행의 `status` · `percent` · `message` · `timeInfo` | O | O |
| 행의 `targetDisk` · `size` · `mode` | - | O |
| 행의 `diskNumber` (Windows) · `overwrite` (Linux) | - | O |
| `job.log` | - | O (이 경로 전용) |

**`partitions[]` 는 파티션마다 다른 값을 냅니다.** 각 행의 `status` · `percent` · `message` · `timeInfo` 는 **그 파티션의 실제 진행**이며, 작업 단위 값을 행마다 복사한 것이 아닙니다. 복구는 파티션을 하나씩 처리하므로 한 작업 안에서 끝난 파티션과 아직 시작하지 않은 파티션이 함께 나오는 것이 정상입니다. **반대로 행이 전부 `Complete` 라고 해서 그것만으로 작업이 끝난 것은 아닙니다** — 행의 종료는 **그 파티션의 복사**가 끝났다는 뜻이고, 복구는 그 뒤에 재부팅 같은 후속 단계가 남습니다. 작업 단위 상태는 작업 본체가 정하므로, 본체가 아직 진행 중이라고 말하면 이때도 `Processing` 입니다.

**작업 단위 `percent` 표기 규칙** — 두 모니터링 경로가 같은 규칙을 씁니다.

| 상황 | 값 |
|------|-----|
| 데몬이 센 복구 완료 개수가 있음 | `"45%"` — 완료 개수를 전체 개수로 나눈 값 (반올림, 최대 `"100%"`) |
| 그 값이 없고 진행 정보의 진행률이 유효함 | `"60%"` |
| 그 값이 없고 진행 정보는 있으나 진행률 값이 비어 있음 | `"-"` |
| 그 값도 진행 정보도 없고 상태가 `Complete` | `"100%"` |
| 그 외 | `"-"` |

> **`job.progress.percent` 의 출처는 데몬이 세어 둔 복구 완료 개수입니다.** 응답의 `partitions[]` 로는 재현되지 않습니다 — 행의 진행률을 평균 내거나 완료된 행 수를 세지 마세요. 데몬이 세는 단위가 `partitions[]` 행과 1:1 이라는 보장이 없어 값이 어긋납니다. 표시할 값은 응답의 `percent` 를 그대로 쓰세요.
>
> **`percent` 가 `"100%"` 인데 `status` 가 `Processing` 인 것은 모순이 아닙니다.** 진행률은 복사가 어디까지 갔는지를 말하고, 상태는 작업 본체가 말합니다 — 복사가 다 끝나도 재부팅 같은 후속 단계가 남아 있으면 작업은 아직 진행 중입니다. `percent` 가 `"100%"` 가 됐다고 완료로 표시하지 마세요. **완료 판정은 `status` 로만 하세요.**

**`partitions[].status` 판정 규칙** — 파티션마다 따로 계산합니다.

| 상황 | 값 |
|------|-----|
| 그 파티션의 진행 정보가 있음 | 그 진행 정보로 계산한 상태 (`Preparing`, `Processing`, `Complete`, `Scheduled`, `Canceling`, `Canceled`, `Error`) |
| 그 파티션의 진행 정보는 없고 작업의 다른 파티션에는 있음 | `"Registered"` — **아직 시작하지 않은 파티션**입니다 |
| 작업 전체에 진행 정보가 하나도 없음 | `job.progress.status` 와 같은 값 (파티션을 가를 근거가 없는 경우) |

**`partitions[].percent` 표기 규칙** — 작업 단위와 같은 표기를 쓰되 **그 파티션의** 진행 정보로 판단합니다.

| 상황 | 값 |
|------|-----|
| 그 파티션의 진행 정보가 있고 진행률 값이 유효함 | `"62%"` |
| 그 파티션의 진행 정보가 있으나 진행률 값이 비어 있음 | `"-"` |
| 그 파티션의 진행 정보가 없고 그 행의 `status` 가 `Complete` | `"100%"` |
| 그 외 (아직 시작하지 않은 파티션 포함) | `"-"` |

> 아직 시작하지 않은 파티션은 `status: "Registered"` · `percent: "-"` · `message: "-"` 이고 `timeInfo` 의 세 값이 모두 `"-"` 입니다. **진행률 `0%` 로 표기되지 않습니다** — 시작하지 않은 것과 시작해서 0% 인 것은 다릅니다.
>
> 진행 정보가 모두 정리된 뒤 완료된 작업을 조회하면 모든 행이 `status: "Complete"` · `percent: "100%"` 이면서 `message` 와 `timeInfo` 는 `"-"` 로 나옵니다. 그 행에 남아 있는 진행 정보가 없기 때문이며 모순이 아닙니다.

> `job.info.role` 은 이 경로에 없습니다. 조회 기준 서버가 정해져야 역할을 판정할 수 있으므로 **서버 기준 조회에서만** 실립니다.
>
> `mode` 와 `overwrite` 는 **표시용 문자열**입니다. 요청의 `?mode=` 는 `full` / `increment` 를 받지만 응답은 그 값을 그대로 되돌려주지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Token expired."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**작업을 찾을 수 없음 (404 Not Found)**

경로의 `identifier` 에 해당하는 복구 작업이 없는 경우 반환됩니다. `center` 를 지정했고 그 범위에서 작업을 찾지 못한 경우도 **같은 응답**입니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "JOB-ERROR-01",
    "message": "Recovery job with Name 'daily-recovery' not found."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

> **이 경로에서 404가 나오는 경우는 이것뿐입니다.** 필터 조건에 맞는 파티션이 없는 것은 200 + 빈 `progress.partitions` 입니다.

**작업 정보 행 결손 (500 Internal Server Error)**

작업은 존재하지만 짝이 되는 작업 정보 행을 찾지 못한 경우 반환됩니다. 필터 불일치가 아니라 데이터 결손이므로 재시도해도 해소되지 않습니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "JOB-ERROR-16",
    "message": "Recovery job 'daily-recovery' exists, but its job information row is missing."
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

`partition`과 `drive`를 함께 지정했거나, `center` 를 키만 보내고 값이 비어 있거나, `mode` 에 허용되지 않는 값을 보낸 경우 반환됩니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "partition": [
        "partition and drive filter the same column and cannot be used together. Use one of them — 'C', 'C:' and '/data' are all accepted."
      ]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

`error.details` 는 요청 검증 실패에만 실립니다. 그 외 에러 응답에는 `traceId`, `success`, `error.code`, `error.message`, `timestamp` 만 있습니다.

</details>

<details markdown="1" open>
<summary><strong>대시보드 연동 가이드</strong></summary>

**이 경로의 위치**

이 경로는 **드릴다운**용입니다. 목록과 상태 타일은 서버 기준 조회로 얻고, 사용자가 작업을 선택했을 때 그 작업의 `info.id` 를 이 경로에 넘깁니다.

| 단계 | 호출 | 용도 |
|------|------|------|
| 1. 목록·상태판 | `GET /recoveries/monitoring/system/:identifier` (`detail` 미지정) | 서버의 작업 목록 + 상태 타일 + 파티션별 진행률. 주기적으로 폴링 |
| 2. 상세 보기 | `GET /recoveries/monitoring/job/:identifier?detail=true` | 파티션 메타데이터(디스크·크기·모드) + 작업 로그. 상세 화면 진입 시 **1회** |
| 3. 상세 화면 갱신 | `GET /recoveries/monitoring/job/:identifier` (`detail` 미지정) | 파티션별 진행률만 갱신 |

**파티션별 진행률 막대를 그리는 데 `detail=true` 가 필요하지 않습니다.** 기본 응답의 `progress.partitions[]` 로 충분하며, `detail=true` 는 값이 바뀌지 않는 메타데이터와 로그를 더할 뿐입니다.

**로그는 이 경로에서만 나옵니다.** 서버 기준 조회는 `detail=true` 를 지정해도 `log` 를 반환하지 않습니다. 작업이 여럿일 때 각 작업의 로그 전 이력을 함께 읽는 비용을 폴링 경로에 지우지 않기 위함입니다.

**폴링 주기**

- 상세 화면을 열어 둔 채 갱신한다면 **5초 미만 주기는 권장하지 않습니다.**
- `detail=true` 는 로그 조회를 동반하고 파티션마다 메타데이터를 더 실으므로 기본 응답보다 비쌉니다. **폴링에는 `detail` 을 붙이지 마세요** — 반복 호출에서는 페이로드 크기 자체가 비용이고, 디스크 번호·모드·덮어쓰기 설정은 매 호출 다시 받을 값이 아닙니다. 파티션이 많은 서버일수록 차이가 큽니다.

**토큰 만료 처리 (401 → 재발급 → 재시도)**

- 토큰은 `POST /api/token/issue` 로 발급하며 기본 유효 기간은 **1시간**입니다. **refresh 토큰은 없습니다.**
- 응답이 `401 UNAUTHORIZED` / `"Token expired."` 이면 ① 새 토큰을 발급받고 ② 같은 요청을 **1회만** 재시도하며 ③ 재시도도 401이면 자격 증명 문제이므로 중단하고 사용자에게 알립니다.
- 만료 직전에 선제적으로 재발급하면 401 자체를 마주치지 않습니다. **매 요청마다 재발급하지 마세요** — 토큰 발급 경로의 요청 수 제한에 걸려 `429` 를 받게 됩니다.

**다중 center 환경**

작업 이름은 center 사이에서 유일하지 않습니다. 이름으로 조회한다면 `center` 로 범위를 지정해 다른 center 의 동명 작업이 잡히지 않게 하세요. 작업 ID로 조회할 때는 필요하지 않습니다.

</details>

---
