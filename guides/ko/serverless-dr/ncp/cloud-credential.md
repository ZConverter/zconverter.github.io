---
layout: docs
title: "4.1 클라우드 인증 추가"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

1.  오브젝트 스토리지 사용을 위한 클라우드 인증정보 등록 기능입니다.

2.  상단의 다운로드 버튼을 클릭하여 기본 설정 파일이 다운로드 할 수 있고 해당 파일의 내용을 채워서 추가버튼을 이용하여 해당 파일의 업로드가 가능합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-01.png)

3.  파일의 확장자명은 반드시 .conf의 형태를 가지고 있어야 합니다.

    ![텍스트, 스크린샷이(가) 표시된 사진 AI 생성 콘텐츠는 정확하지 않을 수 있습니다.](/assets/images/guides/serverless-dr-ncp/04-01-02.png)

4.  파일의 내용을 수정할 때 해당되는 클라우드 플랫폼을 제외한 나머지 부분은 삭제를  
    권장합니다.

5.  이 가이드의 서버리스 복구 자동화 대상은 NCP입니다. 클라우드 인증에는 NCP Object Storage 설정 파일을 사용합니다.

### 등록 방법

1.  추가 버튼을 클릭합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-03.png)

2.  해당하는 클라우드 플랫폼을 선택한후 설정파일을 업로드 합니다.

3.  파일명은 중복되지 않습니다.

    1.  ZDM: 서비스 센터를 의미합니다.

    2.  표시 명: 설정정보에 등록될 표시명을 입력합니다.

    3.  클라우드 플랫폼: 사용할 오브젝트 스토리지가 있는 클라우드 플랫폼을 선택합니다.

    4.  설정파일: 설정파일을 참조하여 파일명.conf의 형태의 파일로 저장한 뒤 업로드합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-04.png)

4.  확인 버튼을 클릭하면 해당 파일이 유효한지 검증을 시작합니다.

5.  인증 요청이 실패하면 아래화면처럼 표시되며 설정파일을 다시 확인한 후 다시  
    시도합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-05.png)

6.  인증 요청이 성공하면 아래화면처럼 표시되며 해당 설정파일을 이용하여 오브젝트  
    스토리지로 동기화 작업이 가능합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-06.png)

### 삭제 방법

1.  해당 설정파일의 우측 관리칼럼의 삭제 버튼을 클릭하여 설정파일 삭제가 가능합니다.

    ![](/assets/images/guides/serverless-dr-ncp/04-01-07.png)
