---
layout: docs
title: GET /files/list
section_title: ZDM API Documentation
navigation: api-1.0.3
---

업로드된 파일 목록을 조회합니다.

---

## `GET /files/list` {#get-files-list}

> * ZDM에 업로드된 파일 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/files/list</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 파일 목록 조회
curl -X GET "https://api.example.com/api/v1/files/list" \
  -H "Authorization: Bearer <token>"

# 페이지네이션 적용 조회
curl -X GET "https://api.example.com/api/v1/files/list?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `page` | Query | number | Optional | 1 | 페이지 번호 (1부터 시작) | - |
| `limit` | Query | number | Optional | 20 | 페이지당 항목 수 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 미적용</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "files": [
      {
        "fileName": "file-1705312200000-123456789-document.txt",
        "fileOriginName": "document.txt",
        "size": {
          "raw": 1024,
          "formatted": "1.0 KB"
        },
        "uploadDate": "2025-01-15 10:30:00"
      },
      {
        "fileName": "file-1705312300000-987654321-image.png",
        "fileOriginName": "image.png",
        "size": {
          "raw": 204800,
          "formatted": "200.0 KB"
        },
        "uploadDate": "2025-01-15 10:35:00"
      }
    ],
    "totalCount": 2
  },
  "message": "File list retrieved",
  "timestamp": "2025-01-15T10:40:00Z"
}
```

</details>

<details markdown="1" open>
<summary>기본 응답 (200 OK) - 페이지네이션 적용 (page, limit 파라미터 사용 시)</summary>

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "files": [
      {
        "fileName": "file-1705312200000-123456789-document.txt",
        "fileOriginName": "document.txt",
        "size": {
          "raw": 1024,
          "formatted": "1.0 KB"
        },
        "uploadDate": "2025-01-15 10:30:00"
      }
    ],
    "totalCount": 50
  },
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 50,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  },
  "message": "File list retrieved",
  "timestamp": "2025-01-15T10:40:00Z"
}
```

</details>

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `files` | array | 파일 목록 |
| `files[].fileName` | string | 저장된 파일 이름 |
| `files[].fileOriginName` | string | 원본 파일 이름 |
| `files[].size.raw` | number | 파일 크기 (bytes) |
| `files[].size.formatted` | string | 파일 크기 (포맷) |
| `files[].uploadDate` | string | 업로드 시간 |
| `totalCount` | number | 전체 파일 수 |
| `pagination.currentPage` | number | 현재 페이지 번호 (page/limit 사용 시) |
| `pagination.totalPages` | number | 전체 페이지 수 (page/limit 사용 시) |
| `pagination.totalItems` | number | 전체 항목 수 (page/limit 사용 시) |
| `pagination.itemsPerPage` | number | 페이지당 항목 수 (page/limit 사용 시) |
| `pagination.hasNextPage` | boolean | 다음 페이지 존재 여부 (page/limit 사용 시) |
| `pagination.hasPreviousPage` | boolean | 이전 페이지 존재 여부 (page/limit 사용 시) |

</details>

---
