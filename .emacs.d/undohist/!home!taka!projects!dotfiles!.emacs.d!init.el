
((digest . "6ac134e17b928f895eb1d4fc5946d39d") (undo-list nil (4990 . 4991) (t 22125 11941 212386 999000) nil (#(";" 0 1 (fontified t face font-lock-comment-delimiter-face)) . -5082) nil (5080 . 5099) nil (5079 . 5080) (t 22125 11882 884385 388000) nil (5123 . 5124) nil (5120 . 5123) nil (5100 . 5120) nil (5080 . 5100) (t 22125 11554 156376 313000) nil (5059 . 5060) nil (5055 . 5056) nil (#("'" 0 1 (fontified t)) . -5055) nil (5055 . 5056) nil (5058 . 5059) nil (#("\"" 0 1 (face font-lock-string-face fontified t)) . -5058) nil (5054 . 5055) nil (#("\\" 0 1 (fontified t)) . 5054) nil (5050 . 5054) nil (#("\"" 0 1 (face font-lock-string-face fontified t)) . -5050) nil (#("c" 0 1 (fontified t)) . -5074) nil (5074 . 5075) (t 22125 11344 560370 527000) nil (5058 . 5074) nil (5057 . 5058) nil (5045 . 5057) nil (5025 . 5045) nil (5024 . 5025) nil (5005 . 5024) nil (#(";;; プレフィクスキーはC-t
(setq elscreen-prefix-key (kbd \"C-c t\"))
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '((\"^dired-mode$\" .
	 (lambda ()
	   (format \"Dired(%s)\" dired-directory)))
	(\"^Info-mode$\" .
	 (lambda ()
	   (format \"Info(%s)\" (file-name-nondirectory Info-current-file))))
	(\"^mew-draft-mode$\" .
	 (lambda ()
	   (format \"Mew(%s)\" (buffer-name (current-buffer)))))
	(\"^mew-\" . \"Mew\")
	(\"^irchat-\" . \"IRChat\")
	(\"^liece-\" . \"Liece\")
	(\"^lookup-\" . \"Lookup\")))
(setq elscreen-mode-to-nickname-alist
      '((\"[Ss]hell\" . \"shell\")
	(\"compilation\" . \"compile\")
	(\"-telnet\" . \"telnet\")
	(\"dict\" . \"OnlineDict\")
	(\"*WL:Message*\" . \"Wanderlust\")))
" 0 4 (face font-lock-comment-delimiter-face fontified t) 4 17 (face font-lock-comment-face fontified t) 17 48 (fontified t) 48 55 (face font-lock-string-face fontified t) 55 58 (fontified t) 58 62 (face font-lock-comment-delimiter-face fontified t) 62 78 (face font-lock-comment-face fontified t) 78 122 (fontified t) 122 126 (face font-lock-comment-delimiter-face fontified t) 126 153 (face font-lock-comment-face fontified t) 153 193 (fontified t) 193 197 (face font-lock-comment-delimiter-face fontified t) 197 234 (face font-lock-comment-face fontified t) 234 283 (fontified t) 283 297 (face font-lock-string-face fontified t) 297 303 (fontified t) 303 309 (face font-lock-keyword-face fontified t) 309 325 (fontified t) 325 336 (face font-lock-string-face fontified t) 336 358 (fontified t) 358 371 (face font-lock-string-face fontified t) 371 377 (fontified t) 377 383 (face font-lock-keyword-face fontified t) 383 399 (fontified t) 399 409 (face font-lock-string-face fontified t) 409 458 (fontified t) 458 476 (face font-lock-string-face fontified t) 476 482 (fontified t) 482 488 (face font-lock-keyword-face fontified t) 488 504 (fontified t) 504 513 (face font-lock-string-face fontified t) 513 550 (fontified t) 550 557 (face font-lock-string-face fontified t) 557 560 (fontified t) 560 565 (face font-lock-string-face fontified t) 565 569 (fontified t) 569 579 (face font-lock-string-face fontified t) 579 582 (fontified t) 582 590 (face font-lock-string-face fontified t) 590 594 (fontified t) 594 603 (face font-lock-string-face fontified t) 603 606 (fontified t) 606 613 (face font-lock-string-face fontified t) 613 617 (fontified t) 617 627 (face font-lock-string-face fontified t) 627 630 (fontified t) 630 638 (face font-lock-string-face fontified t) 638 680 (fontified t) 680 689 (fontified t) 689 699 (face font-lock-string-face fontified t) 699 702 (fontified t) 702 709 (face font-lock-string-face fontified t) 709 713 (fontified t) 713 726 (face font-lock-string-face fontified t) 726 729 (fontified t) 729 738 (face font-lock-string-face fontified t) 738 742 (fontified t) 742 751 (face font-lock-string-face fontified t) 751 754 (fontified t) 754 762 (face font-lock-string-face fontified t) 762 766 (fontified t) 766 772 (face font-lock-string-face fontified t) 772 775 (fontified t) 775 787 (face font-lock-string-face fontified t) 787 791 (fontified t) 791 805 (face font-lock-string-face fontified t) 805 808 (fontified t) 808 820 (face font-lock-string-face fontified t) 820 824 (fontified t)) . 5005) (t 22123 62412 115328 673000) ((marker) . -824) ((marker) . -824) nil undo-tree-canary))
