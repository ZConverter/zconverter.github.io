---
layout: docs
title: File Management
section_title: ZDM CLI Documentation
sidebar:
  - title: "CLI Documentation"
    links:
      - title: "CLI 소개"
        url: "/zdm/cli/docs_kr"
      - title: "Overview"
        url: "/zdm/cli/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/cli/docs_kr/authentication"
      - title: "Config Management"
        url: "/zdm/cli/docs_kr/config"
      - title: "ZDM Center Management"
        url: "/zdm/cli/docs_kr/zdm-centers"
      - title: "Server Management"
        url: "/zdm/cli/docs_kr/servers"
      - title: "License Management"
        url: "/zdm/cli/docs_kr/licenses"
      - title: "Backup Management"
        url: "/zdm/cli/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/cli/docs_kr/recoveries"
      - title: "Schedule Management"
        url: "/zdm/cli/docs_kr/schedules"
      - title: "File Management"
        url: "/zdm/cli/docs_kr/files"
        sublinks:
          - title: "파일 목록 조회"
            url: "/zdm/cli/docs_kr/files#file-list"
          - title: "파일 업로드"
            url: "/zdm/cli/docs_kr/files#file-upload"
          - title: "파일 다운로드"
            url: "/zdm/cli/docs_kr/files#file-download"
---

파일을 업로드, 다운로드, 조회합니다.

---

## File Commands

### `file list` {#file-list}

업로드된 파일 목록을 조회합니다.

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

### `file upload` {#file-upload}

파일을 서버에 업로드합니다.

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

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--file-path` | `-f` | string | Required | 업로드할 파일의 경로 |

</details>

<details markdown="1" open>
<summary><strong>응답 예시</strong></summary>

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

### `file download` {#file-download}

서버에서 파일을 다운로드합니다.

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

| 파라미터 | 별칭 | 타입 | 필수 | 설명 |
|----------|------|------|------|------|
| `--file-name` | `-f` | string | Required | 다운로드할 파일명 |
| `--save-path` | `-s` | string | Optional | 저장할 경로 (기본값: 현재 디렉토리) |

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

<!-- ## 파일 타입 및 용도

<details markdown="1" open>
<summary><strong>지원 파일 타입</strong></summary>

**스크립트 파일:**
- `.sh` (Bash 스크립트)
- `.ps1` (PowerShell 스크립트)
- `.py` (Python 스크립트)

**설정 파일:**
- `.json` (JSON 설정)
- `.yaml`, `.yml` (YAML 설정)
- `.conf` (설정 파일)

**백업 파일:**
- `.tar.gz`, `.tgz` (압축 아카이브)
- `.zip` (압축 파일)
- `.bak` (백업 파일)

**기타:**
- `.txt` (텍스트 파일)
- `.log` (로그 파일)
- `.csv` (데이터 파일)

</details>

<details markdown="1" open>
<summary><strong>파일 용도</strong></summary>CLI를 처음 실행하면 자동으로 설정 디렉토리와 파일이 생성됩니다.

**스크립트 실행:**
백업/복구 작업 전후에 실행할 스크립트를 업로드합니다.

```bash
# 스크립트 업로드
zdm-cli file upload --file-path ./pre-backup.sh

# 백업 작업에 스크립트 적용
zdm-cli backup regist \
  --server web-01 \
  --mode full \
  --scriptPath /scripts/pre-backup.sh \
  --scriptRun before
```

**스케줄 정의:**
스케줄 JSON 파일을 업로드합니다.

```bash
# 스케줄 파일 업로드
zdm-cli file upload --file-path ./daily-schedule.json

# 스케줄 등록
zdm-cli schedule regist --path ./daily-schedule.json
```

**설정 백업:**
설정 파일을 백업용으로 업로드합니다.

```bash
# 설정 파일 업로드
zdm-cli file upload --file-path ./zdm-config.json
```

</details>

---

## 사용 시나리오

<details markdown="1" open>
<summary><strong>백업 스크립트 관리</strong></summary>

**1단계: 스크립트 작성**
```bash
# pre-backup.sh
#!/bin/bash
echo "Starting pre-backup tasks..."
systemctl stop myapp
echo "Application stopped"
```

**2단계: 스크립트 업로드**
```bash
zdm-cli file upload --file-path ./pre-backup.sh
```

**3단계: 업로드 확인**
```bash
zdm-cli file list
```

**4단계: 백업 작업에 적용**
```bash
zdm-cli backup regist \
  --server web-01 \
  --mode full \
  --scriptPath /scripts/pre-backup.sh \
  --scriptRun before
```

</details>

<details markdown="1" open>
<summary><strong>스케줄 파일 관리</strong></summary>

**1단계: 스케줄 생성**
```bash
zdm-cli schedule create --type 3 --basic-time 02:00 --path ./daily-schedule.json
```

**2단계: 스케줄 파일 검증**
```bash
zdm-cli schedule verify --path ./daily-schedule.json
```

**3단계: 스케줄 파일 업로드**
```bash
zdm-cli file upload --file-path ./daily-schedule.json
```

**4단계: 스케줄 등록**
```bash
zdm-cli schedule regist --path ./daily-schedule.json
```

</details>

<details markdown="1" open>
<summary><strong>설정 파일 백업 및 복원</strong></summary>

**백업:**
```bash
# 현재 설정 백업
cp ~/.zdm-cli/config.json ./zdm-config-backup.json

# 서버에 업로드
zdm-cli file upload --file-path ./zdm-config-backup.json

# 업로드 확인
zdm-cli file list
```

**복원:**
```bash
# 파일 목록 확인
zdm-cli file list

# 설정 파일 다운로드
zdm-cli file download --file-name zdm-config-backup.json --save-path ./restored-config.json

# 설정 복원
cp ./restored-config.json ~/.zdm-cli/config.json
```

</details>

<details markdown="1" open>
<summary><strong>대용량 파일 관리</strong></summary>

```bash
# 대용량 백업 파일 업로드
zdm-cli file upload --file-path ./large-backup.tar.gz

# 진행률 확인하며 다운로드
zdm-cli file download --file-name large-backup.tar.gz --save-path /mnt/storage/

# 파일 정보 확인
zdm-cli file list --output json | grep large-backup
```

</details>

---

## 파일 크기 제한

<details markdown="1" open>
<summary><strong>업로드 제한</strong></summary>

**일반적인 제한:**
- 최대 파일 크기는 서버 설정에 따라 다름
- 일반적으로 100MB ~ 10GB
- 네트워크 타임아웃 고려

**대용량 파일 처리:**
```bash
# 네트워크 안정적인 환경에서 업로드
zdm-cli file upload --file-path ./large-file.tar.gz

# 업로드 실패 시 파일 분할 고려
split -b 100M large-file.tar.gz large-file-part-
```

</details>

---

## 보안 고려사항

<details markdown="1" open>
<summary><strong>파일 보안</strong></summary>

**권장사항:**
- 민감한 정보가 포함된 파일 업로드 주의
- 스크립트 파일의 권한 확인
- 암호화된 파일 사용 권장

**스크립트 보안:**
```bash
# 스크립트 권한 확인 후 업로드
chmod 700 pre-backup.sh
zdm-cli file upload --file-path ./pre-backup.sh

# 업로드된 스크립트는 서버에서 실행 권한 확인 필요
```

</details>

<details markdown="1" open>
<summary><strong>접근 제어</strong></summary>

- 업로드된 파일은 인증된 사용자만 접근 가능
- 파일 다운로드 시 토큰 인증 필요
- 파일 목록 조회 권한 확인

</details>

--- -->