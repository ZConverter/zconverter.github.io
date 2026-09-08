
서버별 백업 이미지 목록을 조회합니다.

---

## `GET /backups/images/server/:server` {#get-backups-images-server}

> * 특정 서버의 백업 이미지 목록을 조회합니다.
> * `:server`는 **서버 ID 또는 서버 이름**을 모두 받습니다. 숫자를 주면 해당 서버를 조회해 서버 이름으로 바꾼 뒤, 백업 이미지가 기록한 소유 서버 이름과 비교합니다. (이전 버전은 이름만 받았습니다)
> * 저장소 경로는 환경변수 `BACKUP_REPOSITORY_PATH`에서 가져옵니다. (기본값: `/ZConverter`)
> * 만약 백업이미지가 존재하는데 검색시 []가 나오는 경우 `BACKUP_REPOSITORY_PATH`의 값을 backup이미지가 저장되는 디렉토리의 전체경로로 수정해주세요.
> * **주의 — 고아 이미지는 이름으로만 조회됩니다.** 소스 서버가 DB에 등록돼 있지 않으면 서버 행 자체가 없어 **ID가 존재하지 않습니다.** ID로 조회하면 에러 없이 **0건**이 반환되므로, 고아 이미지를 찾을 때는 반드시 서버 이름을 사용하세요.
> * 고아 이미지 지원
  - 서버 정보가 삭제되어도 백업 이미지가 존재하면 조회 가능합니다.
  - 이 경우 OS 타입을 `UNKNOWN`으로 처리하여 `partition` 형식으로 응답합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/images/server/:server</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 서버 이름으로 조회
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)" \
  -H "Authorization: Bearer <token>"

# 서버 ID로 조회 (이름으로 변환 후 비교)
curl -X GET "https://api.example.com/api/backups/images/server/12" \
  -H "Authorization: Bearer <token>"

# 작업 이름으로 필터 (정확히 일치)
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?jobName=source-centos7-bios_ROOT" \
  -H "Authorization: Bearer <token>"

# 파티션/드라이브 필터 (Linux, Windows 구분 없이 하나만 사용)
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?partition=/" \
  -H "Authorization: Bearer <token>"

curl -X GET "https://api.example.com/api/backups/images/server/SOURCE-2012 (192.168.0.179)?partition=C" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?page=1&limit=10" \
  -H "Authorization: Bearer <token>"

# 필터 조합
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?jobName=source-centos7-bios_ROOT&partition=/&page=1&limit=10" \
  -H "Authorization: Bearer <token>"

# Center 및 Repository 필터
curl -X GET "https://api.example.com/api/backups/images/server/source-amazon2023-bios_(192.168.2.99)?center=6&repositoryId=13" \
  -H "Authorization: Bearer <token>"

# Center 복수 지정 (ID/이름 혼용 가능)
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?center=1,zdm-b" \
  -H "Authorization: Bearer <token>"

# Repository Path 필터
curl -X GET "https://api.example.com/api/backups/images/server/source-centos7-bios (192.168.2.104)?repositoryPath=/ZConverter" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| `server` | Path | string | Required | - | 서버 ID 또는 서버 이름 ( source server ) |
| `center` | Query | string | Optional | - | Center ID 또는 이름으로 필터 (콤마로 복수 지정 가능) |
| `repositoryId` | Query | number | Optional | - | Repository ID로 필터 |
| `repositoryPath` | Query | string | Optional | - | Repository 경로로 필터 (예: `/ZConverter`) |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 (정확히 일치) |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`/`, `/boot`, `C`, `C:` 모두 허용) |
| `drive` | Query | string | Optional | - | 파티션/드라이브 필터 (`partition`과 같은 필터. 동시 지정 불가) |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 |

> `page`와 `limit`을 **둘 다 생략하면 페이지네이션 없이 전체가 반환**되며 `pagination` 필드도 없습니다. 둘 중 하나만 지정하면 나머지에 기본값(`page` 1, `limit` 20)이 적용됩니다.

**필터링 동작:**
- `server`: ID를 주면 서버를 조회해 이름으로 변환한 뒤 비교합니다. ID로 서버를 찾지 못해도 에러가 아니며 결과가 0건이 됩니다.
- `center`: 특정 Center의 백업 이미지만 조회 (미지정 시 모든 Center)
- `repositoryId`: 특정 Repository에 저장된 백업 이미지만 조회 (미지정 시 모든 Repository)
- `jobName`: 작업 이름과 정확히 일치하는 경우만 반환
- `partition` / `drive`: 정확히 일치하는 경우만 반환

**`partition`과 `drive`는 하나만 사용하세요 (동시 지정 시 400):**
- 두 파라미터는 **같은 항목을 가리키는 하나의 필터**입니다. 함께 주면 조건이 서로를 배제하므로 요청 자체를 **400**으로 거절합니다.
- 값 형식은 API가 정규화합니다 — `C`, `C:`, `/data`가 모두 허용되므로 **하나만 쓰면 됩니다.**
- 따라서 **OS(Linux/Windows)를 구분해 파라미터를 골라 쓸 필요가 없습니다.** Windows 서버에도 `partition=C`로 조회할 수 있습니다.
- 값을 줬는데 쓸 수 있는 조각이 하나도 없는 경우(`,`, 공백 등)도 **400**입니다.

**`center` 사용 시 주의:**
- `?center=1,zdm-b` 처럼 ID/이름을 **콤마로 여러 개** 지정할 수 있습니다.
- 해석되지 않는 식별자가 섞여 있으면 **없는 것만 짚어 404**를 반환합니다.
- `?center=` 처럼 **키는 보냈는데 값이 비면 400**입니다. 파라미터를 **생략**하는 것은 종전대로 "필터 없음"이며 동작 변화가 없습니다. "안 보낸 것"과 "빈 값"은 다릅니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>Linux 서버 응답 (200 OK)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "image": {
        "name": "source-centos7-bios_ROOT_[2026-01-07_08_44].ZIA",
        "jobName": "source-centos7-bios_ROOT",
        "type": "Full",
        "size": {
          "original": {
            "raw": 2328637440,
            "formatted": "2.17 GB"
          },
          "compressed": {
            "raw": 831622708,
            "formatted": "793.10 MB"
          }
        },
        "createdAt": "2026-01-07 08:43:48",
        "compression": {
          "level": "Default",
          "ratio": {
            "percent": 64.29,
            "formatted": "64.29%"
          }
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        },
        "comment": ""
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/",
        "device": "/dev/mapper/centos-root"
      }
    },
    {
      "image": {
        "name": "source-centos7-bios_boot_[2026-01-08_01_19].ZIA",
        "jobName": "source-centos7-bios_boot",
        "type": "Full",
        "size": {
          "original": {
            "raw": 157310976,
            "formatted": "150.02 MB"
          },
          "compressed": {
            "raw": 113541428,
            "formatted": "108.28 MB"
          }
        },
        "createdAt": "2026-01-08 01:19:29",
        "compression": {
          "level": "Default",
          "ratio": {
            "percent": 27.82,
            "formatted": "27.82%"
          }
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        },
        "comment": ""
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/boot",
        "device": "/dev/sda1"
      }
    }
  ],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary>Windows 서버 응답 (200 OK)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "image": {
        "name": "SOURCE-2012_C.ZIA",
        "jobName": "SOURCE-2012_C",
        "type": "Full",
        "size": {
          "original": {
            "raw": 18513952768,
            "formatted": "17.24 GB"
          },
          "compressed": {
            "raw": 8416938102,
            "formatted": "7.84 GB"
          }
        },
        "createdAt": "2025-12-22 16:30:01",
        "compression": {
          "level": "Default",
          "ratio": {
            "percent": 54.54,
            "formatted": "54.54%"
          }
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        },
        "comment": ""
      },
      "server": {
        "name": "SOURCE-2012 (192.168.0.179)",
        "os": "Windows Server 2012 R2 Standard[64bit]"
      },
      "drive": {
        "letter": "C:"
      }
    }
  ],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-24T08:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary>페이지네이션 적용 응답 (200 OK)</summary>

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "image": {
        "name": "source-centos7-bios_ROOT_[2026-01-07_08_44].ZIA",
        "jobName": "source-centos7-bios_ROOT",
        "type": "Full",
        "size": {
          "original": {
            "raw": 2328637440,
            "formatted": "2.17 GB"
          },
          "compressed": {
            "raw": 831622708,
            "formatted": "793.10 MB"
          }
        },
        "createdAt": "2026-01-07 08:43:48",
        "compression": {
          "level": "Default",
          "ratio": {
            "percent": 64.29,
            "formatted": "64.29%"
          }
        },
        "repository": {
          "id": 13,
          "path": "/ZConverter"
        },
        "comment": ""
      },
      "server": {
        "name": "source-centos7-bios (192.168.2.104)",
        "os": "CentOS Linux release 7.9.2009 (Core), 3.10.0-1160.el7.x86_64"
      },
      "partition": {
        "mountPoint": "/",
        "device": "/dev/mapper/centos-root"
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 2,
    "totalItems": 15,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary>이미지 없음 응답 (200 OK)</summary>

> 지정한 서버의 이미지가 없거나, 서버 ID가 어떤 서버에도 매칭되지 않거나, 스캔한 저장소가 모두 비어 있으면 빈 배열을 반환합니다 (에러가 아님).

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

**공통 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data` | array | 백업 이미지 목록 |
| `data[].image` | object | 이미지 정보 |
| `data[].image.name` | string | 백업 이미지 이름 |
| `data[].image.jobName` | string | 백업 작업 이름 |
| `data[].image.type` | string | 백업 이미지 타입 (`Full`, `Update`, `Incremental`, `Different`, `Unknown`) |
| `data[].image.size` | object | 이미지 크기 정보 (압축 전/후) |
| `data[].image.size.original` | object | 원본 데이터 크기 (압축 전) |
| `data[].image.size.original.raw` | number | 원본 데이터 크기 원본 값 (bytes) |
| `data[].image.size.original.formatted` | string | 원본 데이터 크기 포맷팅 값 (예: "2.17 GB") |
| `data[].image.size.compressed` | object | 백업 이미지 크기 (압축 후) |
| `data[].image.size.compressed.raw` | number | 백업 이미지 크기 원본 값 (bytes) |
| `data[].image.size.compressed.formatted` | string | 백업 이미지 크기 포맷팅 값 (예: "793.10 MB") |
| `data[].image.createdAt` | string | 백업 이미지 생성 시간 |
| `data[].image.compression` | object | 압축 정보 |
| `data[].image.compression.level` | string | 압축 레벨 (`None`, `Default`, `Maximum`, `Unknown`) |
| `data[].image.compression.ratio` | object \| null | 압축률. 산출 불가 시 `null` |
| `data[].image.compression.ratio.percent` | number | 절감률 숫자 값 (예: 64.29) |
| `data[].image.compression.ratio.formatted` | string | 절감률 포맷팅 값 (예: "64.29%") |
| `data[].image.repository` | object | Repository 정보 |
| `data[].image.repository.id` | number | Repository ID |
| `data[].image.repository.path` | string | Repository 경로 (예: "/ZConverter") |
| `data[].image.comment` | string | 백업 이미지 설명 (없으면 빈 문자열) |
| `data[].server` | object | 서버 정보 |
| `data[].server.name` | string | 백업 대상 서버 이름 |
| `data[].server.os` | string | 서버 운영체제 |

**압축률(`compression.ratio`) 산출 기준**
- 절감률(`1 - 압축 후 크기 / 압축 전 크기`)을 백분율로 나타낸 값입니다.
- 이미 압축된 데이터는 이미지가 원본보다 커질 수 있어 **음수**가 나올 수 있습니다 (정상).
- 원본 크기를 알 수 없으면(0) 산출이 불가능하므로 `ratio`가 **`null`** 이 됩니다.

**Linux 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].partition` | object | 파티션 정보 (Linux) |
| `data[].partition.mountPoint` | string | 마운트 포인트 (예: "/", "/boot") |
| `data[].partition.device` | string | 디바이스 경로 (예: "/dev/mapper/centos-root") |

**Windows 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].drive` | object | 드라이브 정보 (Windows) |
| `data[].drive.letter` | string | 드라이브 문자 (예: "C:", "D:") |

**페이지네이션 필드** (page, limit 파라미터 사용 시)

| 필드 | 타입 | 설명 |
|------|------|------|
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**Center 미존재 (404 Not Found)**

요청한 Center를 찾을 수 없는 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-ERROR-01",
    "message": "Requested Center '6' not found"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

**Repository 미존재 (404 Not Found)**

요청한 Repository를 찾을 수 없는 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "Requested Repository ID 14 not found"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

조건에 맞는 Repository가 하나도 없는 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "No registered Repositories found"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

> 저장소는 존재하는데 그 안에 **이미지가 없는 것**은 에러가 아닙니다. 위 404는 스캔할 Center/Repository **자체를 찾지 못한 경우**에만 발생합니다.
>
> **"저장소가 비어 있음"과 "조회 결과 0건"은 다릅니다.**
>
> - **저장소가 비어 있음** — 데몬이 그 저장소를 훑었으나 이미지 파일이 하나도 없는 **저장소 상태**입니다. 요청한 서버와 무관하므로 그 저장소만 빈 기여로 처리되고, **나머지 저장소의 이미지는 200으로 반환**됩니다. 저장소 한 곳이 비었다고 조회 전체가 404가 되지 않습니다.
> - **조회 결과 0건** — 데몬은 이미지를 찾아 채웠지만 요청한 서버 이름/ID · `jobName` · `partition`에 해당하는 것이 없는 경우입니다. 이것도 **200 + 빈 배열**입니다.
>
> 저장소 하나가 **스캔에 실패**해도(타임아웃 등) 나머지 저장소의 이미지는 그대로 200으로 반환되며,
> **어느 저장소가 왜 빠졌는지는 응답의 `scan` 필드에 담깁니다.**
>
> ```json
> "scan": {
>   "total": 3,
>   "succeeded": 2,
>   "failed": 1,
>   "failures": [
>     {
>       "centerName": "zdm-center-01",
>       "repositoryId": 13,
>       "code": "JOB-ERROR-68",
>       "reason": "Backup image lookup timed out (30 seconds elapsed, Center: zdm-center-01, Repository ID: 13, last job status: Waiting(3))",
>       "retryable": true
>     }
>   ]
> }
> ```
>
> | 필드 | 설명 |
> |---|---|
> | `total` / `succeeded` / `failed` | 스캔 대상 저장소 수와 성공·실패 건수 |
> | `failures[].code` | 분기용 안정 식별자. 사유가 분류되지 않은 경우 생략됩니다 |
> | `failures[].reason` | 사람이 읽는 실패 사유 |
> | `failures[].retryable` | 다시 호출하면 풀릴 수 있는 실패인지. 타임아웃·락 경합은 `true`, 저장소 미존재 등은 `false` |
>
> **`scan` 은 실패가 없어도 항상 포함됩니다.** `failed: 0` 이 곧 "목록이 완전하다" 는 신호입니다 —
> 실패했을 때만 실으면 이 필드를 모르는 클라이언트가 부분 결과를 전체로 오인합니다.
> 부분 결과일 때는 `message` 도 `Backup images retrieved (2 of 3 repositories scanned)` 로 바뀝니다.

**모든 저장소 스캔 실패 (500 Internal Server Error)**

**모든 저장소가 실패하면 요청도 실패합니다** — 부분 성공이 하나도 없는 상태를 빈 목록으로 위장하지 않습니다. 이때는 첫 번째 실패 사유가 그대로 반환됩니다. 예를 들어 데몬 응답이 제한 시간(기본 30초) 내에 오지 않은 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "Backup image lookup timed out (30 seconds elapsed, Center: CenterName, Repository ID: 13, last job status: Waiting(0))"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

**Path 파라미터 검증 실패 (400 Bad Request)**

`:server`가 비어 있거나 공백만 있는 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-02",
    "message": "URL parameter validation failed.",
    "details": {
      "server": ["server is required"]
    }
  },
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

**Query 파라미터 검증 실패 (400 Bad Request)**

`partition`과 `drive`를 함께 지정한 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "partition": ["partition and drive filter the same column and cannot be used together. Use one of them — 'C', 'C:' and '/data' are all accepted."]
    }
  },
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

`?center=` 처럼 값이 빈 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["center must contain at least one identifier"]
    }
  },
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

---
