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

;;;; below works but changes GUI apps theme when launching term..not good..maybe look into this in future  

;; ;; last t is for NO-ENABLE
  ;;   (load-theme 'zprime t t)
  ;;   (load-theme 'tango-dark t t)
  
  ;;   (defun mb/pick-color-theme (frame)
  ;;     (select-frame frame)
  ;;     (if (window-system frame)
  ;;         (progn  
  ;;           (disable-theme 'tango-dark) ; in case it was active
  ;;           (enable-theme 'zprime))
  ;;       (progn  
  ;;         (disable-theme 'zprime) ; in case it was active
  ;;         (enable-theme 'tango-dark))))
  ;;   (add-hook 'after-make-frame-functions 'mb/pick-color-theme)
  
  ;;   ;; For when started with emacs or emacs -nw rather than emacs --daemon
  ;;   (if window-system
  ;;       (enable-theme 'zprime)
  ;;     (enable-theme 'tango-dark))

; fonts in linux
(if (system-type-is-gnu)
;(add-to-list 'default-frame-alist '(font . "Inconsolata-16"))
;(add-to-list 'default-frame-alist '(font . "Source Code Pro-14"))
(add-to-list 'default-frame-alist '(font . "Pragmata Pro-16"))
)

;; fontso in Win
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

(require 'package)
;since we are using use-packag-don't autoload anythings
(setq package-enable-at-startup nil)

;sources for package.el 
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))

;; Initialize installed package
(package-initialize)  

;; Bootstrap `use-package'
;(unless (package-installed-p 'use-package)
;  (package-refresh-contents)
;  (package-install 'use-package))

(require 'use-package)

(use-package key-chord 
  :ensure t
  :config
(setq key-chord-two-keys-delay 0.16)
(setq key-chord-one-key-delay 0.20)
)

(use-package yasnippet
 :config 
(yas-global-mode 1)
;; Use custom snippets.
;(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-reload-all)
(setq yas-snippet-dirs '("~/.emacs.d/snippets/"))
)

(defun shk-yas/helm-prompt (prompt choices &optional display-fn)
  "Use helm to select a snippet. Put this into `yas/prompt-functions.'"
  (interactive)
  (setq display-fn (or display-fn 'identity))
  (if (require 'helm-config)
      (let (tmpsource cands result rmap)
        (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
        (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
        (setq tmpsource
              (list
               (cons 'name prompt)
               (cons 'candidates cands)
               '(action . (("Expand" . (lambda (selection) selection))))
               ))
        (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
        (if (null result)
            (signal 'quit "user quit!")
          (cdr (assoc result rmap))))
    nil))

;; (use-package yasnippet
;; :diminish yas-minor-mode
;; :commands yas-global-mode
;; :ensure t
;;   :bind ("M-=" . yas-insert-snippet)
;;   :config
;;   (progn
;;     (defun my-yas/prompt (prompt choices &optional display-fn)
;;       (let* ((names (loop for choice in choices
;;                           collect (or (and display-fn
;;                                            (funcall display-fn choice))
;;                                       choice)))
;;              (selected (helm-other-buffer
;;                         `(((name . ,(format "%s" prompt))
;;                            (candidates . names)
;;                            (action . (("Insert snippet" . (lambda (arg)
;;                                                             arg))))))
;;                         "*helm yas/prompt*")))
;;         (if selected
;;             (let ((n (position selected names :test 'equal)))
;;               (nth n choices))
;;           (signal 'quit "user quit!"))))
;;     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt))))))

(use-package helm
:ensure t
:config
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(use-package helm-cmd-t
:ensure t
:config
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
)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(setq helm-locate-fuzzy-match t)

(use-package helm-bibtex
 :ensure t
 :config
(autoload 'helm-bibtex "helm-bibtex" "" t)
;(setq helm-bibtex-bibliography "/home/zeltak/org/files/Uni/papers/bib/kloog_2014.bib")
(setq helm-bibtex-bibliography "~/ZH_tmp/xkloog_2014.bib")
(setq helm-bibtex-library-path "/home/zeltak/Sync/Uni/pdf_lib/")
(setq helm-bibtex-browser-function 'browser-url-chromium)


 (setq helm-bibtex-pdf-open-function
   (lambda (fpath)
     (start-process "okular" "*okular*" "okular" fpath)))
 )

(use-package ebib
 :ensure t
 :config
(setq ebib-preload-bib-files '("~/ZH_tmp/xkloog_2014.bib")) 

(setq ebib-common-optional-fields
      '(translator keywords origlanguage url file location
        partinfo subtitle edition abstract note annotator
        crossref urldate address subtitle language))

(setq ebib-file-associations '(("pdf" . "okular") ("djvu" . "okular")))
(setq ebib-uniquify-keys t)
(setq ebib-autogenerate-keys t)
(setq ebib-index-window-size 20)
(setq ebib-print-multiline t)

;index view
(setq ebib-index-display-fields (quote (year author)))
(setq ebib-sort-order (quote ((year) (author) )))


 )

(use-package hydra
:ensure t )

(use-package async
:ensure t)

(use-package evil
:ensure t
:config
)

;; (require 'evil)
;; (evil-mode 1)

;; ;for normal undo
;; (setq evil-want-fine-undo t)

;; ;;; esc quits
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; ;searches
;; (global-set-key (kbd "C-*") 'evil-search-symbol-forward)
;; (global-set-key (kbd "C-#") 'evil-search-symbol-backward)

(use-package evil-nerd-commenter
:ensure t
:config
)
;(evilnc-default-hotkeys)
;(setq evilnc-hotkey-comment-operator ",,")

;; (require 'edit-server)
;;  (edit-server-start)
;; (autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
;; (autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
;; (add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
;; (add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(use-package org-download 
 :ensure t
 :config
 (setq-default org-download-heading-lvl nil)
 (setq-default org-download-image-dir "/home/zeltak/org/attach/images_2015")
)

;; (setq org-download-method 'attach
;;        org-download-screenshot-method "scrot -s %s"
;;        org-download-backend (if (executable-find "curl") "curl \"%s\" -o \"%s\"" t)))

; (load-file "~/.emacs.g/extra/org-download/org-download.el")
; (setq-default org-download-heading-lvl nil)
; (setq-default org-download-image-dir "/home/zeltak/org/attach/images_2015")

;(if (string= system-name "voices") (setq-default org-download-image-dir "/home/zeltak/org/attach/images_2014/") (setq-default org-download-image-dir "/media/NAS/Uni/org/attach/images_2013/"))

(add-to-list 'load-path "/home/zeltak/.emacs.g/extra/org-dp/")
(require 'org-dp-lib)

(when (require 'org-dp-lib nil t)

;;;;;;;;;; wrap in elisp
  (defun z/wrap-elisp ()
        (org-dp-wrap-in-block
         nil '(src-block nil nil nil (:language "emacs-lisp" :preserve-indent 1  :parameters ":results none" ))))

;for hydra create interactive new functions
(defun z/hydra-wrap-elisp () (interactive) (beginning-of-line) (z/wrap-elisp))

;;;;;;;;;; wrap in bash
  (defun z/wrap-bash ()
        (org-dp-wrap-in-block
         nil '(src-block nil nil nil (:language "sh" :preserve-indent 1  :parameters ":results none" ))))

;for hydra create interactive new functions
(defun z/hydra-wrap-bash () (interactive) (beginning-of-line) (z/wrap-bash))


;;;;;;;;;; wrap in bash
  (defun z/wrap-example ()
        (org-dp-wrap-in-block
         nil '(src-block nil nil nil (:language "example" :preserve-indent 1  :parameters ":results none" ))))

;for hydra create interactive new functions
(defun z/hydra-wrap-example () (interactive) (beginning-of-line) (z/wrap-example))



;;;;;;;;;; wrap in R
  (defun z/wrap-R ()
        (org-dp-wrap-in-block
         nil '(src-block nil nil nil (:language "R" :preserve-indent 1  :parameters ":results none" ))))

;for hydra create interactive new functions
(defun z/hydra-wrap-R () (interactive) (beginning-of-line) (z/wrap-R))
;end paren
     )

(use-package yasnippet
:ensure t
:config
(require 'yasnippet)
;for orgmode properties fix 
(setq yas-indent-line 'fixed)
;set insert at point prompt type- here ido
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/completing-prompt))
)

;; (require 'yasnippet)

;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/snippets"                 ;; personal snippets
;;         ""           ;; foo-mode and bar-mode snippet collection
;;         "" ;; the yasmate collection
;;         ""         ;; the default collection
;;         ))

;; (yas-global-mode 1)

;; ;;; use popup menu for yas-choose-value
;; (require 'popup)

;; ;; add some shotcuts in popup menu mode
;; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

;; (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
;;   (when (featurep 'popup)
;;     (popup-menu*
;;      (mapcar
;;       (lambda (choice)
;;         (popup-make-item
;;          (or (and display-fn (funcall display-fn choice))
;;              choice)
;;          :value choice))
;;       choices)
;;      :prompt prompt
;;      ;; start isearch mode immediately
;;      :isearch t
;;      )))

;; (setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

(setq ispell-personal-dictionary "~/.emacs.d/ispell-dico-personal")

(use-package browse-kill-ring
:ensure t
:config
)

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

(use-package smex
:ensure t
:config
)

(use-package bookmark+
:ensure t
:config
(setq bookmark-version-control t
      bookmark-save-flag t)
;ask for tags when saving a bookmark move nil to t to ask each time
(setq bmkp-prompt-for-tags-flag nil)
)

(use-package undo-tree 
:ensure t
:config
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '((".*" . "~/.emacs.t/undo-files")))
(setq undo-tree-mode-lighter "")         
)

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

(use-package openwith 
:ensure t
:config
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
)

(use-package expand-region
 :ensure t
 :config
 :bind (
       ("M-2" . er/expand-region )
 )
)

;; some proposals for binding:
 
;  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
;  (define-key evil-motion-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
;  (define-key evil-motion-state-map (kbd "M-SPC") #'evil-ace-jump-line-mode)
   
  ;; (define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode)      ; similar to f
  ;; (define-key evil-operator-state-map (kbd "C-SPC") #'evil-ace-jump-char-to-mode) ; similar to t
  ;; (define-key evil-operator-state-map (kbd "M-SPC") #'evil-ace-jump-word-mode)

(use-package ace-window
    :config
;set keys to only these 
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    (setq aw-background nil))

(custom-set-faces
 '(aw-leading-char-face
   ((t (:inherit ace-jump-face-foreground :height 3.0)))))

(defcustom avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
  "Keys for jumping.")

(global-set-key (kbd "C-;") 'avi-goto-char-2)

(setq avi-background t)

;use-package ace-isearch
;:ensure t
;:config
;(ace-isearch-mode +1)
;(global-ace-isearch-mode +1)
;)

;(custom-set-variables
; '(ace-isearch-input-length 7)
; '(ace-isearch-input-idle-delay 0.4)
; '(ace-isearch-submode 'ace-jump-char-mode)
; '(ace-isearch-use-ace-jump 'printing-char))

;(ace-isearch-set-ace-jump-after-isearch-exit t)

(use-package ace-jump-zap
  :ensure ace-jump-zap
)

;(require 'tex)
;(setq preview-scale-function 1.1)

(use-package lentic
 :ensure t
 :config
 )

(setq manage-minor-mode-default
      '((global
         (on   rainbow-mode)
         (off  line-number-mode))
        (emacs-lisp-mode
         (on   rainbow-delimiters-mode eldoc-mode show-paren-mode))
        (js2-mode
         (on   color-identifiers-mode)
         (off  flycheck-mode))))

(use-package rainbow-mode
:ensure t
:config
)

(dolist (hook '(css-mode-hook
                html-mode-hook
                js-mode-hook
                emacs-lisp-mode-hook
                org-mode-hook
                text-mode-hook
                ))
  (add-hook hook 'rainbow-mode))

(use-package google-contacts
:ensure t
:config
)



(use-package unfill
:ensure t
:config
)

(use-package indent-guide
:ensure t
:config
)

(use-package fill-column-indicator
:ensure t
:config
)

(use-package drag-stuff
 :ensure t
 :config
  )

(use-package bug-hunter
 :ensure t
 :config
  )

(use-package mic-paren
 :ensure t
 :config
  )

(use-package mu4e-maildirs-extension
 :ensure t
 :config
(setq mu4e-maildirs-extension-title "Mail")
;(setq mu4e-maildirs-extension-custom-list (quote ("INBOX" "Starred"  )))
 )

(use-package swiper 
 :ensure t
 :config
 )

(use-package engine-mode
 :ensure t
 :config 
 )

(use-package color-theme-approximate
 :ensure t
 :config
(color-theme-approximate-on)
 )

(use-package peep-dired
 :ensure t
 :config
 (setq peep-dired-ignored-extensions '("mkv" "iso" "mp4"))
 )

(require 'dired-x)

(use-package dired-sort
 :ensure t
 :config
  )

(use-package dired+
 :ensure t
 :config
(toggle-diredp-find-file-reuse-dir 1)
  )

(use-package dired-details
 :ensure t
 :config
(setq dired-details-hide-link-targets nil)
 )

(use-package dired-details+
 :ensure t
 :config
 )

(use-package dired-avfs
 :ensure t
 :config
 )

(use-package dired-filter
 :ensure t
 :config
 )

(use-package dired-narrow
 :ensure t
 :config
 )

(use-package dired-efap
 :ensure t
 :config
 
 )

(add-to-list 'load-path "/home/zeltak/.emacs.g/password-store/")
(require 'password-store)

(use-package golden-ratio
 :ensure t
 :config
 (require 'golden-ratio)
 (golden-ratio-mode 1)
 )

(winner-mode 1)

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
  (let ((year 2003)
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

(defun z/copy-comment-paste ()
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

(defun z/comment-line (n)
  "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above.
If region is active, apply to active region instead."
  (interactive "p")
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning) (region-end))
    (let ((range
           (list (line-beginning-position)
                 (goto-char (line-end-position n)))))
      (comment-or-uncomment-region
       (apply #'min range)
       (apply #'max range)))
    (forward-line 1)
    (back-to-indentation)))

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

;(defun  z/search-replace-file ()
;(interactive)
;(goto-char (point-min))
;(query-replace-regexp ))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(defun z/copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

; (define-key ctl-x-map "\C-i" 'endless/ispell-word-then-abbrev)

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

(defun z/regex-delete-numeric  ()
  "delete all numeric characters"
  (interactive)
  (goto-char (point-min))
  (replace-regexp "[0-9]" "")
)

(defun z/comment-box (b e)
  "Draw a box comment around the region but arrange for the region
to extend to at least the fill column. Place the point after the
comment box."
  (interactive "r")
  (let ((e (copy-marker e t)))
    (goto-char b)
    (end-of-line)
    (insert-char ?  (- fill-column (current-column)))
    (comment-box b e 1)
    (goto-char e)
    (set-marker e nil)))

(defun z/insert-keyleft ()
  " insert 【   "
  (interactive)
  (insert "【")
  )

(defun z/insert-keyright ()
  " insert 】   "
  (interactive)
  (insert "】")
  )


(defun z/insert-keyboth ()
  " insert 【】  "
  (interactive)
  (insert "【 】")
(backward-char 2)  
)

(defun z/insert-bashscript ()
  " insert #!/bin/sh  "
  (interactive)
  (insert "#!/bin/sh")
)

(defun z/org-convert-header-samelevel  ()
                     (interactive)                                
                     (let ((current-prefix-arg '(4)))             
                       (call-interactively #'org-toggle-heading)))

(defun pl/hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

(with-eval-after-load "org"
  (define-key org-mode-map "<"
    (lambda () (interactive)
      (if (looking-back "^")
          (hydra-org-template/body)
        (self-insert-command 1)))))

;(fset 'z/prefix-org-refile (C-u M-x org-refile))

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

(defun z-save-buffer-close-window ()
  "DOCSTRING"
  (interactive)
    (save-buffer)
    (kill-this-buffer)
  )

(defun resize-window (&optional arg)    ; Hirose Yuuji and Bob Wiener
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
        (message
         "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
         arg)
        (setq c (read-char))
        (condition-case ()
            (cond
             ((= c ?h) (enlarge-window arg))
             ((= c ?s) (shrink-window arg))
             ((= c ?w) (enlarge-window-horizontally arg))
             ((= c ?n) (shrink-window-horizontally arg))
             ((= c ?\^G) (keyboard-quit))
             ((= c ?q) (throw 'done t))
             ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
             (t (beep)))
          (error (beep)))))
    (message "Done.")))

(defun transpose-windows (arg)
   "Transpose the buffers shown in two windows."
   (interactive "p")
   (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
     (while (/= arg 0)
       (let ((this-win (window-buffer))
             (next-win (window-buffer (funcall selector))))
         (set-window-buffer (selected-window) next-win)
         (set-window-buffer (funcall selector) this-win)
         (select-window (funcall selector)))
       (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(defun ood () (interactive) (dired "/home/zeltak/org"))

(defun create-scratch-buffer nil
   "create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(defun z/narrow-or-widen-dwim ()
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

(defun ora-test-emacs ()
  (interactive)
  (require 'async)
  (async-start
   (lambda () (shell-command-to-string
          "emacs --batch --eval \"
(condition-case e
    (progn
      (load \\\"~/.emacs.d/settings.el\\\")
      (message \\\"-OK-\\\"))
  (error
   (message \\\"ERROR!\\\")
   (signal (car e) (cdr e))))\""))
   `(lambda (output)
      (if (string-match "-OK-" output)
          (when ,(called-interactively-p 'any)
            (message "All is well"))
        (switch-to-buffer-other-window "*startup error*")
        (delete-region (point-min) (point-max))
        (insert output)
        (search-backward "ERROR!")))))

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

(defmacro C-u (&rest args)
  (let ((prefix (list 4)))
    (while (cdr args)
      (cond
       ((eq (car args) 'C-u)
        (setf (car prefix) (* 4 (car prefix))))
       ((eq (car args) 'M-x)
        ;; ignore
        t)
       (t
        (error "Unknown arg %S" (car args))))
      (setq args (cdr args)))
    (unless (functionp (car args))
      (error "%S is not a function" (car args)))
    `(lambda ()
       (interactive)
       (let ((current-prefix-arg ',prefix))
         (call-interactively ',(car args))))))

(fset 'del_exe_mu4e
   [?d ?x ?y ])

(global-unset-key (kbd "<f1>"))
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4>"))
(global-unset-key (kbd "<f5>"))
(global-unset-key (kbd "<f6>"))
(global-unset-key (kbd "<f7>"))
(global-unset-key (kbd "<f8>"))
(global-unset-key (kbd "<f9>"))
(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<f12>"))
(global-unset-key (kbd "C-v "))
(global-unset-key (kbd "C-M-p"))
(global-unset-key (kbd "C-M-e"))
(global-unset-key (kbd "C-M-b"))
(global-unset-key (kbd "C-M-b"))

(key-chord-define-global "yy"     'z/copy-line)
(key-chord-define-global "jj"     'avi-goto-char-2)

(global-unset-key (kbd "M-`"))
(global-set-key (kbd "M-`") 'avi-goto-char-2)

;Create an ID for the entry at point if it does not yet have one.
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key "\C-cs" 'org-babel-execute-subtree)
(global-set-key "\C-cl" 'org-store-link)

(global-set-key
   (kbd "<f1>")
(defhydra hydra-toggles (:color blue)
  "toggle Emacs configs"
  ("g"     indent-guide-mode            "indent guide")
  ("f"     fci-mode                     "fci")
  ("k"     key-chord-mode               "key chord")
  ("l"     linum-mode             "linum")
  ("t"     lentic-mode             "lentic ")
  ("e"     evil-mode                    "evil mode")
  ("r"     read-only-mode       "read only mode ") 
  ("v"     view-mode       "view mode ") 
  ("w"     whitespace-mode              "whitespace" )
  ("=" text-scale-increase "font plus" :color red)
  ("-" text-scale-decrease "font minus" :color red)
  ("p" list-packages          "MELPA")
  ("s" create-scratch-buffer   "create scratch")
  ("c" cua-mode          "cua")
  ("m"  hydra-toggles-macro/body "macros")
  ("h"      hydra-toggles-help/body     "hel-keys")
  ("q"     nil                          "cancel" )
))

(defhydra hydra-toggles-macro  (:color blue :hint nil )
     "macro commands
     "
     ("s" start-kbd-macro  "start macro" ) 
     ("e" end-kbd-macro  "end macro" ) 
     ("n" name-last-kbd-macro  "name macro" ) 
     ("i" insert-kbd-macro  "insert macro" ) 
     ("q" nil "cancel" nil)
)

(defhydra hydra-toggles-help   (:color blue :hint nil )
     "help commands
     "
     ("k" describe-key   "keybinds help" ) 
     ("v" describe-variable    "variable help" ) 
     ("f" describe-function   "function help" ) 
     ("q" nil "cancel" nil)
)

(global-set-key
   (kbd "<f2>")
(defhydra hydra-dired-main (:color blue)
  "dired"
  ("<f2>"     dired            "start dired")
  ("j"  dired-jump  "jump current folder")
  ("p"  peep-dired      "toggle peep mode")
  ("t"   hydra-dired-configs/body      "dired toggles")
  ("m"   diredp-mark/unmark-extensio      "mark")
  ("q"     nil                          "cancel" )
))

(defhydra hydra-dired-configs (:color blue )
     "
     "
    ("o" dired-omit-mode  "dired omit" ) 
    ("w" wdired-change-to-wdired-mode  "wdired" ) 
     ("q" nil "cancel" nil)
)

(global-set-key
 (kbd "<f3>")
 (defhydra hydra-spell  ()
   "spell checking "
   ("<f3>" endless/ispell-word-then-abbrev  "check and add to abbrv" :color blue)
   ("i"    ispell  "start spell checker" :color blue)
   ("w"   ispell-word  "check word" :color blue)
   ("b"   flyspell-goto-next-error  "go to next bad word" :color blue)
   ("c"   flyspell-check-next-highlighted-word  "check next bad word" :color blue)
   ("q" nil "cancel")))

(global-set-key
    (kbd "<f4>")
    (defhydra hydra-org-blocks ()
    "
_c_enter  _q_uote    _L_aTeX:
_l_atex   _e_xample  _i_ndex:
_a_scii   _v_erse    _I_NCLUDE:
_s_rc     ^ ^        _H_TML:
_h_tml    ^ ^        _A_SCII:
"
      ("z"    org-dp-wrap-in-block   "multi_wrap" :color blue)
      ("<f4>" z/hydra-wrap-elisp "elisp" :color blue)
      ("r"    z/hydra-wrap-R "R" :color blue)
      ("b"   z/hydra-wrap-bash  "bash" :color blue)
    ("s" (pl/hot-expand "<s"))
    ("e" (pl/hot-expand "<e"))
    ("q" (pl/hot-expand "<q"))
    ("v" (pl/hot-expand "<v"))
    ("c" (pl/hot-expand "<c"))
    ("l" (pl/hot-expand "<l"))
    ("h" (pl/hot-expand "<h"))
    ("a" (pl/hot-expand "<a"))
    ("L" (pl/hot-expand "<L"))
    ("i" (pl/hot-expand "<i"))
    ("I" (pl/hot-expand "<I"))
    ("H" (pl/hot-expand "<H"))
    ("A" (pl/hot-expand "<A"))
    ("<" self-insert-command "ins")
      ("q" nil "cancel")))

(global-set-key
   (kbd "<f5>")
(defhydra hydra-mu4e (:color blue :hint nil)
  "
"
  ("<f5>"     mu4e            "start mu4e")
  ("u"     mu4e-update-mail-and-index           "Send/Recive")
  ("o"     mu4e-headers-change-sorting            "sort")
    ("q"     nil                          "cancel" )
))

(global-set-key
   (kbd "<f6>")
(defhydra hydra-bib (:color blue :hint nil)
  "
"
  ("<f6>"     helm-bibtex            "hbibtex")
  ("e"    ebib           "ebib")
    ("q"     nil                          "cancel" )
))

(global-set-key
   (kbd "<f8>")
   (defhydra hydra-bookmark   (:color blue)
     "bookmark  commands "
     ("<f8>" helm-bookmarks  "choose bookmark"  )
     ("m" bookmark-bmenu-list "B+ menu"  )
     ("r" helm-recentf  "recents"  )
     ("b" bmkp-bookmark-set-confirm-overwrite "Add bookmark"  )
     ("f" bmkp-bmenu-filter-tags-incrementally "B+ menu"  )
     ("c" helm-chrome-bookmarks "chrome bkmrks"  )
     ("s" bookmark-save  "save bkmrks"  )
     ("q" nil "cancel")))

(global-set-key
     (kbd "<f9>")
  (defhydra hydra-org (:color blue )
  "
  "
      ("<f9>"  helm-org-headlines   "search-headers")
      ("u"     outline-up-heading  "outline-up-heading")
      ("x"     org-archive-subtree "org-archive-subtree")
      ("e"     org-export-dispatch "org-export-dispatch")
      ("i"     org-toggle-inline-images  "org-toggle-inline-images")
      ("t"     org-todo  "org-todo")
      ("c"     org-columns         "org-columns")
      ("C"     org-columns-quit    "org-columns-quit")
      ("b"     org-bibtex-yank     "org-bibtex-yank")
      ("r"     org-refile          "org-refile")
      ("R"     z/prefix-org-refile   "refile" )
      ("B"     org-bibtex-create   "org-bibtex-create")
      ("s"     org-sort     "org-sort")
      ("n"     org-narrow-to-subtree "org-narrow-to-subtree")
      ("W"     widen              "widen")
      ("w"     z/narrow-or-widen-dwim              "toggle wide/narrow")
      ("d"     org-download-screenshot "org-download-screenshot")
      ("D"     org-download-delete "org-download-delete")
      ("8"     org-toggle-heading   "convert>header (**)")
      ("7"     z/org-convert-header-samelevel  "convert>header (*)")
      ("l"     hydra-org-links/body  "links")
      ("h"     org-insert-heading  "org insert header")
;need to escape \ with \\
      ("\\"     hydra-org-table/body      "org tables")
      ("X"     org-babel-execute-subtree      "exe.babel.subtree")
      ("f"     hydra-org-food/body      "org-food")
       ("q"     nil                          "cancel" )
  ))

(defhydra hydra-org-links (:color blue )
     "
     "
    ("i" org-insert-link   "insert (or edit if on link)" ) 
    ("d"     org-id-create "org id create")
    ("c" org-id-copy  "copy org-id" ) 
    ("s" org-id-store-link  "store org-id" ) 
    ("a" org-store-link  "orgmode store" ) 
     ("q" nil "cancel" nil)
)

(defhydra hydra-org-table  (:color red )
     "
     "
    ("y" org-table-copy-region  "copy" :color blue) 
    ("d" org-table-cut-region  "cut" ) 
    ("p" org-table-paste-rectangle  "paste" :color red ) 
    ("c" org-table-create-or-convert-from-region  "convert" ) 
     ("q" nil "cancel" nil)
)

(defhydra hydra-org-food ()
   "org-food "
   ("b" cooking-sparse-tree-breakfeast "breakfeast_view" :color blue)
   ("m" cooking-sparse-tree-main "main_view" :color blue)
   ("r" recipe-template "recipe-template" :color blue)
   ("t" travel-template  "travel-template" :color blue)
   ("q" nil "cancel")
)

(global-set-key
 (kbd "C-M-o")
 (defhydra hydra-org-edit (:color blue)
   "orgmode editing "
   ("t" org-insert-todo-heading-respect-content "insert TODO" )
   ("d" org-cut-subtree  "org cut" )
   ("y" org-copy-subtree "org copy" )
   ("p" org-paste-subtree  "org paste" )
   ("h" org-set-line-headline "line to headline" )
   ("c" org-set-line-checkbox  "line to checkbox" )
   ("s" hydra-org-time/body "time stamps" )
   ("q" nil "cancel")))

(defhydra hydra-org-time (:color blue)
   "time command"
   ("s"  org-timestamp-select "select time stamp")
   ("n" org-timestamp-now  "timestamp current" )
   ("i" z-insert-date "insert current data")  
   ("d" org-deadline  "set deadline")  
   ("i" org-schedule  "set schedule")  
   ("q" nil "cancel")
)

; (require 'hydra-examples)
; (hydra-create "C-M-o" hydra-example-move-window-splitter)

; (hydra-create "C-M-o"
;   '(("h" hydra-move-splitter-left)
;     ("j" hydra-move-splitter-down)
;     ("k" hydra-move-splitter-up)
;     ("l" hydra-move-splitter-right)))

(global-set-key
 (kbd "C-M-y")
 (defhydra hydra-yas ()
   "yas command "
   ("a" yas-activate-extra-mode "enable Emacs mode for yas" :color blue)
   ("n" yas-new-snippet "add new snippet" :color blue)
   ("v" yas-visit-snippet-file "visit" :color blue)
   ("i" yas-insert-snippet "insert_point" :color blue)
   ("r" yas-reload-all  "reload" :color blue)
   ("t" yas-tryout-snippe  "try snipet" :color blue)
   ("q" nil "cancel")))

(global-set-key                         
 (kbd "C-M-e")
 (defhydra hydra-editing (:color blue)
   "editing command"
   ("e" hydra-edit-extra/body  "Extra editing commands")
   ("<up>" drag-stuff-up  "marked up" :color red)
   ("<down>" drag-stuff-down  "marked down" :color red)
   ;("<left>" drag-stuff-left  "marked left" :color red)
   ;("<right>" drag-stuff-right "marked right" :color red)
   ("p" duplicate-current-line-or-region  "duplicate" :color red)
   (";"  hydra-commenting/body  "comment!" )
   ("i"  hydra-editing-insert/body  "insert" )   
   ("f" flush-blank-line  "flush blank" )
   ("u" z-fix-characters "fix unicode" )
   ("g" google-search "google searh selected" )
   ("c" z/comment-box "comment box" )
   ("R" revert-buffer  "revert buffer before changes" ) 
   ("q" nil "cancel")))

(defhydra hydra-edit-extra (:color blue :hint nil )
     "
fix _u_nicode issue  // u_p_case region // _d_owncase region 
     "
     ("u" z-fix-characters  "fix unicode" ) 
     ("p" upcase-region  "upcase region" ) 
     ("d" downcase-region  "downcase region" ) 
     ("f" toggle-fill-unfill  "fill/unfill")
     ("r" z-edit-file-as-root  "edit as root")
     ("q" nil "cancel" nil)
     ("1" z/regex-delete-numeric "delete numbers")
)

(defhydra hydra-commenting (:color blue  )
     "
comment  _;_ // comment _t_o line // comment para_g_raph // co_p_y-paste-comment 
comment _e_macs function  // copy-paste-comment-function _r_  

     "
     (";" evilnc-comment-or-uncomment-lines  "comment" ) 
     ("t" evilnc-quick-comment-or-uncomment-to-the-line   "c 2 line"  nil ) 
     ("g" evilnc-comment-or-uncomment-paragraphs  "c paragraph"  nil ) 
     ("p" evilnc-copy-and-comment-lines  "c,c,p"  nil ) 
     ("e" z/comment-line  "comment-line-emacsfun" :color blue)
     ("r" z/copy-comment-paste  "c,c,p-fun " :color blue)
     ("q" nil "cancel" nil)
)

(defhydra hydra-editing-insert (:color blue)
  "unicode"
  ("k"    z/insert-keyboth  "【】") 
  ("b"     z/insert-bashscript  "#!") 
  ("q" nil "cancel" nil)
)

(global-set-key
 (kbd "C-M-;")
 (defhydra hydra-avi ()
   "yas command "
   ("g" avi-goto-char-2 "avi-goto-char-2" :color blue)
   ("c" avi-goto-char "avi-goto-char" :color blue)
   ("l" avi-goto-line "avi-goto-line" :color blue)
   ("4" avi-copy-line  "avi-copy-line" :color blue)
   ("3" avi-move-line  "avi-move-line" :color blue)
   ("r" avi-copy-region  "avi-copy-region" :color blue)
   ("a" avi-goto-word-1  "avi-goto-word-1" :color blue)
   ("v" avi-goto-word-0  "avi-goto-word-0" :color blue)
   ("z" ace-jump-zap  "zap text" :color blue)
   ("q" nil "cancel")))

(global-set-key
   (kbd "<f11>")
   (defhydra hydra-buffer  (:color blue)
     "buffer commands "
     ("s" save-buffer "save buffer"  )
     ("a" write-file  "save as.."  )
     ("x" kill-this-buffer "kill buffer"  )
     ("o" z-kill-other-buffers "kill all but current" )
     ("i" kill-buffer  "ido-kill" )
     ("c" z-save-buffer-close-window "save and close"  )
     ("k" kill-buffer "helm kill buffer" )
     ("n" next-user-buffer  "next buffer" )
     ("p" previous-user-buffer "prev buffer"  )
     ("N" next-emacs-buffer "next Emacs  buffer"  )
     ("P" previous-emacs-buffer "prev emacs buffer"  )
     ("<f11>" switch-to-previous-buffer  "last buffer"  )
     ("q" nil "cancel")))

(global-set-key
 (kbd "<f12>")
 (defhydra hydra-window (:color blue)
   "window"
   ("h" windmove-left)
   ("j" windmove-down)
   ("k" windmove-up)
   ("l" windmove-right)
   ("a" (lambda ()
          (interactive)
          (ace-window 1)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body)
          (throw 'hydra-disable t))
        "ace")
   ("=" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right))
        "vert")
   ("-" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down))
        "horz")
   ("t" transpose-windows  "transpose")
   ("<f12>" other-window "other-window")
   ("x" delete-window "delete window")
   ("x" delete-other-windows "delete all other  windows")
   ("i" ace-maximize-window "ace-one" )
   ("r" resize-window "resize" )
   ("q" nil "cancel")))

(defhydra hydra-goto-line (:pre (progn
                                  (linum-mode 1))
                           :post (progn
                                   (linum-mode -1))
                           :color blue)
  "goto"
  ("g" goto-line "line")
  ("c" goto-char "char")
  ("2" er/expand-region "expand")
  ("q" nil "quit"))

(global-set-key
   (kbd "<f7>")
(defhydra hydra-helm (:color blue :hint nil)
  "
helm-mini _<f7>_  // h_e_lm extra
_k_ill ring
_m_ark ring
_r_ecents
_l_ocate
_r_ecents
"
  ("<f7>"     helm-mini            "helm-mini")
  ("e"     hydra-helm-extra/body            "extra helm commands")
  ("k"     helm-show-kill-ring            "killring")
  ("m"     helm-mark-ring            "markring")
  ("r"     helm-recentf            "recents")
  ("l"     helm-locate            "locate")
  ("f"     helm-find-files            "find files")
  ("a"     helm-apropos            "apropos")
  ("c"     helm-occur            "occur")
  ("b"     helm-buffer-list            "buffers")
  ("o"     helm-my-org            "search org file")
    ("q"     nil                          "cancel" )
))

(defhydra hydra-helm-extra (:color blue :hint nil )
       "
 helm meta-_x_ 
helm _t_op
       "
       ("x" helm-M-x  "helm m-x" ) 
       ("t"     helm-top            "helm top") 
       ("q" nil "cancel" nil)
  )

(progn
  ;; set arrow keys in isearch. left/right is backward/forward, up/down is history. press Return to exit
  (define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat )
  (define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance )
  (define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward) ; single key, useful
  (define-key isearch-mode-map (kbd "<right>") 'isearch-repeat-forward) ; single key, useful
 )

(define-key dired-mode-map (kbd "<left>") 'diredp-up-directory-reuse-dir-buffer )
(define-key dired-mode-map (kbd "<right>") 'diredp-find-file-reuse-dir-buffer )
(define-key dired-mode-map (kbd "S-RET") 'dired-open-in-external-app )

(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program "chromium")

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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

(setq recentf-save-file "/home/zeltak/.emacs.t/recentf")  ;; (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
;(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!

(require 'tramp) ; Remote file editing via ssh
(setq tramp-default-method "ssh")

(setq explicit-shell-file-name "/bin/zsh")

(setq org-directory "~/org/files/")
(setq org-default-notes-file "~/org/files/refile.org")

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

(setq org-support-shift-select 't)

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

(setq org-agenda-files '("~/org/files/agenda/"))

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

 ;;   Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                   #("----------------" 0 16 (org-heading t))
                                   (0900 1100 1300 1500 1700))))

 ;; Display tags farther right
 (setq org-agenda-tags-column -102)

(setq org-agenda-custom-commands 
'(

("w" tags-todo "CATEGORY=\"work\"")
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

(appt-activate 1)
(org-agenda-to-appt)

(add-hook 'org-agenda-finalize-hook (lambda ()  (org-agenda-to-appt t)))

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

(setq org-outline-path-complete-in-steps nil)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(require 'org-protocol)

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
              ("r" "respond" entry (file+headline  "~/org/files/agenda/Research.org" "Mails")
               "* TODO Respond to %:from on %:subject\nSCHEDULED: %t\n\n%U\n\n%a\n\n" )
              ("q" "Quick Note" entry (file "~/org/quick-note.org")
                "* %?\n%U")
              ("w" "webCapture" entry (file+headline "refile.org" "Web")  "* BOOKMARKS %T\n%c\%a\n%i\n Note:%?" :prepend t :jump-to-captured t :empty-lines-after 1 :unnarrowed t)
              ;agenda captures
              ("r" "Work_short_term" entry (file+headline "~/org/files/agenda/Research.org" "Short term Misc")
               "* TODO  %^{Description} " )
)))

;;For agenda files locations, each location you add within " "
(require 'org-mobile)
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

;; (global-set-key (kbd "C-c w l")
;;                 (lambda ()
;;                   (interactive)
;;                   (let ((current-prefix-arg '(4)))
;;                      (call-interactively
;;                       'org-wrap-in-src-block ))))

;; (global-set-key (kbd "C-c w n")
;;                 (lambda ()
;;                   (interactive)
;;                   (let ((current-prefix-arg '(16)))
;;                      (call-interactively
;;                       'org-wrap-in-src-block))))

;; (global-set-key (kbd "C-c w w") 'org-wrap-in-src-block)


;; (global-set-key (kbd "C-c w y")
;;                 (lambda ()
;;                   (interactive)
;;                       (org-wrap-in-src-block  "shell" 1)))

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

(setq org-attach-directory "/home/zeltak/org/attach/files_2015/")

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


;;disable tooltips
(tooltip-mode -1)

;Start maximized, please
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized

; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)

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

(setq dired-dwim-target t)

(setq dired-dwim-target t)

(setq dired-recursive-deletes 'always); “always” means no asking
;Always recursively copy directory
(setq dired-recursive-copies 'top) ; “top” means ask once

(defun z/dired-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference."
  (interactive)
  (let* (
         (ξfile-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (ξdo-it-p (if (<= (length ξfile-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))

    (when ξdo-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (fPath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))) ξfile-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (fPath) (shell-command (format "open \"%s\"" fPath)))  ξfile-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) ξfile-list))))))

(defun z/dired-open-in-desktop ()
  "Show current file in desktop (OS's file manager)."
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. ⁖ with nautilus
    ) ))

(defun z/dired-get-size ()
 (interactive)
 (let ((files (dired-get-marked-files)))
   (with-temp-buffer
     (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
     (message "Size of all marked files: %s"
              (progn 
                (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                 (match-string 1))))))

(setq-default dired-omit-mode t)

;To activate it, add this to your .emacs
(setq-default dired-omit-mode t)
;To toggle the mode, bind it to a keystroke that you like
(define-key dired-mode-map (kbd "C-o") 'dired-omit-mode)

(defun my-mark-file-name-for-rename ()
    "Mark file name on current line except its extension"
    (interactive)

    ;; get the file file name first
    ;; full-name: full file name
    ;; extension: extension of the file
    ;; base-name: file name without extension
    (let ((full-name (file-name-nondirectory (dired-get-filename)))
          extension base-name)
      
      ;; check if it's a dir or a file
      ;; TODO not use if, use switch case check for symlink
      (if (file-directory-p full-name)
          (progn
            ;; if file name is directory, mark file name should mark the whole
            ;; file name
            (call-interactively 'end-of-line) ;move the end of line
            (backward-char (length full-name)) ;back to the beginning
            (set-mark (point))
            (forward-char (length full-name)))
        (progn
          ;; if current file is a file, mark file name mark only the base name,
          ;; exclude the extension
          (setq extension (file-name-extension full-name))
          (setq base-name (file-name-sans-extension full-name))
          (call-interactively 'end-of-line)
          (backward-char (length full-name))
          (set-mark (point))
          (forward-char (length base-name))))))

  (defun my-mark-file-name-forward ()
    "Mark file name on the next line"
    (interactive)
    (deactivate-mark)
    (next-line)
    (my-mark-file-name-for-rename))

  (defun my-mark-file-name-backward ()
    "Mark file name on the next line"
    (interactive)
    (deactivate-mark)
    (previous-line)
    (my-mark-file-name-for-rename))

;; (require 'wdired)

;; (eval-after-load 'wdired
;;   (progn
;;     (define-key wdired-mode-map (kbd "TAB") 'my-mark-file-name-forward)
;;     (define-key wdired-mode-map (kbd "S-<tab>") 'my-mark-file-name-backward)
;;     (define-key wdired-mode-map (kbd "s-a") 'my-mark-file-name-for-rename))) ;

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



(require 'mu4e)
(require 'mu4e-contrib) 
;for below make sure the (mu4e-maildirs-extension) is installed from melpa/git
(mu4e-maildirs-extension)

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 120
      mu4e-headers-auto-update t)


;; list of my email addresses.
(setq mu4e-user-mail-address-list '("ikloog@gmail.com"
                                    "ikloog@bgu.ac.il"
                                    "ekloog@hsph.harvard.edu"))

;; something about ourselves
(setq
   user-mail-address "ikloog@gmail.com"
   user-full-name  "itai kloog "
   mu4e-compose-signature
    (concat
      "itai kloog\n"
      "http://www.example.com\n"))

(setq mu4e-compose-signature-auto-include 't)

;; default
(setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

(setq mu4e-attachment-dir  "~/Downloads")

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))

mu4e-compose-dont-reply-to-self t                  ; don't reply to myself

(require 'org-mu4e)

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "ikloog@gmail.com" nil))
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587)

;; don't save messages to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

(setq mu4e-date-format-long "%d/%m/%Y (%H:%M:%S)")
(setq mu4e-headers-date-format "%d/%m/%Y (%H:%M:%S)")
;can define a horizontal or vertical split 
(setq mu4e-split-view 'horizontal)


;; use 'fancy' non-ascii characters in various places in mu4e
(setq mu4e-use-fancy-chars t)
;; attempt to show images when viewing messages
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))
;preffer html  
(setq mu4e-view-prefer-html t)

;; Silly mu4e only shows names in From: by default. Of course we also  want the addresses.
(setq mu4e-view-show-addresses t)

;; mu4e-action-view-in-browser is built into mu4e
;; by adding it to these lists of custom actions
;; it can be invoked by first pressing a, then selecting
(add-to-list 'mu4e-headers-actions
             '("in browser" . mu4e-action-view-in-browser) t)
(add-to-list 'mu4e-view-actions
             '("in browser" . mu4e-action-view-in-browser) t)

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
    '( (:date          .  25)
       (:flags         .   6)
       (:from          .  22)
       (:subject       .  nil)))


;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(require 'mu4e-contrib) 
(setq mu4e-html2text-command 'mu4e-shr2text) 
;(setq mu4e-html2text-command "w3m -I utf8 -O utf8 -T text/html")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

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

;(global-set-key (kbd "XXX") 'z-open-file-fast)

(add-to-list 'load-path "/home/zeltak/.emacs.g/extra/edit-server/")
(require 'edit-server)
(edit-server-start)

(add-to-list 'load-path "/home/zeltak/.emacs.g/ESS/lisp/")
(load "ess-site")

(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;don't ask to save file
;(setq ess-ask-about-transfile nil)
(setq ess-ask-about-transfile nil)

(setq ess-ask-for-ess-directory nil)
;define deault ess dir
(setq ess-directory "/home/zeltak/ZH_tmp/")

(setq ess-local-process-name "Runi")

(setq ess-history-directory "~/.essrhist/")

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
        (mapcar 'file-name-sans-extension
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

(defun helm-agenda-candidates (query)
  (let ((results '()))
    (mapc (lambda (f)
      (with-current-buffer (find-file-noselect f)
        (org-map-entries
         (lambda ()
           (add-to-list 'results
                        (cons
                         (concat
                          (file-name-nondirectory f) " | "
                          (make-string (nth 1 (org-heading-components)) ?*)
                          " "
                          (org-get-heading))
                         (point-marker))))
         query))) (org-agenda-files))
    results))


(defun helm-query-agenda (query)
  "Helm interface to headlines with TODO status in current buffer."
  (interactive "sQuery: ")
  (let ((candidates (helm-agenda-candidates query)))
    (helm :sources '(((name . "TODO headlines")
                      (candidates . candidates)
                      (action . (("open" . (lambda (m)
                                             (switch-to-buffer (marker-buffer m))
                                             (goto-char m)
                                             (show-children))))))))))

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
