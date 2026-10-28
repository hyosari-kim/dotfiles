# Dotfiles

Git bare repo 방식으로 관리하는 터미널 환경 설정.

## 새 컴퓨터에서 복원

```bash
# 1. Xcode CLI tools 설치
xcode-select --install

# 2. Bare repo 클론
git clone --bare https://github.com/hyosari-kim/dotfiles.git $HOME/.dotfiles

# 3. Alias 설정
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 4. 파일 체크아웃
dotfiles checkout

# 기존 파일과 충돌 시 백업 후 재시도:
mkdir -p $HOME/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p $(dirname $HOME/.dotfiles-backup/{}) && mv $HOME/{} $HOME/.dotfiles-backup/{}'
dotfiles checkout

# 5. 설정
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.bare false

# 6. Bootstrap 스크립트 실행 (Homebrew, oh-my-zsh, 플러그인, tmux, nvm 등 설치)
chmod +x ~/.bootstrap.sh && ~/.bootstrap.sh

# 7. Ghostty 설치
brew install --cask ghostty

# 8. 시크릿 설정 (~/.zshrc.local 에 직접 추가)
# export KAMAL_REGISTRY_PASSWORD="..."

# 9. 터미널 재시작
```

## 관리 명령어

```bash
dotfiles status          # 변경 확인
dotfiles add <file>      # 파일 추가
dotfiles commit -m "msg" # 커밋
dotfiles push            # 푸시
```

## 추적 중인 파일

| 파일 | 용도 |
|---|---|
| `~/.zshrc` | zsh 메인 설정 |
| `~/.config/zsh/aliases.sh` | alias 모음 |
| `~/.config/zsh/catppuccin-zsh-syntax-highlighting/` | Catppuccin zsh 테마 |
| `~/.config/ghostty/config` | Ghostty 터미널 |
| `~/.config/tmux/tmux.conf.local` | tmux 설정 |
| `~/.config/nvim/` | Neovim (LazyVim) |
| `~/.config/karabiner/karabiner.json` | 키보드 매핑 |
| `~/.config/gh/config.yml` | GitHub CLI |
| `~/.config/git/ignore` | 글로벌 gitignore |
| `~/.gitconfig` | Git 설정 |
| `~/.claude/CLAUDE.md` | Claude Code 지침 |
| `~/.claude/RTK.md` | RTK 참조 |
| `~/.claude/settings.json` | Claude Code 설정 |
| `~/.Brewfile` | Homebrew 패키지 목록 |
| `~/.bootstrap.sh` | 초기 설치 스크립트 |

## 초기화 (지웠다가 다시 설치)

dotfiles 설정이 꼬였거나 처음부터 다시 하고 싶을 때:

```bash
# 1. 기존 bare repo 삭제
rm -rf $HOME/.dotfiles

# 2. dotfiles가 관리하던 파일들은 그대로 남아있음 (삭제되지 않음)
#    필요하면 수동으로 삭제:
rm -f ~/.zshrc ~/.gitconfig ~/.Brewfile ~/.bootstrap.sh ~/.dotfiles-README.md
rm -rf ~/.config/nvim ~/.config/ghostty ~/.config/tmux
rm -rf ~/.config/zsh/aliases.sh ~/.config/zsh/catppuccin-zsh-syntax-highlighting
rm -f ~/.config/karabiner/karabiner.json ~/.config/gh/config.yml ~/.config/git/ignore
rm -f ~/.claude/CLAUDE.md ~/.claude/RTK.md ~/.claude/settings.json

# 3. 다시 클론하고 복원 ("새 컴퓨터에서 복원" 섹션 참고)
git clone --bare https://github.com/hyosari-kim/dotfiles.git $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.bare false
chmod +x ~/.bootstrap.sh && ~/.bootstrap.sh
```

## 추적하지 않는 것

- `~/.zshrc.local` — 시크릿 (KAMAL_REGISTRY_PASSWORD 등)
- `~/.config/gh/hosts.yml` — 인증 토큰
- `~/.claude/` 내 세션 데이터 (history, todos, tasks 등)

## AI 전역 지침과 스킬

전역 행동 지침의 원본은 `~/.config/ai/AGENTS.md`, RTK 참조의 원본은
`~/.config/ai/RTK.md`이다. 다음 상대 경로 심볼릭 링크를 함께 추적하므로
dotfiles를 체크아웃하면 Codex와 Claude Code가 같은 문서를 참조한다.

| 연결 경로 | 공통 원본 |
|---|---|
| `~/.codex/AGENTS.md` | `~/.config/ai/AGENTS.md` |
| `~/.claude/CLAUDE.md` | `~/.config/ai/AGENTS.md` |
| `~/.codex/RTK.md` | `~/.config/ai/RTK.md` |
| `~/.claude/RTK.md` | `~/.config/ai/RTK.md` |

지침 수정은 공통 원본에서 한 번만 한다. 모델·권한·플러그인 설정은
제품별 설정 파일로 따로 관리한다. 기기별 경로·인증정보가 들어갈 수 있는
Codex 설정 전체나 세션 데이터는 이 통합 작업에서 추가 추적하지 않는다.

재사용 스킬·에이전트는 [skills](https://github.com/hyosari-kim/skills) 저장소에서
관리하고 필요한 항목을 각 도구에 연결한다. 프로젝트별 설정은 별도로 유지한다.
