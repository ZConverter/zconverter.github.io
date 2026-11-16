
ZOS 인증 키 파일을 다운로드하는 명령어입니다.

---

## `cloud-auth zos-download` {#cloud-auth-zos-download}

> * 등록된 ZOS 인증 키 파일을 로컬로 다운로드합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli cloud-auth zos-download [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 현재 디렉토리에 다운로드
zdm-cli cloud-auth zos-download --fn key.json

# 특정 디렉토리에 다운로드
zdm-cli cloud-auth zos-download --fn key.json --sp /tmp
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --file-name | -fn | string | Required | - | 다운로드할 파일명 (경로 구분자 `/` · `\` 를 포함할 수 없음) | - |
| --save-path | -sp | string | Optional | 현재 디렉토리 | 저장 디렉토리 (없으면 만듦) | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
File downloaded: /home/user/aws-key.json
```

> **Note**: 다운로드 명령어는 파일 저장 결과만 출력하며 JSON 형식은 지원하지 않습니다.

</details>

<details markdown="1" open>
<summary><strong>실패 시</strong></summary>

`file download` 와 같은 다운로드 경로를 사용합니다. 받는 도중 실패하면 반쪽 파일을 남기지 않습니다.

| 상황 | 종료 코드 | 메시지 · 오류 코드 |
|------|-----------|--------------------|
| `--file-name` 에 `/` 또는 `\` 포함 | `2` | `file-name should not contain path separators. Use --save-path to specify directory` (`INVALID_FILE_NAME`) |
| 서버 4xx 응답 | `2` | 서버 메시지, 서버 오류 코드 또는 `HTTP_<상태>` |
| 401 · 403 응답 | `3` | 401 은 `TOKEN_EXPIRED` · `TOKEN_MISSING` |
| 서버 5xx 응답 | `7` | 서버 메시지, 서버 오류 코드 또는 `HTTP_<상태>` |
| 파일 쓰기 실패 | `1` | `File write error: <이유>` (`FILE_WRITE_ERROR`) |

서버가 준 `traceId` 는 `-o json` 실패 응답에 실립니다.

</details>

---
