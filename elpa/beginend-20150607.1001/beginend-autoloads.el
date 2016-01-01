;;; beginend-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "beginend" "beginend.el" (22148 1134 826135
;;;;;;  715000))
;;; Generated autoloads from beginend.el

(autoload 'beginend-setup-all "beginend" "\
Use beginend on all compatible modes.
For `dired', this activates `beginend-dired-mode'.
For messages, this activates `beginend-message-mode'.

\(fn)" nil nil)

(autoload 'beginend-message-goto-beginning "beginend" "\
Go to the beginning of an email, after the headers.

\(fn)" t nil)

(autoload 'beginend-message-goto-end "beginend" "\
Go to the end of an email, before the signature.

\(fn)" t nil)

(autoload 'beginend-dired-goto-beginning "beginend" "\
Go to the beginning of a dired's buffer first file, after `.' and `..'.

\(fn)" t nil)

(autoload 'beginend-dired-goto-end "beginend" "\
Go at the end of a dired's buffer last file, before the empty line.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; beginend-autoloads.el ends here
