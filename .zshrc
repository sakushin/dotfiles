# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit
compinit -u
autoload colors
colors

setopt prompt_subst
setopt list_types
setopt auto_list
setopt hist_ignore_dups
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_menu
setopt auto_cd
setopt auto_param_keys
setopt list_packed

PROMPT="%n@%m:%~%(!.#.$) "
PROMPT2="_> "
SPROMPT="correct: %R -> %r [nyae]? "

# rvm
[[ -s "/usr/local/rvm/scripts/rvm" ]] && . "/usr/local/rvm/scripts/rvm" # Load RVM function

# phpenv
if [ -s "$HOME/.phpenv/bin/phpenv" ]; then
  export PATH="$HOME/.phpenv/bin:$PATH"
  eval "$(phpenv init -)"
fi

# tmux command alert
if [ -n $TMUX ]; then
  function _tmux_alert(){
    echo -n "\a"
  }
  autoload -U add-zsh-hook
  add-zsh-hook precmd _tmux_alert
fi

# alias
alias ls='ls --color'
alias ll='ls --color -l'
alias bruby='bundle exec ruby'
alias tmux='tmux -2'

export PATH=$HOME/bin:$PATH

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
