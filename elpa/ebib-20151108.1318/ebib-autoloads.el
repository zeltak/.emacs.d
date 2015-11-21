;;; ebib-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ebib" "ebib.el" (22083 31317 538853 349000))
;;; Generated autoloads from ebib.el

(autoload 'ebib "ebib" "\
Ebib, a BibTeX database manager.
Optional argument FILE is a file to load.  If FILE is already
loaded, switch to it.  If KEY is given, jump to it.

\(fn &optional FILE KEY)" t nil)

(autoload 'ebib-open-org-link "ebib" "\
Open Ebib and jump to KEY.
This is for use in Org-mode links.

\(fn KEY)" nil nil)

;;;***

;;;### (autoloads nil nil ("ebib-db.el" "ebib-filters.el" "ebib-keywords.el"
;;;;;;  "ebib-pkg.el" "ebib-utils.el") (22083 31317 561062 112000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ebib-autoloads.el ends here
