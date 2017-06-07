# autoload -U compinit
# compinit 

# oh-my-zsh
#export ZSH=/home/taka/.oh-my-zsh
#source $ZSH/oh-my-zsh.sh

# zprezto
if [[ ! -f ~/.zpreztorc ]]; then
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Zplug
# Check if zplug is installed
#if [[ ! -d ~/.zplug ]]; then
#    git clone https://github.com/zplug/zplug ~/.zplug
#    source ~/.zplug/init.zsh && zplug update --self
#fi

# Essential
source ~/.zplug/init.zsh

# What does this do?
#zplug "junegunn/fzf-bin", \
    #    from:gh-r, \
    #    at:0.11.0, \
    #    as:command, \
    #    use:"*darwin*amd64*", \
    #    rename-to:fzf
# It grabs the binary of fzf-bin version 0.11.0 from GitHub Release and uses
# the file that matches "*darwin*amd64" as a command called fzf!

#zplug "yous/vanilli.sh"
#zplug "b4b4r07/enhancd", use:init.sh
#zplug "zsh-users/zsh-history-substring-search", use:"__zsh_version 4.3"
#zplug "zsh-users/zsh-completions"
#zplug 'zsh-users/zaw'
#zplug "zsh-users/zsh-syntax-highlighting", defer:2


# Install plugins if there are plugins that have not been installed
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi

#if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
#    zcompile ~/.zshrc
#fi

# Then, source packages and add commands to $PATH
#zplug load --verbose

source ~/git/enhancd/init.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/git/zaw/zaw-launcher.zsh
source ~/git/zsh-completions/zsh-completions.plugin.zsh
source ~/git/zsh-history-substring-search/zsh-history-substring-search.zsh

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

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

#aliases
alias vnc="vncviewer"
alias matlab="matlab -softwareopengl"
alias scilab="~/scilab*/bin/scilab -l en_US"
alias meshlab="~/MeshLabSrc_AllInc_*/meshlab/src/distrib/meshlab"
alias minecraft='java -Xms8192m -Xmx8192m -jar ~/minecraft/Minecraft.jar'
alias eagle="~/eagle-*/eagle"

function apt-cache_search(){ apt-cache search "$@" | grep "$@"; }

# History
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

alias history="history -E 1"

# time
if (which zprof > /dev/null) ;then
    zprof | less
fi
