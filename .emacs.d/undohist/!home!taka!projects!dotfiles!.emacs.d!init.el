
((digest . "15db2d50160f3f711270d6aad8405071") (undo-list nil (#(";; initial frame maximize
;; 参考
;; http://d.hatena.ne.jp/sandai/20120304/p2

;; 起動時にウィンドウ最大化
;; http://www.emacswiki.org/emacs/FullScreen#toc12
(defun jbr-init ()
  \"Called from term-setup-hook after the default
   terminal setup is
   done or directly from startup if term-setup-hook not
   used.  The value
   0xF030 is the command for maximizing a window.\"
  (interactive)
  (w32-send-sys-command #xf030)
  (ecb-redraw-layout)
  (calendar))

(let ((ws window-system))
  (cond ((eq ws 'w32)
	 (set-frame-position (selected-frame) 0 0)
	 (setq term-setup-hook 'jbr-init)
	 (setq window-setup-hook 'jbr-init))
	((eq ws 'ns)
	 ;; for MacBook Air(Late2010) 11inch display
	 (set-frame-position (selected-frame) 0 0)
	 (set-frame-size (selected-frame) 95 47))))
" 0 3 (fontified t face font-lock-comment-delimiter-face) 3 26 (fontified t face font-lock-comment-face) 26 29 (fontified t face font-lock-comment-delimiter-face) 29 32 (fontified t face font-lock-comment-face) 32 35 (fontified t face font-lock-comment-delimiter-face) 35 76 (fontified t face font-lock-comment-face) 76 77 (fontified t) 77 80 (fontified t face font-lock-comment-delimiter-face) 80 93 (fontified t face font-lock-comment-face) 93 96 (fontified t face font-lock-comment-delimiter-face) 96 144 (fontified t face font-lock-comment-face) 144 145 (fontified t) 145 150 (fontified t face font-lock-keyword-face) 150 151 (fontified t) 151 159 (fontified t face font-lock-function-name-face) 159 165 (fontified t) 165 289 (fontified t face font-lock-doc-face) 289 359 (fontified t face font-lock-doc-face) 359 446 (fontified t) 446 449 (fontified t face font-lock-keyword-face) 449 474 (fontified t) 474 478 (fontified t face font-lock-keyword-face) 478 626 (fontified t) 626 629 (fontified t face font-lock-comment-delimiter-face) 629 670 (fontified t face font-lock-comment-face) 670 759 (fontified t)) . 7514) (t 22125 39757 577714 993000) ((marker) . -26) ((marker) . -26) ((marker) . -32) ((marker) . -32) ((marker) . -76) ((marker) . -76) ((marker) . -77) ((marker) . -77) ((marker) . -93) ((marker) . -93) ((marker) . -144) ((marker) . -144) ((marker) . -163) ((marker) . -163) ((marker . 7514) . -759) ((marker . 7514) . -759) ((marker) . -212) ((marker) . -212) ((marker) . -233) ((marker) . -233) ((marker) . -289) ((marker) . -289) ((marker) . -309) ((marker) . -309) ((marker) . -360) ((marker) . -360) ((marker) . -376) ((marker) . -376) ((marker) . -408) ((marker) . -408) ((marker) . -430) ((marker) . -430) ((marker) . -444) ((marker) . -444) ((marker) . -445) ((marker) . -445) nil (1399 . 1400) (#("	              " 0 15 (fontified t)) . -1399) 1404 nil (1373 . 1376) (#("		          " 0 12 (fontified t)) . -1373) 1387 nil (1344 . 1350) (#("            " 0 12 (fontified t)) . -1344) 1378 nil (1452 . 1453) nil (#(")" 0 1 (fontified t)) . -1452) nil (1441 . 1453) nil (1421 . 1441) nil (1413 . 1421) nil (1401 . 1413) nil (1381 . 1401) nil (1378 . 1381) nil (1370 . 1378) nil (1350 . 1370) nil (1343 . 1350) nil (1339 . 1343) nil (1319 . 1339) nil (#(";; (setq frame-title-format
;;      (format \"%%f - Emacs@%s\" (system-name)))" 0 3 (face font-lock-comment-delimiter-face fontified t) 3 28 (face font-lock-comment-face fontified t) 28 36 (face font-lock-comment-delimiter-face fontified t) 36 76 (face font-lock-comment-face fontified t)) . 1319) (t 22125 39111 17684 148000)))
