;;; helm-mt-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "helm-mt" "helm-mt.el" (22078 16085 769616
;;;;;;  337000))
;;; Generated autoloads from helm-mt.el

(autoload 'helm-mt/wrap-shells "helm-mt" "\
Put advice around shell functions when called interactively.
This routes to helm-mt UI instead of launching a new shell/terminal.
If ONOFF is t, activate the advice and if nil, remove it.

\(fn ONOFF)" t nil)

(autoload 'helm-mt "helm-mt" "\
Custom helm buffer for terminals only.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; helm-mt-autoloads.el ends here
