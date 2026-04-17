
ZDM 서버 파일 관리 기능에 대한 개요입니다. 서버에 파일을 업로드, 다운로드하고 목록을 조회할 수 있습니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [하위 명령어](#하위-명령어)
- [파일 이름 형식](#파일-이름-형식)

</details>

---

## 하위 명령어

<details markdown="1" open>
<summary><strong>file 하위 명령어 목록</strong></summary>

| 명령어 | 설명 |
|--------|------|
| `file list` | 업로드된 파일 목록 조회 |
| `file upload` | ZDM 서버에 파일 업로드 |
| `file download` | ZDM 서버에서 파일 다운로드 |

</details>

---

## 파일 이름 형식

<details markdown="1" open>
<summary><strong>저장된 파일 이름 구조</strong></summary>

서버에 저장된 파일은 다음 형식을 따릅니다:

```
file-{timestamp}-{random}-{original-name}
```

| 구성 요소 | 설명 | 예시 |
|-----------|------|------|
| `file` | 고정 접두사 | file |
| `timestamp` | 업로드 시간 | 1698500000000 |
| `random` | 랜덤 숫자 | 123456789 |
| `original-name` | 원본 파일명 | backup.tar.gz |

**예시:**
- 원본: `backup.tar.gz`
- 저장: `file-1698500000000-123456789-backup.tar.gz`

</details>

---
