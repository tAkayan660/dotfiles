#!/bin/sh

set -u

DOTFILES_DIR=$(cd $(dirname $0) && pwd)/dotfiles

# Package install
sudo apt-get -q update
sudo apt-get -y install git vim bash zsh

# dotfiles
git clone https://github.com/takayan660/dotfiles.git

# emacs
#cd ${DOTFILES_DIR}/emacs.d/public_repos/
#git clone https://github.com/ancane/emacs-nav.git
#git clone https://github.com/auto-complete/popup-el.git
#git clone https://github.com/milkypostman/powerline.git
#ln -s ${DOTFILES_DIR}/emacs.d ~/.emacs.d

# Neovim
#mkdir -p ~/.vim/backups
#mkdir -p ~/.vim/tmp
## add neovim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
## python3
sudo apt-get install python3-dev python3-pip
sudo pip3 install -U pip3
sudo pip3 install neovim
## python2
sudo apt-get install python-dev python-pip
sudo pip2 install -U pip2
sudo pip2 install neovim
## Add path
export XDG_CONFIG_HOME="~/.config"
export XDG_CACHE_HOME="~/.cache"
mkdir -p ${XDG_CONFIG_HOME}
mkdir -p ${XDG_CACHE_HOME}
## Add dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ${XDG_CACHE_HOME}/dein
rm ./installer.sh
## Symbolic link
ln -s ${DOTFILES_DIR}/nvim ${XDG_CONFIG_HOME}

# bash
ln -s ${DOTFILES_DIR}/bashrc ~/.bashrc

# zsh
mkdir ~/.zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
git clone https://github.com/junegunn/fzf.git ~/.zsh/fzf
sed -i -e "s/alias rm='rmi'//g" ~/.zprezto/modules/utility/init.zsh
git clone https://github.com/b4b4r07/enhancd.git ~/.zsh/enhancd
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search
cd ~/.zsh/fzf
yes | ./install
## Symbolic link
ln -s ${DOTFILES_DIR}/zshrc ~/.zshrc
ln -s ${DOTFILES_DIR}/zshenv ~/.zshenv
ln -s ${DOTFILES_DIR}/zpreztorc ~/.zpreztorc

# powerline
git clone https://github.com/banga/powerline-shell.git ~/.zsh/powerline-shell
cd ~/.zsh/powerline-shell
sudo ./setup.py install
sudo pip3 install -r requirements-dev.txt
git clone https://github.com/powerline/fonts.git ~/.fonts
cd ~/.fonts
./install.sh
## Symbolic link
ln -s ${DOTFILES_DIR}/powerline-shell.json ~/.powerline-shell.json

# tmux
## Symbolic link
ln -s ${DOTFILES_DIR}/tmux.conf ~/.tmux.conf

# latexmk
sudo apt install latexmk texlive-lang-japanese
ln -s ${DOTFILES_DIR}/latexmkrc ~/.latexmkrc

# sshrc
#wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
#chmod +x sshrc
#sudo mv sshrc /usr/local/bin
#mkdir ~/.sshrc.d
## Symbolic link
#ln -s ${DOTFILES_DIR}/sshrc ~/.sshrc
#ln -s ${DOTFILES_DIR}/vimrc ~/.sshrc.d/vimrc
#ln -s ${DOTFILES_DIR}/bashrc ~/.sshrc.d/bashrc
#ln -s ${DOTFILES_DIR}/tmux.conf ~/.sshrc.d/tmux.conf

# Sh selection
echo $SHELL
if [ ! $SHELL = "/bin/zsh" ]; then
    read -p "Would you like to set the default sh to 'zsh'? [Y/n]: " ZSH_DEF

    case $ZSH_DEF in
        "" | "Y" | "y" | "YES" | "Yes" | "yes" ) 
            sudo chsh -s /bin/zsh
            ;;
        * ) ;;
    esac
fi
