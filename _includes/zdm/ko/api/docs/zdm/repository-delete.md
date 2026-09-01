
특정 ZDM 레포지토리를 삭제합니다.

---

## `DELETE /zdms/repositories/:identifier` {#delete-zdms-repositories-identifier}

> * 레포지토리 ID로 특정 레포지토리를 삭제합니다.
> * `center` 는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 주면 400이고, `?center=` 처럼 키만 보내고 값이 비어도 400입니다. 파라미터를 **생략**하는 것은 종전대로 허용됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/zdms/repositories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 레포지토리 ID로 삭제
curl -X DELETE "https://api.example.com/api/zdms/repositories/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 레포지토리 ID (숫자만 허용) | - |
| `center` | Query | string | Optional | - | 센터 식별자(ID 또는 이름). **정확히 1개만** 허용(여러 개·빈 값은 400). 지정 시 레포지토리가 해당 센터에 속하는지 검증 (불일치 시 403) | - |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "data": {
    "id": 1,
    "centerName": "Main-Center",
    "remotePath": "/backup/data",
    "localPath": "/mnt/backup"
  },
  "message": "Repository has been successfully deleted",
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `data.id` | number | 삭제된 레포지토리 ID |
| `data.centerName` | string | 레포지토리가 속한 센터 이름 |
| `data.remotePath` | string | 원격 경로 |
| `data.localPath` | string | 로컬 마운트 경로 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**레포지토리를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-REPOSITORY-ERROR-01",
    "message": "Repository with ID '999' not found"
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**잘못된 파라미터 (400 Bad Request)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-02",
    "message": "URL parameter validation failed.",
    "details": {
      "identifier": ["identifier must be a number (Repository ID)"]
    }
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**센터-레포지토리 소속 불일치 (403 Forbidden)**

`center` 쿼리 지정 시 레포지토리가 해당 센터에 속하지 않으면 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CENTER-ERROR-01",
    "message": "Repository does not belong to center 'Main-Center'"
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**`center` 다중 지정 / 빈 값 (400 Bad Request)**

삭제는 대상이 모호하면 안 되므로 `center` 는 정확히 1개만 허용합니다. 콤마로 여러 개를 주거나 `?center=` 처럼 값이 비면 반환됩니다. 이전에도 같은 규칙이었으나 검증 위치가 서비스 계층에서 요청 스키마로 옮겨져 에러 형식이 `DTO-VALIDATION-03` 으로 바뀌었습니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "DTO-VALIDATION-03",
    "message": "Query parameter validation failed.",
    "details": {
      "center": ["exactly one center must be specified"]
    }
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

</details>

---
