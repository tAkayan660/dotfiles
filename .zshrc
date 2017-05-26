# oh-my-zsh
export ZSH=/home/taka/.oh-my-zsh
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Zplug
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# What does this do?
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    at:0.11.0, \
    as:command, \
    use:"*darwin*amd64*", \
    rename-to:fzf
# It grabs the binary of fzf-bin version 0.11.0 from GitHub Release and uses
# the file that matches "*darwin*amd64" as a command called fzf!

zplug "yous/vanilli.sh"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source packages and add commands to $PATH
zplug load --verbose

# Powerline
function powerline_precmd() {
    PS1="$(~/powerline-shell.py --cwd-max-depth 1 $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
