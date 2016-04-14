;;; rectangle-utils-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "rectangle-utils" "rectangle-utils.el" (22287
;;;;;;  16142 925644 758000))
;;; Generated autoloads from rectangle-utils.el

(autoload 'rectangle-utils-extend-rectangle-to-end "rectangle-utils" "\
Create a rectangle based on the longest line of region.

\(fn BEG END)" t nil)

(autoload 'rectangle-utils-menu "rectangle-utils" "\


\(fn BEG END)" t nil)

(autoload 'rectangle-utils-insert-at-right "rectangle-utils" "\
Create a new rectangle based on longest line of regionand insert string at right of it.
With prefix arg, insert string at end of each lines (no rectangle).

\(fn BEG END ARG)" t nil)

(autoload 'rectangle-utils-copy-rectangle "rectangle-utils" "\
Well, copy rectangle, not kill.

\(fn BEG END)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rectangle-utils-autoloads.el ends here
