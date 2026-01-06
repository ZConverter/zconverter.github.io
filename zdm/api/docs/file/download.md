---
layout: docs
title: GET /files/download/:fileName
section_title: ZDM API Documentation
navigation: api
---

파일을 다운로드합니다.

---

## `GET /files/download/:fileName` {#download-file}

> * 파일을 다운로드합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/files/download/:fileName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 기본 다운로드
curl -X GET "https://api.example.com/api/v1/files/download/document.pdf" \
  -H "Authorization: Bearer <token>" \
  -O

# 강제 다운로드 모드
curl -X GET "https://api.example.com/api/v1/files/download/document.pdf?download=true" \
  -H "Authorization: Bearer <token>" \
  -O

# 미리보기 모드
curl -X GET "https://api.example.com/api/v1/files/download/document.pdf?preview=true" \
  -H "Authorization: Bearer <token>"

# 부분 다운로드 (Range 요청)
curl -X GET "https://api.example.com/api/v1/files/download/document.pdf?range=bytes=0-1023" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `fileName` | Path | string | Required | - | 다운로드할 파일명 | - |
| `download` | Query | boolean | Optional | - | 강제 다운로드 모드 | - |
| `preview` | Query | boolean | Optional | - | 미리보기 모드 | - |
| `range` | Query | string | Optional | - | 부분 다운로드 범위 | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 시:** 파일이 직접 다운로드됩니다.

**실패 시 (파일 없음):**

```json
{
  "success": false,
  "requestID": "req-file-download",
  "error": "FILE_NOT_FOUND",
  "timestamp": "2024-01-31T10:30:45.123Z",
  "detail": {
    "fileName": "nonexistent.pdf",
    "message": "요청한 파일을 찾을 수 없습니다"
  }
}
```

</details>

---
