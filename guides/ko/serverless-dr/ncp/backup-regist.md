---
layout: docs
title: "3.2 백업 작업 등록"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

1.  **Registration System(Backup)** 메뉴로 이동합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-02-01.png)

2.  Backup 대상 서버를 선택한 후 **Next**를 클릭합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-02-02.png)

3.  Backup할 파티션(파일시스템)을 선택합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-02-03.png)

| **항목**    | **설명**                              |
|-------------|---------------------------------------|
| Job Name    | Backup 작업 이름을 입력합니다.        |
| Backup Type | Full / Incremental 방식을 선택합니다. |
| Rotation    | 백업 보관 개수를 설정합니다.          |

4.  Backup 이미지를 저장할 Repository를 선택합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-02-04.png)

5.  스케줄 및 옵션을 선택하고 다음 버튼을 클릭합니다.

    1.  옵션

    ![](/assets/images/guides/serverless-dr-ncp/03-02-05.png)

| **옵션**       | **설명**                                   |
|----------------|--------------------------------------------|
| Email          | 작업 결과를 이메일로 전송합니다.           |
| Compression    | 데이터 압축을 적용합니다.                  |
| Script         | 작업 완료 후 사용자 스크립트를 실행합니다. |
| Exclude Folder | 백업에서 제외할 디렉토리를 설정합니다.     |

6.  설정 내용을 확인하고 Register 버튼을 클릭하여 Backup Job을 생성합니다.

    ![](/assets/images/guides/serverless-dr-ncp/03-02-06.png)
