;;; ranger-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ranger" "ranger.el" (22100 31730 50765 497000))
;;; Generated autoloads from ranger.el

(defvar ranger-key [16] "\
`dired-mode' key used to toggle `ranger-mode'")

(custom-autoload 'ranger-key "ranger" t)

(defvar ranger-override-dired nil "\
When non-nil, load `deer' whenever dired is loaded.")

(custom-autoload 'ranger-override-dired "ranger" t)

(when ranger-key (with-eval-after-load 'dired (define-key dired-mode-map ranger-key 'ranger-mode)))

(autoload 'deer "ranger" "\
Launch dired in a minimal ranger window.

\(fn &optional PATH)" t nil)

(autoload 'ranger "ranger" "\
Launch dired in ranger-mode.

\(fn &optional PATH)" t nil)

(when ranger-override-dired (add-hook 'dired-mode-hook 'ranger-override-dired-fn))

(autoload 'ranger-override-dired-fn "ranger" "\
Open dired as deer unless already in ranger-mode

\(fn)" nil nil)

(autoload 'ranger-mode "ranger" "\
A convienent way to look up file contents in other window while browsing directory in dired

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ranger-autoloads.el ends here
