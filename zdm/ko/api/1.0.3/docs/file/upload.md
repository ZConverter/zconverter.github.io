---
layout: docs
title: POST /files/upload
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

파일을 업로드합니다.

---

## `POST /files/upload` {#post-files-upload}

> * 단일 파일을 서버에 업로드합니다.
> * 최대 파일 크기는 10MB이며, 한 번에 최대 5개까지 업로드 가능합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/v1/files/upload</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 단일 파일 업로드
curl -X POST "https://api.example.com/api/v1/files/upload" \
  -H "Authorization: Bearer <token>" \
  -F "file=@/path/to/file.txt"
```

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `file` | file | Required | 업로드할 파일 (multipart/form-data) |

**제한 사항:**
- 최대 파일 크기: 10MB
- 최대 파일 수: 5개

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (201 Created)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "file": {
      "filename": "file-1705312200000-123456789-document.txt",
      "originalname": "document.txt",
      "size": "1.0 KB",
      "mimetype": "text/plain",
      "path": "/ZConverterManger/api-files/uploads/file-1705312200000-123456789-document.txt"
    }
  },
  "message": "File uploaded successfully",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `file.filename` | string | 저장된 파일 이름 |
| `file.originalname` | string | 원본 파일 이름 |
| `file.size` | string | 파일 크기 (포맷된 문자열, 예: "1.0 KB") |
| `file.mimetype` | string | 파일 MIME 타입 |
| `file.path` | string | 저장된 파일 경로 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**파일 크기 초과 (400 Bad Request)**

```json
{
  "success": false,
  "error": {
    "code": "FILE-ERROR-02",
    "message": "파일 크기가 제한을 초과했습니다. (최대 10MB)"
  }
}
```

**업로드 오류 (400 Bad Request)**

```json
{
  "success": false,
  "error": {
    "code": "FILE-ERROR-03",
    "message": "파일 업로드 중 오류가 발생했습니다."
  }
}
```

</details>

---
