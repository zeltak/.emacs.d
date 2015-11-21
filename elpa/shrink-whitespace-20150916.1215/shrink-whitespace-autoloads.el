;;; shrink-whitespace-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "shrink-whitespace" "shrink-whitespace.el"
;;;;;;  (22015 62464 348088 762000))
;;; Generated autoloads from shrink-whitespace.el

(autoload 'shrink-whitespace "shrink-whitespace" "\
Remove whitespace around cursor to just one or none.
If current line contains non-white space chars, then shrink any
whitespace char surrounding cursor to just one space.  If current
line does not contain non-white space chars, then remove blank
lines to just one.

\(fn)" t nil)

(autoload 'shrink-whitespace-grow-whitespace-around "shrink-whitespace" "\
Counterpart to shrink-whitespace, grow whitespace in a smartish way.

\(fn)" t nil)

(autoload 'shrink-whitespace-shrink-whitespace-around "shrink-whitespace" "\
Shrink whitespace surrounding point.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; shrink-whitespace-autoloads.el ends here
