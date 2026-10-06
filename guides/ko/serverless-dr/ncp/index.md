---
layout: docs
title: 서버리스 복구 자동화 가이드 (NCP)
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

![ZConverterCloud](/assets/images/guides/serverless-dr-ncp/00-00-01.png){: .doc-logo-banner }

**ZConverter 서버리스 복구 자동화 가이드 — Naver Cloud Platform**

Source 서버의 Agent가 ZIA 백업 이미지를 생성해 Source ZDM의 Repository에 저장합니다.
저장소 소산 복제로 백업 이미지를 NCP Object Storage에 업로드한 뒤, Source ZDM의
`ncp-zdm-dr` 스크립트로 복구를 자동화합니다. 기존 Target ZDM은 사전에 설치하지 않습니다.

---

## 목차

### 1 개요 및 준비

| 문서 | 내용 |
|------|------|
| [1 개요 및 준비](/guides/ko/serverless-dr/ncp/overview) | 작업 흐름, 시스템·네트워크 요구사항, 지원 OS·클라우드, 사전 준비 확인 |

### 2 Source ZDM 설치와 설정

| 문서 | 내용 |
|------|------|
| [2.1 ZDM 설치](/guides/ko/serverless-dr/ncp/zdm-install) | 설치 패키지를 이용한 Source 환경 ZDM 설치 |
| [2.2 ZDM 저장소 구성](/guides/ko/serverless-dr/ncp/zdm-repository) | 백업 이미지를 저장할 Repository 구성 |
| [2.3 Web Access](/guides/ko/serverless-dr/ncp/web-access) | ZDM Web Portal 접속 |
| [2.4 라이선스 등록](/guides/ko/serverless-dr/ncp/license) | 라이선스 등록 및 확인 |

### 3 백업 구성

| 문서 | 내용 |
|------|------|
| [3.1 Agent 설치 (Source)](/guides/ko/serverless-dr/ncp/agent-install) | Source 서버 ZConverter Agent 설치 |
| [3.2 백업 작업 등록](/guides/ko/serverless-dr/ncp/backup-regist) | 백업 작업 생성 및 옵션 설정 |
| [3.3 백업 작업 모니터링](/guides/ko/serverless-dr/ncp/backup-monitoring) | 백업 진행 상태 확인 |

### 4 저장소 소산 복제 (Cloud Storage)

| 문서 | 내용 |
|------|------|
| [4.1 클라우드 인증 추가](/guides/ko/serverless-dr/ncp/cloud-credential) | 오브젝트 스토리지용 클라우드 인증정보 등록 |
| [4.2 NCP 인증정보 설정 파일 작성](/guides/ko/serverless-dr/ncp/ncp-credential-file) | NCP 인증정보 파일 작성 |
| [4.3 클라우드 저장소 추가](/guides/ko/serverless-dr/ncp/cloud-storage) | NCP Object Storage 저장소 등록 |
| [4.4 저장소 소산 복제 등록](/guides/ko/serverless-dr/ncp/replication-regist) | 소산 복제 작업 등록 |
| [4.5 저장소 소산 복제 모니터링](/guides/ko/serverless-dr/ncp/replication-monitoring) | 복제 진행 상태 확인 |

### 5 복구 자동화 실행

| 문서 | 내용 |
|------|------|
| [5 복구 자동화 실행](/guides/ko/serverless-dr/ncp/recovery-automation) | `ncp-zdm-dr` 스크립트를 이용한 서버리스 복구 자동화 |

### 6 부록

| 문서 | 내용 |
|------|------|
| [6 부록](/guides/ko/serverless-dr/ncp/appendix-server-access) | 서버 SSH 접속 방법 |

---

![ZConverter Cloud](/assets/images/guides/serverless-dr-ncp/00-00-02.png){: .doc-logo }

*NOTE: DO NOT COPY, REPRODUCE OR REDISTRIBUTE WITHOUT EXPRESS WRITTEN CONSENT OF THE AUTHOR*
*Copyright© ZConverterCloud, Inc.*
