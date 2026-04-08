---
layout: docs
title: ZDM API Documentation v1.3.0
section_title: ZDM API Documentation
navigation: ko-api-1.3.0
lang: ko
---

{% capture changelog %}
<details markdown="1" open>
<summary><strong>Cloud Auth - 신규 엔드포인트</strong></summary>

**ZOS 클라우드 인증 (파일 업로드 방식)**
- **POST /cloud-auth/zos** — ZOS 인증 키 파일 업로드 + 메타데이터 등록
- **GET /cloud-auth/zos** — ZOS 인증 목록 조회
- **GET /cloud-auth/zos/download/:fileName** — ZOS 인증 키 파일 다운로드
- **DELETE /cloud-auth/zos/:identifier** — ZOS 인증 삭제 (ID 또는 파일명)

**Recovery 클라우드 인증 (body 등록 방식)**
- **POST /cloud-auth/recovery** — Recovery 인증 정보 등록 (GCP: 키 파일 업로드 포함)
- **GET /cloud-auth/recovery** — Recovery 인증 목록 조회
- **DELETE /cloud-auth/recovery/:identifier** — Recovery 인증 삭제

**리전 목록 조회**
- **GET /cloud-auth/regions/:platform** — 플랫폼별 리전 목록 조회 (aws, gcp)

</details>

<details markdown="1" open>
<summary><strong>OS Replication - 신규 엔드포인트</strong></summary>

- **POST /os-replications** — OS 복제 작업 등록
- **GET /os-replications** — OS 복제 작업 목록 조회
- **GET /os-replications/:identifier** — OS 복제 작업 단건 조회
- **PUT /os-replications/:identifier** — OS 복제 작업 수정
- **DELETE /os-replications/:identifier** — OS 복제 작업 삭제
- **GET /os-replications/histories** — OS 복제 히스토리 목록 조회
- **GET /os-replications/histories/:identifier** — OS 복제 히스토리 단건 조회
- **GET /os-replications/monitoring/job/:identifier** — OS 복제 작업 모니터링

</details>

<details markdown="1" open>
<summary><strong>Cloud Auth 지원 플랫폼</strong></summary>

> **ZOS**: OCI, NHN, NCP, AWS, Azure, MinIO
>
> **Recovery**: AWS, GCP
> - AWS — Access Key, Secret Key, Region 기반 인증
> - GCP — Service Account, Project, Service Key File 기반 인증 (키 파일 업로드 필수)

</details>

<details markdown="1" open>
<summary><strong>OS Replication 복제 유형</strong></summary>

</details>

<details markdown="1" open>
<summary><strong>기타 변경사항</strong></summary>

- `CLOUD_AUTH_FILE_SAVE_PATH`, `CLOUD_RETION_FILE_SAVE_PATH` 환경변수 추가

</details>
{% endcapture %}

{% include zdm/ko/api/index.md version="1.3.0" changelog=changelog changelog_title="변경 사항" %}
