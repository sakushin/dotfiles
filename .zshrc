# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit; compinit
autoload -U colors; colors

zstyle ':completion:*' menu select interactive

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
setopt inc_append_history

PROMPT="%B%F{green}%n@%m%f:%F{blue}%~%f%(!.#.$)%b "
PROMPT2="_> "
SPROMPT="correct: %R -> %r [nyae]? "

# tmux alert
if [ -n "$TMUX" ]; then
  function _tmux_alert(){
    echo -n "\a"
  }
  autoload -U add-zsh-hook
  add-zsh-hook precmd _tmux_alert
fi

# function
function mcd() {
  mkdir -p $1
  cd $1
}

# alias
alias ls='ls --color'
alias ll='ls --color -l'
alias la='ls --color -la'
alias less='less -S'
alias diff='diff --color'
# aws
alias aws-ecr-auth='aws ecr get-login-password | docker login --username AWS --password-stdin aws_account_id.dkr.ap-northeast-1.amazonaws.com'
alias aws-logs-browse='xdg-open "https://console.aws.amazon.com/cloudwatch/home#logEventViewer:group=$(aws logs describe-log-groups | jq -r ".logGroups[].logGroupName" | peco);start=PT30S"'
alias aws-logs-select='aws logs describe-log-groups | jq -r ".logGroups[].logGroupName" | peco'
alias aws-logs-tailf='awslogs get -SGw $(aws logs describe-log-groups | jq -r ".logGroups[].logGroupName" | peco)'
alias aws-ssm-param-select='aws ssm get-parameter --with-decryption --name $(aws ssm describe-parameters | jq -r ".Parameters[].Name" | peco) | jq -r ".Parameter.Value"'
# android
alias android-emulator-select='emulator @$(avdmanager list avd | grep Name: | awk '\''{print $2}'\'' | peco)'


export PATH=$HOME/bin:$PATH

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
