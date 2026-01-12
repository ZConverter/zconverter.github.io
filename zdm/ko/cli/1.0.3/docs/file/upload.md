---
layout: docs
title: file upload
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

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

# JSON 형식으로 결과 출력
zdm-cli file upload --file "/path/to/file.txt" --output json
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --file | -f | string | Required | - | 업로드할 파일 경로 | - |
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* File Upload Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
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
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
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
  "timestamp": "2025-01-01 10:00:00"
}
```

**Table 형식**
```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* File Upload Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: table]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : File uploaded successfully
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[File Upload Success]
┌─────────┬────────────────┬───────────────────────────────┬──────────┬──────────────────┬─────────────────────────────────────────┐
│ (index) │ originalname   │ filename                      │ size     │ mimetype         │ path                                    │
├─────────┼────────────────┼───────────────────────────────┼──────────┼──────────────────┼─────────────────────────────────────────┤
│ 0       │ backup.tar.gz  │ backup_20250101_123456.tar.gz │ 52428800 │ application/gzip │ /uploads/backup_20250101_123456.tar.gz  │
└─────────┴────────────────┴───────────────────────────────┴──────────┴──────────────────┴─────────────────────────────────────────┘
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
