
등록된 전체 복제 작업 목록을 조회합니다.

{% include zdm/ko/api/docs/replication/_version-notice.md %}

---

## `GET /replications` {#get-replications}

> * 시스템에 등록된 모든 복제 작업 정보를 조회합니다.
> * 필터 옵션을 통해 특정 조건의 복제 작업만 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/replications</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 복제 작업 목록 조회
curl -X GET "https://api.example.com/api/replications" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/replications?mode=full&status=running" \
  -H "Authorization: Bearer <token>"

# 상세 정보 포함 조회
curl -X GET "https://api.example.com/api/replications?detail=true" \
  -H "Authorization: Bearer <token>"

# 복제 단위별 필터 조회
curl -X GET "https://api.example.com/api/replications?unit=repository" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/replications?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `jobId` | Query | number | Optional | - | 작업 ID 필터 | - |
| `jobName` | Query | string | Optional | - | 작업 이름 필터 | - |
| `server` | Query | string | Optional | - | 대상 서버 이름/ID 필터 | - |
| `status` | Query | string | Optional | - | 작업 상태 필터 | {% include zdm/replication-job-status.md %} |
| `mode` | Query | string | Optional | - | 복제 모드 필터 | {% include zdm/replication-modes.md %} |
| `unit` | Query | string | Optional | - | 복제 단위 유형 필터 | {% include zdm/replication-unit-types.md %} |
| `detail` | Query | boolean | Optional | `false` | 상세 정보 포함 여부 | `true`, `false` |
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |
| `center` | Query | string | Optional | - | center 식별자 필터 (ID/이름, comma-separated 다중 가능, 예: `destconm,9`) | - |
| `sort` | Query | string | Optional | `desc` | 정렬 순서 | `asc`, `desc` |

<details markdown="1">
<summary><strong>V1 차이점</strong></summary>

| 파라미터 | V1 선택값 |
|----------|-----------|
| `mode` | {% include zdm/replication-v1-modes.md %} (`sync` 미지원) |
| `unit` | {% include zdm/replication-v1-unit-types.md %} (`server` 미지원) |

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 - backup 단위 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "name": "center-01"
      },
      "job": {
        "info": {
          "id": "1",
          "name": "backup-replication-01",
          "unitType": "Backup Policy",
          "replicationMode": "Full",
          "status": {
            "current": "Complete",
            "time": {
              "start": "2026-03-20 02:00:00",
              "elapsed": "00:30:00",
              "end": "2026-03-20 02:30:00"
            }
          },
          "lastUpdated": "2026-03-20 02:30:00"
        },
        "backupJob": [
          {
            "name": "daily-backup",
            "id": "10"
          }
        ],
        "repository": {
          "target": {
            "id": "1",
            "type": "NFS",
            "path": "/replication/target"
          }
        },
        "option": {
          "compression": "Use",
          "encryption": "Not Use",
          "networkLimit": 0,
          "mailEvent": ""
        }
      }
    }
  ],
  "message": "Replication list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1">
<summary>기본 응답 - repository 단위 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "name": "center-01"
      },
      "job": {
        "info": {
          "id": "2",
          "name": "repo-replication-01",
          "unitType": "Repository",
          "replicationMode": "Incremental",
          "status": {
            "current": "Processing",
            "time": {
              "start": "2026-03-20 03:00:00",
              "elapsed": "00:15:00",
              "end": "-"
            }
          },
          "lastUpdated": "2026-03-20 03:15:00"
        },
        "repository": {
          "source": {
            "id": "1",
            "path": "/backup/source"
          },
          "target": {
            "id": "2",
            "type": "SMB",
            "path": "//192.168.1.100/replication"
          }
        },
        "option": {
          "compression": "Use",
          "encryption": "Use",
          "networkLimit": 1024,
          "mailEvent": "admin@example.com"
        }
      }
    }
  ],
  "message": "Replication list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1">
<summary>기본 응답 - server 단위 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "name": "center-01"
      },
      "job": {
        "info": {
          "id": "3",
          "name": "server-replication-01",
          "unitType": "Server",
          "replicationMode": "Sync",
          "status": {
            "current": "Registered",
            "time": {
              "start": "-",
              "elapsed": "-",
              "end": "-"
            }
          },
          "lastUpdated": "2026-03-20 01:00:00"
        },
        "server": {
          "source": [
            {
              "id": "1",
              "name": "web-server-01"
            }
          ]
        },
        "repository": {
          "target": {
            "id": "3",
            "type": "NFS",
            "path": "/replication/server"
          }
        },
        "option": {
          "compression": "Not Use",
          "encryption": "Not Use",
          "networkLimit": 0,
          "mailEvent": ""
        }
      }
    }
  ],
  "message": "Replication list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary>페이지네이션 적용 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "name": "center-01"
      },
      "job": {
        "info": {
          "id": "1",
          "name": "backup-replication-01",
          "unitType": "Backup Policy",
          "replicationMode": "Full",
          "status": {
            "current": "Complete",
            "time": {
              "start": "2026-03-20 02:00:00",
              "elapsed": "00:30:00",
              "end": "2026-03-20 02:30:00"
            }
          },
          "lastUpdated": "2026-03-20 02:30:00"
        },
        "backupJob": [
          {
            "name": "daily-backup",
            "id": "10"
          }
        ],
        "repository": {
          "target": {
            "id": "1",
            "type": "NFS",
            "path": "/replication/target"
          }
        },
        "option": {
          "compression": "Use",
          "encryption": "Not Use",
          "networkLimit": 0,
          "mailEvent": ""
        }
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalItems": 25,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "Replication list",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

<details markdown="1">
<summary>V1 응답 예시 - image 단위 (200 OK)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": [
    {
      "system": {
        "name": "center-01"
      },
      "job": {
        "info": {
          "id": 1,
          "name": "image-replication-01",
          "unitType": "image",
          "replicationMode": "full",
          "status": "success",
          "startTime": "2026-03-20 02:00:00",
          "endTime": "2026-03-20 02:30:00",
          "lastUpdated": "2026-03-20 02:30:00"
        },
        "backup": {
          "backupName": "daily-backup",
          "transferBackupName": "daily-backup-transfer"
        },
        "repository": {
          "source": {
            "id": 1,
            "path": "/backup/source"
          },
          "target": {
            "id": 2,
            "type": "nfs",
            "path": "/replication/target",
            "ip": "192.168.1.100",
            "port": 8080
          }
        },
        "option": {
          "compression": "use",
          "encryption": "not use",
          "networkLimit": 0,
          "mailEvent": ""
        }
      }
    }
  ],
  "message": "Replication list",
  "timestamp": "2026-03-20 10:30:00"
}
```

> **V1 응답 차이점:**
> - `unitType`: `image` 또는 `repository` (`backup`, `server` 없음)
> - `job.backup`: `backupName`, `transferBackupName` 필드 사용 (V2의 `backupJob[]` 대신)
> - `job.repository`: source/target이 하나의 객체에 통합 (V2는 분리)
> - `server` 단위 유형 미지원

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `system.name` | string | 센터 이름 |
| `job.info.id` | string | 복제 작업 ID (문자열로 반환) |
| `job.info.name` | string | 작업 이름 |
| `job.info.unitType` | string | 복제 단위 유형 표시값 (`Backup Policy`/`Repository`/`Server`/`Unknown`) |
| `job.info.replicationMode` | string | 복제 모드 표시값 (`Full`/`Incremental`/`Sync`/`Unknown`) |
| `job.info.status.current` | string | 작업 상태 (PascalCase: `Preparing`, `Processing`, `Complete`, `Scheduled`, `Registered`, `Canceling`, `Canceled`, `Error`) |
| `job.info.status.time.start` | string | 작업 시작 시간 (`YYYY-MM-DD HH:mm:ss` 또는 `-`) |
| `job.info.status.time.elapsed` | string | 경과 시간 (`HH:MM:SS` 또는 `-`) |
| `job.info.status.time.end` | string | 작업 종료 시간 (`YYYY-MM-DD HH:mm:ss` 또는 `-`) |
| `job.info.lastUpdated` | string | 마지막 업데이트 시간 |
| `job.backupJob[].name` | string | 백업 작업 이름 (unitType=backup) |
| `job.backupJob[].id` | string | 백업 작업 ID (unitType=backup, 문자열) |
| `job.server.source[].id` | string | 소스 서버 ID (unitType=server, 문자열) |
| `job.server.source[].name` | string | 소스 서버 이름 (unitType=server) |
| `job.repository.source.id` | string | 소스 레포지토리 ID (unitType=repository, 문자열) |
| `job.repository.source.path` | string | 소스 레포지토리 경로 (unitType=repository) — `type` 미반환 |
| `job.repository.target.id` | string | 타겟 레포지토리 ID (문자열) |
| `job.repository.target.type` | string | 타겟 레포지토리 타입 |
| `job.repository.target.path` | string | 타겟 레포지토리 경로 |
| `job.option.compression` | string | 압축 사용 여부 (`Use`/`Not Use`/`Unknown`) |
| `job.option.encryption` | string | 암호화 사용 여부 (`Use`/`Not Use`/`Unknown`) |
| `job.option.networkLimit` | number | 네트워크 제한 속도 (0: 무제한) |
| `job.option.mailEvent` | string | 이벤트 알림 이메일 |
| `pagination.currentPage` | number | 현재 페이지 번호 |
| `pagination.totalPages` | number | 전체 페이지 수 |
| `pagination.totalItems` | number | 전체 항목 수 |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 |

</details>

<details markdown="1" open>
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

유효하지 않은 토큰이거나 토큰이 만료된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Token has expired.",
  "timestamp": "2026-03-20 10:30:00"
}
```

**잘못된 요청 파라미터 (400 Bad Request)**

유효하지 않은 필터 값이 전달된 경우 반환됩니다.

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "Invalid enum value. Expected 'preparing' | 'processing' | 'complete' | 'scheduled' | 'canceling' | 'canceled' | 'error' | 'registered', received 'unknown'",
  "timestamp": "2026-03-20 10:30:00"
}
```

</details>

---
