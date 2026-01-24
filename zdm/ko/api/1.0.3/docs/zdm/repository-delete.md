---
layout: docs
title: DELETE /zdms/repositories/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 ZDM 레포지토리를 삭제합니다.

---

## `DELETE /zdms/repositories/:identifier` {#delete-zdms-repositories-identifier}

> * 레포지토리 ID로 특정 레포지토리를 삭제합니다.

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
    "centerName": "Main-Center",
    "remotePath": "/backup/data",
    "localPath": "/mnt/backup"
  },
  "message": "Repository가 성공적으로 삭제되었습니다",
  "timestamp": "2026-01-23 10:30:00"
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
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Repository를 찾을 수 없습니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

**잘못된 파라미터 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "identifier는 숫자(Repository ID)만 허용됩니다",
  "timestamp": "2026-01-23 10:30:00"
}
```

</details>

---
