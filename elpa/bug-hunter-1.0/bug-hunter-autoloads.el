;;; bug-hunter-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "bug-hunter" "bug-hunter.el" (21975 15310 581975
;;;;;;  244000))
;;; Generated autoloads from bug-hunter.el

(autoload 'bug-hunter-file "bug-hunter" "\
Bisect FILE while testing ASSERTION.
All sexps in FILE are read and passed to `bug-hunter-hunt' as a
list.  See `bug-hunter-hunt' for how to use ASSERTION.

\(fn FILE &optional ASSERTION)" t nil)

(autoload 'bug-hunter-init-file "bug-hunter" "\
Test ASSERTION throughout `user-init-file'.
All sexps inside `user-init-file' are read and passed to
`bug-hunter-hunt' as a list.  See `bug-hunter-hunt' for how to use
ASSERTION.

\(fn &optional ASSERTION)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; bug-hunter-autoloads.el ends here
