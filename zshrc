if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR="nvim"

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

export HOMEBREW_NO_INSTALL_CLEANUP=true

export GOPROXY=https://goproxy.io,direct

export PNPM_HOME="$HOME/Library/pnpm"

typeset -U path PATH fpath FPATH
path=(
  "$PNPM_HOME"
  "$HOME/.kimi-code/bin"
  "$HOME/go/bin"
  "$HOME/.local/bin"
  $path
)

if (( $+commands[brew] )); then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions

zinit snippet OMZP::sudo
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh

source <(fzf --zsh)

autoload -Uz compinit
compinit
_comps[zinit]=_zinit

zinit light Aloxaf/fzf-tab
zinit light lukechilds/zsh-nvm
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

eval "$(zoxide init zsh --cmd cd)"

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

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

alias ls="eza"
alias ll="ls -l"
alias la="ls -la"
alias vi="nvim"
alias vim="nvim"
alias lab="ssh why@lab"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
