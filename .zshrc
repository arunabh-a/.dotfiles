# ──────────────────────────────────────────────────────────────
#  Powerlevel10k Instant Prompt (must stay at the very top)
# ──────────────────────────────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ──────────────────────────────────────────────────────────────
#  Oh My Zsh
# ──────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"

# ──────────────────────────────────────────────────────────────
#  PATH  (single consolidated block — edit only here)
# ──────────────────────────────────────────────────────────────
# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Languages & runtimes
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Java (Azul Zulu 21)
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Go
export PATH="/usr/local/go/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
[[ -d "/Applications/Android Studio.app/Contents/bin" ]] && \
  export PATH="$PATH:/Applications/Android Studio.app/Contents/bin"

# Flutter (also in .zshenv for non-interactive shells)
[[ -d "$HOME/Library/flutter/bin" ]] && export PATH="$HOME/Library/flutter/bin:$PATH"

# Docker (OrbStack)
export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"

# Google Cloud SDK
[[ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]] && \
  source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
[[ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]] && \
  source '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'

# Antigravity / Antigravity IDE
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

# ──────────────────────────────────────────────────────────────
#  PATH cleanup — deduplicate & strip non-existent directories
#  Catches stale Fedora/Linux paths inherited from parent process
#  MUST run before NVM so dedup doesn't clobber NVM's node
# ──────────────────────────────────────────────────────────────
# Strip known Fedora/Linux leftovers by pattern
path=( ${path:#*nvim-linux64*} )
path=( ${path:#*/usr/bin/WebStorm*} )
path=( ${path:#*/usr/bin/android-studio*} )
path=( ${path:#*/usr/bin/flutter*} )
path=( ${path:#*/usr/bin/platform-tools*} )
# Remove non-existent directories
path=( ${^path}(N/) )
# Deduplicate (keeps first occurrence)
typeset -aU path

# ──────────────────────────────────────────────────────────────
#  NVM  (loads AFTER cleanup so its node takes priority)
# ──────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ──────────────────────────────────────────────────────────────
#  Aliases
# ──────────────────────────────────────────────────────────────
alias python='python3.10'
alias pip='pip3.10'

# ──────────────────────────────────────────────────────────────
#  macOS ls colors
# ──────────────────────────────────────────────────────────────
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

# ──────────────────────────────────────────────────────────────
#  Powerlevel10k config (must stay at the bottom)
# ──────────────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
