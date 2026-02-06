---
layout: docs
title: PUT /zdms/repositories/:identifier
section_title: ZDM API Documentation
navigation: ko-api-1.0.3
lang: ko
---

특정 ZDM 레포지토리 정보를 수정합니다.

---

## `PUT /zdms/repositories/:identifier` {#put-zdms-repositories-identifier}

> * 레포지토리 ID로 특정 레포지토리의 정보를 수정합니다.
> * 수정 가능 필드: `remotePath`, `remoteUser`, `remotePwd`, `ip`
> * `center` 필드는 필수이며, Center 존재 여부 및 Repository 소속 일치를 검증합니다.

<details markdown="1" open>
<summary><strong>엔드포인트</strong></summary>

<div class="command-card">
  <code>PUT /api/zdms/repositories/:identifier</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>요청 예시</strong></summary>

```bash
# 레포지토리 원격 경로 수정
curl -X PUT "https://api.example.com/api/zdms/repositories/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "Main-Center",
    "remotePath": "/backup/new-path"
  }'

# 레포지토리 IP 추가
curl -X PUT "https://api.example.com/api/zdms/repositories/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "1",
    "ip": "192.168.1.201"
  }'

# 여러 필드 동시 수정
curl -X PUT "https://api.example.com/api/zdms/repositories/1" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "center": "Main-Center",
    "remotePath": "/backup/updated",
    "remoteUser": "new-admin",
    "remotePwd": "newPassword123",
    "ip": "192.168.1.202"
  }'
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 위치 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `identifier` | Path | string | Required | - | 레포지토리 ID (숫자만 허용) | - |

</details>

<details markdown="1" open>
<summary><strong>요청 본문</strong></summary>

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| `center` | string | Required | 센터 ID (숫자) 또는 센터 이름. Center 존재 여부 및 Repository 소속 일치 검증 |
| `remotePath` | string | Optional | 원격 경로. DB의 저장소 타입(SMB/NFS)에 따른 경로 양식 검증 |
| `remoteUser` | string | Optional | 원격 접속 사용자 |
| `remotePwd` | string | Optional | 원격 접속 비밀번호 |
| `ip` | string | Optional | 레포지토리 서버 IP. IPv4 양식 검증 후 기존 등록 IP와 중복 검사, 중복되지 않으면 `\|` 구분자로 추가 |

> `remotePath`, `remoteUser`, `remotePwd`, `ip` 중 하나 이상 포함해야 합니다.

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

**성공 응답 (200 OK)**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "repositoryInfo": {
      "id": 1,
      "centerName": "Main-Center"
    },
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "remotePath",
          "previous": "/backup/old-path",
          "new": "/backup/updated"
        },
        {
          "field": "ipAddress",
          "previous": "192.168.1.200",
          "new": "192.168.1.200|192.168.1.202"
        }
      ]
    }
  },
  "message": "Repository가 성공적으로 수정되었습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**remotePwd 변경 시 응답 예시**

```json
{
  "success": true,
  "requestID": "req-abc123",
  "data": {
    "repositoryInfo": {
      "id": 1,
      "centerName": "Main-Center"
    },
    "summary": {
      "state": "success",
      "updatedFields": [
        {
          "field": "remotePwd",
          "previous": "********",
          "new": "********"
        }
      ]
    }
  },
  "message": "Repository가 성공적으로 수정되었습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>응답 필드</strong></summary>

| 필드 | 타입 | 설명 |
|------|------|------|
| `data.repositoryInfo` | object | 수정된 레포지토리 정보 |
| `data.repositoryInfo.id` | number | 레포지토리 ID |
| `data.repositoryInfo.centerName` | string | 센터 이름 |
| `data.summary.state` | string | 수정 결과 상태 (`success`) |
| `data.summary.updatedFields` | array | 변경된 필드 목록 |
| `data.summary.updatedFields[].field` | string | 변경된 필드명 |
| `data.summary.updatedFields[].previous` | string | 변경 전 값 |
| `data.summary.updatedFields[].new` | string | 변경 후 값 |

> `remotePwd` 변경 시 `previous`와 `new` 모두 `"********"`로 마스킹됩니다.

</details>

<details markdown="1">
<summary><strong>에러 응답</strong></summary>

**레포지토리를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Repository를 찾을 수 없습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**센터를 찾을 수 없음 (404 Not Found)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "ID가 '999'인 Center를 찾을 수 없습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**센터-레포지토리 소속 불일치 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "Repository가 지정된 Center에 속하지 않습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**remotePath 경로 양식 오류 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "NFS 타입의 remotePath는 '/'로 시작해야 합니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**IP 양식 오류 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "유효한 IPv4 주소 형식이 아닙니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**IP 중복 (409 Conflict)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "IP '192.168.1.200'은(는) 이미 등록되어 있습니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

**잘못된 파라미터 (400 Bad Request)**

```json
{
  "success": false,
  "requestID": "req-abc123",
  "error": "identifier는 숫자(Repository ID)만 허용됩니다",
  "timestamp": "2026-02-05 10:30:00"
}
```

</details>

---
