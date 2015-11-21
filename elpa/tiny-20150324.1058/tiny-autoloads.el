;;; tiny-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "tiny" "tiny.el" (21956 53167 920260 338000))
;;; Generated autoloads from tiny.el

(autoload 'tiny-expand "tiny" "\
Expand current snippet.
It polls the expander functions one by one
if they can expand the thing at point.
First one to return a string succeeds.
These functions are expected to set `tiny-beg' and `tiny-end'
to the bounds of the snippet that they matched.
At the moment, only `tiny-mapconcat' is supported.
`tiny-mapconcat2' should be added to expand rectangles.

\(fn)" t nil)

(autoload 'tiny-replace-this-sexp "tiny" "\
Eval and replace the current sexp.
On error go up list and try again.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; tiny-autoloads.el ends here
