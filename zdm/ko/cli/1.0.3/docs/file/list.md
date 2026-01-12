---
layout: docs
title: file list
section_title: ZDM CLI Documentation
navigation: ko-cli-1.0.3
lang: ko
---

ZDM 서버에 저장된 파일 목록을 조회합니다.

---

## `file list` {#file-list}

> * 서버에 업로드된 파일 목록을 조회합니다.
> * 파일명, 원본 파일명, 크기, 업로드 날짜 정보를 표시합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file list [options]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 파일 목록 조회 (기본 텍스트 형식)
zdm-cli file list

# JSON 형식으로 파일 목록 조회
zdm-cli file list --output json

# 테이블 형식으로 파일 목록 조회
zdm-cli file list -o table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

| 파라미터 | 별칭 | 타입 | 필수 | 기본값 | 설명 | 선택값 |
|----------|------|------|------|--------|------|--------|
| --output | -o | string | Optional | text | 출력 형식 | {% include zdm/output-formats.md %} |

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식 (기본값)**
```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* File List Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : File list retrieved successfully
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Total Files: 3]

[1]
  File Name     : backup_20250101.tar.gz
  Original Name : backup.tar.gz
  Size          : 52428800
  Upload Date   : 2025-01-01T10:00:00Z

[2]
  File Name     : config_20250102.json
  Original Name : config.json
  Size          : 1024
  Upload Date   : 2025-01-02T14:30:00Z

[3]
  File Name     : data_20250103.csv
  Original Name : data.csv
  Size          : 2048576
  Upload Date   : 2025-01-03T09:15:00Z

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**JSON 형식**
```json
{
  "requestID": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "message": "File list retrieved successfully",
  "success": true,
  "data": {
    "totalCount": 3,
    "files": [
      {
        "fileName": "backup_20250101.tar.gz",
        "fileOriginName": "backup.tar.gz",
        "size": 52428800,
        "uploadDate": "2025-01-01T10:00:00Z"
      },
      {
        "fileName": "config_20250102.json",
        "fileOriginName": "config.json",
        "size": 1024,
        "uploadDate": "2025-01-02T14:30:00Z"
      },
      {
        "fileName": "data_20250103.csv",
        "fileOriginName": "data.csv",
        "size": 2048576,
        "uploadDate": "2025-01-03T09:15:00Z"
      }
    ]
  },
  "timestamp": "2025-01-01 10:00:00"
}
```

**Table 형식**
```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* File List Result [requestID: a1b2c3d4-e5f6-7890-abcd-ef1234567890] [output: table]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[request info]

status    : success
message   : File list retrieved successfully
timestamp : 2025-01-01 10:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[data]

[Total Files: 3]

┌─────────┬─────────────────────────┬──────────────────┬──────────┬──────────────────────┐
│ (index) │ File Name               │ Original Name    │ Size     │ Upload Date          │
├─────────┼─────────────────────────┼──────────────────┼──────────┼──────────────────────┤
│ 0       │ backup_20250101.tar.gz  │ backup.tar.gz    │ 52428800 │ 2025-01-01T10:00:00Z │
│ 1       │ config_20250102.json    │ config.json      │ 1024     │ 2025-01-02T14:30:00Z │
│ 2       │ data_20250103.csv       │ data.csv         │ 2048576  │ 2025-01-03T09:15:00Z │
└─────────┴─────────────────────────┴──────────────────┴──────────┴──────────────────────┘
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</details>

---
