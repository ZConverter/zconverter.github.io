---
layout: docs
title: file download
section_title: ZDM CLI Documentation
navigation: cli-1.0.3
---

ZDM 서버에서 파일을 다운로드합니다.

---

## `file download` {#file-download}

> * 서버에 저장된 파일을 로컬로 다운로드합니다.
> * 다운로드 진행률을 실시간으로 표시합니다.

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
| --save-path | -s | string | Optional | 현재 디렉토리 | 파일 저장 경로 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

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

---
