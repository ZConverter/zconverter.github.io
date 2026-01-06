---
layout: docs
title: POST /files/upload
section_title: ZDM API Documentation
navigation: api
---

파일을 업로드합니다.

---

## `POST /files/upload` {#upload-file}

> * 파일을 업로드합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/files/upload</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X POST "https://api.example.com/api/v1/files/upload" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/document.pdf"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `file` | Body (multipart) | file | Required | - | 업로드할 파일 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-file-upload",
  "data": {
    "file": {
      "originalName": "document.pdf",
      "fileName": "20240131_103045_document.pdf",
      "path": "/uploads/2024/01/31/20240131_103045_document.pdf",
      "size": 1048576,
      "mimeType": "application/pdf",
      "uploadedAt": "2024-01-31T10:30:45.123Z"
    }
  },
  "message": "파일이 성공적으로 업로드되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
