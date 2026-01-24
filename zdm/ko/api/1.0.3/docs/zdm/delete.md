---
layout: docs
title: DELETE /zdms/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 ZDM을 삭제합니다.

---

## `DELETE /zdms/:identifier` {#delete-zdms-identifier}

> * ZDM ID 또는 이름으로 특정 ZDM을 삭제합니다.
> * 관련된 disk, network, partition, repository 정보도 함께 삭제됩니다.

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

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
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
  "message": "ZDM이 성공적으로 삭제되었습니다",
  "timestamp": "2026-01-23 10:30:00"
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
  "requestID": "req-abc123",
  "error": "'Main-Center'에 해당하는 ZDM을 찾을 수 없습니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

</details>

---
