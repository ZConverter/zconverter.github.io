
파일을 업로드합니다.

---

## `POST /files/upload` {#post-files-upload}

> * 단일 파일을 서버에 업로드합니다.
> * 최대 파일 크기는 10MB 입니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>POST /api/files/upload</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 단일 파일 업로드
curl -X POST "https://api.example.com/api/files/upload" \
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
- 한 요청당 파일 수: 1개 (멀티 업로드 미지원)

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

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
  "message": "File upload result",
  "timestamp": "2025-01-15 10:30:00"
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
  "requestID": "req-abc123",
  "success": false,
  "error": "File size exceeds the limit.",
  "timestamp": "2025-01-15 10:30:00"
}
```

**업로드 오류 (400 Bad Request)**

```json
{
  "requestID": "req-abc123",
  "success": false,
  "error": "An error occurred during file upload.",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

<details markdown="1">
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 메시지 | 발생 시점 |
|------|------|--------|-----------|
| `FILE-ERROR-01` | 404 | File not found. | 업로드 요청에 파일 본문이 비어있을 때 |
| `FILE-ERROR-04` | 400 | File size exceeds the limit. | 파일 크기가 10MB 초과 (multer `LIMIT_FILE_SIZE`) |
| `FILE-ERROR-05` | 400 | An error occurred during file upload. | 그 외 multer 처리 오류 |
| `DTO-CREATION-01` | 500 | DTO creation error. | 응답 DTO 변환 중 오류 |

</details>

---
