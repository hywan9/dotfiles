if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export EDITOR="nvim"
export VISUAL="nvim"
export HOMEBREW_NO_INSTALL_CLEANUP=true


export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

  autoload -Uz compinit
  compinit
fi


export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  sudo
)

source "$ZSH/oh-my-zsh.sh"


autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line


if type fzf &>/dev/null; then
  source <(fzf --zsh)
fi

if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi


[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


__conda_setup="$('/Users/kele/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/kele/miniforge3/etc/profile.d/conda.sh" ]; then
    . "/Users/kele/miniforge3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/kele/miniforge3/bin:$PATH"
  fi
fi
unset __conda_setup


alias lab="ssh why@lab"
alias -g bat="bat --theme-dark Catppuccin Latte --theme-light Catppuccin Latte"
