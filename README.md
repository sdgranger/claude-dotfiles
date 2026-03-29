# Claude Code Dotfiles

Claude Code 설정 파일 모음. 다른 PC에서도 동일한 환경을 재현할 수 있습니다.

## 포함 항목

| 파일 | 설명 |
|------|------|
| `settings.json` | 모델, 플러그인, hooks, status line 설정 |
| `statusline-command.sh` | 하단 상태창 스크립트 (경로, 모델, 컨텍스트 사용량 표시) |
| `install.sh` | 자동 설치 스크립트 |

## 설치 방법

```bash
git clone <repo-url> ~/claude-dotfiles
cd ~/claude-dotfiles
chmod +x install.sh
./install.sh
```

## 사전 요구 사항

- [Claude Code](https://claude.ai/code) CLI 설치
- `jq` 설치 (`brew install jq` / `apt install jq`)

## 참고

- `settings.local.json` (프로젝트별 권한)은 머신마다 다르므로 포함하지 않습니다.
- 기존 `settings.json`이 있으면 병합(merge)됩니다. 기존 파일은 `.bak`으로 백업됩니다.
