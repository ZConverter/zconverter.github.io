
등록된 모든 저장소를 훑어 백업 이미지 목록을 조회합니다.

---

## `GET /backups/images` {#get-backups-images}

> * **필수 파라미터가 없습니다.** 이미지 파일명이나 서버 이름을 모르는 상태에서 "지금 어떤 백업 이미지가 있는가"를 확인하는 용도입니다.
> * 서버 정보가 삭제된 **고아 이미지도 그대로 조회**됩니다. 이 경우 OS 타입을 `UNKNOWN`으로 처리하여 `partition` 형식으로 응답합니다.
> * 여러 서버의 이미지가 한 응답에 섞이므로 OS 판정은 **행마다 개별**로 이루어집니다. 같은 응답 안에 `partition` 형과 `drive` 형이 함께 나올 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/backups/images</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>스캔 범위가 곧 비용입니다</strong></summary>

이 API는 ZDBackup 데몬에 요청을 넣고 저장소를 훑은 결과를 읽습니다. **(Center × 저장소) 조합 하나가 데몬 왕복 1회**이므로, 조합 수가 그대로 응답 시간이 됩니다. 필터 없이 호출하면 등록된 모든 저장소를 왕복합니다.

**왕복 횟수를 줄이는 파라미터 (스캔 대상 저장소 자체를 좁힘)**

| 파라미터 | 효과 |
|----------|------|
| `center` | 지정한 Center에 속한 저장소만 스캔 |
| `repositoryType` | 해당 타입(`smb` / `nfs`)의 저장소만 스캔 |
| `repositoryId` | 해당 Repository 하나만 스캔 |

**왕복 횟수를 줄이지 않는 파라미터 (스캔 후 결과를 거르는 필터)**

`server`, `jobName`, `partition`, `drive`, `repositoryPath`, `page`, `limit`은 스캔이 끝난 뒤 적용되는 필터입니다. 결과는 줄어들지만 **데몬 왕복 비용은 동일합니다.**

조회 대상 저장소를 이미 알고 있다면 `center` · `repositoryType` · `repositoryId`로 먼저 좁히세요.

</details>

<details markdown="1" open>
<summary><strong>저장소 부분 실패 허용</strong></summary>

* 저장소 하나가 응답하지 않아도 **나머지 저장소의 이미지를 200으로 반환**합니다.
* **어느 저장소가 왜 빠졌는지는 응답의 `scan` 필드에 담깁니다** — `total` / `succeeded` / `failed` 와
  저장소별 `failures[]`(`centerName` · `repositoryId` · `code` · `reason` · `retryable`). 형식과 예시는
  [GET /backups/images/server/:server](/zdm/ko/api/3.0.0/docs/backup/images#조회-결과가-비어-있는-경우) 참조.
* **`scan` 은 실패가 없어도 항상 포함됩니다.** `failed: 0` 이 곧 "목록이 완전하다" 는 신호입니다.
* **모든 저장소가 실패하면 요청도 실패합니다** — 부분 성공이 하나도 없는 상태를 빈 목록으로 위장하지 않습니다. 이때는 첫 번째 실패 사유가 그대로 에러로 반환됩니다.
* 이미지가 하나도 없는 **빈 저장소는 정상**이며, 그 저장소만 빈 기여로 처리됩니다. 저장소 한 곳이 비었다고 조회 전체가 404가 되지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 조회 (등록된 모든 저장소 스캔)
curl -X GET "https://api.example.com/api/backups/images" \
  -H "Authorization: Bearer <token>"

# Center로 스캔 범위 축소 (권장)
curl -X GET "https://api.example.com/api/backups/images?center=6" \
  -H "Authorization: Bearer <token>"

# Center 복수 지정 (ID/이름 혼용 가능)
curl -X GET "https://api.example.com/api/backups/images?center=1,zdm-b" \
  -H "Authorization: Bearer <token>"

# 저장소 타입으로 스캔 범위 축소
curl -X GET "https://api.example.com/api/backups/images?repositoryType=nfs" \
  -H "Authorization: Bearer <token>"

# 저장소 하나만 스캔
curl -X GET "https://api.example.com/api/backups/images?repositoryId=13" \
  -H "Authorization: Bearer <token>"

# 서버 필터 (선택) - 이름 또는 ID
curl -X GET "https://api.example.com/api/backups/images?server=source-centos7-bios (192.168.2.104)" \
  -H "Authorization: Bearer <token>"

curl -X GET "https://api.example.com/api/backups/images?server=12" \
  -H "Authorization: Bearer <token>"

# 작업 이름 필터 (정확히 일치)
curl -X GET "https://api.example.com/api/backups/images?jobName=source-centos7-bios_ROOT" \
  -H "Authorization: Bearer <token>"

# 파티션/드라이브 필터 (Linux, Windows 구분 없이 하나만 사용)
curl -X GET "https://api.example.com/api/backups/images?partition=/" \
  -H "Authorization: Bearer <token>"

curl -X GET "https://api.example.com/api/backups/images?partition=C" \
  -H "Authorization: Bearer <token>"

# 오래된 이미지부터 정렬
curl -X GET "https://api.example.com/api/backups/images?sort=asc" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/backups/images?center=6&page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|------|--------|------|
| `center` | Query | string | Optional | - | Center ID 또는 이름으로 필터 (콤마로 복수 지정 가능). 스캔 범위 축소 |
| `repositoryType` | Query | string | Optional | - | 저장소 타입으로 필터 (`smb`, `nfs`). 스캔 범위 축소 |
| `repositoryId` | Query | number | Optional | - | Repository ID로 필터. 스캔 범위 축소 |
| `server` | Query | string | Optional | - | 서버 ID 또는 서버 이름으로 필터 ( source server ) |
| `repositoryPath` | Query | string | Optional | - | Repository 경로로 필터 (예: `/ZConverter`) |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 (정확히 일치) |
| `partition` | Query | string | Optional | - | 파티션/드라이브 필터 (`/`, `/boot`, `C`, `C:` 모두 허용) |
| `drive` | Query | string | Optional | - | 파티션/드라이브 필터 (`partition`과 같은 필터. 동시 지정 불가) |
| `sort` | Query | string | Optional | desc | 백업 시간 정렬 방향 (`asc`, `desc`) |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 |

> `page`와 `limit`을 **둘 다 생략하면 페이지네이션 없이 전체가 반환**되며 `pagination` 필드도 없습니다. 둘 중 하나만 지정하면 나머지에 기본값(`page` 1, `limit` 20)이 적용됩니다. 스캔 범위가 넓을수록 결과가 커지므로 탐색 용도라면 `limit`을 함께 지정하세요.

**필터링 동작:**
- `center`: 지정한 Center에 속한 저장소만 스캔 (미지정 시 모든 Center)
- `repositoryType`: 지정한 타입의 저장소만 스캔 (미지정 시 모든 타입)
- `repositoryId`: 지정한 Repository만 스캔 (미지정 시 모든 Repository)
- `server`: 이미지가 기록한 소유 서버 이름과 비교합니다. ID를 주면 해당 서버를 조회해 이름으로 변환한 뒤 비교합니다. **스캔 범위는 좁히지 않습니다.**
- `repositoryPath`: 저장소 경로와 정확히 일치하는 이미지만 반환. **스캔 범위는 좁히지 않습니다.**
- `jobName`: 작업 이름과 정확히 일치하는 경우만 반환
- `partition` / `drive`: 정확히 일치하는 경우만 반환
- `sort`: 백업 시간(`image.createdAt`) 기준. 미지정 시 최신순(`desc`)

**`server` 사용 시 주의:**
- **고아 이미지(소스 서버가 DB에 등록돼 있지 않은 이미지)는 이름으로만 조회됩니다.** 서버 행이 없어 ID 자체가 존재하지 않기 때문에, ID로 조회하면 에러 없이 **0건**이 됩니다.
- `?server=` 처럼 **키는 보냈는데 값이 비면 400**입니다. 파라미터를 **생략**하는 것은 "필터 없음"이며 동작 변화가 없습니다. "안 보낸 것"과 "빈 값"은 다릅니다.

**`partition`과 `drive`는 하나만 사용하세요 (동시 지정 시 400):**
- 두 파라미터는 **같은 항목을 가리키는 하나의 필터**입니다. 함께 주면 조건이 서로를 배제하므로 요청 자체를 **400**으로 거절합니다.
- 값 형식은 API가 정규화합니다 — `C`, `C:`, `/data`가 모두 허용되므로 **하나만 쓰면 됩니다.**
- 따라서 **OS(Linux/Windows)를 구분해 파라미터를 골라 쓸 필요가 없습니다.**
- 값을 줬는데 쓸 수 있는 조각이 하나도 없는 경우(`,`, 공백 등)도 **400**입니다.

**`center` 사용 시 주의:**
- `?center=1,zdm-b` 처럼 ID/이름을 **콤마로 여러 개** 지정할 수 있습니다.
- 해석되지 않는 식별자가 섞여 있으면 **없는 것만 짚어 404**를 반환합니다.
- `?center=` 처럼 **키는 보냈는데 값이 비면 400**입니다. 생략은 종전대로 "필터 없음"입니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 여러 서버의 이미지 혼재</summary>

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
          "id": 14,
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
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary>고아 이미지 포함 응답 (200 OK)</summary>

> 소스 서버가 DB에 없는 이미지는 OS 타입이 `UNKNOWN`으로 처리되어 `partition` 형식으로 응답합니다. `server.os`는 이미지에 기록된 값이 없으면 빈 문자열입니다.

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": [
    {
      "image": {
        "name": "removed-server_C.ZIA",
        "jobName": "removed-server_C",
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
        "createdAt": "2025-11-30 02:10:44",
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
        "name": "removed-server (192.168.0.201)",
        "os": ""
      },
      "partition": {
        "mountPoint": "C:",
        "device": ""
      }
    }
  ],
  "message": "Backup images retrieved successfully",
  "timestamp": "2026-01-09T10:30:00.000+09:00"
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
    "totalPages": 4,
    "totalItems": 37,
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
<summary>빈 결과 응답 (200 OK)</summary>

> 필터에 맞는 이미지가 없거나 스캔한 저장소가 모두 비어 있으면 빈 배열을 반환합니다 (에러가 아님). 저장소 하나가 비어 있는 것은 정상 상태이며 404가 아닙니다.

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
| `data` | array | 백업 이미지 목록 (백업 시간 기준 정렬, 기본 최신순) |
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

**Linux(및 고아 이미지) 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].partition` | object | 파티션 정보 |
| `data[].partition.mountPoint` | string | 마운트 포인트 (예: "/", "/boot") |
| `data[].partition.device` | string | 디바이스 경로 (예: "/dev/mapper/centos-root") |

**Windows 전용 필드**

| 필드 | 타입 | 설명 |
|------|------|------|
| `data[].drive` | object | 드라이브 정보 |
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

`center`로 지정한 식별자를 찾을 수 없는 경우 (없는 것만 짚어 반환):

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

**스캔 대상 Repository 없음 (404 Not Found)**

지정한 Repository를 찾을 수 없는 경우 (적용된 필터가 메시지에 함께 표시됩니다):

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "Requested Repository ID 14 not found (center: 6)"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

필터 조건에 맞는 Repository가 하나도 없는 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "No registered Repositories found (repositoryType: nfs)"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
}
```

> 저장소는 존재하는데 **이미지가 없는 것**은 에러가 아니라 **200 + 빈 배열**입니다. 위 404는 스캔할 저장소 자체를 찾지 못한 경우입니다.

**모든 저장소 스캔 실패 (500 Internal Server Error)**

부분 성공이 하나도 없는 경우 첫 번째 실패 사유가 그대로 반환됩니다. 예를 들어 데몬 응답이 제한 시간(기본 30초) 내에 오지 않은 경우:

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

원인을 특정할 수 없는 스캔 실패:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "JOB-ERROR-68",
    "message": "[Backup image list] - scan failed"
  },
  "timestamp": "2026-01-28T08:42:51.000+09:00"
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

`?server=` 처럼 값이 빈 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "server": ["server must not be empty"]
    }
  },
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

`repositoryType`에 허용되지 않은 값을 준 경우:

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "repositoryType": ["repositoryType must be one of: smb, nfs"]
    }
  },
  "timestamp": "2026-01-09T10:30:00.000+09:00"
}
```

</details>

---
