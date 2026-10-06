---
layout: docs
title: "2.1 ZDM 설치"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

ZConverter 관리서버(ZDM)는 제공되는 설치 패키지를 이용하여 Source 환경에 설치합니다.

### 설치 파일 준비

1.  설치 대상 서버에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  설치 파일을 서버로 복사합니다.

    예시:
>
> ```bash
> install_zdm_v7.1_build1000.tar.gz
> ```

3.  압축을 해제합니다.

    ```bash
    tar zxvf install_zdm_v7.1_build1000.tar.gz
    tar xvf instsall_zdm_v7.1_build1000.tar (.tar 파일 압축 해제 시)
    ```

### Repository 디스크 초기화 (Optional)

관리서버에 추가 디스크를 Repository 용도로 사용하는 경우,  
init_repository.sh 스크립트를 통해 디스크 초기화 및 마운트를 자동으로 구성합니다.

1.  대화형 모드

    ```bash
    ./init_repository.sh
    ```

2.  비대화형 모드 (Silent Mode)

    ```bash
    ./init_repository.sh -d <디바이스 경로> -p <마운트 경로>
    ```

    ![](/assets/images/guides/serverless-dr-ncp/02-01-01.png)

### ZConverter 관리서버(ZDM) 설치

설치 스크립트를 실행하여 ZDM을 설치합니다.

```bash
./install.sh
```

- 설치 시간은 환경에 따라 약 10 ~ 30분 소요됩니다.

- 설치 완료 후 ZDM 서비스가 자동으로 실행됩니다.

![](/assets/images/guides/serverless-dr-ncp/02-01-02.png)
