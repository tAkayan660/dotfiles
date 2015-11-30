### dotfiles

* Emacs
 * init.el適用方法
 　端末で次のように、シンボリックリンクを作成する
	`ln -s /home/ユーザー名/dotfiles/.emacs.d ~/`
   emacsを開き次のように設定を読みこませれば完了
	`M-x load-file RET ~/dotfiles/.emacs.d/init.d`
