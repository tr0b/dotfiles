# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.zprofile
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias ls='ls --color=always'
bindkey '-v'
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000000
SAVEHIST=100000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
# Created by newuser for 5.8
autoload -U compinit promptinit
       compinit
       promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPS="--no-mouse --height 50% -1 --reverse --multi --preview 'bat --style=numbers --color=always {} | head -500'"
source /usr/share/fzf/key-bindings.zsh
source ~/.fzf/shell/completion.zsh
# zsh-bd
. $HOME/.zsh/bd/bd.zsh
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/fzf-git/fzf-git.plugin.zsh
eval "$(lua ~/.zsh/z.lua-1.8.4/z.lua --init zsh enhanced once)"
# source ~/.zsh/fz/fz.plugin.zsh
export _ZL_ECHO=1
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Source fz
export FZ_HISTORY_CD_CMD="_zlua"
source ~/.zsh/fz/fz.sh
export ZSH_AUTOSUGGEST_USE_ASYNC=1
