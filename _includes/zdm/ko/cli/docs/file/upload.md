
로컬 파일을 ZDM 서버에 업로드합니다.

---

## `file upload` {#file-upload}

> * 로컬 파일을 ZDM 서버에 업로드합니다.
> * 업로드 완료 후 파일 정보를 표시합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file upload [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 파일 업로드 (절대 경로)
zdm-cli file upload --file "/path/to/file.txt"

# 파일 업로드 (상대 경로)
zdm-cli file upload -f "./backup.tar.gz"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --file | -f | string | Required | - | 업로드할 파일 경로 | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* File Upload Result [traceId: a1b2c3d4e5f60718293a4b5c6d7e8f90] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : File uploaded successfully
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[File Upload Success]
  file.originalname : backup.tar.gz
  file.filename     : backup_20250101_123456.tar.gz
  file.size         : 52428800 bytes
  file.mimetype     : application/gzip
  file.path         : /uploads/backup_20250101_123456.tar.gz

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "traceId": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "message": "File uploaded successfully",
  "success": true,
  "data": {
    "file": {
      "originalname": "backup.tar.gz",
      "filename": "backup_20250101_123456.tar.gz",
      "size": 52428800,
      "mimetype": "application/gzip",
      "path": "/uploads/backup_20250101_123456.tar.gz"
    }
  },
  "timestamp": "2025-01-01T10:00:00.000+09:00"
}
```

</details>

<details markdown="1" open>
<summary><strong>실패 시</strong></summary>

업로드 실패 응답은 다른 명령과 같은 규칙으로 해석됩니다.

| 상황 | 종료 코드 | 오류 코드 (`error.code`) |
|------|-----------|--------------------------|
| 토큰 만료 (401) | `3` | `TOKEN_EXPIRED` — `Token expired. Please reissue the token` |
| 토큰 없음 (401) | `3` | `TOKEN_MISSING` — `Authentication required. Please issue a token first` |
| 그 밖의 서버 오류 응답 | 상태에 따라 `2`(4xx) · `3`(403) · `7`(5xx) | 서버가 준 코드, 없으면 `HTTP_<상태>` |
| 요청 시간 초과 | `4` | `REQUEST_TIMEOUT` |

- 서버 오류 응답의 `traceId` 가 `-o json` 실패 응답에 실립니다.

</details>

---
