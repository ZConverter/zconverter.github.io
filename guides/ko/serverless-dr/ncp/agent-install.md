---
layout: docs
title: "3.1 Agent 설치 (Source)"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

Backup 수행을 위해서는 Source 서버에 ZConverter Agent 설치가 필요합니다.

Agent는 OS 유형에 따라 Linux / Windows 방식으로 설치합니다.

### Linux 서버

1.  ZDM Web Portal에 접속합니다.

2.  **Agent** 메뉴로 이동합니다.

3.  **Linux (Source)** 항목에서 설치 스크립트를 복사하거나 Agent 파일을 다운로드합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-01.png)

**(비대화형 모드)** - 설치스크립트 복사 시 자동설치

1.  Source 서버에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  설치 스크립트를 쉘에서 붙여넣기 하여 Agent를 설치합니다.

    ```bash
    # ZConverter Agent Installation Script for Linux
    ZDM_IP="10.0.0.46"
    ZDM_USER=admin@zconverter.com
    curl -o /tmp/ZConverter_CloudSource_Setup_Linux.tar.gz \
    http://$ZDM_IP/download/ZConverter_CloudSource_Setup_Linux.tar.gz
    tar zxvf /tmp/ZConverter_CloudSource_Setup_Linux.tar.gz -C /tmp
    /tmp/zconverter_install_source/install.sh -s $ZDM_IP -u $ZDM_USER
    ```

**(대화형 모드)**

1.  Source 서버에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  다운로드한 Agent 파일을 Source 서버로 전송합니다.

    ```bash
    ZConverter_Cloud_Source_Setup_Linux.tar.gz
    ```

3.  압축을 해제합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-02.png)

4.  설치 스크립트를 실행합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-03.png)

5.  설치과정에서 ZDM 정보를 입력합니다.

6.  입력 완료 후 Agent 설치가 진행됩니다.

#### 설치 확인

1.  ZDM Web Portal에 접속합니다. ([2.3 참고](/guides/ko/serverless-dr/ncp/web-access))

2.  **Management → System** 메뉴에서 Source 서버 목록이 보이는지 확인합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-04.png)

3.  Source 서버를 선택한 후 “Assign License”를 실행합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-05.png)

4.  라이선스 선택 후 Source 서버에 라이선스를 할당합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-06.png)

5.  할당이 완료되면 Status가 “Running”으로 변경됩니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-07.png)

### Windows 서버

1.  ZDM Web Portal에 접속합니다.([2.3 참고](/guides/ko/serverless-dr/ncp/web-access))

2.  **Agent** 메뉴로 이동합니다.

3.  **Windows (Source)** 항목에서 설치 스크립트를 복사하거나 Agent 파일을 다운로드합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-01.png)

**(비대화형 모드)** - 설치스크립트 복사 시 자동설치

1.  Source 서버에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  설치 스크립트를 PowerShell에서 붙여넣기 하여 Agent를 설치합니다.

    ```powershell
    # ZConverter Agent Installation Script for Window
    $ZDM_IP = "10.0.0.46"
    $ZDM_USER = "admin@zconverter.com"
    $TempDir = "$env:TEMP\ZConverter"
    $ExeFile = "$TempDir\ZConverter_CloudSource_Setup_Windows.exe"
    $Url     = "http://$ZDM_IP/download/ZConverter_CloudSource_Setup_Windows.exe"
    if (!(Test-Path $TempDir)) {
        New-Item -ItemType Directory -Path $TempDir | Out-Null
    }
    # Download agent
    curl.exe -L -o "$ExeFile" "$Url"
    Start-Process $ExeFile "-s $ZDM_IP -u $ZDM_USER" -Wait
    ```

**(대화형 모드)**

1.  Source에 접속합니다. ([서버 접속 방법 참고](/guides/ko/serverless-dr/ncp/appendix-server-access))

2.  다운로드한 Agent 파일을 Source 서버로 전송합니다.

    ```bash
    ZConverter_CloudSource_Setup_Windows.exe
    ```

3.  설치 스크립트를 실행합니다.

    ![텍스트, 폰트, 포스터, 스크린샷이(가) 표시된 사진 자동 생성된 설명](/assets/images/guides/serverless-dr-ncp/03-01-08.png)

    ![텍스트, 전자제품, 스크린샷, 폰트이(가) 표시된 사진 자동 생성된 설명](/assets/images/guides/serverless-dr-ncp/03-01-09.png) ![텍스트, 전자제품, 스크린샷, 소프트웨어이(가) 표시된 사진 자동 생성된 설명](/assets/images/guides/serverless-dr-ncp/03-01-10.png)

    ![](/assets/images/guides/serverless-dr-ncp/03-01-11.png)

4.  설치과정에서 ZDM 정보를 입력합니다.

5.  Verify를 통해 실제 ZDM과 연결이 되는지 검증합니다.

6.  OK 입력 완료 후 Agent 설치가 진행됩니다.

#### 설치 확인

1.  ZDM Web Portal에 접속합니다.

2.  **Management → System** 메뉴에서 Source 서버가 정상 등록되었는지 확인합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-12.png)

3.  Source 서버를 선택한 후 “Assign License” 를 실행합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-13.png)

4.  라이선스 선택 후 Source 서버에 라이선스를 할당합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-06.png)

5.  할당이 완료되면 Status가 “Running”으로 변경됩니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-01-14.png)
