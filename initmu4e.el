;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files

(require 'package)
;since we are using use-packag-don't autoload anythings
(setq package-enable-at-startup nil)

;sources for package.el 
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
		  ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
		  ("org" . "http://orgmode.org/elpa/")
                  ))
  (add-to-list 'package-archives source t))

;; Initialize installed package
(package-initialize)  

;; Bootstrap `use-package'
;(unless (package-installed-p 'use-package)
;  (package-refresh-contents)
;  (package-install 'use-package))

(require 'use-package)


;(add-to-list 'load-path "~/.emacs.g/org-mode/lisp")

(require 'org)
(org-babel-load-file
(expand-file-name "mu4esettings.org"
                   user-emacs-directory))

;; init.el ends here

