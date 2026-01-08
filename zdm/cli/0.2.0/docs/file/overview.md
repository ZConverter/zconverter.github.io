---
layout: docs
title: File 개요
section_title: ZDM CLI Documentation
navigation: cli-0.2.0
---

파일 관리 기능에 대한 개요입니다.

<details markdown="1" open>
<summary><strong>목차</strong></summary>

- [파일 이름 형식](#파일-이름-형식)

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
