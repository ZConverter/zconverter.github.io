---
layout: docs
title: "5 복구 자동화 실행"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

## 5.1 서버리스 복구 자동화

서버리스 복구 자동화 기능은 기존 Target ZDM 없이 복구 과정을 자동화하는 기능을 제공합니다.

해당 가이드에서는 Naver Cloud Platform 환경에서 서버리스 복구 자동화 과정을 안내합니다.

1.  Source ZDM 서버에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  ZDM을 설치한 경로로 이동합니다. (2.1 참고)

3.  ZDM을 설치한 경로에서 **ncp-zdm-dr** 프로젝트의 경로를 확인합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-01.png)

4.  자동화 스크립트 실행에 필요한 파일을 생성하고, 정보를 입력합니다.

**4-1. .env** **파일 :** Target으로 사용할 클라우드 플랫폼 및 ZDM 인증 정보를 관리합니다.

1.  ncp-zdm-dr 디렉토리의 **.env.example 파일을 복사하여 .env 파일을 생성**합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-02.png)

2.  해당 파일에 소유자의 읽기, 쓰기 권한을 부여합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-02.png)

3.  .env 파일에 아래와 같이 인증 정보를 입력합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-03.png)

**4-2. dr-targets.auto.tfvars 파일 :** 복구할 VM 정보 및 ZDM 서버 정보를 관리합니다.

1.  **dr-targets.auto.tfvars.example 파일을 복사하여 dr-targets.auto.tfvars파일을 생성**합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-04.png)

2.  dr-targets.auto.tfvars 파일에 아래와 같이 인증 정보를 입력합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-05.png)

3.  ncp-zdm-dr 디렉토리의 deploy.sh 파일을 실행하여 복구 자동화를 진행합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-06.png)

4.  진행되는 로그를 모니터링하여 복구 현황을 파악합니다.

    ![](/assets/images/guides/serverless-dr-ncp/05-01-07.png)
