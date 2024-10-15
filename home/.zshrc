if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    exec sway
fi

# zsh settings
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(
    git
    zsh-autosuggestions
)
export ZSH="$HOME/places/sys/oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Add own binaries to the path
export PATH=$PATH:$HOME/.bin:$HOME/.scripts

export TERM=screen-256color

# Sources
source <(helm completion zsh)
source <(kubectl completion zsh)

# ssh-agent
export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

# Change default editor
export EDITOR="nvim"

# awscli config file
export AWS_CONFIG_FILE="~/places/.aws_credentials"

# Functions
wait_for_status_code() {
    ENDPOINT=$1
    EXPECTED_RC=$2
    for (( ; ; ))
    do
        CURRENT_RC=$(curl --connect-timeout 1 -L -w '%{response_code}' -s -o /dev/null $ENDPOINT)
        echo "$(date): URL: $ENDPOINT, return code: $CURRENT_RC"
        [[ $CURRENT_RC = $EXPECTED_RC ]] && break
        sleep 1
    done
    notify-send "$ENDPOINT return $EXPECTED_RC!"
}

# Aliases
alias s='ssh'
alias v='nvim'
alias vim='nvim'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias kl='kubectl'
alias x='ranger'

# kubeconfs
alias locconf='export KUBECONFIG=~/places/personal/kubeconfigs/loc.conf'

# autoload python venv
python_venv() {
  MYVENV=./venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv
