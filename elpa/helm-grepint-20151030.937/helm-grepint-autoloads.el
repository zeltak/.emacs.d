;;; helm-grepint-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "helm-grepint" "helm-grepint.el" (22073 45261
;;;;;;  173897 639000))
;;; Generated autoloads from helm-grepint.el

(autoload 'helm-grepint-grep "helm-grepint" "\
Run grep in the current directory.

The grep function is determined by the contents of
`helm-grepint-grep-configs' and the order of `helm-grepint-grep-list'.

\(fn)" t nil)

(autoload 'helm-grepint-grep-root "helm-grepint" "\
This function is the same as `helm-grepint-grep', but it runs the grep in a root directory.

\(fn)" t nil)

(autoload 'helm-grepint-set-default-config "helm-grepint" "\
Set the default grep configuration into `helm-grepint-grep-configs' and `helm-grepint-grep-list'.

\(fn)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; helm-grepint-autoloads.el ends here
