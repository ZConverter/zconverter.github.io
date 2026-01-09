---
layout: docs
title: ZDM CLI 호환성
section_title: ZDM CLI Documentation
navigation: cli
---

ZDM CLI 바이너리의 운영체제 호환성 정보입니다.

---

## Linux 호환 버전

<details markdown="1" open>
<summary><strong>세부 정보</strong></summary>

**요구사항:** GLIBC 2.17 이상

| 배포판 | 최소 버전 | 비고 |
|--------|-----------|------|
| CentOS | 7.0+ | GLIBC 2.17 |
| RHEL | 7.0+ | GLIBC 2.17 |
| Ubuntu | 14.04+ | GLIBC 2.19 |
| Debian | 8 (Jessie)+ | GLIBC 2.19 |
| Amazon Linux | 2+ | GLIBC 2.26 |
| Rocky Linux | 8.0+ | GLIBC 2.28 |
| AlmaLinux | 8.0+ | GLIBC 2.28 |
| Fedora | 21+ | GLIBC 2.20 |
| openSUSE | 13.2+ | GLIBC 2.19 |

**빌드 정보:**
- Node.js: v18.20.5 (unofficial-builds, GLIBC 2.17 호환)
- 빌드 환경: CentOS 7 Docker

</details>

---

## Windows 호환 버전

<details markdown="1" open>
<summary><strong>세부 정보</strong></summary>

**요구사항:** Windows 10 이상 (공식), Windows Server 2012 R2 이상 (비공식)

| 버전 | 지원 여부 | 비고 |
|------|-----------|------|
| Windows 11 | O | 권장 |
| Windows 10 (1809+) | O | 공식 지원 |
| Windows Server 2025 | O | 공식 지원 |
| Windows Server 2022 | O | 공식 지원 |
| Windows Server 2019 | O | 공식 지원 |
| Windows Server 2016 | O | 공식 지원 |
| Windows Server 2012 R2 | △ | 지원 (부분) |
| Windows Server 2012 | △ | 지원 (부분) |
| Windows Server 2008 R2 | △ | 지원 (부분) |
| Windows 8.1 | △ | 지원 (부분) |
| Windows 7 | △ | 지원 (부분) |

**빌드 정보:**
- Node.js: v22.13.0
- 빌드 방식: Node.js SEA (Single Executable Application)

</details>

---