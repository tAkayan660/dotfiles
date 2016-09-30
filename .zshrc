# Created by newuser for 5.0.2

# zplug
source ~/.zplug//init.zsh

# $B%@%V%k%/%)!<%F!<%7%g%s$G0O$&$HNI$$(B
zplug "zsh-users/zsh-history-substring-search"

# $B%3%^%s%I$b4IM}$9$k(B
# $B%0%m%V$r<u$1IU$1$k!J%V%l!<%9$d%o%$%k%I%+!<%I$J$I!K(B
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# $B$3$s$J;H$$J}$b$"$k!JB>?M$N(B zshrc$B!K(B
zplug "tcnksm/docker-alias", use:zshrc

# frozen $B%?%0$,@_Dj$5$l$F$$$k$H%"%C%W%G!<%H$5$l$J$$(B
zplug "k4rthik/git-cal", as:command, frozen:1

# GitHub Releases $B$+$i%$%s%9%H!<%k$9$k(B
# $B$^$?!"%3%^%s%I$O(B rename-to $B$G%j%M!<%`$G$-$k(B
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

# oh-my-zsh $B$r%5!<%S%9$H8+$J$7$F!"(B
# $B$=$3$+$i%$%s%9%H!<%k$9$k(B
zplug "plugins/git",   from:oh-my-zsh

# if $B%?%0$,(B true $B$N$H$-$N$_%$%s%9%H!<%k$5$l$k(B
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# $B%$%s%9%H!<%k!&%"%C%W%G!<%H8e$K<B9T$5$l$k%U%C%/(B
# $B$3$N>l9g$O0J2<$N$h$&$J@_Dj$,JLESI,MW(B
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"
    {
        make
        sudo make install
    } &>/dev/null
    "

# $B%j%S%8%g%s%m%C%/5!G=$r;}$D(B
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Gist $B%U%!%$%k$b%$%s%9%H!<%k$G$-$k(B
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# bitbucket $B$b(B
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    hook-build:"chmod 755 *.sh", \
    use:"*.sh"

# $B0MB84IM}(B
# "emoji-cli" $B$O(B "jq" $B$,$"$k$H$-$K$N$_FI$_9~$^$l$k(B
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# $B%N!<%H(B: $BFI$_9~$_=g=x$r;XDj$9$k$J$i(B nice $B%?%0$r;H$$$^$7$g$&(B

# $BFI$_9~$_=g=x$r@_Dj$9$k(B
# $BNc(B: "zsh-syntax-highlighting" $B$O(B compinit $B$NA0$KFI$_9~$^$l$kI,MW$,$"$k(B
# $B!J(B10 $B0J>e$O(B compinit $B8e$KFI$_9~$^$l$k$h$&$K$J$k!K(B
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# $B%m!<%+%k%W%i%0%$%s$bFI$_9~$a$k(B
zplug "~/.zsh", from:local

# $BL$%$%s%9%H!<%k9`L\$r%$%s%9%H!<%k$9$k(B
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# $B%3%^%s%I$r%j%s%/$7$F!"(BPATH $B$KDI2C$7!"%W%i%0%$%s$OFI$_9~$`(B
zplug load --verbose
