
ZOS 인증 키 파일을 다운로드합니다.

---

## `GET /cloud-auth/zos/download/:fileName` {#get-cloud-auth-zos-download}

> * 업로드된 인증 키 파일을 다운로드합니다.
> * 요청한 사용자의 이메일 기준 경로에서 파일을 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/cloud-auth/zos/download/:fileName</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/cloud-auth/zos/download/config.conf" \
  -H "Authorization: Bearer <token>" \
  -o config.conf
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `fileName` | Path | string | Required | 다운로드할 파일명 |

</details>

<details markdown="1" open>
<summary><strong>응답</strong></summary>

> 파일 바이너리가 `Content-Disposition: attachment` 헤더와 함께 반환됩니다.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**인증 실패 (401 Unauthorized)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication required."
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**잘못된 파일 경로 (400 Bad Request)**

> **v2.0.2 신규**: 파일 경로를 안전 결합 방식으로 생성하여, `fileName` 이 기준 디렉토리를 벗어나는 경우(`..` 포함 또는 절대 경로) `FILE-ERROR-11` 로 차단합니다. 이 엔드포인트는 `GET /files/download/:fileName` 과 달리 별도의 경로 파라미터 스키마 검증이 없으므로, 실제 path traversal 방어는 이 검사가 담당합니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "FILE-ERROR-11",
    "message": "Invalid file path (traversal detected): ../../etc/passwd"
  },
  "timestamp": "2026-03-20T10:30:00.000+09:00"
}
```

**파일을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "FILE-ERROR-01",
    "message": "File 'config.conf' not found."
  },
  "timestamp": "2026-08-28T10:30:00.000+09:00"
}
```

> v3.0.0 부터 다운로드 404 도 다른 엔드포인트와 **동일한 응답 형식**을 사용합니다. 이전 버전에서는 `traceId` / `timestamp` 가 없고 `error.code` 에 에러 정의 객체 전체가 실리는 불일치가 있었습니다.

**다운로드 전송 중 오류 (500 Internal Server Error)**

```json
{
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "An error occurred during file download."
  }
}
```

> 위 응답은 응답 헤더가 아직 전송되지 않은 경우에만 반환됩니다. 헤더가 이미 전송된 뒤 스트림 오류가 발생하면 연결이 즉시 종료되어 파일이 잘린 상태로 다운로드됩니다.

</details>

<details markdown="1">
<summary><strong>에러 코드</strong></summary>

| 코드 | HTTP | 메시지 | 발생 시점 |
|------|------|--------|-----------|
| `UNAUTHORIZED` | 401 | Authentication required. | 토큰이 없거나 유효하지 않음 |
| `FILE-ERROR-11` | 400 | `Invalid file path (traversal detected): <fileName>` | `fileName` 이 기준 디렉토리를 벗어남 (`..` 포함 또는 절대 경로) |
| `FILE-ERROR-01` | 404 | `File '<fileName>' not found.` | 사용자 ZOS 경로에 해당 파일이 존재하지 않음 |
| `-` | 500 | An error occurred during file download. | 파일 전송 중 읽기 스트림 오류 (헤더 전송 전) |

</details>
