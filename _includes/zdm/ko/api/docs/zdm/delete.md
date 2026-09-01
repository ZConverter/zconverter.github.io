
특정 ZDM을 삭제합니다.

---

## `DELETE /zdms/:identifier` {#delete-zdms-identifier}

> * ZDM ID 또는 이름으로 특정 ZDM을 삭제합니다.
> * 관련된 disk, network, partition, repository 정보도 함께 삭제됩니다.
> * `center` 는 **정확히 1개만** 지정할 수 있습니다. 콤마로 여러 개를 주면 400이고, `?center=` 처럼 키만 보내고 값이 비어도 400입니다. 파라미터를 **생략**하는 것은 종전대로 허용됩니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>DELETE /api/zdms/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ZDM ID로 삭제
curl -X DELETE "https://api.example.com/api/zdms/1" \
  -H "Authorization: Bearer <token>"

# ZDM 이름으로 삭제
curl -X DELETE "https://api.example.com/api/zdms/Main-Center" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | ZDM ID (숫자) 또는 ZDM 이름 | - |
| `center` | Query | string | Optional | - | 센터 식별자(ID 또는 이름). **정확히 1개만** 허용(여러 개·빈 값은 400). 지정 시 ZDM이 해당 센터에 속하는지 검증 (불일치 시 403) | - |

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
    "name": "Main-Center",
    "relatedDeleted": {
      "disk": 2,
      "network": 1,
      "partition": 5,
      "repository": 3
    }
  },
  "message": "ZDM has been successfully deleted",
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `data.id` | number | 삭제된 ZDM ID |
| `data.name` | string | 삭제된 ZDM 이름 |
| `data.relatedDeleted.disk` | number | 삭제된 디스크 정보 수 |
| `data.relatedDeleted.network` | number | 삭제된 네트워크 정보 수 |
| `data.relatedDeleted.partition` | number | 삭제된 파티션 정보 수 |
| `data.relatedDeleted.repository` | number | 삭제된 레포지토리 정보 수 |

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**ZDM을 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "ZDM-ERROR-01",
    "message": "ZDM matching 'Main-Center' not found"
  },
  "timestamp": "2026-01-23T10:30:00.000+09:00"
}
```

**센터-ZDM 소속 불일치 (403 Forbidden)**

`center` 쿼리 지정 시 ZDM이 해당 센터에 속하지 않으면 반환됩니다.

```json
{
  "success": false,
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "error": {
    "code": "CENTER-ERROR-01",
    "message": "ZDM does not belong to center 'Main-Center'"
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
