
OS 복제 히스토리 목록을 조회합니다.

---

## `GET /os-replications/histories` {#get-os-replications-histories}

> * 실행된 OS 복제 작업의 히스토리를 조회합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/histories</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/histories?page=1&limit=10" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 | 선택값 |
|---------|------|------|------|------|--------|
| `Authorization` | Header | string | Required | Bearer 토큰 | |
| `jobId` | Query | number | Optional | 작업 ID 필터 | |
| `jobName` | Query | string | Optional | 작업 이름 필터 | |
| `server` | Query | string | Optional | 서버 이름 필터 | |
| `result` | Query | string | Optional | 작업 결과 필터 | `success`, `failed` |
| `page` | Query | number | Optional | 페이지 번호 | |
| `limit` | Query | number | Optional | 페이지당 개수 | |
| `sort` | Query | string | Optional | 정렬 방향 | `asc`, `desc` |

</details>
