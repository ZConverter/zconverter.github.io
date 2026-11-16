
ZDM 서버에서 파일을 다운로드합니다.

---

## `file download` {#file-download}

> * 서버에 저장된 파일을 로컬로 다운로드합니다.
> * 다운로드 진행률을 실시간으로 표시합니다.
> * 받는 동안에는 `<저장 경로>.part` 파일에 쓰고, 끝나면 최종 이름으로 바꿉니다. 도중에 실패하면 `.part` 파일을 지우므로 반쪽 파일이 최종 이름으로 남지 않습니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file download [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 현재 디렉토리에 파일 다운로드
zdm-cli file download --file-name "backup.tar.gz"

# 특정 디렉토리에 파일 다운로드
zdm-cli file download -f "backup.tar.gz" -s "/downloads"

# 별칭을 사용한 다운로드
zdm-cli file download -f "config.json" -s "./backup"
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --file-name | -f | string | Required | - | 다운로드할 파일 이름 | - |
| --save-path | -s | string | Optional | 현재 디렉토리 | 파일 저장 경로 (아래 "저장 경로 해석" 참조) | - |

</details>

<details markdown="1" open>
<summary><strong>저장 경로 해석</strong></summary>

| `--save-path` 값 | 저장 위치 |
|------------------|-----------|
| 생략 | 현재 디렉토리의 `<file-name>` |
| 이미 있는 디렉토리 | 그 디렉토리 안의 `<file-name>` |
| 이미 있는 파일 | 그 파일을 덮어씀 |
| 없는 경로, 끝이 `/`(또는 `\`)이거나 확장자가 없음 | 그 경로를 디렉토리로 만들고 안의 `<file-name>` |
| 없는 경로, 확장자가 있음 | 그 경로를 파일 이름으로 사용 |

예를 들어 없는 `--save-path ./newdir` 는 `newdir` 라는 파일이 아니라 `newdir` 디렉토리가 만들어지고 그 안에 저장됩니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
Downloading file: backup.tar.gz
Save to: /home/user/backup.tar.gz

Progress: 100% | 50.00MB / 50.00MB | Elapsed: 00:00:05


[Download Success]
File saved to: /home/user/backup.tar.gz
```

> **Note**: 다운로드 명령어는 진행률 표시와 함께 결과를 출력합니다. 일반적인 API 응답 형식과 다르게 표시됩니다.

</details>

<details markdown="1" open>
<summary><strong>실패 시</strong></summary>

| 상황 | 종료 코드 | 오류 코드 (`error.code`) |
|------|-----------|--------------------------|
| 토큰 만료 · 없음 (401) | `3` | `TOKEN_EXPIRED` · `TOKEN_MISSING` |
| 그 밖의 서버 오류 응답 | 상태에 따라 `2`(4xx) · `3`(403) · `7`(5xx) | 서버가 준 코드, 없으면 `HTTP_<상태>` |
| 받는 도중 연결 끊김 | `4` | `STREAM_ERROR` |
| 저장 위치에 쓸 수 없음 | `1` | `FILE_WRITE_ERROR` |

- 메시지는 서버가 준 메시지 그대로이고, `-o json` 실패 응답에는 서버의 `traceId` 가 실립니다. 종전의 `Download failed (<상태>): ` 접두와 고정 코드 `DOWNLOAD_FAILED` 는 서버 오류 응답에는 쓰이지 않습니다.
- 실패하면 받던 `.part` 파일은 지워집니다.

</details>

---
