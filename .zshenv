# Flutter SDK — also guarded in .zshrc, but .zshenv ensures
# it is available in non-interactive shells (e.g., IDE terminals).
[[ -d "$HOME/Library/flutter/bin" ]] && export PATH="$HOME/Library/flutter/bin:$PATH"
