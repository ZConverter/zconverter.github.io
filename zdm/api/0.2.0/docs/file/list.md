---
layout: docs
title: GET /files/list
section_title: ZDM API Documentation
navigation: api-0.2.0
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
```

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

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

</details>

---
