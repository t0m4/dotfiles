export HOME="/Users/tamassandor"
export GOROOT=/usr/local/go
export PATH="$GOROOT/bin:/usr/local/opt/python@2/libexec/bin:~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.cargo/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:~/GOlibs:$PATH"
export EDITOR="mcedit"
# export RBENV_ROOT="$(brew --prefix rbenv)"
# export GEM_PATH="$(brew --prefix)/opt/gems"
export GPG_TTY=$(tty)

export NVM_AUTO_USE=true
export NVM_COMPLETION=true

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/dotfiles/.secrets
source $HOME/antigen.zsh

antigen use oh-my-zsh

# antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle lukechilds/zsh-nvm

# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=romkatv/powerlevel10k
antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi

antigen apply

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# For historical purposes
HISTSIZE=20000
SAVEHIST=20000

# alias ls="ls -Gfhl"
alias ls="exa -lha --icons"
alias lsg="exa -lha --icons --git"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git aliases
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gcmsg='git commit -m'
alias gd='git diff'
alias gst='git status'
alias gc='git checkout'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'
alias gcm='git checkout master && ggpull'
alias gcr='git checkout release && ggpull'

# pm2 aliases
alias p2rr='pm2 restart'
alias p2ls='pm2 ls'
alias p2stop='pm2 stop'
alias p2start='pm2 start'
alias p2logs='pm2 logs'
alias p2del='pm2 delete'
alias p2kill='pm2 kill'

# dev aliases
alias gt='grunt test'
