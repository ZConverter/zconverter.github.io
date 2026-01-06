---
layout: docs
title: GET /zdms/repositories
section_title: ZDM API Documentation
navigation: api
---

모든 ZDM 리포지토리 정보를 조회합니다.

---

## `GET /zdms/repositories` {#get-repositories}

> * 모든 ZDM 리포지토리 정보를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/v1/zdms/repositories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 전체 리포지토리 목록 조회
curl -X GET "https://api.example.com/api/v1/zdms/repositories" \
  -H "Authorization: Bearer <token>"

# 필터 적용 조회
curl -X GET "https://api.example.com/api/v1/zdms/repositories?centerName=Main-ZDM-Center&status=online" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `centerName` | Query | string | Optional | - | 센터명 필터 | - |
| `type` | Query | string | Optional | - | 리포지토리 타입 필터 | - |
| `path` | Query | string | Optional | - | 경로 필터 | - |
| `status` | Query | string | Optional | - | 상태 필터 | `online`, `offline` |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

```json
{
  "success": true,
  "requestID": "req-all-repositories",
  "data": [
    {
      "center": {
        "id": "ZDM-001",
        "name": "Main-ZDM-Center"
      },
      "repository": {
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
    }
  ],
  "message": "모든 ZDM 리포지토리 정보를 성공적으로 조회했습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

</details>

---
