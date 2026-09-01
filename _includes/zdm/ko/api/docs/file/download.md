
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
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "FILE-ERROR-01",
    "message": "File '<fileName>' not found."
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

> v3.0.0 부터 다운로드 404 도 다른 엔드포인트와 **동일한 응답 형식**을 사용합니다. 이전 버전에서는 `traceId` / `timestamp` 가 없고 `error.code` 에 에러 정의 객체 전체가 실리는 불일치가 있었습니다.

**유효성 검사 실패 (400 Bad Request)**

> **v2.0.2 신규**: `fileName` 에 경로 구분자(`/`, `\`) 또는 `..` 가 포함되면 아래와 같이 거부됩니다. 이전 버전은 값이 비어 있는지만 검사했습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-02",
    "message": "URL parameter validation failed.",
    "details": {
      "fileName": ["fileName must not contain path separators or '..'"]
    }
  },
  "timestamp": "2025-01-15T10:30:00.000+09:00"
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
