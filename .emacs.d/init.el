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

;; キーバインドの割り当て
;; C-c c でcompileコマンドを呼び出す
(define-key mode-specific-map "c" 'compile)
;; C-c s でshell-commandを呼び出す
(define-key global-map (kbd "C-c s") 'shell-command)
;; C-c C-s でshellコマンドを呼び出す
(define-key global-map (kbd "C-c C-s") 'shell)
;; C-m に newline-and-indent を割り当てる。
(global-set-key (kbd "C-m") 'newline-and-indent)
;; C-hをバックスペースに置き換える
;; ?\C-? はDELのキーシーケンス
(keyboard-translate ?\C-h ?\C-?)
;; 別のキーバインドにヘルプを割り当てる。
(global-set-key (kbd "C-x ?") 'help-command)
;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;; "C-t"でウィンドウを切り替える。初期値は transpose-chars
(global-set-key (kbd "C-t") 'other-window)

;; フレーム
;; カラム番号も表示（行数）（モードライン）
(column-number-mode t)
;; 行数番号を常に表示
(global-linum-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示（好みに応じてフォーマットを変更可能）
;; (setq display-time-day-and-date t) ;　曜日・月・日を表示
;; (display-time-mode t) ; 元
;; (setq display-time-24hr-format t) ; 24時間表示
(display-time-mode t)
;; バッリー残量を表示
(display-battery-mode t)
