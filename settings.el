
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

; Check if system is windows
(defun system-type-is-win ()
(interactive)
"Return true if system is windows"
(string-equal system-type "windows-nt")
)

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
(interactive)
"Return true if system is GNU/Linux-based"
(string-equal system-type "gnu/linux")
)

;;;add custom themes to list
(add-to-list 'custom-theme-load-path "/home/zeltak/.emacs.d/themes")
;to load a specifc theme 
;(load-file "~/.emacs.d/themes/zprime-theme.el")
;load the choosen theme at startup 
(load-theme 'zprime t)

;; fonts in linux
(if (system-type-is-gnu)
;(add-to-list 'default-frame-alist '(font . "Inconsolata-16"))
;(add-to-list 'default-frame-alist '(font . "Source Code Pro-14"))
(add-to-list 'default-frame-alist '(font . "Pragmata Pro-14"))
)

;; fonts in Win
(if (system-type-is-win)
(add-to-list 'default-frame-alist '(font . "Consolas-14"))
)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
 
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(global-unset-key (kbd "<f1>"))
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4> "))
(global-unset-key (kbd "<f5>"))
(global-unset-key (kbd "<f6>"))
(global-unset-key (kbd "<f7>"))
(global-unset-key (kbd "<f8>"))
(global-unset-key (kbd "<f9>"))
(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<f12>"))
(global-unset-key (kbd "C-v "))
(global-unset-key (kbd "M-p"))

(define-key org-mode-map (kbd "<f1> S") (lambda () (interactive) (org-agenda nil "s" "<")))
;;below code for by type and todo (cook)
;+TODO="COOK"+Type="breakfest"
(define-key org-mode-map (kbd "<f1> v") (lambda () (interactive) (org-agenda nil "a" )))
(define-key org-mode-map (kbd "<f1> r") (lambda () (interactive) (org-agenda nil "r" )))
(global-set-key (kbd "<f1> h") 'org-goto)
(global-set-key (kbd "<f1> d d") 'org-timestamp-select)
(global-set-key (kbd "<f1> d n") 'org-timestamp-now)
(global-set-key (kbd "<f1> d i") 'z-insert-date)
(global-set-key (kbd "<f1> d l") 'org-deadline)
(global-set-key (kbd "<f1> d s") 'org-schedule)
(global-set-key (kbd "<f1> t") 'org-todo)
(global-set-key (kbd "<f1> a") 'org-agenda)
(global-set-key "\C-ca" 'org-agenda)

;;org cookbook

;(global-set-key (kbd "<f1> c") 'my-cooking-sparse-tree-breakfeast)
(define-key org-mode-map (kbd "<f1> c b") 'cooking-sparse-tree-breakfeast)
(define-key org-mode-map (kbd "<f1> c m") 'cooking-sparse-tree-main)
(define-key org-mode-map (kbd "<f1> c r") 'recipe-template)
(define-key org-mode-map (kbd "<f1> c t") 'travel-template)

(global-set-key (kbd "<f2> e") 'evil-mode)
;;yas
(global-set-key (kbd "<f2> y y") 'yas-insert-snippet)
(global-set-key (kbd "<f2> y n") 'yas-new-snippet)
(global-set-key (kbd "<f2> y r ") 'yas-reload-all)
(global-set-key (kbd "<f2> y v ") 'yas-visit-snippet-file)

;dired
(define-key global-map (kbd "<f3> d") 'dired)
(global-set-key (kbd "<f3> j") 'dired-jump) 
(global-set-key (kbd "<f3> r") 'z-edit-file-as-root) 
(global-set-key (kbd "<f3> E") 'view-mode) 
(global-set-key (kbd "<f3> e") 'read-only-mode) 
(global-set-key (kbd "<f3> s") 'babcore-shell-execute)
(global-set-key (kbd "<f3> b") 'create-scratch-buffer)
(global-set-key (kbd "<f3> r") 'z-edit-file-as-root)
(global-set-key (kbd "<f3> l") 'linium-mode)
(global-set-key (kbd "<f3> ;") 'comment-region)
(global-set-key (kbd "<f3> o") 'back-button-global)

(global-set-key (kbd "<f3> m s") 'start-kbd-macro)
(global-set-key (kbd "<f3> m q") 'end-kbd-macro)
(global-set-key (kbd "<f3> m n") 'name-kbd-macro)
(global-set-key (kbd "<f3> m i") 'insert-kbd-macro)



;;; non F3
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "<f4> c h") 'org-set-line-headline); convert selected lines to headers
(global-set-key (kbd "<f4> c b") 'org-set-line-checkbox); convert selected lines to checkboxes
;convert region to code blocks
(global-set-key (kbd "<f4> e") 'z-wrap-cblock-example)
(global-set-key (kbd "<f4> b") 'z-wrap-cblock-sh)
(global-set-key (kbd "<f4> <f4> b") 'z-wrap-line-bash)
(global-set-key (kbd "<f4> r") 'z-wrap-cblock-r)
(global-set-key (kbd "<f4> q") 'z-wrap-cblock-quote)
(global-set-key (kbd "<f4> l") 'z-wrap-cblock-lisp)
(global-set-key (kbd "<f4> s") 'z-wrap-cblock-sas)
;; easy spell check
(global-set-key (kbd "<f4> w") 'ispell-word)
(global-set-key (kbd "<f4> W") 'ispell)
(global-set-key (kbd "<f4> f") 'flyspell-check-next-highlighted-word)

(global-set-key (kbd "<f4> ;") 'z-copy-comment-paste)
(global-set-key (kbd "<f4> u") 'z-fix-characters)
(global-set-key (kbd "<f4> 6 u") 'upcase-region)
(global-set-key (kbd "<f4> 6 l") 'downcase-region)


(global-set-key (kbd "<f4> k") 'browse-kill-ring)
(global-set-key (kbd "<f4> B ") 'flush-blank-lines)

;; move lines up dowb with C-S-pgup/pgdown
(global-set-key [(control shift prior )]  'move-line-up)
(global-set-key [(control shift next)]  'move-line-down)

; kill (delete) from word to back of the line
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)))

(global-set-key (kbd "<f5> g") 'gnus)

(global-set-key (kbd "<f6> <f6>") 'helm-org-headlines)

(global-set-key (kbd "<f7> y") 'helm-show-kill-ring)
(global-set-key (kbd "<f7> k") 'helm-show-kill-ring)
(global-set-key (kbd "<f7> r") 'helm-recentf)
(global-set-key (kbd "<f7> l") 'helm-locate)
(global-set-key (kbd "<f7> x") 'helm-M-x)
(global-set-key (kbd "<f7> f") 'helm-find-files)
;to replace native C-x C-f
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "<f7> o") 'helm-occur)
(global-set-key (kbd "<f7> h") 'helm-apropos)
(global-set-key (kbd "<f7> t") 'helm-top)

(global-set-key (kbd "<f7> b") 'helm-buffers-list)
(global-set-key (kbd "<f7> <f7>") 'helm-mini)

(global-set-key (kbd "C-c h") 'helm-command-prefix)

(global-set-key (kbd "<f8> <f8> ") 'bookmark-jump)
(global-set-key (kbd "<f8> h") 'helm-bookmarks)
(global-set-key (kbd "<f8> m") 'bookmark-bmenu-list)
(global-set-key (kbd "<f8> r") 'recentf-open-files)
(global-set-key (kbd "<f8> b") 'bmkp-bookmark-set-confirm-overwrite)
(global-set-key (kbd "<f8> s") 'bmkp-bmenu-filter-tags-incrementally)

(global-set-key (kbd "<f9> x") 'org-archive-subtree)
(global-set-key (kbd "<f9> u") 'outline-up-heading)
(global-set-key (kbd "<f9> e") 'org-export-dispatch)
(global-set-key (kbd "<f9> t") 'org-toggle-inline-images)
(global-set-key (kbd "<f9> c") 'org-columns)
(global-set-key (kbd "<f9> q") 'org-columns-quit)
(global-set-key (kbd "<f9> b") 'org-bibtex-yank)
(global-set-key (kbd "<f9> r") 'org-refile)
(global-set-key (kbd "<f9> B") 'org-bibtex-create)
(global-set-key (kbd "<f9> s") 'org-sort)
(global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)
(global-set-key (kbd "<f9> w") 'widen)
(global-set-key (kbd "<f9> d") 'org-download-screenshot)
(global-set-key (kbd "<f9> D") 'org-download-delete)
;Create an ID for the entry at point if it does not yet have one.
(global-set-key (kbd "<f9> I") 'org-id-get-create)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "<f9> p") 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key (kbd "<f9> l s") 'org-store-link)
(global-set-key (kbd "<f9> l i") 'org-insert-link)
(global-set-key (kbd "<f9> l c") 'org-id-copy)
(global-set-key (kbd "<f9> l e") 'org-id-copy)

;movies DL
  (global-set-key (kbd "<f9> <f9> v")
    (lambda ()
      (interactive)
        (org-id-goto "62b49339-cd19-4a3c-a6fd-70dd45be4670")))
;  emacs
  (global-set-key (kbd "<f9> <f9> e ")
    (lambda ()
      (interactive)
        (org-id-goto "38a15adf-f505-4a54-b1d9-f76b22ce1147")
        (org-narrow-to-subtree)
))
  
  
  ;org
  (global-set-key (kbd "<f9> <f9> o")
    (lambda ()
      (interactive)
        (org-id-goto "be4759e1-2951-4c91-a155-056bc2a16d9f")
        (org-narrow-to-subtree)
))
  
  ;ssh
  (global-set-key (kbd "<f9> <f9> s")
    (lambda ()
      (interactive)
        (org-id-goto "bf60adbf-fc3a-4eed-be14-a9244c3fef4e")))
  
  ;beets
  (global-set-key (kbd "<f9> <f9> b")
    (lambda ()
      (interactive)
        (org-id-goto "e0837792-f794-495e-908f-f75bdb4462b3")))
  
  
  ;git
  (global-set-key (kbd "<f9> <f9> g")
    (lambda ()
      (interactive)
        (org-id-goto "7816c1c8-be9a-4fd5-8121-15c190885cd7")))
  
  ;mobileorg
  (global-set-key (kbd "<f9> <f9> m")
    (lambda ()
      (interactive)
        (org-id-goto "0367963c-9ba2-44ee-9b30-bf5b7200b873")))
  
  ;papers
  (global-set-key (kbd "<f9> <f9> p")
    (lambda ()
      (interactive)
        (org-id-goto "47bad96f-740c-4b93-b739-a4b925d85514")))
  
  ;capture settings
 ; (global-set-key (kbd "<f9> <f9> e c")
  ;  (lambda ()
   ;   (interactive)
    ;    (org-id-goto "dfffbe27-21bc-4fb9-908e-f492f4afeb60")))
  
  
  ;papers
  (global-set-key (kbd "<f9> <f9> c c ")
    (lambda ()
      (interactive)
        (org-id-goto "8193566d-2dd5-4368-8238-fac2fc9aa7e9")))

(global-set-key "\C-cs" 'org-babel-execute-subtree)
(global-set-key (kbd "<f10> b s ") 'org-babel-execute-subtree)
(global-set-key (kbd "<f10> s d ") 'org-cut-subtree)
(global-set-key (kbd "<f10> s y ") 'org-copy-subtree)
(global-set-key (kbd "<f10> s p ") 'org-paste-subtree)
(global-set-key (kbd "<f10> 8 ") 'org-toggle-heading)
(global-set-key (kbd "<f10> 7 ") 'org-toggle-heading)
(global-set-key (kbd "<f10> h ") 'org-insert-heading)
 (global-set-key (kbd "<f10> n ") 'org-indent-mode)


(global-set-key (kbd "<f10> m p ") 'org-mobile-pull)
(global-set-key (kbd "<f10> m s ") 'org-insert-push)

(global-set-key (kbd "<f10> t y") 'org-table-copy-region)
(global-set-key (kbd "<f10> t d") 'org-table-cut-region)
(global-set-key (kbd "<f10> t p") 'org-table-paste-rectangle)
(global-set-key (kbd "<f10> t c") 'org-table-create-or-convert-from-region)

;;saving and closing
(global-set-key (kbd "<f11> s") 'save-buffer); Aux save
(global-set-key (kbd "<f11> x") 'kill-this-buffer) ; Close file and buffer
(global-set-key (kbd "<f11> C") 'z-kill-other-buffers ) ; close all buffers but current-based on user script
(global-set-key (kbd "<f11> W") (lambda () (interactive) (save-buffer) (kill-buffer)  ))
(global-set-key (kbd "<f11> X") 'save-buffers-kill-terminl)
(global-set-key (kbd "<f11> i") 'kill-buffer) ; ido kill buffer
(global-set-key (kbd "<f11> S") 'z-save-file-close-window) ; 

;buffers movment
(global-set-key (kbd "<f11> p") 'previous-user-buffer) ; 
(global-set-key (kbd "<f11> n") 'next-user-buffer) ; 
(global-set-key (kbd "<f11> P") 'previous-emacs-buffer) ; 
(global-set-key (kbd "<f11> N") 'next-emacs-buffer) ; 
(global-set-key (kbd "<f11> <f11> ") 'switch-to-previous-buffer)

(global-set-key (kbd "<f12> <f12>") 'other-window)  
(global-set-key (kbd "<f12> x") 'delete-window)  
(global-set-key (kbd "<f12> z") 'delete-other-windows)  
(global-set-key (kbd "<f12> v") 'split-window-vertically)  
(global-set-key (kbd "<f12> l") 'split-window-right)  
(global-set-key (kbd "<f12> j") 'split-window-below)

(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program "chromium")

(setq backup-directory-alist '(("." . "/home/zeltak/.cache/emacs/bk")))

;Make backups of files, even when they're in version control
(setq vc-make-backup-files nil)

(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;If I reopen a file, I want to start at the line at which I was when I closed it.
; save the place in files
(require 'saveplace)
(setq-default save-place t)

; save minibuffer history
(require 'savehist)
(savehist-mode t)

;;autosave
;(setq auto-save-visited-file-name t)
;(setq auto-save-interval 20) ; twenty keystrokes
(setq auto-save-timeout 60) ; ten idle seconds

(setq savehist-file "/home/zeltak/.cache/emacs/hist/hist.txt")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; (require 'recentf)
  ;; (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
  ;; (recentf-mode 1)
  ;; (setq recentf-max-menu-items 25)
  ;; ;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;(recentf-mode 1) ; keep a list of recently opened files
;(setq recentf-max-menu-items 500)
;(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!

(require 'tramp) ; Remote file editing via ssh
(setq tramp-default-method "ssh")

(defun proced-settings ()
  (proced-toggle-auto-update))

(add-hook 'proced-mode-hook 'proced-settings)

(require 'package)
;; use packages from marmalade
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; and the old elpa repo
(add-to-list 'package-archives '("elpa-old" . "http://tromey.com/elpa/"))
;; and automatically parsed versiontracking repositories.
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("SC" . "http://joseito.republika.pl/sunrise-commander/"))



;; Make sure a package is installed
(defun package-require (package)
  "Install a PACKAGE unless it is already installed 
or a feature with the same name is already active.

Usage: (package-require 'package)"
  ; try to activate the package with at least version 0.
  (package-activate package '(0))
  ; try to just require the package. Maybe the user has it in his local config
  (condition-case nil
      (require package)
    ; if we cannot require it, it does not exist, yet. So install it.
    (error (package-install package))))

;; Initialize installed packages
(package-initialize)  
;; package init not needed, since it is done anyway in emacs 24 after reading the init
;; but we have to load the list of available packages

(setq package-enable-at-startup nil)

;;uncomment to have emacs refresh all packages on startup-makes emacs very slow
;(package-refresh-contents)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)

(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(require 'helm-cmd-t)

(defvar my-org-folders (list  "~/org/files/")
  "my permanent folders for helm-mini")

(defun helm-my-org (&optional arg)
  "Use C-u arg to work with repos."
  (interactive "P")
  (if (consp arg)
      (call-interactively 'helm-cmd-t-repos)
    (let ((helm-ff-transformer-show-only-basename nil))
      (helm :sources (mapcar (lambda (dir)
                               (helm-cmd-t-get-create-source-dir dir))
                             my-org-folders)
            :candidate-number-limit 20
            :buffer "*helm-my-org:*"
            :input "org$ "))))

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(setq helm-locate-fuzzy-match t)



(require 'async)

(require 'evil)
(evil-mode 1)

;for normal undo
(setq evil-want-fine-undo t)

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;searches
(global-set-key (kbd "C-*") 'evil-search-symbol-forward)
(global-set-key (kbd "C-#") 'evil-search-symbol-backward)

(evilnc-default-hotkeys)
(setq evilnc-hotkey-comment-operator ",,")

(require 'edit-server)
 (edit-server-start)
(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(require 'dired-sort)

(toggle-diredp-find-file-reuse-dir 1)

(load-file "~/.emacs.g/extra/org-download/org-download.el")

(setq-default org-download-heading-lvl nil)
(setq-default org-download-image-dir "/home/zeltak/org/attach/images_2014")

;(if (string= system-name "voices") (setq-default org-download-image-dir "/home/zeltak/org/attach/images_2014/") (setq-default org-download-image-dir "/media/NAS/Uni/org/attach/images_2013/"))

(add-to-list 'load-path "/home/zeltak/.emacs.g/extra/org-dp/")
(require 'org-dp-lib)

(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ""           ;; foo-mode and bar-mode snippet collection
        "" ;; the yasmate collection
        ""         ;; the default collection
        ))

(yas-global-mode 1)

;;; use popup menu for yas-choose-value
(require 'popup)

;; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

(require 'browse-kill-ring)

;; (ido-mode 1)
;; (require 'flx-ido)
;; (ido-everywhere 1)
;; (flx-ido-mode 1)
;; ;; disable ido faces to see flx highlights.
;; (setq ido-use-faces nil)


;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))
;; ; Use the current window when visiting files and buffers with ido
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)



;; ;ignore case
;; (setq ido-case-fold t)
;; (setq ido-enable-flex-matching t) ; fuzzy matching is a must have

;; ;ido-ubiquitous

;; ;recents ido
;; (defun recentf-ido-find-file ()
;;   "Find a recent file using ido."
;;   (interactive)
;;   (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
;;     (when file
;;      (find-file file))))


;; ;this keybinding lets you even more quickly reach your home folder when in ido-find-file.

;; (add-hook 'ido-setup-hook
;;  (lambda ()
;;    ;; Go straight home
;;    (define-key ido-file-completion-map
;;      (kbd "~")
;;      (lambda ()
;;        (interactive)
;;        (if (looking-back "/")
;;            (insert "~/")
;;          (call-interactively 'self-insert-command))))))

(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.

;Bind some keys:

;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; (require 'icicles)
;; ;turn on by default
;; (icy-mode 1)

(require 'bookmark+)
(setq bookmark-version-control t
      bookmark-save-flag t)
;ask for tags when saving a bookmark move nil to t to ask each time
(setq bmkp-prompt-for-tags-flag nil)

(require 'undo-tree)
 ;automatically save and restore undo-tree history along with buffer (disabled by default)
 (global-undo-tree-mode 1)
 ;Eable the undo-tree-auto-save-history customization option to automatically save and load undo history in undo-tree buffers 
 (setq undo-tree-auto-save-history t)
 (setq undo-tree-history-directory-alist
       `((".*" . ,(concat user-emacs-directory "undo"))))

;; (setq dcsh-command-list '("all_registers"
;;                               "check_design" "check_test" "compile" "current_design"
;;                               "link" "uniquify"
;;                               "report_timing" "report_clocks" "report_constraint"
;;                               "get_unix_variable" "set_unix_variable"
;;                               "set_max_fanout"
;;                               "report_area" "all_clocks" "all_inputs" "all_outputs"))
    
;;     (defun he-dcsh-command-beg ()
;;       (let ((p))
;;         (save-excursion
;;           (backward-word 1)
;;           (setq p (point)))
;;         p))
    
;;     (defun try-expand-dcsh-command (old)
;;       (unless old
;;         (he-init-string (he-dcsh-command-beg) (point))
;;         (setq he-expand-list (sort
;;                               (all-completions he-search-string (mapcar 'list dcsh-command-list))
;;                               'string-lessp)))
;;       (while (and he-expand-list
;;               (he-string-member (car he-expand-list) he-tried-table))
;;         (setq he-expand-list (cdr he-expand-list)))
;;       (if (null he-expand-list)
;;           (progn
;;             (when old (he-reset-string))
;;             ())
;;         (he-substitute-string (car he-expand-list))
;;         (setq he-tried-table (cons (car he-expand-list) (cdr he-tried-table)))
;;         (setq he-expand-list (cdr he-expand-list))
;;         t))

;; (setq hippie-expand-try-functions-list (cons 'yas/hippie-try-expand hippie-expand-try-functions-list))
 
;; (defun my-hippie-expand-completions (&optional hippie-expand-function)
;;       "Return the full list of possible completions generated by `hippie-expand'.
;;     The optional argument can be generated with `make-hippie-expand-function'."
;;       (let ((this-command 'my-hippie-expand-completions)
;;             (last-command last-command)
;;             (buffer-modified (buffer-modified-p))
;;             (hippie-expand-function (or hippie-expand-function 'hippie-expand)))
;;         (flet ((ding)) ; avoid the (ding) when hippie-expand exhausts its options.
;;           (while (progn
;;                    (funcall hippie-expand-function nil)
;;                    (setq last-command 'my-hippie-expand-completions)
;;                    (not (equal he-num -1)))))
;;         ;; Evaluating the completions modifies the buffer, however we will finish
;;         ;; up in the same state that we began, and (save-current-buffer) seems a
;;         ;; bit heavyweight in the circumstances.
;;         (set-buffer-modified-p buffer-modified)
;;         ;; Provide the options in the order in which they are normally generated.
;;         (delete he-search-string (reverse he-tried-table))))
     
;;     (defmacro my-ido-hippie-expand-with (hippie-expand-function)
;;       "Generate an interactively-callable function that offers ido-based completion
;;     using the specified hippie-expand function."
;;       `(call-interactively
;;         (lambda (&optional selection)
;;           (interactive
;;            (let ((options (my-hippie-expand-completions ,hippie-expand-function)))
;;              (if options
;;                  (list (ido-completing-read "Completions: " options)))))
;;           (if selection
;;               (he-substitute-string selection t)
;;             (message "No expansion found")))))
     
;;     (defun my-ido-hippie-expand ()
;;       "Offer ido-based completion for the word at point."
;;       (interactive)
;;       (my-ido-hippie-expand-with 'hippie-expand))
     
;; (global-set-key (kbd "<f12>") 'my-ido-hippie-expand)
;; (global-set-key [(meta f5)] (make-hippie-expand-function
;;                                '(try-expand-dcsh-command
;;                                  try-expand-dabbrev-visible
;;                                  try-expand-dabbrev
;;                                  try-expand-dabbrev-all-buffers) t))
;; (global-set-key (kbd "M-/") 'hippie-expand)
;; (global-set-key (kbd "TAB") 'hippie-expand)

;;open with
(require 'openwith)
(setq openwith-associations '(("\\.pdf\\'" "okular" (file))))
(setq openwith-associations '(("\\.mkv\\'" "mplayer" (file))))
(setq openwith-associations '(("\\.html\\'" "chromium" (file))))
(setq openwith-associations '(("\\.html\\'" "eww" (file))))
(setq openwith-associations '(("\\.mp4\\'" "vlc" (file))))
(setq openwith-associations '(("\\.ogm\\'" "vlc" (file))))
(setq openwith-associations '(("\\.avi\\'" "vlc" (file))))
(setq openwith-associations '(("\\.mpeg\\'" "vlc" (file))))
(setq openwith-associations '(("\\.mkv\\'" "vlc" (file))))
(openwith-mode t)

;; some proposals for binding:

(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "M-SPC") #'evil-ace-jump-line-mode)
 
;; (define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode)      ; similar to f
;; (define-key evil-operator-state-map (kbd "C-SPC") #'evil-ace-jump-char-to-mode) ; similar to t
;; (define-key evil-operator-state-map (kbd "M-SPC") #'evil-ace-jump-word-mode)

;(require 'tex)
;(setq preview-scale-function 1.1)

(global-set-key (kbd "C-x o") 'switch-window)
(require 'switch-window)

(require 'guide-key)
(guide-key-mode 1)  ; Enable guide-key-mode
(setq guide-key/idle-delay 0.1)

(setq guide-key/popup-window-position "right")

;(setq guide-key/guide-key-sequence '("C-c" "C-x r" "C-x 4" "f9"))
(setq guide-key/guide-key-sequence '("<f9>" "<f1>"))
(setq guide-key/recursive-key-sequence-flag t)

;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (ac-config-default)

;; (add-to-list 'completion-styles 'initials t)
;; (add-to-list 'ac-sources 'ac-source-semantic)

;; (setq-default ac-sources (cons 'ac-source-yasnippet ac-sources))

;; ;;; customizations
;; (setq ac-auto-start 2
;;       ac-delay 0.
;;       ac-quick-help-delay 0.
;;       ac-use-fuzzy t
;;       tab-always-indent 'complete ; use 'complete when auto-complete is disabled
;;       ac-dwim t)

;; (define-key ac-completing-map (kbd "C-n") 'ac-next)
;; (define-key ac-completing-map (kbd "C-p") 'ac-previous)
;; ;; (define-key ac-completing-map "\M-/" 'ac-stop)
;; (define-key ac-completing-map "\t" 'ac-expand-common)
;; (define-key ac-completing-map (kbd "RET") 'ac-complete)

;; ;;; work around for autopair auto-complete
;; (define-key ac-completing-map [return] 'ac-complete)
;; (add-hook 'auto-complete-mode-hook 'ac-flyspell-workaround)

;; ;;; list of modes where ac should be available
;; (dolist (mode '(emacs-lisp-mode
;;                 lisp-interaction-mode
;;                 inferior-emacs-lisp-mode
;;                 magit-log-edit-mode
;;                 log-edit-mode
;;                 org-mode
;;                 text-mode
;;                 haml-mode
;;                 sass-mode
;;                 yaml-mode
;;                 haskell-mode
;;                 html-mode
;;                 nxml-mode
;;                 sh-mode
;;                 lisp-mode
;;                 textile-mode
;;                 markdown-mode
;;                 cperl-mode
;;                 sass-mode
;;                 latex-mode
;;                 fortran-mode
;;                 f90-mode))

;;   (add-to-list 'ac-modes mode))

(require 'company)
(global-company-mode 1)
;To use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;;look and feel
(setq company-idle-delay 0.3)
(setq company-tooltip-limit 20)
(setq company-minimum-prefix-length 2)
(setq company-echo-delay 0)
(setq company-auto-complete nil)
(add-to-list 'company-backends 'company-dabbrev t)
(add-to-list 'company-backends 'company-ispell t)
(add-to-list 'company-backends 'company-files t)

;; (defun my-pcomplete-capf ()
;;   (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
;; (add-hook 'org-mode-hook #'my-pcomplete-capf)

(require 'back-button)
(back-button-mode 1)

(rainbow-mode 1)

(dolist (hook '(css-mode-hook
                html-mode-hook
                js-mode-hook
                emacs-lisp-mode-hook
                org-mode-hook
                text-mode-hook
                ))
  (add-hook hook 'rainbow-mode))

(require 'google-contacts)



;(load-file "/home/zeltak/.emacs.g/extra/org-screenshot/org-screenshot.el")
;(require 'org-screenshot)

;; (require 'fill-column-indicator)
;;  (setq fci-rule-width 1)
;;   (setq fci-rule-color "darkblue")

;; ;to turn it on automatically when visiting a file with C code, put the following line in your init file:
;; (add-hook 'org-mode-hook 'fci-mode)

;; ;To turn on fci-mode automatically for all files, put the following line in your init file:
;; ;add-hook 'after-change-major-mode-hook 'fci-mode)

;; ;To enable fci-mode as a global minor mode, put the following code to your init file:
;; ;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; ;(global-fci-mode 1)

(if (string= system-name "voices") 
(progn
(setq org-directory "~/org/files/")
(setq org-default-notes-file "~/org/files/refile.org")
)

(progn
(setq org-directory "/media/NAS/Uni/org/files/")
)
)

;associate these files with org
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;don’t insert blank lines
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))
;make new headings appear after the content for the current one
(setq org-insert-heading-respect-content t)
;allow RETURN to open links
(setq org-return-follows-link nil)
;going to the beginning and end of the heading instead of the current line
(setq org-special-ctrl-a/e t)
;rebind certain one-letter keybindings when the cursor is at the beginning of the row - most notably ‘t’ for org-todo instead of ‘C-c C-t’
(setq org-startup-align-all-tables t)
(setq org-archive-location (concat org-directory "archive/%s_archive::"))
(setq org-attach-store-link-p)
;to make ido mode work in org mode as wel
(setq org-completion-use-ido t)
;allow speedkeys
(setq org-use-speed-commands t)
(setq org-speed-commands-user nil)
(setq org-src-fontify-natively t);; syntax highlighting the source code

(run-at-time "00:59" 3600 'org-save-all-org-buffers)

;enable flyspelll
(add-hook 'org-mode-hook  
          (lambda ()      
            (flyspell-mode)))

;;disable linemode on org
(defun my-org-mode-hook () 
  (linum-mode 0)) 
(add-hook 'org-mode-hook 'my-org-mode-hook)

;(add-hook 'org-mode-hook (lambda () (view-mode 1)))

;; (defvar tj/last-buffer-tick nil)
;; (make-variable-buffer-local 'tj/last-buffer-tick)

;; (defun tj/new-buffer-ticks-p ()
;;   (let ((curr-tick (buffer-modified-tick))
;;         (last-tick tj/last-buffer-tick))
;;     (setq tj/last-buffer-tick curr-tick)
;;     (and last-tick (= last-tick curr-tick))))

;; (defun tj/reset-view-mode ()
;;   (run-with-timer 0 (* 5 60)
;;                   (lambda ()
;;                     (when (tj/new-buffer-ticks-p)
;;                       (view-mode t)))))

;; (add-hook 'org-mode-hook 'tj/reset-view-mode)

(org-add-link-type
 "grep"
 (defun endless/follow-grep-link (regexp)
   "Run `rgrep' with REGEXP as argument."
   (grep-compute-defaults)
   (rgrep regexp "*" (expand-file-name "./"))))

(push (cons "\\.pdf\\'" 'emacs) org-file-apps)
(push (cons "\\.html\\'" 'emacs) org-file-apps)
(push (cons "\\.mp4\\'" 'vlc) org-file-apps)

(setq org-id-link-to-org-use-id t)

(add-to-list 'org-modules "org-habit")

;;iimage in org (display images in org files)
(setq org-startup-with-inline-images t)

;;set the org image default size
;(setq org-image-actual-width nil)
(setq org-image-actual-width '(400))

(setq org-use-tag-inheritance nil)

;; (setq org-tag-faces
;;   '(("Indian" . (:foreground "#00000"))
;;      ("Asian"  . (:foreground "#C00000"))
;;      ("israeli"  . (:foreground "#C0a000"))))

(org-add-link-type
 "tag"
 (defun endless/follow-tag-link (tag)
   "Display a list of TODO headlines with tag TAG.
With prefix argument, also display headlines without a TODO keyword."
   (org-tags-view (null current-prefix-arg) tag)))

;allow fast todo
(setq org-use-fast-todo-selection t)
;allow shift-left right to change todo state
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" ))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("PAUSED" :foreground "gray" :weight bold)
              ("SUBMITTED" :foreground "#FFC612" :weight bold)
              ("K_TRACK" :foreground "#45D0FF" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("PUB" :foreground "#00FF37" :weight bold)
              ("PREP" :foreground "#FF7BD0" :weight bold)
              ("SUB" :foreground "#CE008B" :weight bold)
              ("COOK" :background "#0CFB32" :foreground "#001F57" :weight bold)
              ("SHOP" :background "#9CFFBB" :foreground "#004D18" :weight bold)
              )))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-highest-priority ?A)
(setq org-lowest-priority ?A)
(setq org-default-priority ?A)

(setq org-priority-start-cycle-with-default t)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep

;; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;;                                  (org-agenda-files :maxlevel . 9))))

(setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3)))



; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;; goto/navigate with org-refile (C-u c-c c-w)
(setq org-goto-max-level 10)
(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)

;;For agenda files locations, each location you add within " "
(require 'org-mobile)
(setq org-agenda-files '("~/org/files/agenda/"))

(setq org-mobile-directory "~/Dropbox/MobileOrg/")

;; Set to the name of the file where new captures will be stored after pulling from mobile
(setq org-mobile-inbox-for-pull "~/org/files/from-mobile.org")

;; (defvar org-mobile-push-timer nil
;;   "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")

;; (defun org-mobile-push-with-delay (secs)
;;   (when org-mobile-push-timer
;;     (cancel-timer org-mobile-push-timer))
;;   (setq org-mobile-push-timer
;;         (run-with-idle-timer
;;          (* 1 secs) nil 'org-mobile-push)))

;; (add-hook 'after-save-hook 
;;  (lambda () 
;;    (when (eq major-mode 'org-mode)
;;      (dolist (file (org-mobile-files-alist))
;;       (if (string= (file-truename (expand-file-name (car file)))
;;                    (file-truename (buffer-file-name)))
;;            (org-mobile-push-with-delay 30)))
;;    )))

;; (run-at-time "00:05" 86400 '(lambda () (org-mobile-push-with-delay 1))) ;; refreshes agenda file each day

;; ;; Fork the work (async) of pushing to mobile
;; ;; https://gist.github.com/3111823 ASYNC org mobile push...
;; (require 'gnus-async) 
;; ;; Define a timer variable
;; (defvar org-mobile-push-timer nil
;;   "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")
;; ;; Push to mobile when the idle timer runs out
;; (defun org-mobile-push-with-delay (secs)
;;    (when org-mobile-push-timer
;;     (cancel-timer org-mobile-push-timer))
;;   (setq org-mobile-push-timer
;;         (run-with-idle-timer
;;          (* 1 secs) nil 'org-mobile-push)))
;; ;; After saving files, start an idle timer after which we are going to push 
;; (add-hook 'after-save-hook 
;;  (lambda () 
;;    (if (or (eq major-mode 'org-mode) (eq major-mode 'org-agenda-mode))
;;      (dolist (file (org-mobile-files-alist))
;;        (if (string= (expand-file-name (car file)) (buffer-file-name))
;;            (org-mobile-push-with-delay 10)))
;;      )))
;; ;; Run after midnight each day (or each morning upon wakeup?).
;; (run-at-time "00:01" 86400 '(lambda () (org-mobile-push-with-delay 1)))
;; ;; Run 1 minute after launch, and once a day after that.
;; (run-at-time "1 min" 86400 '(lambda () (org-mobile-push-with-delay 1)))

;; ;; watch mobileorg.org for changes, and then call org-mobile-pull
;; ;; http://stackoverflow.com/questions/3456782/emacs-lisp-how-to-monitor-changes-of-a-file-directory
;; (defun install-monitor (file secs)
;;   (run-with-timer
;;    0 secs
;;    (lambda (f p)
;;      (unless (< p (second (time-since (elt (file-attributes f) 5))))
;;        (org-mobile-pull)))
;;    file secs))
;; (defvar monitor-timer (install-monitor (concat org-mobile-directory "/mobileorg.org") 30)
;;   "Check if file changed every 30 s.")

; And add babel inline code execution
; babel, for executing code in org-mode.
(org-babel-do-load-languages
 'org-babel-load-languages
 ; load all language marked with (lang . t).
 '((C . t)
   (R . t)
   (asymptote)
   (awk)
   (calc)
   (clojure)
   (comint)
   (css)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (fortran)
   (gnuplot . t)
   (haskell)
   (io)
   (java)
   (js)
   (latex)
   (ledger)
   (lilypond)
   (lisp)
   (matlab)
   (maxima)
   (mscgen)
   (ocaml)
   (octave)
   (org . t)
   (perl)
   (picolisp)
   (plantuml)
   (python . t)
   (ref)
   (ruby)
   (sass)
   (scala)
   (scheme)
   (screen)
   (sh . t)
   (shen)
   (sql)
   (sqlite)))

;; (defun my-org-confirm-babel-evaluate (lang body)
;;     (not (string= lang "emacs-lisp")))  ; don't ask for lisp
;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(setq org-confirm-babel-evaluate nil)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

(defadvice org-babel-execute:sh (around sacha activate)
  (if (assoc-default :term (ad-get-arg 1) nil)
    (let ((buffer (make-term "babel" "/bin/zsh")))
      (with-current-buffer buffer
        (insert (org-babel-expand-body:generic
             body params (org-babel-variable-assignments:sh params)))
        (term-send-input))
(pop-to-buffer buffer))
    ad-do-it))

(defun org-timestamp-now ()
  "Inserts org timestamp at end of heading"
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-end-of-line nil)
    (insert " ")
    (org-insert-time-stamp nil nil t nil nil nil)))

(defun org-timestamp-select ()
  "Inserts org timestamp at end of heading"
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-end-of-line nil)
    (org-time-stamp-inactive nil)))

(defun org-table-import-ods (&optional file-name)
(interactive "fFile: ")
(let ((csv-file (org-odt-convert file-name "csv"))
(pos (point)))
(save-excursion
(insert (with-temp-buffer
(insert-file-contents csv-file)
(org-table-convert-region (point-min) (point-max) '(4))
(buffer-string))))))

(defun org-set-line-checkbox (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- [ ] ")
      (forward-line))
    (beginning-of-line)))

(defun org-set-line-headline (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "** TODO ")
      (forward-line))
    (beginning-of-line)))

(defun z-wrap-cblock-example ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_EXAMPLE\n")
        (goto-char (point-max))
        (insert "#+END_EXAMPLE\n")
        (deactivate-mark))))

(defun z-wrap-cblock-sh ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_SRC sh\n")
        (goto-char (point-max))
        (insert "#+END_SRC\n")
        (deactivate-mark))))

(defun z-wrap-cblock-r ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_SRC R\n")
        (goto-char (point-max))
        (insert "#+END_SRC\n")
        (deactivate-mark))))

(defun z-wrap-region-in-quote-block ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_QUOTE\n")
        (goto-char (point-max))
        (insert "#+END_QUOTE\n")
        (deactivate-mark))))

(defun z-wrap-cblock-lisp ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_SRC emacs-lisp :results none\n")
        (goto-char (point-max))
        (insert "#+END_SRC\n")
        (deactivate-mark))))

(defun z-wrap-cblock-sas ()
   "Wrap region in quote block"
   (interactive)
   (save-excursion
     (save-restriction
       (and
        (region-active-p)
        (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
        (goto-char (point-min))
        (insert "#+BEGIN_SRC sas\n")
        (goto-char (point-max))
        (insert "#+END_SRC\n")
        (deactivate-mark))))

(defun org-wrap-in-src-block (&optional lang lines)
  "Wrap sexp-at-point or region in src-block.

Use Org-Babel LANGuage for the src-block if given, Emacs-Lisp
otherwise. A region instead of the sexp-at-point is wrapped if
either

   - optional argument LINES is an (positive or negative) integer
   - or the region is active

In the first case the region is determined by moving +/- LINES
forward/backward from point using `forward-line', in the second
case the active region is used.

When called with prefix argument 'C-u', prompt the user for the
Org-Babel language to use. When called with two prefix arguments
'C-u C-u', prompt the user for both the Org-Babel language to use
and the number of lines to be wrapped."
  (interactive
   (cond
    ((equal current-prefix-arg nil) nil)
    ((equal current-prefix-arg '(4))
     (list
      (ido-completing-read "Org-Babel language: "
                           (mapcar
                            (lambda (--lang)
                              (symbol-name (car --lang)))
                            org-babel-load-languages)
                           nil nil nil nil "emacs-lisp")))
    ((equal current-prefix-arg '(16))
     (list
      (ido-completing-read "Org-Babel language: "
                           (mapcar
                            (lambda (--lang)
                              (symbol-name (car --lang)))
                            org-babel-load-languages)
                           nil nil nil nil "emacs-lisp")
      (read-number "Number of lines to wrap: " 1)))))
  (let* ((language (or lang "emacs-lisp"))
         (beg (or (and (not lines)
                       (region-active-p)
                       (region-beginning))
                  (point)))
         (marker (save-excursion (goto-char beg) (point-marker)))
         (bol (save-excursion (goto-char beg) (bolp)))
         (end (cond
               (lines (save-excursion
                        (forward-line lines) (point)))
               ((region-active-p)(region-end))
               (t (save-excursion
                    (forward-sexp) (point)))))
         (cut-strg (buffer-substring beg end)))
    (delete-region beg end)
    (goto-char (marker-position marker))
    (insert
     (format
      "%s#+begin_src %s\n%s%s#+end_src\n"
      (if (or (and lines (< lines 0)) bol) "" "\n")
      language
      cut-strg
      (if lines "" "\n")))
    (set-marker marker nil)))

(global-set-key (kbd "C-c w l")
                (lambda ()
                  (interactive)
                  (let ((current-prefix-arg '(4)))
                     (call-interactively
                      'org-wrap-in-src-block ))))

(global-set-key (kbd "C-c w n")
                (lambda ()
                  (interactive)
                  (let ((current-prefix-arg '(16)))
                     (call-interactively
                      'org-wrap-in-src-block))))

(global-set-key (kbd "C-c w w") 'org-wrap-in-src-block)


(global-set-key (kbd "C-c w y")
                (lambda ()
                  (interactive)
                      (org-wrap-in-src-block  "shell" 1)))

(defun org-mark-readonly ()
(interactive)
(org-map-entries
(lambda ()
(let* ((element (org-element-at-point))
(begin (org-element-property :begin element))
(end (org-element-property :end element)))
(add-text-properties begin (- end 1) '(read-only t
font-lock-face '(:background "#FFE3E3")))))
"read_only")
(message "Made readonly!"))
(defun org-remove-readonly ()
(interactive)
(org-map-entries
(lambda ()
(let* ((element (org-element-at-point))
(begin (org-element-property :begin element))
(end (org-element-property :end element))
(inhibit-read-only t))
(remove-text-properties begin (- end 1) '(read-only t font-lock-face '(:background "yellow")))))
"read_only"))
(add-hook 'org-mode-hook 'org-mark-readonly)

(defun cooking-sparse-tree-breakfeast ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"breakfest\""))

(defun cooking-sparse-tree-main ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"main\""))

(defun cooking-sparse-tree-main ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"sweet\""))

(defun cooking-sparse-tree-main ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"meat\""))

(defun cooking-sparse-tree-fav ()
  (interactive)
  (org-match-sparse-tree t "+Fav=\"y\""))

(defun recipe-template ()
        (interactive)
        (goto-line 0)
        (search-forward "* Inbox")
         (org-meta-return)
         (org-metaright)
         (setq recipe-name (read-string "Title: "))
         (insert recipe-name)
         (org-todo "COOK") 
         (org-set-tags)
         (org-meta-return)
         (org-metaright)
         (insert "Ingridients")
         (org-meta-return)
         (insert "Preperation")
         (search-backward recipe-name)
         (setq src1 (read-string "Time: "))
         (org-set-property "Time" src1)
         (setq src2 (read-string "Rating: "))
         (org-set-property "Rating" src2)
         (setq src3 (read-string "Sources: "))
         (org-set-property "Source" src3)
         (setq src4 (read-string "Ammount: "))
         (org-set-property "Ammount" src4)
         (setq src5 (read-string "Fav: "))
         (org-set-property "Fav" src5)
         (search-forward "Ingridients")
         (evil-open-below 1)
         (beginning-of-visual-line)
)

(defun blank-recipe-template ()
        (interactive)
         (org-meta-return)
         (org-metaright)
         (setq recipe-name (read-string "Title: "))
         (insert recipe-name)
         (org-set-tags)
         (org-meta-return)
         (org-metaright)
         (insert "Ingridients")
         (org-meta-return)
         (insert "Preperation")
         (search-backward recipe-name)
         (setq src1 (read-string "Time: "))
         (org-set-property "Time" src1)
         (setq src2 (read-string "Rating: "))
         (org-set-property "Rating" src2)
         (setq src3 (read-string "Sources: "))
         (org-set-property "Source" src3)
         (setq src4 (read-string "Ammount: "))
         (org-set-property "Ammount" src4)
         (setq src5 (read-string "Fav: "))
         (org-set-property "Fav" src5)
         (search-forward "Ingridients")
         (evil-open-below 1)
         (beginning-of-visual-line)
)

(defun travel-template ()
        (interactive)
        (goto-line 0)
        (search-forward "* Inbox")
         (org-meta-return)
         (org-metaright)
         (setq travel-name (read-string "Title: "))
         (insert travel-name)
         (org-set-tags)
         (org-meta-return)
         (org-metaright)
         (insert "Details")
         (org-meta-return)
         (search-backward travel-name)
         (setq src1 (read-string "Rating: "))
         (org-set-property "Rating" src1)
         (setq src2 (read-string "Sources: "))
         (org-set-property "Source" src2)
         (setq src3 (read-string "Fav: "))
         (org-set-property "Fav" src3)
         (search-forward "Details")
         (evil-open-below 1)
)

; Speed commands are really useful, but I often want to make use of
; them when I'm not at the beginning of a header. Ths command brings
; you back to the beginning of an item's header, so that you can do
; speed commands.
 
(defun org-go-speed ()
"Goes to the beginning of an element's header, so that you can
execute speed commands."
(interactive)
(when (equal major-mode 'org-mode)
(if (org-at-heading-p)
(org-beginning-of-line)
(org-up-element))))

;warning
(font-lock-add-keywords
 'org-mode
'(("\\(@[^@\n]+@\\)" (0 '(:foreground "#B40000" :background "#FFDDDD" :weight bold) t))))

;tip
(font-lock-add-keywords
 'org-mode
'(("\\(%[^%\n]+%\\)" (0 '(:weight ultra-bold :background "#DDFFDD" :foreground "#000000") t))))

;notice
(font-lock-add-keywords
 'org-mode
'(("\\(![^!\n]+!\\)" (0 '(:weight ultra-bold :foreground "#B40000") t))))

;high-green
(font-lock-add-keywords
 'org-mode
'(("\\('[^'\n]+'\\)" (0 '(:background "#35FF00" :weight ultra-bold) t))))

;high-yellow
(font-lock-add-keywords
 'org-mode
'(("\\(`[^`\n]+`\\)" (0 '(:foreground "#000000" :weight ultra-bold :background "#FBFF00") t))))

;
(font-lock-add-keywords
 'org-mode
'(("\\(₆[^₆\n]+₆\\)" (0 '(:foreground "#000000" :underline t :background "#FF9AEA" :weight ultra-bold) t))))

;
(font-lock-add-keywords
 'org-mode
'(("\\(₅[^₅\n]+₅\\)" (0 '(:weight ultra-bold :foreground "#1E00DE") t))))


;
(font-lock-add-keywords
 'org-mode
'(("\\(₄[^₄\n]+₄\\)" (0 '(:weight ultra-bold :foreground "#FF9800") t))))

;blusish
(font-lock-add-keywords
 'org-mode
'(("\\(•[^•\n]•+\\)" (0 '(:weight ultra-bold :foreground "#393D900") t))))


 
;;;;SPECIFIC WORDS 

;server
(font-lock-add-keywords
'org-mode
'(("\\b[Ss]erver\\b" (0 '(:weight ultra-bold :foreground "#FF9800") t))))

;client
(font-lock-add-keywords
'org-mode
'(("\\b[Cc]lient\\b" (0 '(:weight ultra-bold :foreground "#0044FF") t))))

;private
(font-lock-add-keywords
'org-mode
'(("\\b[Pp]rivate\\b" (0 '(:weight ultra-bold :foreground "#FF6767") t))))

;public
(font-lock-add-keywords
'org-mode
'(("\\b[Pp]ublic\\b" (0 '(:weight ultra-bold :foreground "#59BD7E") t))))


;In Example
(font-lock-add-keywords
'org-mode
'(("\\b[Ii]n example\\b" (0 '(:foreground "#000000" :underline t :background "#FF9AEA" :weight ultra-bold) t))))


;header
(font-lock-add-keywords
 'org-mode
'(("\\(‡[^‡\n]+‡\\)" (0 '(:foreground "#ffffff" :weight ultra-bold :slant italic :background "#59BD7F" :height 1.3) t))))

;;;FOR SPECIAL CHARACTERS

;for key shortucts
(font-lock-add-keywords
 'org-mode
'(("\\(\\?[^?\n]+\\?\\)" (0 '(:foreground "#000000" :weight ultra-bold :background "#FF9C2C") t))))

;for $Note$ 
(font-lock-add-keywords
 'org-mode
'(("\\(\\$[^$\n]+\\$\\)" (0 '(:background "#DDDDFF" :foreground "#000000" :weight ultra-bold) t))))

;for ^
(font-lock-add-keywords
 'org-mode
'(("\\(\\^[^^\n]+\\^\\)" (0 '(:weight bold  :box (:line-width 1 :color "#A5A0FF")  :foreground "#00006F" :background "#FFFFFF") t))))

;for † 
(font-lock-add-keywords
 'org-mode
'(("\\(\\†[^†\n]+\\†\\)" (0 '(:weight bold  :box (:line-width 1 :color "#A5A0FF")  :foreground "#00006F" :background "#FFFFFF") t))))

;    (defun prettier-org-code-blocks ()
;      (interactive)
;      (font-lock-add-keywords nil
;        '(("\\(\+begin_src\\)"
;           (0 (progn (compose-region (match-beginning 1) (match-end 1) ?¦)
;                     nil)))
;          ("\\(\+end_src\\)"
;           (0 (progn (compose-region (match-beginning 1) (match-end 1) ?¦)
;                     nil))))))
;    (add-hook 'org-mode-hook 'prettier-org-code-blocks)

;change agenda colors
;(setq org-upcoming-deadline '(:foreground "blue" :weight bold))
;max days to show in agenda view
(setq org-agenda-ndays 7)
;start agenda from today!
(setq org-agenda-start-on-weekday nil)
;Items that have deadlines are displayed 10 days in advance
(setq org-deadline-warning-days 10)
;don’t display items that are done in my agenda.
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; Compact the block agenda view
(setq org-agenda-compact-blocks t)


;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)

;; The following custom-set-faces create the highlights
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t))

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                   #("----------------" 0 16 (org-heading t))
                                   (0900 1100 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

(setq org-agenda-custom-commands 
'(
;first command
("r" "research" todo "TODO" 
         (
         (org-agenda-files '("~/org/files/agenda/Research.org")) 
          (org-agenda-sorting-strategy 
          '(priority-down effort-down)
          ) 
          )
          )

;second
("f" "food" todo "COOK" 
         (
         (org-agenda-files '("~/org/files/agenda/food.org")) 
          (org-agenda-sorting-strategy 
          '(priority-up effort-down)
)
)
)

;third
("o" "orgmode" todo "TODO" 
         (
         (org-agenda-files '("~/org/files/agenda/TODO.org")) 
          (org-agenda-sorting-strategy 
          '(priority-up effort-down)
)
)
)


;fourth (code block)
("h" "Agenda and Home-related tasks"
               (
               (agenda "")
               (tags-todo "+PRIORITY=\"A\"")
               (tags "garden")
)
)

;;finalize
;;end brackets for setq
)
)

(setq org-agenda-exporter-settings
      '((ps-number-of-columns 2)
        (ps-landscape-mode t)
        (org-agenda-add-entry-text-maxlines 5)
        (htmlize-output-type 'css)))

(setq org-habit-graph-column 70)
(setq org-habit-show-habits-only-for-today nil)

(setq org-publish-project-alist
           '(
              ("Help_files"
              :base-directory "~/org/files/help/"
              :publishing-directory "~/org/files/export/"
              :section-numbers nil
              :table-of-contents nil
              :publishing-function org-ascii-publish-to-ascii
                     )
              ("econf"
              :base-directory "~/org/files/agenda/"
              :publishing-directory "~/org/files/export/"
              :section-numbers nil
              :table-of-contents nil
              :publishing-function org-html-publish-to-html
                     )
))

(setq org-export-html-validation-link nil)

org-use-sub-superscripts nil        ;; don't use `_' for subscript

(setq org-capture-templates
      (quote (           
              ("x" "todo_nix" entry (file+headline "~/org/files/agenda/TODO.org" "Linux")
               "*  %^{Description}" )
              ("o" "dl_movie" entry (file+headline "~/org/files/agenda/dl.org" "Movies")
               "*  %^{Description}  " )
              ("O" "dl_movie_prerelease" entry (file+headline "~/org/files/agenda/dl.org" "Movies")
               "*  %x :Pre_Release: " )
              ("v" "dl_TV" entry (file+headline "~/org/files/agenda/dl.org" "TV")
               "*  %^{Description}" )
              ("m" "dl_music" entry (file+headline "~/org/files/agenda/dl.org" "Music")
               "*  %^{Description}" )
              ("h" "todo_home" entry (file+headline "~/org/files/agenda/TODO.org" "Home")
               "*   %?\n%T" )
              ("b" "todo_shopping" entry (file+headline "~/org/files/agenda/food.org" "shopping")
               "* SHOP  %^{Description} " )
              ;;;agenda captures
              ("w" "Work_short_term" entry (file+headline "~/org/files/agenda/Research.org" "Short term Misc")
               "* TODO  %^{Description} " )

)))

;(org-babel-load-file "/home/zeltak/.emacs.g/extra/org-ref/org-ref.org")

;; Remove splash screen
(setq inhibit-splash-screen t)

;; transient mode-importnat!
(transient-mark-mode 1)

;;winner mode by def-alut

;m use C-c <left> to restore the previous window configuration
(winner-mode 1)

; syntax highlighting everywhere
(global-font-lock-mode 1)

;;clipboard to sysclip
(setq x-select-enable-clipboard t)

;;paren mode- show visually matching parens
(show-paren-mode 1)
;show line numbers
(global-linum-mode 0) ; display line numbers in margin. Emacs 23 only

;visual line
(global-visual-line-mode 1) ; 1 for on, 0 for off.

;; don't show text in scratch buffer
(setq initial-scratch-message nil)


; Add word wrapping/wrap, may cause lines to be to short if enabled
;(global-visual-line-mode t)
(setq line-move-visual nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step 1) ;; keyboard scroll one line at a time
;;disable tooltips
(tooltip-mode -1)

(tool-bar-mode -1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;make cursor blink (use -1 to disable):
(blink-cursor-mode -1)

;;Keep the cursor steady when scrolling
(setq scroll-preserve-screen-position t)

(define-key-after global-map [menu-bar file lang-modes] 
  (cons "Language Modes" (make-sparse-keymap "major modes")) 'kill-buffer )

(define-key global-map [menu-bar file lang-modes bash] '("Bash" . sh-mode))
(define-key global-map [menu-bar file lang-modes org] '("Org" . org-mode))
(define-key global-map [menu-bar file lang-modes tcl] '("TCL" . tcl-mode))
(define-key global-map [menu-bar file lang-modes ruby] '("Ruby" . ruby-mode))
(define-key global-map [menu-bar file lang-modes python] '("Python" . python-mode))
(define-key global-map [menu-bar file lang-modes php] '("PHP" . php-mode))
(define-key global-map [menu-bar file lang-modes perl] '("Perl" . cperl-mode))
(define-key global-map [menu-bar file lang-modes separator1] '("--"))
(define-key global-map [menu-bar file lang-modes haskell] '("Haskell" . haskell-mode))
(define-key global-map [menu-bar file lang-modes ocaml] '("OCaml" . tuareg-mode))
(define-key global-map [menu-bar file lang-modes elisp] '("Emacs Lisp" . emacs-lisp-mode))
(define-key global-map [menu-bar file lang-modes separator2] '("--"))
(define-key global-map [menu-bar file lang-modes latex] '("LaTeX" . latex-mode))
(define-key global-map [menu-bar file lang-modes js] '("Javascript" . js2-mode))
(define-key global-map [menu-bar file lang-modes xml] '("XML (xml-mode)" . xml-mode))
(define-key global-map [menu-bar file lang-modes nxml] '("XML (nxml-mode)" . nxml-mode))
(define-key global-map [menu-bar file lang-modes html] '("HTML" . html-mode))
(define-key global-map [menu-bar file lang-modes htmlhelper] '("HTML (html-helper-mode)" . html-helper-mode))
(define-key global-map [menu-bar file lang-modes css] '("CSS" . css-mode))
(define-key global-map [menu-bar file lang-modes separator3] '("--"))
(define-key global-map [menu-bar file lang-modes java] '("Java" . java-mode))
(define-key global-map [menu-bar file lang-modes c++] '("C++" . c++-mode))
(define-key global-map [menu-bar file lang-modes c] '("C" . c-mode))

;; (easy-menu-define zmenu global-map "zglobal-menu"
;;   '("zglobal"
     
;; ("Programs" ;; submenu
;;        [""  (djcb-term-start-or-switch "mutt" t)]
;;        ["mc"    (djcb-term-start-or-switch "mc" t)]
;;        ["htop"  (djcb-term-start-or-switch "htop" t)]
;;        ["iotop" (djcb-term-start-or-switch "iotop" t)])
  
;;      ;; http://emacs-fu.blogspot.com/2009/03/math-formulae-in-webpages.html
;;      ;; this submenu is only visible when in org--mode
;;      ("Org"  :visible (or (string= major-mode "org-mode") (string= major-mode "org-mode"))
;;        ["Insert formula"   texdrive-insert-formula :help "Insert some formula"]
;;        ["Generate images"  texdrive-generate-images :help "(Re)generate the images for the formulae"])
     
;;      ;; http://emacs-fu.blogspot.com/2009/03/twitter.html
;;      ("Twitter" ;; submenu
;;        ["View friends" twitter-get-friends-timeline]
;;        ["What are you doing?" twitter-status-edit])

;;      ("Misc"  ;; submenu
;;        ;; http://emacs-fu.blogspot.com/2009/01/counting-words.html
;;        ["Count words" djcb-count-words]

;;        ;;http://emacs-fu.blogspot.com/2008/12/showing-line-numbers.html
;;        ["Show/hide line numbers" linum]

;;        ;; http://emacs-fu.blogspot.com/2008/12/running-emacs-in-full-screen-mode.html
;;        ["Toggle full-screen" djcb-fullscreen-toggle])))

(easy-menu-define zorg org-mode-map "zorg-menu"
  '("zorg"
     ;; http://emacs-fu.blogspot.com/2008/12/running-console-programs-inside-emacs.html
     ("images" ;; submenu
       ["org toggle inline"  (org-toggle-inline-images t)]
       ["mc"    (fun1  t)]
       ["htop"  (fun2  t)]
       ["iotop" (fun3  t)])
     
     ;; http://emacs-fu.blogspot.com/2009/03/twitter.html
     ("Twitter" ;; submenu
       ["View friends" twitter-get-friends-timeline]
       ["What are you doing?" twitter-status-edit])

     ("Misc"  ;; submenu
       ;; http://emacs-fu.blogspot.com/2009/01/counting-words.html
       ["Count words" djcb-count-words]

       ;;http://emacs-fu.blogspot.com/2008/12/showing-line-numbers.html
       ["Show/hide line numbers" linum]

       ;; http://emacs-fu.blogspot.com/2008/12/running-emacs-in-full-screen-mode.html
       ["Toggle full-screen" djcb-fullscreen-toggle])))

(setq custom-safe-themes t)

;; sample code for setting a background color depending on file name extension

; (defun my-set-theme-on-mode ()
;   "set background color depending on file suffix"
;   (interactive)
;   (let ((fileNameSuffix (file-name-extension (buffer-file-name) ) ))
;     (cond
;      ((string= fileNameSuffix "py" ) (set-background-color "honeydew"))
;      ((string= fileNameSuffix "txt" ) (set-background-color "cornsilk"))
;      (t (message "%s" "no match found"))
;      )
;     ))
;
; (add-hook 'find-file-hook 'my-set-theme-on-mode)

;color in emacs mode
(setq evil-emacs-state-cursor '("cyan" box))
;nomral state mode
(setq evil-normal-state-cursor '("green" box))
;visual state mode
(setq evil-visual-state-cursor '("orange" box))
;inset state mode
(setq evil-insert-state-cursor '("red" box))
(setq evil-replace-state-cursor '("red" box))
(setq evil-operator-state-cursor '("red" hollow))

(setq dired-listing-switches "-aBhl  --group-directories-first")

;Spelling
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t) 


(defun flyspell-check-next-highlighted-word ()
  "custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defun z-latex-bullets ()
"This inserts the LaTeX \itemize environment into a document - LaTeX will
take care of the wrapping of each item for me"
(interactive)
(insert-file-contents "/home/zeltak/Uni/bgu_courses/planner_gis/bullets.tex"))

(defun z-fix-characters 
(start end) 
(interactive "r") 
(let ((buffer-invisibility-spec)) (query-replace-regexp "[^\t\n\r\f -~]" ""))
)

(defun z-fix2-characters ()
  (interactive)
  (let ()
    (query-replace-regexp "[^\t\n\r\f -~]" "")
    ))

(defun z-year-increment  (buffer max-year)
  (interactive "b\nsMax year (yy): ")
  (setq max-year (string-to-number max-year))
  (let ((year 2000)
        (newbuf (get-buffer-create "increment-year")))
    (let ((s (with-current-buffer buffer
               (buffer-substring (point-min) (point-max)))))
      (dotimes (n (1+ max-year))
        (with-current-buffer newbuf
          (goto-char (point-max))
          (insert "\n")
          (insert (replace-regexp-in-string (int-to-string year)
                                            (int-to-string (+ year n))
                                            s)))))
    (switch-to-buffer newbuf)))

(defun flush-blank-lines ()
    "Removes all blank lines from buffer or region"
     (interactive)
     (save-excursion
       (let (min max)
         (if (equal (region-active-p) nil)
             (mark-whole-buffer))
         (setq min (region-beginning) max (region-end))
         (flush-lines "^ *$" min max t))))

(global-set-key (kbd "M-j")
            (lambda ()
                  (interactive)
                  (join-line -1)))

(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000)) ; 90002000 is just random. you can use `most-positive-fixnum'
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the inverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))

(defun z-count-words-region (posBegin posEnd)
  "Print number of words and chars in region."
  (interactive "r")
  (message "Counting …")
  (save-excursion
    (let (wordCount charCount)
      (setq wordCount 0)
      (setq charCount (- posEnd posBegin))
      (goto-char posBegin)
      (while (and (< (point) posEnd)
                  (re-search-forward "\\w+\\W*" posEnd t))
        (setq wordCount (1+ wordCount)))

      (message "Words: %d. Chars: %d." wordCount charCount)
      )))

(defun z-copy-comment-paste ()
  "copy active region/current line, comment, and then paste"
  (interactive)
  (unless (use-region-p)
    (progn
      (beginning-of-line 2)
      (push-mark (line-beginning-position 0))))
  (kill-ring-save (region-beginning) (region-end))
  (comment-region (region-beginning) (region-end))
  (yank)
  (exchange-point-and-mark)
  (indent-according-to-mode))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))



(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun z-insert-date (&optional addTimeStamp-p)
  "Insert current date and or time. In this format yyyy-mm-dd.
 When called with `universal-argument', insert date and time, e.g. 2012-05-28T07:06:23-07:00
 Replaces text selection.See also `current-date-time-string'."
  (interactive "P")
  (when (region-active-p) (delete-region (region-beginning) (region-end) ) )
  (cond
   ((equal addTimeStamp-p nil ) (insert (format-time-string "%Y-%m-%d")))
   (t (insert (current-date-time-string))) ) )

(defun copy-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
      (progn
        (cond
         ((and (display-graphic-p) x-select-enable-clipboard)
          (x-set-selection 'CLIPBOARD (buffer-substring (region-beginning) (region-end))))
         (t (shell-command-on-region (region-beginning) (region-end)
                                     (cond
                                      (*cygwin* "putclip")
                                      (*is-a-mac* "pbcopy")
                                      (*linux* "xsel -ib")))
            ))
        (message "Yanked region to clipboard!")
        (deactivate-mark))
        (message "No region active; can't yank to clipboard!")))

(defun paste-from-x-clipboard()
  (interactive)
  (cond
   ((and (display-graphic-p) x-select-enable-clipboard)
    (insert (x-selection 'CLIPBOARD)))
   (t (shell-command
       (cond
        (*cygwin* "getclip")
        (*is-a-mac* "pbpaste")
        (t "xsel -ob"))
       1))
   ))

(defun prelude-indent-rigidly-and-copy-to-clipboard (begin end indent)
  "Copy the selected code region to the clipboard, indented according
to Markdown blockquote rules."
  (let ((buffer (current-buffer)))
    (with-temp-buffer
      (insert-buffer-substring-no-properties buffer begin end)
      (indent-rigidly (point-min) (point-max) indent)
      (clipboard-kill-ring-save (point-min) (point-max)))))

(defun prelude-indent-blockquote-and-copy-to-clipboard (begin end)
  "Copy the selected code region to the clipboard, indented according
to markdown blockquote rules (useful to copy snippets to StackOverflow, Assembla, Github."
  (interactive "r")
  (prelude-indent-rigidly-and-copy-to-clipboard begin end 4))

(defun prelude-indent-nested-blockquote-and-copy-to-clipboard (begin end)
  "Copy the selected code region to the clipboard, indented according
to markdown blockquote rules. Useful to add snippets under bullet points."
  (interactive "r")
  (prelude-indent-rigidly-and-copy-to-clipboard begin end 6))

(defun search-replace-file (&rest rest) (interactive) (save-excursion    
 (goto-char (point-min)) (apply #'query-replace-regexp rest)))

(defun z-edit-file-as-root ()
  "Edit the file that is associated with the current buffer as root"
  (interactive)
  (if (buffer-file-name)
      (progn
        (setq file (concat "/sudo:root@localhost:" (buffer-file-name)))
        (find-file file))
    (message "Current buffer does not have an associated file.")))

(defun z-kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))


(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun z-save-file-close-window ()
  "DOCSTRING"
  (interactive)
    (save-buffer )
    (delete-frame)
  )

(defun ood () (interactive) (dired "/home/zeltak/org"))

(defun create-scratch-buffer nil
   "create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(defun narrow-or-widen-dwim ()
"If the buffer is narrowed, it widens. Otherwise, it narrows to region, or Org subtree."
(interactive)
(cond ((buffer-narrowed-p) (widen))
((region-active-p) (narrow-to-region (region-beginning) (region-end)))
((equal major-mode 'org-mode) (org-narrow-to-subtree))
(t (error "Please select a region to narrow to"))))

(require 'thingatpt)

(defun google-search ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

(fset 'orgstyle-tnote
   [?! home ?!])
(define-key org-mode-map (kbd "C-1") 'orgstyle-tnote)


(fset 'orgstyle-warning
   "@\341@WARNING:")
(define-key org-mode-map (kbd "C-2") 'orgstyle-warning)

(fset 'orgstyle-warning2
   [?@ home ?@])
(define-key org-mode-map (kbd "C-S-2") 'orgstyle-warning2)



(fset 'orgstyle-com1
   [?~ home ?~])
(define-key org-mode-map (kbd "C-3") 'orgstyle-com1)

(fset 'orgstyle-note
   "$\341$NOTE:")
(define-key org-mode-map (kbd "C-4") 'orgstyle-note)

(fset 'orgstyle-note2
   [?$ home ?$])
(define-key org-mode-map (kbd "C-S-4") 'orgstyle-note2)

(fset 'orgstyle-tip
   "%\341%TIP:")
(define-key org-mode-map (kbd "C-5") 'orgstyle-tip)


(fset 'orgstyle-tip2
   [?% home ?%])
(define-key org-mode-map (kbd "C-S-5") 'orgstyle-tip2)


(fset 'orgstyle-code
   [?^ home ?^])
(define-key org-mode-map (kbd "C-6") 'orgstyle-code)

(fset 'orgstyle-header
   [?& home ?&])
(define-key org-mode-map (kbd "C-7") 'orgstyle-header)

(fset 'orgstyle-bold
   [?* home ?*])
(define-key org-mode-map (kbd "C-7") 'orgstyle-bold)

(fset 'orgstyle-highlight-green
   [?' home ?'])
(define-key org-mode-map (kbd "C-9") 'orgstyle-highlight-green)

(fset 'orgstyle-com2
   [?` home ?`])
(define-key org-mode-map (kbd "C-0") 'orgstyle-com2)

(fset 'underline_net_delete
   [?\M-% ?\  return return ?!])

;;;; Saved macros
;; Saved macro - adds latex end-lines to verse passages
(fset 'versify
      [?\C-a ?\C-e ?\\ ?\\ down])

;(global-set-key (kbd "") 'versify)

(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(defalias '~ 'make-backup)
(defalias 'lp 'list-packages)
(defalias 'lm 'lini)
(defalias 'rr 'regex-replace)
(defalias 'em 'evil-mode)
(defalias 'iss 'ispell) ;check spelling on buffer or region if marked
(defalias 'bks 'bmkp-save-menu-list-state) ;check spelling on buffer or region if marked

(defalias 'sl 'sort-lines)
(defalias 'rr 'reverse-region)
(defalias 'rs 'replace-string)
(defalias 'g 'grep)
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)
(defalias 'rb 'revert-buffer)
(defalias 'sh 'shell)
(defalias 'ps 'powershell)
(defalias 'fb 'flyspell-buffer)
(defalias 'sbc 'set-background-color)
(defalias 'rof 'recentf-open-files)
(defalias 'lcd 'list-colors-display)

; major modes
(defalias 'hm 'html-mode)
(defalias 'tm 'text-mode)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'om 'org-mode)
(defalias 'ssm 'shell-script-mode)
(defalias 'html6-mode 'xah-html6-mode)

; minor modes
(defalias 'wsm 'whitespace-mode)
(defalias 'gwsm 'global-whitespace-mode)
(defalias 'dsm 'desktop-save-mode)
(defalias 'acm 'auto-complete-mode)
(defalias 'vlm 'visual-line-mode)
(defalias 'glm 'global-linum-mode)

; elisp
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ed 'eval-defun)
(defalias 'eis 'elisp-index-search)
(defalias 'lf 'load-file)


;escapes
(defalias '\\ 'escape-quotes-region)
(defalias '\[ 'remove-square-brackets)
(defalias '\" 'replace-straight-quotes)

;; stop asking whether to save newly added abbrev when quitting emacs
(setq save-abbrevs t)
;; turn on abbrev mode globally
(setq-default abbrev-mode t)

(define-key ctl-x-map "\C-i" 'endless/ispell-word-then-abbrev)

(define-prefix-command 'endless/toggle-map)
;; The manual recommends C-c for user keys, but C-x t is
;; always free, whereas C-c t is used by some modes.
(define-key ctl-x-map "t" 'endless/toggle-map)
(define-key endless/toggle-map "w" 'endless/ispell-word-then-abbrev)

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word'. Then create an abbrev for the correction made.
With prefix P, create local abbrev. Otherwise it will be global."
  (interactive "P")
  (let ((bef (downcase (or (thing-at-point 'word) ""))) aft)
    (call-interactively 'ispell-word)
    (setq aft (downcase (or (thing-at-point 'word) "")))
    (unless (string= aft bef)
      (message "\"%s\" now expands to \"%s\" %sally"
               bef aft (if p "loc" "glob"))
      (define-abbrev
        (if p local-abbrev-table global-abbrev-table)
        bef aft))))

(setq abbrev-file-name "/home/zeltak/.emacs.d/abbrv/personal_abbrv.txt")

(load "/home/zeltak/.emacs.d/abbrv/personal_abbrv.txt")

(load "/home/zeltak/.emacs.d/abbrv/common_abbrv.txt")

(load "/home/zeltak/.emacs.d/abbrv/misc_abbrv.txt")

(define-generic-mode 'vimrc-generic-mode
    '()
    '()
    '(("^[\t ]*:?\\(!\\|ab\\|map\\|unmap\\)[^\r\n\"]*\"[^\r\n\"]*\\(\"[^\r\n\"]*\"[^\r\n\"]*\\)*$"
       (0 font-lock-warning-face))
      ("\\(^\\|[\t ]\\)\\(\".*\\)$"
      (2 font-lock-comment-face))
      ("\"\\([^\n\r\"\\]\\|\\.\\)*\""
       (0 font-lock-string-face)))
    '("/vimrc\\'" "\\.vim\\(rc\\)?\\'")
    '((lambda ()
        (modify-syntax-entry ?\" ".")))
    "Generic mode for Vim configuration files.")

;; (setq user-full-name "zeltak"
;;       user-mail-address "zeltak@gmail.com")

;; (setq gnus-select-method '(nntp "news.gmane.org"))

;; ;for smtp
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "ikloog@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-local-domain "gmail.com")

(setq gnus-select-method '(nntp "news.gmane.org"))

(add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

;for smtp
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
        smtpmail-auth-credentials '(("smtp.gmail.com" 587 "ikloog@gmail.com" nil))
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587
        smtpmail-local-domain "gmail.com")

(if (string= system-name "voices") 
(progn

(defvar xah-filelist nil "alist for files i need to open frequently. Key is a short abbrev, Value is file path.")
(setq xah-filelist
      '(
        ("t" . "~/org/files/agenda/TODO.org" )
        ("r" . "~/org/files/agenda/Research.org" )
        ("z" . "~/org/files/agenda/z1.org" )
        ("k " . "~/org/files/help/keys.org" )
        ("l" . "~/org/files/Tech/linux.org" )
        ("f" . "~/org/files/agenda/food.org" )
        ("v" . "~/org/files/Home/travel.org" )
        ("h" . "~/org/files/Home/home.org" )
        ("m" . "~/org/files/from-mobile.org" )
        ("v" . "~/org/files/files/agenda/travel.org" )
        ("h" . "~/org/files/files/Home/home.org" )
        ("p" . "~/org/files/files/uni/papers/papers.org" )
        ("E" . "~/.emacs.d/init.el" )
        ("B" . "/home/zeltak/.config/beets/config.yaml" )
        ("S" . "~/.config/sxhkd/sxhkdrc" )
        ("I" . "~/.i3/config" )
        ("X" . "~/.xinitrc" )
        ("B" . "~/.interrobangrc" )
        ("Z" . "~/.zshrc" )
        ("o" . "~/org/attach/" )
        ) )
)

(progn

(defvar xah-filelist nil "alist for files i need to open frequently. Key is a short abbrev, Value is file path.")
(setq xah-filelist
      '(
        ("e" . "~/.emacs.d/settings.org"  )
        ) )

)
)

(defun z-open-file-fast (openCode)
  "Prompt to open a file from a pre-defined set."
  (interactive
   (list (ido-completing-read "Open:" (mapcar (lambda (x) (car x)) xah-filelist)))
   )
  (find-file (cdr (assoc openCode xah-filelist)) ) )

(global-unset-key (kbd "M-`"))
(global-set-key (kbd "M-`") 'z-open-file-fast)

(add-to-list 'load-path "/home/zeltak/.emacs.g/extra/edit-server/")
(require 'edit-server)
(edit-server-start)

(add-to-list 'load-path "/home/zeltak/.emacs.g/ESS/lisp/")
(load "ess-site")

(defun clear-shell ()
   (interactive)
   (let ((old-max comint-buffer-maximum-size))
     (setq comint-buffer-maximum-size 0)
     (comint-truncate-buffer)
     (setq comint-buffer-maximum-size old-max)))

(add-hook 'inferior-ess-mode-hook
    '(lambda nil
          (define-key inferior-ess-mode-map [\C-up]
              'comint-previous-matching-input-from-input)
          (define-key inferior-ess-mode-map [\C-down]
              'comint-next-matching-input-from-input)
          (define-key inferior-ess-mode-map [\C-x \t]
              'comint-dynamic-complete-filename)
     )
 )

(setq ess-eval-visibly 'nowait)

(setq ess-ask-about-transfile t)

(defgroup helm-org-wiki nil
      "Simple jump-to-org-file package."
      :group 'org
      :prefix "helm-org-wiki-")
    (defcustom helm-org-wiki-directory "~/org/files/"
      "Directory where files for `helm-org-wiki' are stored."
      :group 'helm-org-wiki
      :type 'directory)
    (defun helm-org-wiki-files ()
      "Return .org files in `helm-org-wiki-directory'."
      (let ((default-directory helm-org-wiki-directory))
        (mapcar #'file-name-sans-extension
                (file-expand-wildcards "*.org"))))
    (defvar helm-source-org-wiki
      `((name . "Projects")
        (candidates . helm-org-wiki-files)
        (action . ,(lambda (x)
                      (find-file (expand-file-name
                                  (format "%s.org" x)
                                  helm-org-wiki-directory))))))
    (defvar helm-source-org-wiki-not-found
      `((name . "Create org-wiki")
        (dummy)
        (action . (lambda (x)
                    (helm-switch-to-buffer
                     (find-file
                      (format "%s/%s.org"
                              helm-org-wiki-directory x)))))))
    ;;;###autoload
    (defun helm-org-wiki ()
      "Select an org-file to jump to."
      (interactive)
      (helm :sources
            '(helm-source-org-wiki
              helm-source-org-wiki-not-found)))
    (provide 'helm-org-wiki)

(org-babel-load-file "/home/zeltak/.emacs.g/extra/org-ref/org-ref.org")

(setq org-ref-bibliography-notes ""
      org-ref-default-bibliography '("/home/zeltak/ZH_tmp/test.bib")
      org-ref-pdf-directory "/home/zeltak/Dropbox/uni/zlib/pdf_lib")

(defun zconn ()
  (interactive)
  (eshell)
  (insert "export TERM=screen-256color-bce")
  (insert "ssu zuni")
  (comint-send-input))