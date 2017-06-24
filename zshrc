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

source ~/.zsh/enhancd/init.sh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.zsh/zaw/zaw-launcher.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Powerline
function powerline_precmd() {
    PS1="$(~/.zsh/powerline-shell/powerline-shell.py --cwd-max-depth 1 $? --shell zsh 2> /dev/null)"
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

# aliases
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

# cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_ PATH
export CUDA_PATH=/usr/local/cuda

# time
if (which zprof > /dev/null) ;then
    zprof | less
fi

# compile
if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
