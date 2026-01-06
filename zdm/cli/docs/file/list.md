---
layout: docs
title: file list
section_title: ZDM CLI Documentation
navigation: cli
---

업로드된 파일 목록을 조회합니다.

---

## `file list` {#file-list}

> * 업로드된 파일 목록을 조회합니다.

<details markdown="1" open>
<summary><strong>명령어 구문</strong></summary>

<div class="command-card">
  <code>zdm-cli file list [--output &lt;format&gt;]</code>
</div>

</details>

<details markdown="1" open>
<summary><strong>사용 예시</strong></summary>

```bash
# 파일 목록 조회 (text 형식)
zdm-cli file list

# JSON 형식으로 출력
zdm-cli file list --output json

# Table 형식으로 출력
zdm-cli file list --output table
```

</details>

<details markdown="1" open>
<summary><strong>파라미터</strong></summary>

별도의 쿼리 파라미터가 없습니다. 전역 옵션(`--output`)만 사용 가능합니다.

</details>

<details markdown="1" open>
<summary><strong>출력 예시</strong></summary>

**Text 형식:**
```text
Files:
  File Name: file-1698500000000-123456789-example.txt
  Original Name: example.txt
  Size: 1.5 KB
  Upload Date: 2025-10-28 08:30:00

  File Name: file-1698500000001-987654321-test.pdf
  Original Name: test.pdf
  Size: 2.3 MB
  Upload Date: 2025-10-28 09:15:00

Total: 2 files
```

**Table 형식:**
```text
+------------------------------------------+---------------+---------+---------------------+
| File Name                                | Original Name | Size    | Upload Date         |
+------------------------------------------+---------------+---------+---------------------+
| file-1698500000000-123456789-example.txt | example.txt   | 1.5 KB  | 2025-10-28 08:30:00 |
| file-1698500000001-987654321-test.pdf    | test.pdf      | 2.3 MB  | 2025-10-28 09:15:00 |
+------------------------------------------+---------------+---------+---------------------+
Total: 2 files
```

**JSON 형식:**
```json
{
  "requestID": "req-abc123",
  "message": "File list retrieved successfully",
  "success": true,
  "data": {
    "files": [
      {
        "fileName": "file-1698500000000-123456789-example.txt",
        "fileOriginName": "example.txt",
        "size": "1.5 KB",
        "uploadDate": "2025-10-28 08:30:00"
      },
      {
        "fileName": "file-1698500000001-987654321-test.pdf",
        "fileOriginName": "test.pdf",
        "size": "2.3 MB",
        "uploadDate": "2025-10-28 09:15:00"
      }
    ],
    "totalCount": 2
  },
  "timestamp": "2025-10-28 08:30:00"
}
```

</details>

---

## 파일 이름 형식

<details markdown="1" open>
<summary><strong>저장된 파일 이름 구조</strong></summary>

서버에 저장된 파일은 다음 형식을 따릅니다:

```
file-{timestamp}-{random}-{original-name}
```

**예시:**
- 원본: `backup.tar.gz`
- 저장: `file-1698500000000-123456789-backup.tar.gz`

**구성 요소:**
- `file`: 고정 접두사
- `1698500000000`: 업로드 시간 (타임스탬프)
- `123456789`: 랜덤 숫자
- `backup.tar.gz`: 원본 파일명

</details>

---
