;; ~/.emacs.d/elisp ディレクトリをロードパスに追加する
;; ただし、add-to-load-path関数を作成した場合は不要
(add-to-list 'load-path "~/.emacs.d/elisp")

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;; C-c c でcompileコマンドを呼び出す
(define-key mode-specific-map "c" 'compile)
;; C-c z でshell-commandを呼び出す
(define-key glocal-map (kdd "C-c z") 'shell-command)
;; C-c C-z でshellコマンドを呼び出す
(define-key global-map (kdd "C-c C-z") 'shell)
;; Thanks to "http://www.namazu.org/~tsuchiya/elisp/#shell-command-with-completion"
(load-file "~/.emacs.d/shell-command.el")
(shell-command-completion-mode)
