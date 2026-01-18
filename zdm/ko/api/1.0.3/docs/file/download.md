---
layout: docs
title: GET /files/download/:fileName
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

파일을 다운로드합니다.

---

## `GET /files/download/:fileName` {#get-files-download}

> * 파일 이름으로 특정 파일을 다운로드합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/files/download/:fileName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 파일 다운로드
curl -X GET "https://api.example.com/api/files/download/file-1705312200000-123456789-document.txt" \
  -H "Authorization: Bearer <token>" \
  -o downloaded-file.txt
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `fileName` | Path | string | Required | - | 다운로드할 파일 이름 | - |

</details>

<details markdown="1" open>
<summary><strong>응답</strong></summary>

**성공 응답 (200 OK)**

- 요청한 파일이 바이너리로 반환됩니다.
- Content-Disposition 헤더에 파일 이름이 포함됩니다.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**파일을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "요청한 파일을 찾을 수 없습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

**유효성 검사 실패 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "fileName이 누락 되었습니다",
  "timestamp": "2025-01-15 10:30:00"
}
```

</details>

---
