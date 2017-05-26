# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

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
#zplug "yous/lime"
#zplug "fdaciuk/avit-da2k"
#zplug "akz92/clean"
zplug denysdovhan/spaceship-zsh-theme, use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-completions"

# Powerline
#function powerline_precmd() {
#PS1="$(~/git/powerline-shell/powerline-shell.py --cwd-max-depth 1 $? --shell zsh 2> /dev/null)"
#}

#function install_powerline_precmd() {
#for s in "${precmd_functions[@]}"; do
#    if [ "$s" = "powerline_precmd" ]; then
#        return
#    fi
#done
#precmd_functions+=(powerline_precmd)
#}

#if [ "$TERM" != "linux" ]; then
#    install_powerline_precmd
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# aliases
alias vnc="vncviewer"
alias matlab="matlab -softwareopengl"
alias scilab="~/scilab*/bin/scilab -l en_US"
alias meshlab="~/MeshLabSrc_AllInc_*/meshlab/src/distrib/meshlab"
alias minecraft='java -Xms8192m -Xmx8192m -jar ~/minecraft/Minecraft.jar'
alias eagle="~/eagle-*/eagle"
function gl(){ gcc "$@" -lm -lglut -lGLU -lGL;}

# Then, source packages and add commands to $PATH
zplug load --verbose

# time
#if type zprof > /dev/null 2>&1; then
#    zprof | less
#fi
