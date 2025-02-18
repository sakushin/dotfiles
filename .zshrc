# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

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
alias vi='nvim'
alias less='less -S'
alias diff='diff --color'
alias lastpane="tr '\n' ' ' | tmux load-buffer -b tmp - && tmux paste-buffer -b tmp -d -t !"
alias teeclip="tee >(xsel -bi)"
alias base62id="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 22"
# aws
alias aws-ecr-auth='aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $(aws sts get-caller-identity | jq -r .Account).dkr.ecr.ap-northeast-1.amazonaws.com'
alias aws-logs-select='aws logs describe-log-groups | jq -r ".logGroups[].logGroupName" | peco'
alias aws-logs-browse='xdg-open "https://console.aws.amazon.com/cloudwatch/home#logEventViewer:group=$(aws-logs-select);start=PT30S"'
alias aws-logs-get='awslogs get -SG --timestamp $(aws-logs-select)'
alias aws-logs-tailf='awslogs get -SGw --timestamp $(aws-logs-select)'
alias aws-ssm-param-select='aws ssm describe-parameters | jq -r ".Parameters[].Name" | peco'
alias aws-ssm-param-get='aws ssm get-parameter --with-decryption --name $(aws-ssm-param-select) | jq -r ".Parameter.Value"'
alias aws-ssm-param-browse='xdg-open "https://console.aws.amazon.com/systems-manager/parameters$(aws-ssm-param-select)/description"'
alias aws-cfn-stack-select='aws cloudformation describe-stacks | jq -r ".Stacks[].StackName" | peco'
alias aws-cfn-resource-get='aws cloudformation describe-stack-resources --stack-name $(aws-cfn-stack-select) | jq ".StackResources | map({Key:.LogicalResourceId,Value:.PhysicalResourceId}) | from_entries"'
alias aws-cfn-output-get='aws cloudformation describe-stacks --stack-name $(aws-cfn-stack-select) | jq ".Stacks[0].Outputs | map({key:.OutputKey, value:.OutputValue}) | from_entries"'
alias aws-cfn-parameter-get='aws cloudformation describe-stacks --stack-name $(aws-cfn-stack-select) | jq ".Stacks[0].Parameters | map({key:.ParameterKey, value:.ParameterValue}) | from_entries"'
alias aws-cfn-template-get='aws cloudformation get-template --stack-name $(aws-cfn-stack-select) | jq -r ".TemplateBody"'
alias aws-cognito-user-pool-select='aws cognito-idp list-user-pools --max-results 60 | jq -r ".UserPools[] | [.Id, .Name] | join(\":\")" | peco | cut -d: -f1'
alias aws-amplify-app-select='aws amplify list-apps | jq -r ".apps[] | [.appId, .name] | join(\":\")" | peco'
alias aws-amplify-app-get='aws amplify get-app --app-id $(aws-amplify-app-select | cut -d: -f1)'
alias aws-amplify-browse='xdg-open "https://ap-northeast-1.console.aws.amazon.com/amplify/home?region=ap-northeast-1#/$(aws-amplify-app-select | cut -d: -f1)"'
alias aws-route53-hosted-zone-select='aws route53 list-hosted-zones | jq -r ".HostedZones[] | [.Id, .Name] | join(\":\")" | peco | cut -d: -f1'
alias aws-ddb-table-select='aws dynamodb list-tables | jq -r ".TableNames[]" | peco'
alias aws-ddb-scan='aws dynamodb scan --table-name $(aws-ddb-table-select)'
aws-ddb-statement () {
  aws dynamodb execute-statement --statement "$(cat)"
}
aws-profile () {
  NAME=$1
  if [ -z $NAME ]; then
    NAME=$(aws configure list-profiles | peco)
  fi
  export AWS_PROFILE=$NAME
  export AWS_DEFAULT_PROFILE=$NAME
}

# android
alias android-emulator-select='avdmanager list avd | grep Name: | awk '\''{print $2}'\'' | peco'
alias android-emulator-run='emulator @$(android-emulator-select)'

# history
function peco-history-selection() {
    BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | peco | sed 's/\\n/\n/g')
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

export PATH=$HOME/bin:$PATH

if type direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
