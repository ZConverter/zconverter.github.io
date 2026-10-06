---
layout: docs
title: "1 개요 및 준비"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

## 1.1 서버리스 복구 작업 흐름

Source 서버의 Agent가 ZIA 백업 이미지를 생성해 Source ZDM의 Repository에 저장합니다. 저장소 소산 복제로 백업 이미지를 NCP Object Storage에 업로드한 뒤, Source ZDM의 ncp-zdm-dr 스크립트로 복구를 자동화합니다. 기존 Target ZDM은 사전에 설치하지 않습니다.

## 1.2 시스템 요구사항

### ZDM (ZConverter DR Manager)

| 항목 | 요구사항 |
|------|----------|
| OS | Ubuntu 22.04 / 24.04<br />Rocky Linux 8 / 9<br />RHEL 8 / 9 |
| CPU | 2 Core 이상 |
| Memory | 8 GB 이상 |
| Disk | 15GB 이상(ZDM 설치 용량)<br />ZDM 저장소 활용 시 Repository 연결용 디스크 필요 |
| Network | 정의된 포트에 대한 통신 가능 환경 |

※ 용량 산정 기준

- 필요 용량 = Source 서버 실제 사용 데이터 총합 이상

- 용도 및 보관 정책에 따라 용량 고려

- 백업 대상 서버 수에 따라 권장 사양이 늘어날 수 있음

### 백업 대상 Source Server

| 항목     | 요구사항                           |
|----------|------------------------------------|
| OS       | Windows / Linux                    |
| 유형     | BareMetal / VM / Cloud VM          |
| 권한     | 관리자 권한 (root / administrator) |
| 네트워크 | 정의된 포트에 대한 통신 가능 환경  |

## 1.3 네트워크 요구사항

Source ZDM, 백업 대상 서버, Repository 간 통신을 확인합니다. 방화벽에서는 사용하는 저장소 프로토콜에 해당하는 포트만 허용합니다.

| **출발지**  | **목적지** | **TCP 포트**                     | **용도**                    |
|-------------|------------|----------------------------------|-----------------------------|
| 관리자      | Source ZDM | 80, 22                           | Web Portal 및 SSH 접속      |
| Source 서버 | Source ZDM | 80, 53306                        | Agent 파일 다운로드 및 통신 |
| Source 서버 | Repository | 139, 445 (SMB) / 111, 2049 (NFS) | ZIA 백업 이미지 저장        |

NCP Object Storage와 NCP API 엔드포인트에 접근할 수 있도록 Source ZDM의 외부 통신 정책도 확인합니다.

## 1.4 지원 OS 환경

<details markdown="1">
<summary><strong>Windows</strong></summary>

| **Version**                            | **Edition**                           |
|----------------------------------------|---------------------------------------|
| Microsoft Windows Server 2025          | Datacenter                            |
| Microsoft Windows Server 2022          | Standard, Datacenter                  |
| Microsoft Windows Server 2019          | Standard, Datacenter                  |
| Microsoft Windows Server 2016          | Standard, Datacenter                  |
| Microsoft Windows Server 2012, 2012 R2 | Standard, Datacenter                  |
| Microsoft Windows Server 2008, 2008 R2 | Standard, Enterprise, Datacenter, Web |
| Microsoft Windows Server 2003, 2003 R2 | Standard, Enterprise, Datacenter, Web |

</details>

<details markdown="1">
<summary><strong>Linux</strong></summary>

| **Version**                   | **Edition**                     |
|-------------------------------|---------------------------------|
| RedHat Enterprise Linux(RHEL) | 5 ~ 10 (All Editions)           |
| CentOS                        | 5 ~ 8 (All Editions)            |
| CentOS Stream                 | 8, 9 (All Editions)             |
| Oracle Linux                  | 5 ~ 10 (All Editions)           |
| Rocky Linux                   | 8, 9, 10 (All Editions)         |
| Alma Linux                    | 8, 9 (All Editions)             |
| SUSE Linux Enterprise (SLES)  | 11, 12, 15 (SP included)        |
| Debian                        | 11 , 12 , 13                    |
| Ubuntu                        | 12.04 – 24.04 (All Editions)    |
| Amazon Linux                  | 1, 2, 2023 (All Editions)       |
| Fedora                        | Latest - Rolling (All Editions) |

</details>

## 1.5 지원 클라우드 환경

이 문서의 서버리스 복구 자동화 스크립트가 지원하는 대상 클라우드는 Naver Cloud Platform(NCP)입니다. 다른 클라우드와 가상화 플랫폼은 이 절차의 대상에 포함하지 않습니다.

## 1.6 사전 준비 확인

> • Source ZDM 서버, 설치 패키지, 관리자(root) 권한을 준비하고 1.2절의 사양과 1.3절의 통신 조건을 확인합니다.
>
> • 백업 대상 Source 서버의 OS 지원 여부와 관리자 권한을 확인합니다. Agent 설치와 라이선스 할당이 필요합니다.
>
> • Repository를 준비하고 백업 대상 서버의 실제 사용 데이터 합계와 보관 정책을 기준으로 용량을 계획합니다.
>
> • NCP 계정, Object Storage 사용 권한, Access Key ID와 Secret Key, 리전 및 Endpoint를 준비합니다.
>
> • 복구 대상 VM의 구성 값과 ZDM 접속 정보를 정리하고, Source ZDM 설치 경로에 ncp-zdm-dr 프로젝트와 .env.example, dr-targets.auto.tfvars.example, deploy.sh가 있는지 확인합니다.
>
> • 5장 실행 전에는 백업 작업과 저장소 소산 복제를 완료하고 NCP Object Storage에 백업 이미지가 있는지 확인합니다.
