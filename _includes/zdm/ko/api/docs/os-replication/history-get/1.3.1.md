
OS 복제 히스토리를 단건 조회합니다.

---

## `GET /os-replications/histories/:identifier` {#get-os-replications-histories-identifier}

> * ID(숫자): 히스토리 단건 조회
> * 작업 이름(문자열): 해당 작업의 히스토리 목록 조회

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>GET /api/os-replications/histories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
curl -X GET "https://api.example.com/api/os-replications/histories/1" \
  -H "Authorization: Bearer <token>"
```

</details>

<details markdown="1" open>
<summary><strong>요청 파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 설명 |
|---------|------|------|------|------|
| `Authorization` | Header | string | Required | Bearer 토큰 |
| `identifier` | Path | string | Required | 히스토리 ID(숫자) 또는 작업 이름 |

</details>
