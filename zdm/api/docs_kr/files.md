---
layout: docs
# title: File Management
section_title: ZDM API Documentation
sidebar:
  - title: "API Documentation"
    links:
      - title: "API 소개"
        url: "/zdm/api/docs_kr"
      - title: "Overview"
        url: "/zdm/api/docs_kr/overview"
      - title: "Authentication"
        url: "/zdm/api/docs_kr/authentication"
      - title: "User Management"
        url: "/zdm/api/docs_kr/users"
      - title: "Server Management"
        url: "/zdm/api/docs_kr/servers"
      - title: "Schedule Management"
        url: "/zdm/api/docs_kr/schedules"
      - title: "Backup Management"
        url: "/zdm/api/docs_kr/backups"
      - title: "Recovery Management"
        url: "/zdm/api/docs_kr/recoveries"
      - title: "File Management"
        url: "/zdm/api/docs_kr/files"
        sublinks:
          - title: "파일 업로드"
            url: "/zdm/api/docs_kr/files#upload-file"
          - title: "파일 다운로드"
            url: "/zdm/api/docs_kr/files#download-file"
          - title: "파일 목록 조회"
            url: "/zdm/api/docs_kr/files#list-files"
      - title: "License Management"
        url: "/zdm/api/docs_kr/licenses"
      - title: "ZDM Center Management"
        url: "/zdm/api/docs_kr/zdm-centers"
---

## File Management

### POST `/files/upload` {#upload-file}

파일을 업로드합니다.

**Request:** Multipart form data

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| file | file | Required | 업로드할 파일 |

**Response:**

```json
{
  "success": true,
  "requestID": "req-file-upload",
  "data": {
    "file": {
      "originalName": "document.pdf",
      "fileName": "20240131_103045_document.pdf",
      "path": "/uploads/2024/01/31/20240131_103045_document.pdf",
      "size": 1048576,
      "mimeType": "application/pdf",
      "uploadedAt": "2024-01-31T10:30:45.123Z"
    }
  },
  "message": "파일이 성공적으로 업로드되었습니다",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**특징:**

- Multipart form data 형식으로 파일 전송
- 최대 파일 크기: 10MB
- 최대 파일 개수: 5개
- 한글 파일명 지원
- 고유한 파일명 자동 생성 (타임스탬프 + 랜덤 숫자)

**Status Codes:**

- `201` - 업로드 성공
- `400` - 잘못된 요청 (파일 크기 초과, 파일 개수 초과 등)
- `500` - 서버 오류

### GET `/files/download/:fileName` {#download-file}

파일을 다운로드합니다.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| fileName | string | Required | 다운로드할 파일명 |

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| download | boolean | Optional | 강제 다운로드 모드 |
| preview | boolean | Optional | 미리보기 모드 |
| range | string | Optional | 부분 다운로드 범위 (bytes=0-1023) |

**Response:** 파일 스트림 또는 에러 응답

**성공 시:** 파일이 직접 다운로드됩니다.

**실패 시 (파일 없음):**

```json
{
  "success": false,
  "requestID": "req-file-download",
  "error": "FILE_NOT_FOUND",
  "timestamp": "2024-01-31T10:30:45.123Z",
  "detail": {
    "fileName": "nonexistent.pdf",
    "message": "요청한 파일을 찾을 수 없습니다"
  }
}
```

**특징:**

- Content-Disposition 헤더를 통한 파일명 전달
- 한글 파일명 지원 (UTF-8 인코딩)
- MIME 타입 자동 감지

**Status Codes:**

- `200` - 다운로드 성공
- `404` - 파일을 찾을 수 없음
- `500` - 서버 오류

### GET `/files/list` {#list-files}

업로드된 파일 목록을 조회합니다.

**Response:**

```json
{
  "success": true,
  "requestID": "req-file-list",
  "data": {
    "files": [
      {
        "fileName": "file-1706688645123-987654321-document.pdf",
        "fileOriginName": "document.pdf",
        "size": "1.5 MB",
        "uploadDate": "2024-01-31 10:30:45"
      },
      {
        "fileName": "file-1706602245456-123456789-report.xlsx",
        "fileOriginName": "report.xlsx",
        "size": "512.3 KB",
        "uploadDate": "2024-01-30 14:15:22"
      }
    ],
    "totalCount": 2
  },
  "message": "File list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Response Fields:**

- `fileName`: 서버에 저장된 실제 파일명 (타임스탬프 포함)
- `fileOriginName`: 원본 파일명
- `size`: 파일 크기 (MB/KB 단위로 변환)
- `uploadDate`: 업로드 일시
- `totalCount`: 총 파일 개수

**Status Codes:**

- `200` - 조회 성공
- `500` - 서버 오류
