---
layout: docs
title: "2.2 ZDM 저장소 구성"
section_title: "서버리스 복구 자동화 가이드 (NCP)"
navigation: ko-guide-serverless-dr-ncp
lang: ko
---

ZIA 이미지를 저장하기 위해 Repository 등록이 필요합니다.

Repository는 관리서버 Local Disk 또는 외부 Network Storage를 사용할 수 있으며,

SMB(CIFS) 또는 NFS 프로토콜을 지원합니다.

### ZDM 저장소 추가(Local Disk)

관리서버 내부 디스크를 Repository로 사용하는 경우 다음과 같이 설정합니다.

#### “ZDM(SMB)” 타입 저장소 추가

1.  **Web Portal**에 접속합니다.([2.3 참고](/guides/ko/serverless-dr/ncp/web-access))

2.  **Management → ZDM** 메뉴로 이동합니다.

3.  대상 ZDM을 선택한 후 **Add Repository**를 클릭합니다.

4.  Type에서 **ZDM(SMB)**를 선택하고 아래 정보를 입력합니다.

    1.  IP : Agent에서 접근 가능한 ZDM IP

    2.  Local Path : Repository 저장 경로

    3.  Account : SMB 인증 계정

    ‘sudo pdbedit -L’명령어를 통해 확인 가능

5.  Password: SMB 인증 비밀번호

6.  Force Register : 인증 없이 등록이 필요한 경우 체크합니다.

    ![](/assets/images/guides/serverless-dr-ncp/02-02-01.png)

#### “ZDM(NFS)” 타입 저장소 추가

1.  **Management → ZDM** 메뉴로 이동합니다.

2.  대상 ZDM을 선택한 후 **Add Repository**를 클릭합니다.

3.  Type에서 **ZDM(NFS)**를 선택하고 아래 정보를 입력합니다.

    1.  IP : Agent에서 접근 가능한 ZDM IP

    2.  NFS Local Path : Repository 저장 경로

    3.  Force Register : 인증 없이 등록이 필요한 경우 체크합니다.

    ![](/assets/images/guides/serverless-dr-ncp/02-02-02.png)

### ZDM 저장소 추가(Network Disk)

외부 NAS 또는 네트워크 스토리지를 사용하는 경우 다음과 같이 설정합니다.

#### “SMB” 타입 저장소 추가

1.  **Management → ZDM** 메뉴로 이동합니다.

2.  대상 ZDM을 선택한 후 **Add Repository**를 클릭합니다.

3.  Type에서 **ZDM(NFS)**를 선택하고 아래 정보를 입력합니다.

    1.  Remote Path : 네트워크 공유 경로

    2.  Local Path : ZDM에 마운트될 경로

    3.  Account : SMB 인증 계정

    4.  Password: SMB 인증 비밀번호

    5.  Force Register : 인증 없이 등록이 필요한 경우 체크합니다.

    ![](/assets/images/guides/serverless-dr-ncp/02-02-03.png)

#### “NFS” 타입 저장소 추가

1.  **Management → ZDM** 메뉴로 이동합니다.

2.  대상 ZDM을 선택한 후 **Add Repository**를 클릭합니다.

3.  Type에서 **ZDM(NFS)**를 선택하고 아래 정보를 입력합니다.

    1.  Remote Path : NFS 공유 경로

    2.  NFS Local Path : ZDM 마운트 경로

    3.  Force Register : 인증 없이 등록이 필요한 경우 체크합니다.

    ![](/assets/images/guides/serverless-dr-ncp/02-02-04.png)

### 저장소 관리

#### 저장소 정보

![](/assets/images/guides/serverless-dr-ncp/02-02-05.png)

- Repository

  - Repository Type: 저장소가 어떤 방식으로 사용되는지를 의미합니다.

  - Path(local): 서비스 센터에 연결되어 있는 경로입니다.

  - Path(remote): 저장소의 원격 경로입니다.

  - User: 저장소의 연결 계정입니다.

  - Disk size: 저장소의 용량 정보입니다.

  - Last authentication: 제일 마지막으로 저장소 정보를 갱신한 날짜입니다.

  - Misc: 인증/갱신/수정/삭제 기능을 사용할 수 있습니다.
