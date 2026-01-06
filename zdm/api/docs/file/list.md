---
layout: docs
title: GET /files/list
section_title: ZDM API Documentation
navigation: api
---

업로드된 파일 목록을 조회합니다.

---

## `GET /files/list` {#list-files}

> * 업로드된 파일 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/files/list</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/v1/files/list" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| - | - | - | - | - | 파라미터 없음 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-file-list",
  "data": {
    "files": [
      {
        "fileName": "file-1706688645123-987654321-document.pdf",
        "fileOriginName": "document.pdf",
        "size": "1.5 MB",
        "uploadDate": "2024-01-31 10:30:45"
      },
      {
        "fileName": "file-1706602245456-123456789-report.xlsx",
        "fileOriginName": "report.xlsx",
        "size": "512.3 KB",
        "uploadDate": "2024-01-30 14:15:22"
      }
    ],
    "totalCount": 2
  },
  "message": "File list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**응답 필드 설명:**
- `fileName`: 서버에 저장된 실제 파일명 (타임스탬프 포함)
- `fileOriginName`: 원본 파일명
- `size`: 파일 크기 (MB/KB 단위로 변환)
- `uploadDate`: 업로드 일시
- `totalCount`: 총 파일 개수

</details>

---
