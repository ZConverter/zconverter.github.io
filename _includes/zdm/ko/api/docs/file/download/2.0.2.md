
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
| `fileName` | Path | string | Required | - | 다운로드할 파일 이름 (`/`, `\`, `..` 포함 불가 — path traversal 방어, v2.0.2 신규) | - |

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
  "error": {
    "code": {
      "code": "FILE-ERROR-01",
      "httpCode": 404,
      "message": "File not found."
    },
    "message": "File '<fileName>' not found."
  }
}
```

> **참고**: 본 404 응답은 공통 에러 응답 형식을 따르지 않습니다 (`requestID` / `timestamp` 없음). 또한 `error.code` 가 문자열이 아닌 `{ code, httpCode, message }` 객체로 그대로 내려갑니다. 다른 엔드포인트와 다른 알려진 불일치 사항입니다.

**유효성 검사 실패 (400 Bad Request)**

> **v2.0.2 신규**: `fileName` 에 경로 구분자(`/`, `\`) 또는 `..` 가 포함되면 아래와 같이 거부됩니다. 이전 버전은 값이 비어 있는지만 검사했습니다.

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "URL parameter validation failed.",
  "timestamp": "2025-01-15 10:30:00",
  "detail": {
    "validationErrors": {
      "fileName": ["fileName must not contain path separators or '..'"]
    }
  }
}
```

</details>

<details markdown="1">
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 메시지 | 발생 시점 |
|------|------|--------|-----------|
| `FILE-ERROR-01` | 404 | `File '<fileName>' not found.` | 요청한 파일이 업로드 경로에 존재하지 않음 |
| `DTO-VALIDATION-02` | 400 | URL parameter validation failed. | `fileName` 경로 파라미터 검증 실패 |
| `FILE-ERROR-11` | 400 | Invalid file path. | (v2.0.2 신규) `fileName` 이 기준 디렉토리를 벗어나는 경우 (`..` 또는 절대경로). 본 엔드포인트에서는 위의 `DTO-VALIDATION-02` 검증이 먼저 걸러내므로 2차 방어선으로만 동작 |

</details>

---
