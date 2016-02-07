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

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

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
;; (keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; 別のキーバインドにヘルプを割り当てる。
(global-set-key (kbd "C-x ?") 'elp-command)
;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;; "C-t"でウィンドウを切り替える。初期値は transpose-chars
(global-set-key (kbd "C-t") 'other-window)

;; 行番号表示
(global-linum-mode t)
(setq linum-format "%d ")
(set-face-attribute 'linum nil
		    :foreground "#FFFF00"
		    :height 0.9)
;;
;; タブ幅変更
;;
(setq default-tab-width 4)

;; package.elの設定
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; auto-installの設定
;; (when (require 'auto-install nil t)
  ;; インストールディレクトリを設定する　初期値は ~/.emacs.d/auto-install/
;;  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelisp の名前を取得する
;;  (auto-install-update-emacswiki-package-name t)
  ;; プロキシ設定
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elisp の関数を利用可能にする
;;  (auto-install-compatibility-setup))

;;; anything
;; (auto-install-batch "naything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多い時は体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    ;; デフォルトは"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install)))

;; 要color-moccur.el
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur用 'anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; バッファの情報をハイライトする
   anything-c-moccur-higligt-info-line-flag t
   ;; 現在選択中の候補の位置を他のwindowに表示する
   anything-c-moccur-enable-auto-look-flag t
   ;; 起動時にポイントの位置の単語を初期パターンにする
   anything-c-moccur-enable-initial-pattern t)
  ;;C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

;; auto-completeの設定
;; 引用先
;; https://github.com/auto-complete/auto-complete.git
;; https://github.com/auto-complete/popup-el.git
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; color-moccurの設定
(when (require 'color-moccur nil t)
  ;; M-o に occur-by-moccur を割り当てる。
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; moccur-edit の設定
(require 'moccur-edit nil t)

;; undohistの設定
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-treeの設定
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undoの設定
(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
)

;;; ElScreenの設定
;; (require 'elscreen)
;; (elscreen-set-prefix-key (kbd "C-t"))
;; (global-set-key (kbd "C-M-n") 'elscreen-clone)
;; (global-set-key (kbd "C-M-]") 'elscreen-next)
;; (global-set-key (kbd "C-M-[") 'elscreen-previous)
;; (elscreen-start)
;; タブの先頭に[X]を表示しない
;; (setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
;; (setq elscreen-tab-display-control nil)

;;
;; tabber-mode
;;
;; 引用元
;; http://blog.iss.ms/2014/03/01/202435
(require 'tabbar)
(tabbar-mode 1)
;;
;; ref: http://d.hatena.ne.jp/plasticster/20110825/1314271209
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
	       tabbar-scroll-left-button
	       tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
		 (cons "" nil))))
;; タブに表示させるバッファの設定
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")
(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
	 (re (regexp-opt my-tabbar-displayed-buffers))
	 (cur-buf (current-buffer))
	 (tabs (delq nil
		     (mapcar (lambda (buf)
			       (let ((name (buffer-name buf)))
				 (when (or (string-match re name)
					   (not (memq (aref name 0) hides)))
				   buf)))
			     (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
	tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
;; appearances
(setq tabbar-separator '(1.0)) ;; タブセパレータの長さ
(set-face-attribute 'tabbar-default nil
		    :family "Ricty"
		    :foreground "#e5e5e5"
		    :background "#000000"
		    :height 1.0)
(set-face-attribute 'tabbar-unselected nil
		    :foreground "#e5e5e5"
		    :background "#00cd00"
		    :box nil)
(set-face-attribute 'tabbar-selected nil
		    :foreground "#00cd00"
		    :background "#e5e5e5"
		    :box nil)
(set-face-attribute 'tabbar-button nil
		    :box nil)
;; key bindings
(global-set-key [(C-tab)]   'tabbar-forward-tab)
(global-set-key [(C-S-tab)] 'tabbar-backward-tab)
(global-set-key (kbd "M-]")     'tabbar-forward-tab)
(global-set-key (kbd "M-[")     'tabbar-backward-tab)


;; Flymake の設定
;; 参考
;; http://d.hatena.ne.jp/sandai/20120304/p2
(when (require 'flymake nil t)
  ;; 下の一行はflymakeモードでエラー行に飛べるコマンドをキーに割り当ててるコードですが、
  ;; 個人的な理由でコメントアウトしてます。必要でしたらこのコメント削除して、アンコメントしてください
  ;;(define-key global-map (kbd "C-cd") 'flymake-display-err-menu-for-current-line)
  
  ;; C
  ;; http://d.hatena.ne.jp/nyaasan/20071216/p1
  (defun flymake-c-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	   (local-file  (file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
      (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.\\(c\\|h\\|y\\l\\)$" flymake-c-init))
  ;; C++
  (defun flymake-cc-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	   (local-file  (file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
      (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.cpp$" flymake-cc-init))
  
  ;; Emacs Lisp
  ;; http://www.emacswiki.org/emacs/FlymakeElisp
  (defun flymake-elisp-init ()
    (unless (string-match "^ " (buffer-name))
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
			   'flymake-create-temp-inplace))
	     (local-file  (file-relative-name
			   temp-file
			   (file-name-directory buffer-file-name))))
	(list
	 (expand-file-name invocation-name invocation-directory)
	 (list
	  "-Q" "--batch" "--eval"
	  (prin1-to-string
	   (quote
	    (dolist (file command-line-args-left)
	      (with-temp-buffer
		(insert-file-contents file)
		(condition-case data
		    (scan-sexps (point-min) (point-max))
		  (scan-error
		   (goto-char(nth 2 data))
		   (princ (format "%s:%s: error: Unmatched bracket or quote\n"
				  file (line-number-at-pos)))))))
	    )
	   )
	  local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.el$" flymake-elisp-init))

  (add-hook 'emacs-lisp-mode-hook
	    ;; workaround for (eq buffer-file-name nil)
	    (function (lambda () (if buffer-file-name (flymake-mode)))))
  (add-hook 'c-mode-common-hook
	    (lambda () (flymake-mode t)))
  (add-hook 'php-mode-hook
	    (lambda () (flymake-mode t)))
  )


;;
;; emacs-nav
;;
(require 'nav)
(setq nav-split-window-direction 'vertical) ;; 分割したフレームを垂直に並べる
(global-set-key "\C-x\C-d" 'nav-toggle)     ;; C-x C-d で nav をトグル

;;
;; backup の保存先
;;
(setq backup-directory-alist
<<<<<<< HEAD
        (cons (cons ".*" (expand-file-name "~/.backups/emacs/"))
	              backup-directory-alist))

(setq auto-save-file-name-transforms
        `((".*", (expand-file-name "~/.backups/emacs/") t)))

(setq auto-save-list-file-prefix "~/.backups/emacs/")

;; Powerline
;; (require 'powerline)
;; (powerline-default-theme)

;; powerline.el
(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \"};"  color1 color2))

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\"};"  color2 color1))


(defconst color1 "#ffffff")
(defconst color3 "#000000")
(defconst color2 "#0ad000")
(defconst color4 "#000000")

(defvar arrow-right-1 (create-image (arrow-right-xpm color1 color2) 'xpm t :ascent 'center))
(defvar arrow-right-2 (create-image (arrow-right-xpm color2 "None") 'xpm t :ascent 'center))
(defvar arrow-left-1  (create-image (arrow-left-xpm color2 color1) 'xpm t :ascent 'center))
(defvar arrow-left-2  (create-image (arrow-left-xpm "None" color2) 'xpm t :ascent 'center))

(setq-default mode-line-format
	      (list  '(:eval (concat (propertize " %b " 'face 'mode-line-color-1)
				     (propertize " " 'display arrow-right-1)))
		     '(:eval (concat (propertize " %m " 'face 'mode-line-color-2)
				     (propertize " " 'display arrow-right-2)))

		     ;; Justify right by filling with spaces to right fringe - 16
		     ;; (16 should be computed rahter than hardcoded)
		     '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))

		     '(:eval (concat (propertize " " 'display arrow-left-2)
				     (propertize " %p " 'face 'mode-line-color-2)))
		     '(:eval (concat (propertize " " 'display arrow-left-1)
				     (propertize "%4l:%2c  " 'face 'mode-line-color-1)))
		     ))

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
		    :foreground "#0ad000"
		    :background color1)

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
		    :foreground "#fff"
		    :background color2)

(set-face-attribute 'mode-line nil
		    :foreground "#fff"
		    :background color3
		    :box nil)
(set-face-attribute 'mode-line-inactive nil
		    :foreground "#fff"
		    :background color4)

<<<<<<< HEAD
;;
;; ctags
;;
;; (require 'ctags nil t)
;; (setq tags-revert-without-query t)
;; (setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
;; (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
;; (global-set-key (kbd "M-.") 'ctags-search)
=======
(setq auto-save-list-file-prefix "~/backup/emacs/")

>>>>>>> powerline有効化＆整理
=======
        (cons (cons ".*" (expand-file-name "~/.backup/emacs/"))
	              backup-directory-alist))

(setq auto-save-file-name-transforms
        `((".*", (expand-file-name "~/.backup/emacs/") t)))

(setq auto-save-list-file-prefix "~/.backup/emacs/")

;;
;; emacs-color-theme-solarized
;;
;; (load-theme 'solarized t)
>>>>>>> .bashrc設定追加
