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
;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; 行数番号を常に表示
;; (global-linum-mode t)
;; 行番号表示
(global-linum-mode t)
(setq linum-format "%4d ")
(set-face-attribute 'linum nil
		    :foreground "#FFFF00"
		    :height 0.9)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示（好みに応じてフォーマットを変更可能）
;; (setq display-time-day-and-date t) ;　曜日・月・日を表示
;; (display-time-mode t) ; 元
;; (setq display-time-24hr-format t) ; 24時間表示
(display-time-mode t)
;; バッリー残量を表示
;; (display-battery-mode t)

;; auto-installの設定
(when (require 'auto-install nil t)
  ;; インストールディレクトリを設定する　初期値は ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelisp の名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;; プロキシ設定
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elisp の関数を利用可能にする
  (auto-install-compatibility-setup))

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

;; ElScreenの設定
;; プレフィックスキーを変更する（初期値はC-z）
;; (setq  elscreen-prefix-key "C-w")

;; (when (require 'elscreen nil t)
  ;; C-z とタイプした場合にデフォルトのC-zを利用する
;;  (if window-system
;;      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
;;    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))



