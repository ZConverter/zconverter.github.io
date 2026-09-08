
특정 서버와 관련된 복구 작업들의 진행 상황을 조회합니다.

---

## `GET /recoveries/monitoring/system/:identifier` {#get-recoveries-monitoring-system}

> * 서버 ID 또는 서버 이름으로, **그 서버와 관련된 복구 작업 전체**의 현재 상태를 배열로 조회합니다.
> * 상태 타일용 집계(`summary`)를 함께 반환하는 **대시보드 폴링용 엔드포인트**입니다.
> * 각 작업의 진행 상태와 **파티션/드라이브별 진행률**이 `job[].progress` 에 함께 담깁니다. **파티션별 진행률은 기본 응답에 있습니다** — `detail` 이 필요하지 않습니다.
> * `detail=true` 는 파티션 **메타데이터**(`targetDisk` · `size` · `mode` · `diskNumber` · `overwrite`)만 더합니다. **로그는 이 경로에서 제공하지 않습니다** — 작업 로그는 `GET /recoveries/monitoring/job/:identifier` 의 `detail=true` 응답에만 실립니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/recoveries/monitoring/system/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 ID로 조회 (파티션별 진행률 포함)
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/1" \
  -H "Authorization: Bearer <token>"

# 서버 이름으로 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server" \
  -H "Authorization: Bearer <token>"

# 진행 중인 작업만 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?status=processing" \
  -H "Authorization: Bearer <token>"

# 이 서버가 target 인 복구만 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?serverType=target" \
  -H "Authorization: Bearer <token>"

# 파티션 메타데이터까지 포함해 조회 (폴링용이 아닙니다)
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?detail=true" \
  -H "Authorization: Bearer <token>"

# 다중 센터 범위 지정 (comma-separated; ID 또는 이름 혼용 가능)
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?center=1,zdm-b" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/recoveries/monitoring/system/target-server?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 서버 ID (숫자) 또는 서버 이름 | - |
| `serverType` | Query | string | Optional | - | 조회 서버를 한쪽 관점으로만 볼 때 지정. 생략하면 source·target 양쪽을 모두 포함합니다 | {% include zdm/server-modes.md %} |
| `jobName` | Query | string | Optional | - | 작업 이름으로 `job` 배열을 좁힙니다 | - |
| `status` | Query | string | Optional | - | 계산된 작업 상태로 `job` 배열을 거릅니다 (소문자로 지정) | {% include zdm/job-status.md %} |
| `mode` | Query | string | Optional | - | 복구 방식으로 `progress.partitions[]` 행을 좁힙니다 | {% include zdm/job-modes.md %} |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`drive`와 동시 지정 불가). `progress.partitions[]` 행을 좁힙니다 | - |
| `drive` | Query | string | Optional | - | `partition`과 같은 대상을 가리키는 별칭 (둘 중 하나만 사용) | - |
| `detail` | Query | boolean | Optional | `false` | 파티션 **메타데이터**(`targetDisk` · `size` · `mode` · `diskNumber` · `overwrite`) 포함 여부. **파티션별 진행률은 이 값과 무관하게 항상 담깁니다.** 이 경로는 `detail=true` 여도 `log` 를 싣지 않습니다 | `true`, `false` |
| `center` | Query | string | Optional | - | center 식별자 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작). `job` 배열 기준 | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수. `job` 배열 기준 | - |

> **참고:**
> - **`summary` 는 필터 적용 후 전체, `job` 은 그 중 한 페이지입니다.** 적용 순서는 `조회 → 파티션/드라이브/mode 필터 → status 필터 → 정렬 → summary 집계 → 페이지 잘라내기` 입니다. 따라서 `summary.total` 은 페이지 크기와 무관하게 언제나 필터를 통과한 전체 작업 수입니다.
> - **`page` 가 범위를 넘어가면 `job` 은 빈 배열이고 `summary.total` 은 0보다 큽니다. 이는 정상 동작입니다** — "서버에 작업이 없음" 으로 해석하지 마세요. 작업 유무는 `summary.total` 로 판단합니다.
> - `page` 와 `limit` 중 **하나만 지정해도 페이지네이션이 적용**됩니다 (`?limit=5` → `page=1`, `?page=2` → `limit=20`). 둘 다 생략하면 `pagination` 키가 없고 전체 배열이 반환됩니다.
> - `status` 는 **소문자 값으로 지정**하지만, 응답의 `job[].progress.status` 는 PascalCase(`Processing`, `Complete` 등)입니다.
> - `partition` / `drive` / `mode` 는 **`progress.partitions[]` 행을 좁히는 필터**입니다. 이 경로에서는 **일치하는 행이 하나도 없는 작업이 `job` 배열에서 제외**됩니다. `progress.partitions[]` 는 기본 응답에도 있으므로 **`detail` 없이도 필터가 남긴 행이 그대로 보입니다.**
> - **필터와 `detail` 은 서로 다른 것을 정합니다.** 필터는 **어떤 작업·어떤 행을 실을지**, `detail` 은 **각 행에 어떤 필드를 실을지**를 정합니다. `progress.partitions` 키는 `detail` 값과 무관하게 **항상 있습니다**.
> - `mode` 는 **기본 응답에 실리지 않는 필드로 거릅니다.** `detail` 없이 `?mode=` 를 지정하면 작업과 행이 줄어든 근거가 응답에 드러나지 않습니다. 걸러진 이유까지 확인하려면 `detail=true` 로 함께 조회하세요.
> - `partition`과 `drive`는 **같은 대상을 가리키는 하나의 필터**입니다. 두 파라미터를 함께 지정하면 400으로 거부됩니다.
> - 값 형식은 API가 정규화하므로 `C`, `C:`, `/data`를 모두 그대로 쓸 수 있습니다. **OS에 따라 골라 쓸 필요 없이 하나만 사용**하면 됩니다.
> - `?center=`, `?partition=`처럼 **키만 보내고 값이 비어 있으면 400**입니다. 파라미터를 아예 **생략**하는 것(필터 없음)과는 다릅니다. 단 `detail` 은 예외로, `?detail` 처럼 값 없이 보내면 `true`로 해석됩니다.
> - `center`를 지정하면 **그 범위 밖의 서버는 존재하지 않는 것으로 취급**되어 404가 반환됩니다.
> - **제거된 파라미터**: `server`, `sort`. 대상 서버는 경로 `identifier` 가 정하므로 `server` 는 의미가 없고, 정렬은 아래 규칙으로 고정되어 `sort` 가 없습니다. 이 값들은 **더 이상 받지 않습니다** — 요청에 실으면 `400` (`DTO-VALIDATION-03`) 이고, `error.details` 에 해당 파라미터 이름이 담깁니다. 이전 버전에서 이 값들이 검증만 되고 실제로는 반영되지 않던 동작을 정리한 것입니다.

**정렬 순서** — 진행 정보를 가진 작업이 앞에 오고, 그 안에서는 최근 갱신순(`sLastUpdateTime` 내림차순, 동률이면 최근 등록순)입니다.

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
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 12,
          "name": "daily-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
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
      },
      {
        "info": {
          "id": 9,
          "name": "weekly-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
        },
        "progress": {
          "status": "Complete",
          "percent": "100%",
          "message": "-",
          "partitions": [
            {
              "partition": "/",
              "backupFile": "weekly-backup_20250112_030000.ZIA",
              "status": "Complete",
              "percent": "100%",
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
          "start": "2025-01-14 02:00:00",
          "elapsed": "00:42:10",
          "end": "2025-01-14 02:42:10"
        }
      },
      {
        "info": {
          "id": 7,
          "name": "dr-drill-recovery",
          "source": "target-server",
          "target": "dr-server",
          "role": "source"
        },
        "progress": {
          "status": "Registered",
          "percent": "-",
          "message": "-",
          "partitions": [
            {
              "partition": "/data",
              "backupFile": "data-backup_20250113_040000.ZIA",
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
          "start": "-",
          "elapsed": "-",
          "end": "-"
        }
      }
    ]
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> **파티션별 진행률은 이 기본 응답에 이미 들어 있습니다.** 상태 타일과 파티션 진행률 막대를 한 번의 폴링으로 함께 그릴 수 있습니다.
>
> `daily-recovery` 의 세 행이 서로 다릅니다 — `/` 는 끝났고, `/home`(daily 이미지)은 복구 중이며, `/home`(weekly 이미지)은 **아직 시작하지 않았습니다.** 같은 파티션이 두 번 나오는 것은 행이 **(파티션, 백업 작업, 백업 이미지) 조합**이기 때문이며 `backupFile` 이 그 둘을 구분합니다.
>
> **작업 단위 `progress.message` 에는 `[source-server_home]` 같은 작업명 접두어가 붙고, 파티션 행의 `message` 는 그 접두어가 빠진 형태**입니다. 파티션 객체 안에서는 작업명이 중복이기 때문입니다.
>
> **작업 단위 `percent` 와 `summary.overallProgress` 를 `partitions[]` 로 계산하지 마세요.** 두 값 모두 데몬이 세어 둔 복구 완료 개수에서 나옵니다. `daily-recovery` 는 3행 중 1행이 완료(33%)인데 작업 진행률이 `"45%"` 이며, 이는 오류가 아닙니다 — 출처가 다릅니다.

</details>

<details markdown="1">
<summary>Linux 서버 - 메타데이터 포함 (200 OK) - <code>detail=true</code></summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 1,
      "completed": 0,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 0,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 12,
          "name": "daily-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
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
        }
      }
    ]
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> 기본 응답과 **작업 수·행 수·진행 값은 같습니다.** `detail=true` 가 더한 것은 각 행의 `targetDisk` · `size` · `mode` · `overwrite`(Linux) 뿐이며, **`log` 는 이 경로에서 `detail=true` 여도 실리지 않습니다.**

</details>

<details markdown="1">
<summary>Windows 서버 - 메타데이터 포함 (200 OK) - <code>detail=true</code></summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "server": {
      "name": "target-win-server"
    },
    "summary": {
      "total": 1,
      "completed": 0,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 0,
      "overallProgress": "60%"
    },
    "job": [
      {
        "info": {
          "id": 21,
          "name": "daily-recovery-win",
          "source": "source-win-server",
          "target": "target-win-server",
          "role": "target"
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
        }
      }
    ]
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> **Windows 응답은 `partition` 대신 `drive` 키를 씁니다.** 키 이름 자체가 갈리므로 두 이름을 모두 확인하는 코드가 필요합니다. `diskNumber` 는 Windows 에만, `overwrite` 는 Linux 에만 실리며 둘 다 `detail=true` 에서만 나옵니다.

</details>

<details markdown="1">
<summary>조건에 맞는 작업 없음 (200 OK) - 404가 아닙니다</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 0,
      "completed": 0,
      "inProgress": 0,
      "failed": 0,
      "canceled": 0,
      "pending": 0,
      "overallProgress": "-"
    },
    "job": []
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> 서버에 등록된 복구 작업이 없거나, 필터 조건에 맞는 작업이 없는 경우입니다. **404가 아니라 200 + 빈 배열**입니다. 404는 **서버 자체가 없을 때만** 반환됩니다.
>
> 파티션 필터에 맞는 행이 하나도 없는 작업은 **`job` 배열에서 통째로 빠집니다.** 작업 기준 조회가 같은 상황에서 작업을 남기고 `progress.partitions` 만 비우는 것과 다릅니다 — 이 비대칭은 의도된 것입니다.

</details>

<details markdown="1">
<summary>페이지네이션 적용 (200 OK) - <code>page</code> 또는 <code>limit</code> 지정 시</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "server": {
      "name": "target-server"
    },
    "summary": {
      "total": 3,
      "completed": 1,
      "inProgress": 1,
      "failed": 0,
      "canceled": 0,
      "pending": 1,
      "overallProgress": "45%"
    },
    "job": [
      {
        "info": {
          "id": 12,
          "name": "daily-recovery",
          "source": "source-server",
          "target": "target-server",
          "role": "target"
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
            }
          ]
        },
        "timeInfo": {
          "start": "2025-01-15 10:30:00",
          "elapsed": "00:15:00",
          "end": "-"
        }
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 3,
      "itemsPerPage": 1,
      "hasNextPage": true,
      "hasPreviousPage": false
    }
  },
  "message": "Recovery information retrieved",
  "timestamp": "2025-01-15T10:45:00.000+09:00"
}
```

> `pagination` 은 응답 봉투 최상위가 아니라 **`data` 안**에 있습니다. `summary.total` 과 `pagination.totalItems` 는 같은 값(필터 적용 후 전체 작업 수)이고, `job` 의 길이는 그 중 한 페이지입니다.
>
> **페이지네이션은 `job` 배열만 자릅니다.** 남은 작업의 `progress.partitions[]` 는 그대로 전부 실립니다 — 파티션이 많은 서버에서는 `limit` 을 작게 잡는 편이 응답 크기를 줄이는 데 효과적입니다.

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

`job[]` 원소의 구조는 작업 기준 조회(`/monitoring/job/:identifier`)의 `job` 과 **동일**합니다. 다른 점은 이 경로가 배열을 반환하고, `info.role` 이 실리며, **`log` 를 제공하지 않는다**는 것뿐입니다.

```
job[]
├─ info      { id, name, source, target, role }
├─ progress  { status, percent, message, partitions[] }   ← partitions[] 는 기본 응답에도 있습니다
└─ timeInfo  { start, elapsed, end }
                                                          ← log 는 이 경로에 없습니다
```

| 필드 | 타입 | 조건 | 설명 |
|------|------|------|------|
| `server.name` | string | 항상 | 조회 기준 서버 이름. ID로 조회해도 이름으로 반환됩니다 |
| `summary.total` | number | 항상 | 필터 적용 후 전체 작업 수 (현재 페이지 수가 아님) |
| `summary.completed` | number | 항상 | 완료된 작업 수 |
| `summary.inProgress` | number | 항상 | 진행 중인 작업 수 |
| `summary.failed` | number | 항상 | 실패한 작업 수 |
| `summary.canceled` | number | 항상 | 취소된 작업 수 (취소 진행 중 포함) |
| `summary.pending` | number | 항상 | 대기 중인 작업 수 |
| `summary.overallProgress` | string | 항상 | 진행 정보를 가진 작업들의 진행률 평균 (`"45%"`). 각 작업의 진행률은 `job[].progress.percent` 와 **같은 출처**(데몬이 센 복구 완료 개수)를 씁니다. 평균에 넣을 작업이 하나도 없으면 `"-"` |
| `job` | array | 항상 | 작업 배열. 조건에 맞는 작업이 없으면 빈 배열 |
| `job[].info.id` | number | 항상 | 복구 작업 ID. 상세 조회(`/monitoring/job/:id`)로 이어갈 때 사용합니다 |
| `job[].info.name` | string | 항상 | 복구 작업 이름 |
| `job[].info.source` | string | 항상 | 복구 이미지를 제공한 원본 서버 이름 |
| `job[].info.target` | string | 항상 | 복구가 이뤄지는 대상 서버 이름 |
| `job[].info.role` | string | 항상 | 조회 기준 서버가 그 작업에서 맡은 쪽 (`source` 또는 `target`). 작업에 기록된 서버 이름이 조회 기준 이름과 정확히 일치하지 않는 드문 경우에는 키가 생략됩니다 |
| `job[].progress.status` | string | 항상 | 계산된 작업 상태 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`). **작업 본체가 정합니다** — `partitions[]` 행이 종료 단계에 들어가도 본체가 아직 진행 중이면 `Processing` 입니다 |
| `job[].progress.percent` | string | 항상 | 작업 단위 진행률 표기. 아래 **작업 단위 `percent` 표기 규칙** 참고 |
| `job[].progress.message` | string | 항상 | 현재 진행 메시지. 데몬이 기록한 **원문 그대로**이며 `[source-server_home]` 같은 작업명 접두어가 붙습니다. 진행 정보가 없으면 `"-"` |
| `job[].progress.partitions` | array | 항상 | 파티션/드라이브별 진행. **`detail` 과 무관하게 항상 실립니다** |
| `job[].progress.partitions[].partition` | string | Linux | 복구 대상 파티션. Windows 응답에는 이 키가 없습니다 |
| `job[].progress.partitions[].drive` | string | Windows | 복구 대상 드라이브. Linux 응답에는 이 키가 없습니다 |
| `job[].progress.partitions[].backupFile` | string | 항상 | 복구에 사용하는 백업 이미지 파일 이름. **같은 파티션이 여러 행으로 나타날 때 그 행들을 구분하는 값**입니다 |
| `job[].progress.partitions[].status` | string | 항상 | **그 파티션의** 계산 상태. 값 어휘는 `job[].progress.status` 와 같습니다. 판정 규칙은 아래 참고 |
| `job[].progress.partitions[].percent` | string | 항상 | **그 파티션의** 진행률. 표기 규칙은 아래 참고 |
| `job[].progress.partitions[].message` | string | 항상 | **그 파티션의** 진행 메시지. **작업명 접두어(`[...] `)가 제거된 형태**입니다. 그 파티션의 진행 정보가 없으면 `"-"` |
| `job[].progress.partitions[].timeInfo.start` | string | 항상 | 그 파티션의 시작 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job[].progress.partitions[].timeInfo.elapsed` | string | 항상 | 그 파티션의 경과 시간. 값이 없으면 `"-"` |
| `job[].progress.partitions[].timeInfo.end` | string | 항상 | 그 파티션의 종료 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job[].progress.partitions[].targetDisk` | string | `detail=true` | 복구 대상 디스크 경로 또는 ID |
| `job[].progress.partitions[].size` | number | `detail=true` | 복구 대상 디스크 크기 (신규 디스크 생성 시 사용) |
| `job[].progress.partitions[].mode` | string | `detail=true` | 복구 방식 표시 문자열 — `Full Recovery`, `Incremental Recovery`, `Unknown` |
| `job[].progress.partitions[].diskNumber` | number | `detail=true` · Windows | 복구 대상 디스크 번호. Linux 응답에는 이 키가 없습니다 |
| `job[].progress.partitions[].overwrite` | string | `detail=true` · Linux | 파티션 덮어쓰기 상태 — `Overwritten`, `Not overwritten`. Windows 응답에는 이 키가 없습니다 |
| `job[].timeInfo.start` | string | 항상 | 시작 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `job[].timeInfo.elapsed` | string | 항상 | 경과 시간. 값이 없으면 `"-"` |
| `job[].timeInfo.end` | string | 항상 | 종료 시각 (`YYYY-MM-DD HH:mm:ss`). 값이 없으면 `"-"` |
| `pagination.currentPage` | number | `page`/`limit` | 현재 페이지 번호 |
| `pagination.totalPages` | number | `page`/`limit` | 전체 페이지 수 |
| `pagination.totalItems` | number | `page`/`limit` | 필터 적용 후 전체 작업 수 |
| `pagination.itemsPerPage` | number | `page`/`limit` | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | `page`/`limit` | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | `page`/`limit` | 이전 페이지 존재 여부 |

**기본 응답과 `detail=true` 의 경계** — `detail` 은 작업이나 행을 고르는 값이 아니라 **각 행에 실릴 필드**를 정합니다.

| | 기본 응답 | `detail=true` |
|---|---|---|
| `server` · `summary` · `pagination` | O | O |
| `job[].info` · `job[].progress.status` · `percent` · `message` · `job[].timeInfo` | O | O |
| `progress.partitions[]` 배열 자체 | O | O |
| 행의 `partition` / `drive` · `backupFile` | O | O |
| 행의 `status` · `percent` · `message` · `timeInfo` | O | O |
| 행의 `targetDisk` · `size` · `mode` | - | O |
| 행의 `diskNumber` (Windows) · `overwrite` (Linux) | - | O |
| `log` | - | - (이 경로에는 없습니다) |

**`partitions[]` 는 파티션마다 다른 값을 냅니다.** 각 행의 `status` · `percent` · `message` · `timeInfo` 는 **그 파티션의 실제 진행**이며, 작업 단위 값을 행마다 복사한 것이 아닙니다. 복구는 파티션을 하나씩 처리하므로 한 작업 안에서 끝난 파티션과 아직 시작하지 않은 파티션이 함께 나오는 것이 정상입니다. **반대로 행이 전부 `Complete` 라고 해서 그것만으로 작업이 끝난 것은 아닙니다** — 행의 종료는 **그 파티션의 복사**가 끝났다는 뜻이고, 복구는 그 뒤에 재부팅 같은 후속 단계가 남습니다. 작업 단위 상태는 작업 본체가 정하므로, 본체가 아직 진행 중이라고 말하면 이때도 `Processing` 입니다.

**작업 단위 `percent` 표기 규칙** — 두 모니터링 경로가 같은 규칙을 씁니다.

| 상황 | 값 |
|------|-----|
| 데몬이 센 복구 완료 개수가 있음 | `"45%"` — 완료 개수를 전체 개수로 나눈 값 (반올림, 최대 `"100%"`) |
| 그 값이 없고 진행 정보의 진행률이 유효함 | `"60%"` |
| 그 값이 없고 진행 정보는 있으나 진행률 값이 비어 있음 | `"-"` |
| 그 값도 진행 정보도 없고 상태가 `Complete` | `"100%"` |
| 그 외 | `"-"` |

> **`job[].progress.percent` 와 `summary.overallProgress` 의 출처는 데몬이 세어 둔 복구 완료 개수입니다.** 응답의 `partitions[]` 로는 재현되지 않습니다 — 행의 진행률을 평균 내거나 완료된 행 수를 세지 마세요. 데몬이 세는 단위가 `partitions[]` 행과 1:1 이라는 보장이 없어 값이 어긋납니다. 표시할 값은 응답의 `percent` 를 그대로 쓰세요.
>
> **`percent` 가 `"100%"` 인데 `status` 가 `Processing` 인 것은 모순이 아닙니다.** 진행률은 복사가 어디까지 갔는지를 말하고, 상태는 작업 본체가 말합니다 — 복사가 다 끝나도 재부팅 같은 후속 단계가 남아 있으면 작업은 아직 진행 중입니다. `percent` 가 `"100%"` 가 됐다고 완료로 표시하지 마세요. **완료 판정은 `status` 로만 하세요.**

**`partitions[].status` 판정 규칙** — 파티션마다 따로 계산합니다.

| 상황 | 값 |
|------|-----|
| 그 파티션의 진행 정보가 있음 | 그 진행 정보로 계산한 상태 (`Preparing`, `Processing`, `Complete`, `Scheduled`, `Canceling`, `Canceled`, `Error`) |
| 그 파티션의 진행 정보는 없고 작업의 다른 파티션에는 있음 | `"Registered"` — **아직 시작하지 않은 파티션**입니다 |
| 작업 전체에 진행 정보가 하나도 없음 | `job[].progress.status` 와 같은 값 (파티션을 가를 근거가 없는 경우) |

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

**`status` → `summary` 버킷 대응** — 8개 상태가 5개 버킷으로 모입니다. **버킷 합은 언제나 `total` 과 같습니다**(페이지네이션과 무관).

| 버킷 | 포함되는 `status` |
|------|------------------|
| `completed` | `Complete` |
| `inProgress` | `Preparing`, `Processing` |
| `failed` | `Error` |
| `canceled` | `Canceling`, `Canceled` |
| `pending` | `Scheduled`, `Registered` |

> `overallProgress` 의 분모는 **진행 정보(실행 정보 행)를 가진 작업**이며 `summary.inProgress` 와 반드시 일치하지는 않습니다. 진행률을 구할 수 없어 `"-"` 로 나가는 작업도 분모에서 빠집니다. 두 값을 같은 것으로 계산하지 마세요.
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

**서버를 찾을 수 없음 (404 Not Found)**

경로의 `identifier` 에 해당하는 서버가 없는 경우 반환됩니다. `center` 를 지정했고 그 범위에서 서버를 찾지 못한 경우도 **같은 응답**입니다.

```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "success": false,
  "error": {
    "code": "SERVER-ERROR-01",
    "message": "Server with Name 'target-server' not found"
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
}
```

> **이 경로에서 404가 나오는 경우는 이것뿐입니다.** 조건에 맞는 작업이 없는 것은 200 + 빈 배열입니다.

**잘못된 요청 파라미터 (400 Bad Request)**

`partition`과 `drive`를 함께 지정했거나, `center` / `jobName` 을 키만 보내고 값이 비어 있거나, `status` · `serverType` · `mode` 에 허용되지 않는 값을 보낸 경우 반환됩니다.

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

**2단 조회 패턴**

| 단계 | 호출 | 용도 |
|------|------|------|
| 1. 목록·상태판 | `GET /recoveries/monitoring/system/:identifier` (`detail` 미지정) | 서버의 작업 목록 + 상태 타일 + **파티션별 진행률**. **이 호출만 주기적으로 반복**합니다 |
| 2. 상세 보기 | `GET /recoveries/monitoring/job/:identifier?detail=true` | 목록에서 작업을 선택했을 때 1회. 파티션 메타데이터 + 로그 |

1단계 응답의 `job[].info.id` 를 그대로 2단계 경로의 `:id` 로 넘기면 됩니다.

**파티션 진행률 막대는 1단계만으로 그릴 수 있습니다.** `progress.partitions[]` 가 기본 응답에 있으므로, 작업 목록과 각 작업의 파티션 진행 상황을 한 번의 폴링으로 함께 갱신합니다. 2단계는 디스크·크기·모드처럼 **바뀌지 않는 값**과 로그를 볼 때만 필요합니다.

**폴링 주기**

- **5초 미만 주기는 권장하지 않습니다.** 복구 진행률 갱신 주기보다 촘촘해도 얻는 정보가 없습니다.
- **`detail=true` 는 폴링용이 아닙니다.** 파티션 메타데이터는 반복 호출에서 매번 다시 받을 값이 아니며, 파티션이 많은 서버일수록 페이로드 크기 차이가 큽니다. 진행률 갱신에는 기본 응답을 쓰세요.
- 전체 목록 조회(`GET /recoveries`)는 화면 진입 시 1회용입니다. **폴링에 사용하지 마세요** — 이 모니터링 경로가 폴링용입니다.

**토큰 만료 처리 (401 → 재발급 → 재시도)**

- 토큰은 `POST /api/token/issue` 로 발급하며 기본 유효 기간은 **1시간**입니다. **refresh 토큰은 없습니다.**
- 장시간 폴링하는 대시보드는 만료 시점의 폴링 1회가 `401 UNAUTHORIZED` / `"Token expired."` 로 떨어집니다. 처리 순서는 다음과 같습니다.
  1. 응답이 401 이면 `POST /api/token/issue` 로 **새 토큰을 발급**받습니다.
  2. 새 토큰으로 **같은 요청을 1회만 재시도**합니다.
  3. 재시도도 401 이면 자격 증명 문제이므로 폴링을 중단하고 사용자에게 알립니다.
- 만료 직전(예: 남은 유효 기간 5분 이내)에 선제적으로 재발급하면 401을 마주치는 폴링 자체가 사라집니다.
- **매 요청마다 재발급하지 마세요.** 토큰 발급 경로에는 요청 수 제한이 걸려 있어 `429` 를 받게 됩니다. 재발급은 401을 받았을 때나 만료 직전에만 수행합니다.

**빈 응답의 해석**

- `job: []` + `summary.total > 0` → **페이지 범위를 벗어난 것**입니다. 작업은 존재합니다.
- `job: []` + `summary.total == 0` → 필터 조건에 맞는 작업이 없습니다.
- `404` → 서버 자체가 없거나 지정한 `center` 범위 밖입니다.

**다중 center 환경**

작업 이름은 center 사이에서 유일하지 않습니다. 여러 center 를 한 보드에 올린다면 `center` 파라미터로 조회 범위를 명시하세요. 생략하면 전체 center 가 대상입니다.

</details>

---
