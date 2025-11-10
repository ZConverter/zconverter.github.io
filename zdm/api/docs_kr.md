---
layout: page
title: ZDM API RESTful Documentation
---

## Table of Contents

1. [Overview & Authentication](docs_kr/overview)
2. [User Management](docs_kr/users)
3. [Server Management](docs_kr/servers)
4. [Schedule Management](docs_kr/schedules)
5. [Backup Management](docs_kr/backups)
6. [Recovery Management](docs_kr/recoveries)
7. [File Management](docs_kr/files)
8. [License Management](docs_kr/licenses)
9. [ZDM Center Management](docs_kr/zdm-centers)

---

## Quick Links

### 인증 (Authentication)

- [POST /auth/issue](docs_kr/overview#post-authissue) - 토큰 발급

### 사용자 관리 (User Management)

- [GET /users](docs_kr/users#get-users) - 사용자 목록 조회
- [GET /users/:identifier](docs_kr/users#get-usersidentifier) - 특정 사용자 조회
- [PUT /users/:identifier](docs_kr/users#put-usersidentifier) - 사용자 정보 업데이트

### 서버 관리 (Server Management)

- [GET /servers](docs_kr/servers#get-servers) - 서버 목록 조회
- [GET /servers/:identifier](docs_kr/servers#get-serversidentifier) - 특정 서버 조회
- [GET /servers/:identifier/partitions](docs_kr/servers#get-serversidentifierpartitions) - 특정 서버 파티션 조회
- [GET /servers/partitions](docs_kr/servers#get-serverspartitions) - 모든 서버 파티션 조회

### 스케줄 관리 (Schedule Management)

- [GET /schedules](docs_kr/schedules#get-schedules) - 스케줄 목록 조회
- [GET /schedules/:identifier](docs_kr/schedules#get-schedulesidentifier) - 특정 스케줄 조회
- [POST /schedules](docs_kr/schedules#post-schedules) - 스케줄 생성

### 백업 관리 (Backup Management)

- [GET /backups](docs_kr/backups#get-backups) - 백업 목록 조회
- [GET /backups/:identifier](docs_kr/backups#get-backupsidentifier) - 특정 백업 조회
- [POST /backups](docs_kr/backups#post-backups) - 백업 작업 등록
- [PUT /backups/:identifier](docs_kr/backups#put-backupsidentifier) - 백업 작업 수정
- [DELETE /backups/:identifier](docs_kr/backups#delete-backupsidentifier) - 백업 작업 삭제
- [GET /backups/monitoring/job/:identifier](docs_kr/backups#get-backupsmonitoringjobidentifier) - 백업 작업 모니터링
- [GET /backups/monitoring/system/:identifier](docs_kr/backups#get-backupsmonitoringsystemidentifier) - 백업 시스템 모니터링

### 복구 관리 (Recovery Management)

- [GET /recoveries](docs_kr/recoveries#get-recoveries) - 복구 목록 조회
- [GET /recoveries/:identifier](docs_kr/recoveries#get-recoveriesidentifier) - 특정 복구 조회
- [POST /recoveries](docs_kr/recoveries#post-recoveries) - 복구 작업 등록
- [PUT /recoveries/:identifier](docs_kr/recoveries#put-recoveriesidentifier) - 복구 작업 수정
- [DELETE /recoveries/:identifier](docs_kr/recoveries#delete-recoveriesidentifier) - 복구 작업 삭제
- [GET /recoveries/monitoring/job/:identifier](docs_kr/recoveries#get-recoveriesmonitoringjobidentifier) - 복구 작업 모니터링
- [GET /recoveries/monitoring/system/:identifier](docs_kr/recoveries#get-recoveriesmonitoringsystemidentifier) - 복구 시스템 모니터링

### 파일 관리 (File Management)

- [POST /files/upload](docs_kr/files#post-filesupload) - 파일 업로드
- [GET /files/list](docs_kr/files#get-fileslist) - 업로드된 파일 목록 조회
- [GET /files/download/:fileName](docs_kr/files#get-filesdownloadfilename) - 파일 다운로드

### 라이선스 관리 (License Management)

- [GET /licenses](docs_kr/licenses#get-licenses) - 라이선스 목록 조회
- [GET /licenses/:identifier](docs_kr/licenses#get-licensesidentifier) - 특정 라이선스 조회
- [GET /licenses/key/:key](docs_kr/licenses#get-licenseskeykey) - 키로 라이선스 조회
- [POST /licenses](docs_kr/licenses#post-licenses) - 라이선스 등록
- [PUT /licenses/assign](docs_kr/licenses#put-licensesassign) - 라이선스 할당

### ZDM 센터 관리 (ZDM Center Management)

- [GET /zdms](docs_kr/zdm-centers#get-zdms) - ZDM 센터 목록 조회
- [GET /zdms/:identifier](docs_kr/zdm-centers#get-zdmsidentifier) - 특정 ZDM 센터 조회
- [GET /zdms/:identifier/repositories](docs_kr/zdm-centers#get-zdmsidentifierrepositories) - ZDM 센터 리포지토리 조회
- [GET /zdms/repositories](docs_kr/zdm-centers#get-zdmsrepositories) - 모든 ZDM 리포지토리 조회
