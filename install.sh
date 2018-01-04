#!/bin/sh

set -u

DOTFILES_DIR=$(cd $(dirname $0) && pwd)/dotfiles

# Package install
sudo apt-get -q update
sudo apt-get -y git vim bash zsh python3-pip

# dotfiles
git clone https://github.com/tAkayan660/dotfiles.git

# emacs
cd ${DOTFILES_DIR}/emacs.d/public_repos/
git clone https://github.com/ancane/emacs-nav.git
git clone https://github.com/auto-complete/popup-el.git
git clone https://github.com/milkypostman/powerline.git

# vim
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/dein
cd ~/.vim/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./install.sh ./

# zsh
mkdir ~/.zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
git clone https://github.com/junegunn/fzf.git ~/.zsh/fzf
sed -i -e "s/alias rm='rmi'//g" ~/.zprezto/modules/utility/init.zsh
git clone https://github.com/b4b4r07/enhancd.git ~/.zsh/enhancd
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search
#git clone https://github.com/jhawthorn/fzy.git ~/.zsh/fzy
#cd ~/.zsh/fzy
#sudo make install
cd ~/.zsh/fzf
yes | ./install

# powerline
git clone https://github.com/banga/powerline-shell.git ~/.zsh/powerline-shell
cd ~/.zsh/powerline-shell
sudo ./setup.py install
sudo pip3 install -r requirements-dev.txt
git clone https://github.com/powerline/fonts.git ~/.fonts
cd ~/.fonts
./install.sh

# tmux-powerline
git clone https://github.com/erikw/tmux-powerline.git ~/.zsh/tmux-powerline

# sshrc
wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
chmod +x sshrc
sudo mv sshrc /usr/local/bin
mkdir ~/.sshrc.d

# Symbolic link
ln -s ${DOTFILES_DIR}/vimrc ~/.vimrc
ln -s ${DOTFILES_DIR}/vim/dein/dein.toml ~/.vim/dein/
ln -s ${DOTFILES_DIR}/vim/dein/dein_lazy.toml ~/.vim/dein/
#ln -s ${DOTFILES_DIR}/emacs.d ~/.emacs.d
ln -s ${DOTFILES_DIR}/bashrc ~/.bashrc
ln -s ${DOTFILES_DIR}/zshrc ~/.zshrc
ln -s ${DOTFILES_DIR}/zshenv ~/.zshenv
ln -s ${DOTFILES_DIR}/powerline-shell.json ~/.powerline-shell.json
ln -s ${DOTFILES_DIR}/tmux.conf ~/.tmux.conf
ln -s ${DOTFILES_DIR}/sshrc ~/.sshrc
ln -s ${DOTFILES_DIR}/vimrc ~/.sshrc.d/vimrc
ln -s ${DOTFILES_DIR}/bashrc ~/.sshrc.d/bashrc
ln -s ${DOTFILES_DIR}/tmux.conf ~/.sshrc.d/tmux.conf


# Sh selection
if [ ! $SHELL = "/usr/bin/zsh" ]; then
    read -p "Would you like to set the default sh to 'zsh'? [Y/n]: " ZSH_DEF

    case $ZSH_DEF in
        "" | "Y" | "y" | "YES" | "Yes" | "yes" ) 
            sudo chsh -s /usr/bin/zsh
            ;;
        * ) ;;
    esac
fi
