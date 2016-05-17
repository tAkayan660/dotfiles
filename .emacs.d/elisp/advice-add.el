(defun advice:start ()
  (let (lst)
    `(:return ,(advice:1 256)
      :route ,(nreverse lst))))
(defun advice:reset ()
  (dolist (where '(before after around override filter-return
                          filter-args true false))
    (advice-remove 'advice:1 (intern (format "advice:%s" where)))))

;;; 元の挙動
(defun advice:1 (x) (push `(original ,x) lst) 'original)
(advice:reset)
(advice:start)
;; => (:return original :route
;;             ((original 256)))

;;; beforeアドバイス
(defun advice:before (x) (push `(before ,x) lst) 'before)
(advice-add 'advice:1 :before 'advice:before)
(advice:start)
;; => (:return original :route
;;             ((before 256)
;;              (original 256)))

;;; afterアドバイス
(defun advice:after (x) (push `(after ,x) lst) 'after)
(advice-add 'advice:1 :after 'advice:after)
(advice:start)
;; => (:return original :route
;;             ((before 256)
;;              (original 256)
;;              (after 256)))

;;; aroundアドバイス
(defun advice:around (orig-func &rest args)
  (push `(around-1 ,args) lst)
  (apply orig-func args)
  (push `(around-2 ,args) lst)
  'around)
(advice-add 'advice:1 :around 'advice:around)
(advice:start)
;; => (:return around :route
;;             ((around-1
;;               (256))
;;              (before 256)
;;              (original 256)
;;              (after 256)
;;              (around-2
;;               (256))))
