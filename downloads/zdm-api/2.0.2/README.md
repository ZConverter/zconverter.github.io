# zdm-api v2.0.2 binary placeholder

`zdm-api-linux.tar.gz` 파일을 이 디렉토리에 배치하세요.

빌드: `/project/zdm-api-v2` 에서
```
npm run build:linux && npm run package
```

배치 후 정합성 검증:
```
cd /project/gitpage/zconverter.github.io
ruby -ryaml -e '...'  # CLAUDE.md 7+단계 스크립트
```

배치 후 본 README 는 삭제하세요.
