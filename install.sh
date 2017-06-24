#dotfiles
git clone https://github.com/tAkayan660/dotfiles.git

#emacs
cd dotfiles/emacs.d/public_repos/
git clone https://github.com/ancane/emacs-nav.git
git clone https://github.com/auto-complete/popup-el.git
git clone https://github.com/milkypostman/powerline.git

#vim
mkdir -p ~/.backups/vim/
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

#zsh
mkdir ~/.zsh
git clone https://github.com/b4b4r07/enhancd.git ~/.zsh/enhancd
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search
git clone https://github.com/jhawthorn/fzy.git ~/.zsh/fzy
cd ~/.zsh/fzy
sudo make install
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

#powerline
git clone https://github.com/banga/powerline-shell.git ~/.zsh/powerline-shell
cd ~/.zsh/powerline-shell
./install.py
