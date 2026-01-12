---
layout: docs
title: ZDM CLI 호환성
section_title: ZDM CLI Documentation
navigation: ko-cli
lang: ko
---

ZDM CLI 바이너리의 운영체제 호환성 정보입니다.

> **최종 업데이트:** 2025-01-09

---

## Linux 호환 버전

**요구사항:** GLIBC 2.17 이상

<details markdown="1">
<summary><strong>CentOS / RHEL</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| CentOS | 7.0 - 7.9 | 2.17 | O |
| CentOS | 8.0 - 8.5 | 2.28 | O |
| CentOS Stream | 8, 9 | 2.28+ | O |
| RHEL | 7.0 - 7.9 | 2.17 | O |
| RHEL | 8.0 - 8.10 | 2.28 | O |
| RHEL | 9.0 - 9.4 | 2.34 | O |

</details>

<details markdown="1">
<summary><strong>Ubuntu</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Ubuntu | 14.04 LTS (Trusty Tahr) | 2.19 | O |
| Ubuntu | 16.04 LTS (Xenial Xerus) | 2.23 | O |
| Ubuntu | 18.04 LTS (Bionic Beaver) | 2.27 | O |
| Ubuntu | 20.04 LTS (Focal Fossa) | 2.31 | O |
| Ubuntu | 22.04 LTS (Jammy Jellyfish) | 2.35 | O |
| Ubuntu | 24.04 LTS (Noble Numbat) | 2.39 | O |

</details>

<details markdown="1">
<summary><strong>Debian</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Debian | 8 (Jessie) | 2.19 | O |
| Debian | 9 (Stretch) | 2.24 | O |
| Debian | 10 (Buster) | 2.28 | O |
| Debian | 11 (Bullseye) | 2.31 | O |
| Debian | 12 (Bookworm) | 2.36 | O |

</details>

<details markdown="1">
<summary><strong>Amazon Linux</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Amazon Linux | 2 | 2.26 | O |
| Amazon Linux | 2023 | 2.34 | O |

</details>

<details markdown="1">
<summary><strong>Rocky Linux / AlmaLinux</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Rocky Linux | 8.0 - 8.10 | 2.28 | O |
| Rocky Linux | 9.0 - 9.4 | 2.34 | O |
| AlmaLinux | 8.0 - 8.10 | 2.28 | O |
| AlmaLinux | 9.0 - 9.4 | 2.34 | O |

</details>

<details markdown="1">
<summary><strong>Fedora</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Fedora | 21 - 25 | 2.20 - 2.24 | O |
| Fedora | 26 - 30 | 2.25 - 2.30 | O |
| Fedora | 31 - 35 | 2.30 - 2.34 | O |
| Fedora | 36 - 40 | 2.35 - 2.39 | O |
| Fedora | 41 | 2.40 | O |

</details>

<details markdown="1">
<summary><strong>openSUSE</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| openSUSE | 13.2 | 2.19 | O |
| openSUSE Leap | 15.0 - 15.2 | 2.26 | O |
| openSUSE Leap | 15.3 - 15.6 | 2.31 | O |
| openSUSE Tumbleweed | - | 2.38+ | O |

</details>

**빌드 정보:**
- Node.js: v18.20.5 (unofficial-builds, GLIBC 2.17 호환)
- 빌드 환경: CentOS 7 Docker

---

## Windows 호환 버전

**요구사항:** Windows 10 이상 (공식), Windows 7 이상 (부분 지원)

<details markdown="1">
<summary><strong>Windows Desktop</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Windows | 11 | - | O |
| Windows | 10 (1809+) | - | O |
| Windows | 8.1 | - | △ |
| Windows | 7 | - | △ |

</details>

<details markdown="1">
<summary><strong>Windows Server</strong></summary>

| 배포판 | 버전 | GLIBC | 지원 |
|--------|------|-------|------|
| Windows Server | 2025 | - | O |
| Windows Server | 2022 | - | O |
| Windows Server | 2019 | - | O |
| Windows Server | 2016 | - | O |
| Windows Server | 2012 R2 | - | △ |
| Windows Server | 2012 | - | △ |
| Windows Server | 2008 R2 | - | △ |

</details>

**빌드 정보:**
- Node.js: v22.13.0
- 빌드 방식: Node.js SEA (Single Executable Application)

---