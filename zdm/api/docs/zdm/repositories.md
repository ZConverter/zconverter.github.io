---
layout: docs
title: GET /zdms/:identifier/repositories
section_title: ZDM API Documentation
navigation: api
---

특정 ZDM 센터의 리포지토리 정보를 조회합니다.

---

## `GET /zdms/:identifier/repositories` {#get-zdm-repositories}

> * 특정 ZDM 센터의 리포지토리 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms/:identifier/repositories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# ID로 조회
curl -X GET "https://api.example.com/api/v1/zdms/ZDM-001/repositories" \
  -H "Authorization: Bearer <token>"

# 센터명으로 조회
curl -X GET "https://api.example.com/api/v1/zdms/Main-ZDM-Center/repositories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/zdms/ZDM-001/repositories?type=local&status=online" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | ZDM 센터 ID 또는 센터명 | - |
| `type` | Query | string | Optional | - | 리포지토리 타입 필터 | - |
| `path` | Query | string | Optional | - | 경로 필터 | - |
| `status` | Query | string | Optional | - | 상태 필터 | `online`, `offline` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-zdm-repositories",
  "data": [
    {
      "id": "REPO-001",
      "name": "Primary Repository",
      "type": "local",
      "path": "C:\\ZDM\\Repository",
      "status": "online",
      "capacity": {
        "total": "1TB",
        "used": "256GB",
        "available": "768GB",
        "usage": "25%"
      }
    }
  ],
  "message": "ZDM 센터 리포지토리 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
