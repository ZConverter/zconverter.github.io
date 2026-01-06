---
layout: docs
title: file download
section_title: ZDM CLI Documentation
navigation: cli
---

서버에서 파일을 다운로드합니다.

---

## `file download` {#file-download}

> * 서버에서 파일을 다운로드합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file download --file-name &lt;name&gt; [--save-path &lt;path&gt;]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 현재 디렉토리에 다운로드
zdm-cli file download --file-name backup.tar.gz

# 특정 디렉토리에 다운로드
zdm-cli file download --file-name backup.tar.gz --save-path /downloads

# 다른 이름으로 저장
zdm-cli file download --file-name backup.tar.gz --save-path /downloads/my-backup.tar.gz

# 전체 파일명으로 다운로드
zdm-cli file download --file-name file-1698500000000-123456789-backup.tar.gz
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--file-name` | `-f` | string | Required | - | 다운로드할 파일명 | - |
| `--save-path` | `-s` | string | Optional | 현재 디렉토리 | 저장할 경로 | - |

</details>

<details markdown="1" open>
<summary><strong>진행률 표시</strong></summary>

다운로드 중에는 실시간으로 진행률이 표시됩니다:

```text
Downloading: backup.tar.gz
Progress: 45% | 4.50MB / 10.00MB | Elapsed: 00:00:12
Download completed: /downloads/backup.tar.gz
```

</details>

<details markdown="1" open>
<summary><strong>파일 이름 검색</strong></summary>

다운로드 시 원본 파일명 또는 전체 파일명 모두 사용 가능합니다:

```bash
# 원본 파일명으로 검색
zdm-cli file download --file-name backup.tar.gz

# 전체 파일명으로 검색
zdm-cli file download --file-name file-1698500000000-123456789-backup.tar.gz

# 파일 목록에서 확인
zdm-cli file list
```

</details>

---
