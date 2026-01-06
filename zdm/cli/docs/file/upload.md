---
layout: docs
title: file upload
section_title: ZDM CLI Documentation
navigation: cli
---

파일을 서버에 업로드합니다.

---

## `file upload` {#file-upload}

> * 파일을 서버에 업로드합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file upload --file-path &lt;path&gt;</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 단일 파일 업로드
zdm-cli file upload --file-path ./backup.tar.gz

# 절대 경로로 업로드
zdm-cli file upload --file-path /home/user/data/backup.tar.gz

# 스크립트 파일 업로드
zdm-cli file upload --file-path ./scripts/pre-backup.sh

# 설정 파일 업로드
zdm-cli file upload --file-path ./configs/backup-config.json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| `--file-path` | `-f` | string | Required | - | 업로드할 파일의 경로 | - |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

```json
{
  "requestID": "req-abc123",
  "message": "File uploaded successfully",
  "success": true,
  "data": {
    "fileName": "file-1698500000000-123456789-backup.tar.gz",
    "fileOriginName": "backup.tar.gz",
    "size": "150.5 MB",
    "uploadDate": "2025-01-15T10:30:00Z"
  },
  "timestamp": "2025-01-15T10:30:00Z"
}
```

</details>

---
