(use-package sunrise-x-popviewer
  :ensure t
  :config
(require 'sunrise-x-popviewer)
(sr-popviewer-mode 1)
;; to open in next pane and not new window
(setq sr-popviewer-select-viewer-action
         (lambda nil (let ((sr-running nil)) (other-window 1))))
  )

(use-package sunrise-x-mirror
 :ensure t
 :config
 (require 'sunrise-x-mirror)
(setq sr-mirror-unionfs-impl (quote unionfs-fuse))
 )

(use-package sunrise-x-loop
 :ensure t
 :config
(require 'sunrise-x-loop) 
 )

(use-package  sunrise-x-modeline
 :ensure t
 :config
 )

(use-package sunrise-x-tabs
 :ensure t
 :config
;(require 'sunrise‐x‐tabs) 
 )

(use-package sunrise-x-checkpoints
 :ensure t
 :config
  )

;;; Adding files opened with external apps to the history of recent files.
(defadvice openwith-file-handler
  (around advice-openwith-file-handler (operation &rest args))
  (condition-case description
      ad-do-it
    (error (progn
             (recentf-add-file (car args))
             (error (cadr description))))))
(ad-activate 'openwith-file-handler)

(defun er/sunrise-flatten ()
 (interactive)
 (sr-find "-type f"))

; Kill all sunrise and dired buffers when closing Sunrise Commander
(defun er/kill-all-sunrise-buffers()
      "Kill all dired buffers."
      (interactive)
      (save-excursion
        (let((count 0))
          (dolist(buffer (buffer-list))
            (set-buffer buffer)
            (when (derived-mode-p 'dired-mode 'sr-virtual-mode 'sr-mode)
                (setq count (1+ count))
                (kill-buffer buffer)))
          (message "Killed %i sunrise buffer(s)." count ))))
(setq sr-quit-hook 'er/kill-all-sunrise-buffers)

(define-key sr-mode-map (kbd "/") 'sr-fuzzy-narrow) 
(define-key sr-mode-map (kbd "") 'er/sunrise-flatten) 
(define-key sr-mode-map (kbd "\\") 'hydra-sr-chd/body ) 
(define-key sr-mode-map (kbd "`") 'hydra-sunrise-leader/body ) 
;lynx like
(define-key sr-mode-map (kbd "<left>") 'sr-dired-prev-subdir ) 
(define-key sr-mode-map (kbd "<right>") 'sr-advertised-find-file ) 
;move back/forward im history
(define-key sr-mode-map (kbd "M-<left>") 'sr-history-prev ) 
(define-key sr-mode-map (kbd "M-<right>") 'sr-history-next )

(global-set-key
   (kbd "")
(defhydra hydra-sr-chd  (:color blue :hint nil :columns 4)

"
"
("a" (find-file "~/AUR/") "AUR" )
("b"  (find-file "~/bin/") "bin" )
("c"  nil )
("d" (find-file "~/Downloads/")    "Downloads" )
("e"  (find-file "~/.emacs.d/") "Emacs.d")
("E"  (find-file "~/.emacs.g/") "Emacs.g")
("f"  nil )
("g"  nil )
("h"  (find-file "~/") "HOME" )
("i"  nil )
("j"  nil )
("k"  (find-file "~/BK/") "BK" )
("l"  nil )
("m"  (find-file "~/music/") "music" )
("n"  nil )
("o"  (find-file "~/org/files/") "Org" )
("p"  (find-file "~/mtp") "mtp" )
("r"  (find-file "~/mreview/") "mreview" )
("s"  (find-file "~/Sync/") "Sync" )
("S"  (find-file "~/scripts/" "scripts") )
("t"  (find-file "~/mounts/" "mounts") )
("u"  (find-file "~/Uni//") "Uni" )
("v"  nil)
("w"  (find-file "~/dotfiles/") "dotfiles" )
("x"  nil )
("y"  nil )
("z"  (find-file "~/ZH_tmp//") "ZH_tmp" )
("."  (find-file "~/.config/") "config")
("/"  (find-file "/") "Root")
("q" nil  )

))

(defhydra hydra-sunrise-leader  (:color blue :hint nil)

"

_a_:         _b_:         _c_:        _d_:        _e_:           _f_:         _g_:  
_h_: collapse org tree        _i_: insert text         _j_:       _k_:       _l_:          _m_: helm-mark        _n_: mark position       
_o_: mark prev   _p_ _q_ _r_ wdired   du_p_licate  _s_:       _t_: term           _u_:       
_v_:        _w_:        _x_:       _y_: kill ring       _z_: 
_q_: 

Sunrise:
【C-c C-d】recent dirs 【C-c C-q】wdired 【M-o】equal panes 【C-enter】open in next pane 
【N】copy/rename same dir 【s/r】sort/reverse 【X】exe file 【K】clone (cp tree) 【y】calc size


"

("a" find-file  )
("b"  nil  )
;("c"  company-complete )
("c"  auto-complete )
("d"  nil )
("e"  nil )
("f"  nil )
("g"  nil )
("h"  hide-sublevels )
("i"  hydra-editing-insert/body )
("j"  nil )
("k"  nil )
("l"  nil )
("m"  helm-mark-ring )
("n"  set-mark-command )
("o"  set-mark-command 4 )
("p"  duplicate-current-line-or-region )
("r"  sr-editable-pane )
("s"  nil )
("t"  sr-term-cd )
("T"  sr-term )
("<f9>"  sr-term-cd-newterm )
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  helm-show-kill-ring )
("z"  nil )
("\\"  z/insert-slsh )
(";"  comment-or-uncomment-region )
("q"  nil )

)

(use-package sr-speedbar
 :ensure t
 :config
  )

(use-package swiper 
 :ensure t
 :config
;(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper-at-point)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
 )

(defun swiper-at-point ()
  (interactive)
  (swiper (thing-at-point 'symbol)))

(use-package swiper-helm
 :ensure t
 :config
  )

(use-package tiny
  :config
;  (global-set-key (kbd "C-s-t") 'tiny-expand)
)

;(add-to-list 'load-path "/home/zeltak/.emacs.g/transmission/")
(require 'transmission)
;(setq transmission-host "10.0.0.2")

(use-package undo-tree 
:ensure t
:config
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '((".*" . "~/.emacs.t/undo-files")))
(setq undo-tree-mode-lighter "")         
)

(use-package unfill
:ensure t
:config
)

(use-package volatile-highlights
 :ensure t
 :config
(require 'volatile-highlights)
(volatile-highlights-mode t) 
 )

;; (use-package  visible-mark 

;;  :ensure t
;;  :config
;;  (defface visible-mark-active ;; put this before (require 'visible-mark)
;;   '((((type tty) (class mono)))
;;     (t (:background "magenta"))) "")
;; (require 'visible-mark)
;; (global-visible-mark-mode 1) ;; or add (visible-mark-mode) to specific hooks
;; (setq visible-mark-max 2)
;; (setq visible-mark-faces `(visible-mark-face1 visible-mark-face2))
;;  )

(use-package worf
 :ensure t
 :config
 
 )

(use-package weechat
   :ensure t
   :config
  (require 'weechat)
(setq weechat-modules '(weechat-button
                        weechat-complete
                        weechat-spelling
                        weechat-corrector
                        weechat-tracking
                        weechat-notifications))
   )

(eval-after-load 'weechat
  '(progn
     (setq weechat-host-default "karif.server-speed.net"
           weechat-port-default 9001
           weechat-color-list
           '(unspecified "black" "dark gray" "dark red" "red"
                         "dark green" "light green" "brown"
                         "yellow" "RoyalBlue3"
                         "light blue"
                         "dark magenta" "magenta" "dark cyan"
                         "light cyan" "gray" "white")
           weechat-prompt "> "
           weechat-notification-mode t
           weechat-auto-monitor-buffers t 
           weechat-complete-nick-ignore-self nil
           weechat-button-buttonize-nicks nil
           weechat-tracking-types '(:highlight (".+#weechat.el" . :message))
           weechat-sync-active-buffer t)
     (setq weechat-auto-monitor-buffers
      '("freenode.#gmpc"
        "bitlbee.rasi"))
     (set-face-background 'weechat-highlight-face "dark red")
     (set-face-foreground 'weechat-highlight-face "light grey")
     (add-hook 'weechat-mode-hook 'visual-line-mode)
     (tracking-mode)))

(winner-mode 1)

;(use-package workgroups2
; :ensure t
; :config
;(workgroups-mode 1)        ; put this one at the bottom of .emacs (init.el)
;(require 'workgroups2)
;; Change workgroups session file
;(setq wg-session-file "~/.emacs.d/.emacs_workgroups") 
;)

(use-package xah-find
 :ensure t
 :config
  )

(use-package yasnippet
:ensure t
 :config 
(require 'yasnippet)
(yas-global-mode 1)
;; Use custom snippets.
;(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-reload-all)
(setq yas-snippet-dirs '("~/.emacs.d/snippets/"))
;for orgmode properties fix 
(setq yas-indent-line 'fixed)
;set insert at point prompt type- here ido
(setq yas/prompt-functions '(yas/ido-prompt
                            yas/completing-prompt))
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
;(add-to-list 'default-frame-alist '(font . "Fantasque Sans Mono 14"))
;(add-to-list 'default-frame-alist '(font . "fira mono 14"))
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
  (insert "【】")
(backward-char 2)  
)

(defun z/insert-bashscript ()
  " insert #!/bin/sh  "
  (interactive)
  (insert "#!/bin/sh")

(defun z/insert-play ()
  " insert   ‣  "
  (interactive)
  (insert "‣")
)

)

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun z/edit-copy-all-or-region ()
  "Put the whole buffer content to `kill-ring', or text selection if there's one.
Respects `narrow-to-region'.
URL `http://ergoemacs.org/emacs/emacs_copy_cut_all_or_region.html'
Version 2015-08-22"
  (interactive)
  (if (use-region-p)
      (progn
        (kill-new (buffer-substring (region-beginning) (region-end)))
        (message "Text selection copied."))
    (progn
      (kill-new (buffer-string))
      (message "Buffer content copied."))))

(defun z/org-convert-header-samelevel  ()
                     (interactive)                                
                     (let ((current-prefix-arg '(4)))             
                       (call-interactively #'org-toggle-heading)))

(defun z/org-tangle-atpoint  ()
                     (interactive)                                
                     (let ((current-prefix-arg '(4)))             
                       (call-interactively #'org-babel-tangle)))

(defun z/org-agenda-calendar ()
"open work agenda"
(interactive)                                
(org-agenda nil "a")
)

(defun z/org-agenda-work ()
"open work agenda"
(interactive)                                
(org-agenda nil "w")
)

(defun z/org-agenda-allan ()
"open work agenda"
(interactive)                                
(org-agenda nil "l")
)

(defun z/org-agenda-joel ()
"open work agenda"
(interactive)                                
(org-agenda nil "j")
)

(defun z/org-agenda-cook ()
"open work agenda"
(interactive)                                
(org-agenda nil "f")
)

(fset 'expdf
      [?\C-c ?\C-e ?\l ?\o ])

(defun z/org-sparse-todo ()
    "all todo sparse"
    (interactive)
    (org-match-sparse-tree t )
)

(defun z/org-agenda-search()
""
(interactive)                                
(org-agenda nil "s")
)

(defun z/org-agenda-search-todo ()
""
(interactive)                                
(org-agenda nil "S")
)

(defun z/org-link-file  ()
                     (interactive)                                
                     (let ((current-prefix-arg '(4)))             
                       (call-interactively #'org-insert-link)))

(defun insert-heading-link (dir)
  "select a headline from org-files in dir and insert a link to it."
  (interactive  (list (read-directory-name "Directory: ")))
  (let ((org-agenda-files (f-entries
                           dir
                           (lambda (f)
                             (string=
                              "org"
                              (file-name-extension f)))
                           t)))
    (helm-org-agenda-files-headings)))

(defun helm-org-insert-id-link-to-heading-at-marker (marker)
  (with-current-buffer (marker-buffer marker)
    (let ((file-name (buffer-file-name))
          (id (save-excursion (goto-char (marker-position marker))
                              (org-id-get-create)
                              (org-id-store-link))))

      (with-helm-current-buffer
        (org-insert-link
         file-name id)))))


(cl-defun helm-source-org-headings-for-files (filenames
                                              &optional (min-depth 1) (max-depth 8))
  (helm-build-sync-source "Org Headings"
    :candidates (helm-org-get-candidates filenames min-depth max-depth)
    :action '(("Go to line" . helm-org-goto-marker)
              ("Refile to this heading" . helm-org-heading-refile)
              ("Insert link to this heading"
               . helm-org-insert-link-to-heading-at-marker)
              ("Insert id link to this heading" .
               helm-org-insert-id-link-to-heading-at-marker))))

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

(defun z/org-cblock-comment ()    
(interactive)
(org-edit-special)
(mark-whole-buffer)
(comment-dwim nil)
(org-edit-src-exit))

(defun  z/org-cblock-paste-lisp ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_SRC emacs-lisp\n")
  (yank)
  (insert "\n#+END_SRC"))

(defun  z/org-cblock-paste-sh ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_SRC sh\n")
  (yank)
  (insert "\n#+END_SRC"))

(defun  z/org-cblock-paste-example ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_EXAMPLE\n")
  (yank)
  (insert "\n#+END_EXAMPLE"))

(defun  z/org-cblock-paste-R ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_SRC R\n")
  (yank)
  (insert "\n#+END_SRC"))

(defun  z/org-cblock-paste-SAS ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_SRC SAS\n")
  (yank)
  (insert "\n#+END_SRC"))

(defun  z/org-cblock-paste-QUOTE ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_QUOTE\n")
  (yank)
  (insert "\n#+END_QUOTE"))

(defun z/org-cblock-iwrap-emacs-lisp (&optional lang lines)
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

(defun z/org-cblock-iwrap-ASK ()
(interactive)
(let ((current-prefix-arg '(4)))
(call-interactively
'z/org-cblock-iwrap-emacs-lisp)))

(defun z/org-cblock-iwrap-ASK-LINE ()
(interactive)
(let ((current-prefix-arg '(4)))
(call-interactively
'z/org-cblock-iwrap-emacs-lisp)))

(defun z/org-cblock-iwrap-R ()
(interactive)
(z/org-cblock-iwrap-emacs-lisp  "R" ))

(defun z/org-cblock-iwrap-sh ()
(interactive)
(z/org-cblock-iwrap-emacs-lisp  "sh" ))

(defun  z/org-cblock-nowrap-example ()
   "paste in already quote block"
  (interactive)
  (insert "#+BEGIN_EXAMPLE\n")
  (insert "\n#+END_EXAMPLE"))

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

(defun z/org-email-heading ()
  "Send the current org-mode heading as the body of an email, with headline as the subject.
use these properties
TO
CC
BCC
OTHER-HEADERS is an alist specifying additional
header fields.  Elements look like (HEADER . VALUE) where both
HEADER and VALUE are strings.
Save when it was sent as a SENT property. this is overwritten on
subsequent sends."
  (interactive)
  ; store location.
  (setq *email-heading-point* (set-marker (make-marker) (point)))
  (save-excursion
    (org-mark-subtree)
    (let ((content (buffer-substring (point) (mark)))
          (TO (org-entry-get (point) "TO" t))
          (SUBJECT (nth 4 (org-heading-components)))
          (OTHER-HEADERS (eval (org-entry-get (point) "OTHER-HEADERS")))
          (continue nil)
          (switch-function nil)
          (yank-action nil)
          (send-actions '((email-send-action . nil)))
          (return-action '(email-heading-return)))
      
      (compose-mail TO SUBJECT OTHER-HEADERS continue switch-function yank-action send-actions return-action)
      (message-goto-body)
      (insert content)
      (when CC
        (message-goto-cc)
        (insert CC))
      (when BCC
        (message-goto-bcc)
        (insert BCC))
      (if TO
          (message-goto-body)
        (message-goto-to)))))

(defun z/org-email-heading-me ()
  "Send the current org-mode heading as the body of an email, with headline as the subject."
  (interactive)
  (save-excursion
    (org-mark-subtree)
    (let ((content (buffer-substring (point) (mark)))
          (SUBJECT (nth 4 (org-heading-components))))

      (compose-mail "ikloog@gmail.com" SUBJECT)
      (message-goto-body)
      (insert content)
      (message-send)
      (message-kill-buffer))))

(defun z/org-move-top-collapse  ()
     (interactive)            
     (beginning-of-buffer)                    
     (hide-sublevels 1)
)

(defun z/insert-slsh ()
  " insert     "
  (interactive)
  (insert "\\")
)

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

(defun z/buffer-close-andmove-other   ()
     (interactive)    
     (ace-window 1)        
      (ace-delete-window)
)

(defun ood () (interactive) (dired "/home/zeltak/org"))

(defun create-scratch-buffer nil
   "create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(defun describe-last-function() 
  (interactive) 
  (describe-function last-command))

;; taken from here: http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/
(defun z/launch--ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/zsh")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                ;; (call-interactively 'rename-buffer)
                (ansi-term term-cmd)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))

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

(defun helm-swish-e-candidates (query)
  "Generate a list of cons cells (swish-e result . path)."
  (let* ((result (shell-command-to-string
                  (format "swish-e -f ~/.swish-e/index.swish-e -x \"%%r\t%%p\n\" -w %s"
                          (shell-quote-argument query))))
         (lines (s-split "\n" result t))
         (candidates '()))
    (loop for line in lines
          unless (or  (s-starts-with? "#" line)
                      (s-starts-with? "." line))
          collect (cons line (cdr (s-split "\t" line))))))


(defun helm-swish-e (query)
  "Run a swish-e query and provide helm selection buffer of the results."
  (interactive "sQuery: ")
  (helm :sources `(((name . ,(format "swish-e: %s" query))
                    (candidates . ,(helm-swish-e-candidates query))
                    (action . (("open" . (lambda (f)
                                           (find-file (car f)))))))
                   ((name . "New search")
                    (dummy)
                    (action . (("search" . (lambda (f)
                                             (helm-swish-e helm-pattern)))))))))

(defun hotspots ()
  "helm interface to my hotspots, which includes my locations,
org-files and bookmarks"
  (interactive)
  (helm :sources `(((name . "Mail and News")
                    (candidates . (("Mail" . (lambda ()
                                               (if (get-buffer "*mu4e-headers*")
                                                   (progn
                                                     (switch-to-buffer "*mu4e-headers*")
                                                     (delete-other-windows))

                                                 (mu4e))))
                                   ("Calendar" . (lambda ()  (browse-url "https://www.google.com/calendar/render")))
                                   ("RSS" . elfeed)
                                   ("Agenda" . (lambda () (org-agenda "" "w")))))
                    (action . (("Open" . (lambda (x) (funcall x))))))
                   ((name . "My Locations")
                    (candidates . (("master" . "~/org/files/")
                                   (".emacs.d" . "~/.emacs.d/" )
                                   ("todo" . "~/org/files/agenda/todo.org")))
                    (action . (("Open" . (lambda (x) (find-file x))))))

                   ((name . "My org files")
                    (candidates . ,(f-entries "~/org/files/"))
                    (action . (("Open" . (lambda (x) (find-file x))))))
                   helm-source-recentf
                   helm-source-bookmarks
                   helm-source-bookmark-set)))

(defun z/del-nonorg-files ()
(interactive)
(dired-mark-files-regexp "\\.org$") 
(dired-toggle-marks)
(dired-do-delete)
)

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

(defun z/dired-beet-import ()
  (interactive)
  (sr-term)
  (let* ((fmt "beet import %s\n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input))))

(defun z/dired-beet-import-single ()
  (interactive)
  (sr-term)
  (let* ((fmt "beet import -s %s\n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input))))

(defun z/dired-make-exec ()
  (interactive)
  (sr-term)
  (let* ((fmt "chmod +x %s\n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input))))

(defun z/dired-fb-upload ()
  (interactive)
  (sr-term)
  (let* ((fmt "fb %s\n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input)
      (shell-command "notify-send fb uploaded")
)))

(defun z/dired-mpd-add ()
  (interactive)
  (sr-term)
  (let* ((fmt "mpc add file:/ %s\n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input))))

(defun z/dired-ssh-qnap ()
  (interactive)
  (sr-term)
  (let* ((fmt "sshfs -p 12121 admin@10.0.0.2:/share/MD0_DATA/ /home/zeltak/mounts/lraid \n")
         (file (sr-clex-file sr-selected-window))
         (command (format fmt file)))
    (if (not (equal sr-terminal-program "eshell"))
        (term-send-raw-string command)
      (insert command)
      (eshell-send-input))))

(fset 'z/dired-media-info
   [?& ?m ?e ?d ?i ?a ?i ?n ?f ?o return ])

(defun z/dired-nmap-network ()
"map all available IP on my netwrok"
(interactive)
(sr-term )
(insert " nmap -sP 10.0.0.1/24" )
(eshell-send-input)
)

(defun z/dired-sort-menu ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
  (interactive)
  (let (ξsort-by ξarg)
    (setq ξsort-by (ido-completing-read "Sort by:" '( "date" "size" "name" "dir")))
    (cond
     ((equal ξsort-by "name") (setq ξarg "-Al --si --time-style long-iso "))
     ((equal ξsort-by "date") (setq ξarg "-Al --si --time-style long-iso -t"))
     ((equal ξsort-by "size") (setq ξarg "-Al --si --time-style long-iso -S"))
     ((equal ξsort-by "dir") (setq ξarg "-Al --si --time-style long-iso --group-directories-first"))
     (t (error "logic error 09535" )))
    (dired-sort-other ξarg )))

(defun z/dired-backup-lgs ()
"run laptop git script"
(interactive)
(sr-term )
(insert "~/bin/lgs.sh" )
(eshell-send-input)
)

(defun isearch-delete-something ()
  "Delete non-matching text or the last character."
  ;; Mostly copied from `isearch-del-char' and Drew's answer on the page above
  (interactive)
  (if (= 0 (length isearch-string))
      (ding)
    (setq isearch-string
          (substring isearch-string
                     0
                     (or (isearch-fail-pos) (1- (length isearch-string)))))
    (setq isearch-message
          (mapconcat #'isearch-text-char-description isearch-string "")))
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))

(define-key isearch-mode-map (kbd "<backspace>") 
  #'isearch-delete-something)

(defun my-yas-get-first-name-from-to-field ()
  (let ((rlt "AGENT_NAME") str)
    (save-excursion
      (goto-char (point-min))
      ;; first line in email could be some hidden line containing NO to field
      (setq str (buffer-substring-no-properties (point-min) (point-max))))
    (if (string-match "^To: \"\\([^ ,]+\\)" str)
        (setq rlt (match-string 1 str)))
    (message "rlt=%s" rlt)
    rlt))

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
(global-unset-key (kbd "C-v"))
(global-unset-key (kbd "C-M-p"))
(global-unset-key (kbd "C-M-e"))
(global-unset-key (kbd "C-M-b"))
(global-unset-key (kbd "C-M-b"))
(global-unset-key (kbd "C-M-t"))

(global-set-key (kbd "M-x") 'counsel-M-x)

(global-set-key "\C-t" #'transpose-lines)
(define-key ctl-x-map "\C-t" #'transpose-chars)

(key-chord-define-global "yy"     'z/copy-line)
(key-chord-define-global "jj"     'avy-goto-word-or-subword-1)

(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

(global-unset-key (kbd "M-`"))
;(global-set-key (kbd "M-`") 'avy-goto-line)
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<left>") 'windmove-left)

;;(global-set-key (kbd "M-1") 'other-window)
(global-set-key (kbd "M-1") 'ace-window)

;Create an ID for the entry at point if it does not yet have one.
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key "\C-cs" 'org-babel-execute-subtree)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)

(with-eval-after-load "org" 
(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading)
(define-key org-mode-map (kbd "<M-return>")  'org-insert-heading-respect-content)
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

(global-set-key (kbd "C-c x") 'org-babel-execute-subtree)

(defface hydra-face-orange
    '((t (:foreground "orange" :bold t)))
  "Orange face. For fun.")

(defface hydra-face-red
    '((t (:foreground "red" :bold t)))
  "red face. For fun.")

(defface hydra-face-green
    '((t (:foreground "green" :bold t)))
  "green face. For fun.")

(global-set-key
   (kbd "\\")
(defhydra hydra-leader  (:color blue  :columns 4 :hints nil)

"
LEADER:【C-A-W】-append to killring
"
("\]" z/insert-slsh "insert \\")
("\\"  avy-goto-word-1  "avy jump")
("a" nil )
("b"  nil  )
("<f12>" z/buffer-close-andmove-other "move back to window and close" :exit t)   
;("c"  company-complete )
("c"  auto-complete )
("d"  nil )
("e"  nil )
("f"  nil )
("g"  hydra-goto/body )
("h"  z/org-move-top-collapse   "collapse tree")
("H"  hide-sublevels "collapse tree")
("i"  hydra-editing-insert/body "insert symbol" )
("j"  nil )
("k"  nil )
("l"  avy-goto-line "jump line" )
("m"  helm-mark-ring "HELM mark ")
("n"  set-mark-command "mark position")
("o"  set-mark-command 4 "mark prev" )
("p"  duplicate-thing  "duplicate")
("r"  repeat "repeat last command" )
("s"  nil )
("t"  helm-top "top")
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  helm-show-kill-ring "kill ring")
("z"  nil )
(";"  comment-or-uncomment-region )
("q"  nil )

))

(global-set-key
   (kbd "<f1>")
(defhydra hydra-toggles (:color blue  :columns 6)
"Toggles:   【M-g M-g】 goto line"
("a" nil  )
("b" bug-hunter-file "bug hunter" :face 'hydra-face-orange )
("c" cua-mode "cua" :face 'hydra-face-red )
("d" tool-bar-mode "toggle toolbar"   )
("e" evil-mode "evil")
("f" fci-mode "fci" )
("g" google-search "google")
("h" hydra-toggles-help/body "help" )
("i"  nil )
("j"  nil )
("k" key-chord-mode "key-chord"  )
("l" linum-mode  "linium")
("m" hydra-toggles-macro/body "macro menu")
("n" start-kbd-macro "start macro" :face 'hydra-face-green)
("o" end-kbd-macro "end macro" :face 'hydra-face-red)
("O" org-mode "org-mode" )
("p" list-packages "elpa"  )
("r" read-only-mode "read-only")
("s" scratch "scratch")
("S" create-scratch-buffer "New scratch" )
("t" lentic-mode  "lentic")
("u" electric-pair-mode "electric-pair")
("v" view-mode "view-mode")
("w" whitespace-mode "whitespace")
("x" eval-buffer "eval buffer")
("X" eval-region "eval-region")
("y" nil )
("z" nil )
("=" text-scale-increase :color red )
("-" text-scale-decrease :color red)
("G"  indent-guide-mode "guide-mode")
("q" nil "cancel")
))

(defhydra hydra-toggles-macro  (:color blue :hint nil )
     "macro commands
     "
     ("s" start-kbd-macro  "start macro" ) 
     ("e"   "end macro" ) 
     ("e" kmacro-end-and-call-macro  "use C-x e" ) 
     ("n" name-last-kbd-macro  "name macro" ) 
     ("i" insert-kbd-macro  "insert macro" ) 
     ("q" nil "cancel" nil)
)

(global-set-key
   (kbd "")
(defhydra hydra-toggles-help (:color blue :hint nil)

"
_k_ :describe key  _v_ describe variable _f_ describe functiom  
M-1- change windows
M-2 expand region (select gradualy regions)
~movment~ >> 【C-e//C-a】  (end/start of line)
~editing~ >>  【C-BKSP//A-BKSP】 (kill word start/end of line)



_q_: 
"

("a" nil )
("b"  nil  )
("c"  nil )
("d"  describe-last-function "describe last command used" )
("e"  nil )
("f"  describe-function )
("g"  nil )
("h"  nil )
("i"  nil )
("j"  nil )
("k"  describe-key )
("l"  nil )
("m"  nil )
("n"  nil )
("o"  nil )
("p"  nil )
("r"  nil )
("s"  nil )
("t"  nil )
("u"  nil )
("v"  describe-variable)
("w"  nil )
("x"  nil )
("y"  nil )
("z"  nil )
("q"  nil )

))

(global-set-key
   (kbd "<f2>")
(defhydra hydra-dired-main (:color blue :hint nil)

"

_a_:         _b_:         _c_: configs        _d_:mark/unmark        _e_:           _ff_//_fd_//_fd_ (find/find lisp/dirs)         _g_:  
_h_:         _i_:         _j_:dired-jump       _k_:       _l_:          _m_:        _n_:      
_o_: dired operations       _p_:peep dired        _r_:       _s_:       _t_: toggles          _u_:       
_v_:        _w_:        _x_:       _y_:       _z_: 
_q_: 

【s】sort 【+】 add dir 【&/!】 open with 【M-n】 cycle diredx guesses 
【C/R/D/S】 copy/move(rename)/delete/symlink
【S-5-m】 mark by string // ^test(start with) txtDOLLAR (end with) 
【*s】 mark all 【*t】 invert mark 【*d】 mark for deletion 【k】 hide marked 【g】unhide mark 【g】 refresh
【Q】query replace marked files 【o】open file new window 【V】open file read only 【i】open dir-view below

"



("<f2>" dired )
("<f1>" sunrise )
("a" nil )
("b"  nil  )
("c"  hydra-dired-configs/body )
("d"  nil )
("e"  nil )
("ff"  find-dired )
("fl"  find-lisp-find-dired )
("fd"  find-lisp-find-dired-subdirectories )
("g"  nil )
("h"  nil )
("i"  nil )
("j"  dired-jump )
("k"  nil )
("l"  nil )
("m"  diredp-mark/unmark-extension )
("n"  nil )
("o"  hydra-dired-operation/body )
("p"  peep-dired )
("r"  nil )
("s"  nil )
("t"  hydra-dired-configs/body )
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  nil )
("z"  nil )
("q"  nil )

))

(defhydra hydra-dired-configs (:color blue )
     "
     "
    ("o" dired-omit-mode  "dired omit" ) 
    ("t" dired-details-toggle  "dired details" ) 
    ("w" wdired-change-to-wdired-mode  "wdired" ) 
     ("q" nil "cancel" nil)
)

(global-set-key
   (kbd "")
(defhydra hydra-dired-operation (:color blue :hint nil)

"

_a_:         _b_:         _c_: clean non-org        _d_:        _e_:           _f_:         _g_:  
_h_:         _i_:         _j_:       _k_:       _l_:          _m_:        _n_:      
_o_:        _p_:        _r_:       _s_:       _t_:           _u_:       
_v_:        _w_:        _x_:       _y_:       _z_: 
_q_: 

"



("a" nil )
("b"  nil  )
("c"  z/del-nonorg-files )
("d"  nil )
("e"  nil )
("f"  nil )
("g"  nil )
("h"  nil )
("i"  nil )
("j"  nil )
("k"  nil )
("l"  nil )
("m"  nil )
("n"  nil )
("o"  nil )
("p"  nil )
("r"  nil )
("s"  nil )
("t"  nil )
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  nil )
("z"  nil )
("q"  nil )

))

(global-set-key
  (kbd "<f3>")
  (defhydra hydra-spell  (:color blue :hint nil :columns 4)

  "
【C-SPACE】 recntangle select // 【C-;】 ispell cycle // 【C-x z】 repeat last command- keep press 【z】to repeat
 "
  ("<f3>" endless/ispell-word-then-abbrev "check and add" )
  ("a" helm-apropos "Helm-Apropos")
  ("b"  backward-kill-line  "kill backwards")
  ("c"  cycle-spacing "cycle spacing")
  ("d"  helm-do-grep "helm-grep" )
  ("e"  hydra-editing/body "editing menu" 'hydra-face-green)
  ("f"  helm-find-files "Helm FF" )
  ("g"  rgrep "Rgrep")
  ("h"  highlight-symbol "HS symbol")
  ("H"  highlight-symbol-remove-all "HS remove")
  ("i"  ispell "ispell")
  ("j"  highlight-symbol-next  :color red  "HS Next")
  ("k"  highlight-symbol-prev  :color red  "HS Prev")
  ("l"  helm-locate "helm-locate")
  ("L"  counsel-locate "council-locate")
  ("m"  flyspell-check-next-highlighted-word "check next error")
  ("n"  flyspell-goto-next-error "check next error" )
  ("o"  helm-occur "helm Occur")
  ("p"  nil )
  ("R"  anzu-query-replace-at-cursor "Replace@cursor")
  ("s"  isearch-forward "isearch" )
  ("S"  isearch-forward-symbol-at-point "isearch@point" )
  ("t"  nil )
  ("u"  imenu "imenu")
  ("v"  nil)
  ("w"  ispell-word "ispeel word" )
  ("x"  nil )
  ("y"  nil )
  ("z"  counsel-recoll "recoll" )
  ("q"  nil )

  ))

(global-set-key
    (kbd "<f4>")
    (defhydra hydra-org-blocks (:color blue :hint nil :columns 4)
    "
"
    ("<f4>" z/org-cblock-iwrap-emacs-lisp "WRAP-Elisp" )
    ("<f3>" z/org-cblock-iwrap-sh  "Bash" )
    ("r" z/org-cblock-iwrap-emacs-R "WRAP-R" )
    ("a" z/org-cblock-iwrap-ASK  "Ask" )
    ("l" z/org-cblock-iwrap-ASK-LINE "Ask line" )
    ("pl" z/org-cblock-paste-lisp "paste lisp" )
    ("pb" z/org-cblock-paste-sh "paste bash" )
    ("pr" z/org-cblock-paste-R "paste R" )
    ("ps" z/org-cblock-paste-SAS  "paste SAS" )
    ("pe" z/org-cblock-paste-example  "paste SAS" )
    ("pq" z/org-cblock-paste-QUOTE "paste QUOTE" )
    ("e" z/org-cblock-nowrap-example "insert Example block" )
    ("q" nil "cancel")))

(global-set-key
   (kbd "<f5>")
(defhydra hydra-mu4e (:color blue  :columns 2 :hints nil)
  "
Mail:
"
  ("<f5>"     mu4e            "start mu4e")
  ("u"     mu4e-maildirs-extension-force-update           "Send/Recive")
  ("o"     mu4e-headers-change-sorting            "sort")
  ("z"   z/org-email-heading              "email header")
    ("q"     nil                          "cancel" )
))

(global-set-key
   (kbd "<f6>")
(defhydra hydra-bib  (:color blue :hint nil :columns 4)

"
Bib:
"

("<f6>" helm-bibtex "helm-bibtex")
("a" nil )
("b"  nil  )
("c"  org-ref-clean-bibtex-entry "clean bib" )
("d"  doi-utils-insert-bibtex-entry-from-doi "add by doi" )
("e"  ebib )
("f"  nil )
("g"  nil )
("h"  nil )
("i"  nil )
("j"  nil )
("k"  helm-bibtex-ikloog-publications "kloog papers" )
("K"  helm-bibtex-ikloog-publications-all "kloog ALL")
("l"  nil )
("m"  nil )
("n"  org-bibtex-create "new bib entry")
("o"  nil )
("p"  helm-bibtex-ikloog-prep "kloog prep")
("r"  helm-resume "helm resume")
("s"  bibtex-sort-buffer "sort buffer")
("t"  nil )
("u"  nil )
("v"  bibtex-validate "validtae" )
("V"  bibtex-validate-globally "validate-check for dups") ; check for dup keys
("w"  nil )
("x"  nil )
("y"  org-bibtex-yank "yank bibtex")
("z"  nil )
("q"  nil )

))

(global-set-key
   (kbd "<f8>")
(defhydra  hydra-open  (:color blue :hint nil :columns 4)
"
BKMK Menu
"
("<f8>" helm-bookmarks "BKMK's")
("<f7>" helm-mini "helm-mini")
("<f9>" org-iswitchb "org buffers")
("a" nil )
("b"  bmkp-bookmark-set-confirm-overwrite "add BKMK" )
("c"  helm-chrome-bookmarks "Chorme BKMK")
("d"  nil )
("e"  nil )
("f"  bmkp-bmenu-filter-tags-incrementally "BKMK menu filter")
("g"  nil )
("h"  nil )
("i"  nil )
("j"  helm-projectile-switch-to-buffer "Helm projectile switch" )
("k"  nil )
("l"  nil )
("m"  bookmark-bmenu-list "BKMK menu")
("n"  nil )
("o"  helm-projectile "Helm Projectile")
("p"  projectile-find-file "projectile find file")
("r"  helm-recentf "Helm Recents" )
("s"  bookmark-save "BKMK Save" )
("t"  z/launch--ansi-term "ansi-term" )
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  nil )
("z"  nil )
("q"  nil )

))

(global-set-key
   (kbd "<f9>")
(defhydra hydra-org (:color blue :hint nil :columns 4)

"ORG editing"

("<f9>" helm-org-headlines "helm org headers")
("<f10> w" worf-goto "worf org headers")
("<f8>" z/org-insert-heading-link "link/refile")
("RET"  org-insert-todo-heading "org todo header//check list")
("<f10> RET"  org-insert-subheading "org sub header")
("<f10> t"  org-insert-todo-subheading "org sub header")
("."  org-do-demote "<" :color red)
(","  org-do-promote ">" :color red)
("<"  org-promote-subtree "T<" :color red)
(">"  org-demote-subtree "T>" :color red)

("a"  org-sort "sort")
("b"  nil  )
("c"  org-columns "Columns" )
("C"  org-columns-quit "quit Columns" )
("d"  org-download-screenshot "screenshot")
("D"  org-download-delete "del screenshot")
("E"  org-export-dispatch "export")
("ep"  org-latex-export-to-pdf "export latex")
("f"  hydra-org-food/body "food menu"  :face 'hydra-face-orange )
("g"  org-set-tags "tags dialog")
("h"  org-insert-heading "insert header")
("i"  org-toggle-inline-images "toggle images")
("j"  nil )
("k"  nil )
("l"  hydra-org-links/body "link menu" :face 'hydra-face-green)
("m"  org-mark-subtree "mark subtree" )
("n"  helm-swish-e "swish")
("o"  org-occur "org-occur" )
("p"  nil )
("r"  org-refile "refile")
("R"  z/prefix-org-refile "jump to header using refile")
("s"  hydra-org-time/body "time menu" :face 'hydra-face-orange )
("t"  org-todo "todo dialog")
("u"  nil )
("v"  org-babel-execute-subtree "exe block")
("w"  z/narrow-or-widen-dwim "Toggle narrow//widen" )
("x"  org-archive-subtree "Archive" )
("-"  org-toggle-heading "Header lower" )
("="  z/org-convert-header-samelevel "Header same")
("\\"  hydra-org-table/body "table menu"  :face 'hydra-face-orange )
(";"  z/comment-org-in-src-block "comment block" )
("y"  nil )
("z"  nil )
("<home>" outline-up-heading  "up main header" :color red)
("<down>" org-forward-heading-same-level  "up header" :color red)
("<up>" org-backward-heading-same-level  "down header" :color red)
("q"  nil )

))

(defhydra hydra-org-links (:color blue  :hint nil :columns 4)
     "
     "
    ("l" org-store-link  "create and copy link//also 【C-c l】")
    ("i" org-insert-link   "insert (or edit if on link)//also 【C-c C-l】" ) 
    ("d" org-id-create "just create Id")
    ("c" org-id-copy  "copy(and create) to killring" ) 
    ("s" org-id-store-link  "store org-id" ) 
    ("f" z/org-link-file  "link to file (via helm)" ) 
    ("w" worf-copy-heading-id  "worf copy id ot killring" ) 
     ("q" nil "cancel" nil)
)

(defhydra hydra-org-table  (:color red )
     "
     "
    ("i" org-table-insert-row  "insert row" :color blue) 
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
   (kbd "C-M-v")
(defhydra hydra-org-tangle  (:color blue :hint nil)

"
_a_:         _b_:         _c_:        _d_:        _e_:           _f_:         _g_:  
_h_:         _i_:         _j_:       _k_:       _l_:          _m_:        _n_:      
_o_:        _p_: tang-atpoint        _r_:       _s_:       _t_: tangle file           _u_:       
_v_:        _w_:        _x_:       _y_:       _z_: 
_q_: quit 

"

("a" nil )
("b"  nil  )
("c"  nil )
("d"  nil )
("e"  nil )
("f"  nil )
("g"  nil )
("h"  nil )
("i"  nil )
("j"  nil )
("k"  nil )
("l"  nil )
("m"  nil )
("n"  nil )
("o"  nil )
("p"  z/org-tangle-atpoint )
("r"  nil )
("s"  nil )
("t"  org-babel-tangle )
("u"  nil )
("v"  nil)
("w"  nil )
("x"  nil )
("y"  nil )
("z"  nil )
("q"  nil )

))

(defhydra hydra-org-time (:color blue)
   "time command"
   ("s"  org-timestamp-select "select time stamp")
   ("n" org-timestamp-now  "timestamp current" )
   ("i" z-insert-date "insert current data")  
   ("d" org-deadline  "set deadline")  
   ("i" org-schedule  "set schedule")  
   ("q" nil "cancel")
)

(global-set-key
 (kbd "C-M-o")
 (defhydra hydra-org-edit (:color blue :hint nil :columns 4)
   "orgmode editing "
   ("t" org-insert-todo-heading-respect-content "insert TODO" )
   ("d" org-cut-subtree  "org cut" )
   ("y" org-copy-subtree "org copy" )
   ("p" org-paste-subtree  "org paste" )
   ("r" org-copy  "copy via refile" )
   ("h" org-set-line-headline "line to headline" )
   ("c" org-set-line-checkbox  "line to checkbox" )
   (";" z/org-cblock-comment  "line to checkbox" )
   ("s" hydra-org-time/body "time stamps" )
   ("w" worf-mode "Worf mode" )
   ("<up>" org-move-subtree-up "header up" :color red )
   ("<down>" org-move-subtree-down "header down" :color red)
   ("q" nil "cancel")))

(global-set-key
     (kbd "<f10>")
  (defhydra hydra-org-agenda (:color blue :hint nil :columns 4)
"AGENDA:
【SPACE//TAB】open//open-go item in side view 【F】will toggle follow mode for space/tab view
【A】Append another view 【/】 filter tag 【=】 filter regex 【|】 clean all filters
【v】Choose view 【f】forward in time 【b】back in time 【.】goto today 【j】 jump to date
【S-left//right】 change deadline 【k】 launch capture with date/task
【:】 set tags 【,】set priority (then choose) 【S-U/D/L/R】 change todo/pri 
【m,u,U...】 dired marking 【M-m】toggle marking 【B】 execute on marks via dispatcher 
"
      ("<f10>" z/org-agenda-calendar  "org agenda"  )
      ("c"  org-agenda-columns  "agenda columns" )
      ("t"    org-agenda-todo      "change todo")
      ("k"    org-agenda-kill      "delete C-k")
      ("m"    org-agenda-bulk-toggle  "bulk mark"  :color red ) 
      ("x"    org-agenda-bulk-action  "bulk exe")
      ("x"   org-agenda-archive      "archive ")
      ("w"   org-agenda-refile      "refile ")
      (":"   org-agenda-set-tags      "set tags ")
      (","   org-agenda-priority      "priority (S-UP/S-Dn to change as well ")
      ("s"   org-agenda-schedule      "schedule task ")
      ("d"   org-agenda-deadline      "deadline task ")
      ("p"   org-agenda-date-prompt      "prompt date ")
       ("q"     nil                          "cancel" )
  ))

(global-set-key
   (kbd "<f11>")
   (defhydra hydra-buffer  (:color blue :hint nil :columns 4)
     "TODO commands "
     ("<f11>" org-agenda "org-agnda" )
     ("l" z/org-agenda-allan "Allan" )
     ("j" z/org-agenda-joel  "Joel"  )
     ("s"   z/org-agenda-search     "regex search")
     ("t"   z/org-agenda-search-todo     "regex search TODO")
      ("c"   z/org-agenda-cook      "cook")
     ("o" "" )
     ("d" "")
     ("i" "" )
     ("c" ""  )
     ("k"  "" )
     ("n" "" )
     ("p" ""  )
     ("w" z/org-agenda-work  "Work"  )
     ("q" nil "cancel")))

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
   ("t" yas-tryout-snippet  "try snipet" :color blue)
   ("q" nil "cancel")))

(global-set-key                         
 (kbd "C-M-e")
 (defhydra hydra-editing (:color blue :hint nil :columns 4)
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
   ("u" upcase-region  "upcase " )
   ("d" downcase-region  "downcase " )
   ("y" z/edit-copy-all-or-region  "copy buffer" )
   ("w" shrink-whitespace  "shrink-whitespace" )
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
  ("‣"     z/insert-play  " ‣") 
  ("q" nil "cancel" nil)
)

(global-set-key                         
 (kbd "C-M-p")
 (defhydra hydra-password-store (:color blue :columns 4 :hint nil)
   "password store command"
   ("e" password-store-edit   "edit pass" )
   ("d" password-store-remove   "delete pass" )
   ("q" nil "cancel")))

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
 (kbd "<f12>")
 (defhydra hydra-window (:color blue :hint nil :columns 5)
 "Window and buffer Operations"
   ("<f12>" switch-to-previous-buffer  "last buffer"  )
   ("<f11>" ace-delete-window "delete window")
   ("<home>" ace-window "ace-window//also M-1" :exit t)   
   ("=" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right))
        "Split Vertical (|)")
   ("-" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down))
        "Split horzizontal (-)")
   ("<left>" hydra-move-splitter-left "resize left"  :color red)
   ("<right>" hydra-move-splitter-right "resize right"  :color red)
   ("<up>" hydra-move-splitter-up "resize up"  :color red)
   ("<down>" hydra-move-splitter-down "resize down"  :color red)
   ("t" ace-swap-window  "transpose (ace-swap)")
   ("i" ace-maximize-window "ace-one" )
   ("r" resize-window "resize menu" )
   ;;Note winer mode must be enabled
   ("u" winner-undo "winner undo")
   ("s" save-buffer "save buffer"  )
   ("a" write-file  "save as.."  )
   ("x" kill-this-buffer "kill buffer"  )
   ("c" z-save-buffer-close-window "save and close"  )
   ("n" next-user-buffer  "next buffer" )
   ("p" previous-user-buffer "prev buffer"  )
   ("N" next-emacs-buffer "next Emacs  buffer"  )
   ("P" previous-emacs-buffer "prev emacs buffer"  )
   ("da" ace-delete-window)
   ("db" kill-this-buffer)
   ("df" delete-frame "delete frame")
   ("kw" delete-window "delete window")
   ("ka" delete-other-windows "delete all other  windows")
   ("kh" kill-buffer "helm kill buffer" )
   ("kb" z-kill-other-buffers "kill all but current" )
   ("q" nil "cancel")))

(defhydra hydra-goto  (:color blue :hint nil :columns 5)
  "goto"
  ("g" goto-line "line")
  ("c" goto-char "char")
  ("o" ace-link-org "goto org link")
  ("2" er/expand-region "expand")
  ("q" nil "quit"))

(defhydra hydra-vi (:body-pre hydra-vi/pre
                    :color    amaranth)
  "vi"
  ;; basic navigation
  ("l"        forward-char                  nil)
  ("h"        backward-char                 nil)
  ("j"        next-line                     nil)
  ("k"        previous-line                 nil)
  ;; mark
  ("m"        set-mark-command              "mark")
  ("C-o"      (set-mark-command 4)          "jump to prev location")
  ;; beginning/end of line
  ("a"        back-to-indentation-or-beginning-of-line "beg of line/indentation")
  ("^"        back-to-indentation-or-beginning-of-line "beg of line/indentation")
  ("$"        move-end-of-line              "end of line")
  ;; word navigation
  ("e"        forward-word                  "end of word")
  ("w"        modi/forward-word-begin       "beg of next word")
  ("b"        backward-word                 "beg of word")
  ;; page scrolling
  ("<prior>"  scroll-down-command           "page up")
  ("<next>"   scroll-up-command             "page down")
  ;; delete/cut/copy/paste
  ("x"        delete-forward-char           "del char")
  ("d"        my/iregister-cut              "cut/del")
  ("D"                 "cut/del line")
  ("y"        my/iregister-copy             "copy")
  ("p"        yank                          "paste")
  ;; beginning/end of buffer and go to line
  ("g"        hydra-vi/beginning-of-buffer  "beg of buffer/goto line")
  ("G"        hydra-vi/end-of-buffer        "end of buffer/goto line")
  ("<return>" goto-line                     "goto line")
  ;; undo/redo
  ("u"        undo-tree-undo                "undo")
  ("C-r"      undo-tree-redo                "redo")
  ;; misc
  ("<SPC>"    ace-jump-mode                 "ace jump")
  ;; exit points
  ("q"        hydra-vi/post                 "cancel" :color blue))

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

(setq savehist-additional-variables '(search-ring
                                      regexp-search-ring
                                      file-name-history
                                      extended-command-history
                                      kill-ring
                                      sr-history-registry
                                        ))

;;autosave
;(setq auto-save-visited-file-name t)
;(setq auto-save-interval 20) ; twenty keystrokes
(setq auto-save-timeout 60) ; ten idle seconds

(savehist-mode t)

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

(setq cache-long-scans nil)

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

(setq org-directory "~/org/files/")
(setq org-default-notes-file "~/org/files/refile.org")

;associate these files with org

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

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

;;   (defun update-last-edited (beg end length)
;;     (when
;;         (and
;;          (not (org-before-first-heading-p))
;;          (org-get-heading))
;;       (org-entry-put nil "LAST-EDITED" (format-time-string "[%d-%m-%Y(%H:%M)]"))))

;; (add-hook 'org-mode-hook (lambda ()
;; (add-to-list 'after-change-functions 'update-last-edited)))

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

;; when creating new headers make sure there isn't a space
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))
;;;this will make sure there are no empty lines betwwn headers after collapsing headers 
(setq org-cycle-separator-lines 0)

(org-add-link-type
 "grep"
 (defun endless/follow-grep-link (regexp)
   "Run `rgrep' with REGEXP as argument."
   (grep-compute-defaults)
   (rgrep regexp "*" (expand-file-name "./"))))

(org-add-link-type "file+emacs+dired" 'org-open-file-with-emacs-dired)
(add-hook 'org-store-link-functions 'org-dired-store-link)

(defun org-open-file-with-emacs-dired (path)
  "Open in dired."
  (let ((d (file-name-directory path))
        (f (file-name-nondirectory path)))
    (dired d)
    (goto-char (point-min))
    (search-forward f nil t)))

(defun org-dired-store-link ()
  "Store link to files/directories from dired."
  (require 'dired+)
  (when (eq major-mode 'dired-mode)
    (let ((f (dired-get-filename)))
      (setq link (concat "file+emacs+dired" ":" f)
            desc (concat f " (dired)"))
      (org-add-link-props :link link :description desc)
      link)))

(push (cons "\\.pdf\\'" 'emacs) org-file-apps)
(push (cons "\\.html\\'" 'emacs) org-file-apps)
(push (cons "\\.mp4\\'" 'vlc) org-file-apps)

(require 'org-id)
(setq org-id-link-to-org-use-id t)
;; Use global IDs
;; Update ID file .org-id-locations on startup
(org-id-update-id-locations)

(add-to-list 'org-modules "org-habit")

(setq org-agenda-files '("~/org/files/agenda/"))

(setq org-agenda-window-setup "current-window")
(setq org-agenda-restore-windows-after-quit t)

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; Compact the block agenda view
(setq org-agenda-compact-blocks t)
;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;;  Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                  #("----------------" 0 16 (org-heading t))
                                  (0900 1100 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

(defun cooking-sparse-tree-breakfeast ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"breakfest\""))

(defun cooking-sparse-tree-main ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"main\""))

(defun cooking-sparse-tree-sweet ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"sweet\""))

(defun cooking-sparse-tree-meat ()
  (interactive)
  (org-match-sparse-tree t "+TODO=\"COOK\"+Type=\"meat\""))

(defun cooking-sparse-tree-fav ()
  (interactive)
  (org-match-sparse-tree t "+Fav=\"y\""))

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

(setq org-agenda-custom-commands 
'(

;;TODO sparse tree
("T" occur-tree "TODO")

;;;;;;;WORK;;;;;;;;;;;;;;;;;;;;;;

;work related only tasks (from research|bgu files)
("w" "work" todo "TODO|BGU|EXP" 
(
(org-agenda-files (list "~/org/files/agenda/Research.org"  "~/org/files/agenda/bgu.org"))
(org-agenda-sorting-strategy '(priority-down effort-down))
))
         
;;;;;;;;;;;Allan;;;;;;;;;;;;;;;;;;;;
;;custom sparse tree
("L" occur-tree "allan")

; allan todos
("l" "allan tasks" tags-todo "allan"
(
(org-agenda-files (list "~/org/files/agenda/Research.org"  "~/org/files/agenda/bgu.org"))
(org-agenda-sorting-strategy '(priority-down effort-down))
))


;;;;;;;;;Joel;;;;;;;;;;;;;;;;
("j" "joel tasks" tags-todo "joel"
(
(org-agenda-files (list "~/org/files/agenda/Research.org"  "~/org/files/agenda/bgu.org"))
(org-agenda-sorting-strategy '(priority-down effort-down))
))

;;custom sparse tree
("J" occur-tree "joel")



;;;;;;;;;;;;;COOKING;;;;;;;;;;;
("f" "food" todo "COOK" 
         (
         (org-agenda-files '("~/org/files/agenda/food.org")) 
          (org-agenda-sorting-strategy 
          '(priority-up effort-down)
)
)
)




;;;;;;;;;;;;;;;;;TECH;;;;;;;;;;;;;;
("t" "tech" todo "TODO" 
         (
         (org-agenda-files '("~/org/files/agenda/TODO.org")) 
          (org-agenda-sorting-strategy 
          '(priority-up effort-down)
)
)
)

;;;;;;;;;;;;;;;;;HOME;;;;;;;;;;;;;;;;


("h" "home" todo "TODO" 
         (
         (org-agenda-files '("~/org/files/agenda/home.org")) 
          (org-agenda-sorting-strategy 
          '(priority-up effort-down)
)
)
)


("x" "Agenda and Home-related tasks"
               (
               (agenda "")
               (tags-todo "+PRIORITY=\"A\"")
               (tags "garden")
)
)



;;end brackets for setq
)
)

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

(defadvice org-capture (around bp/org-capture--around)
  (flet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    ad-do-it))
(ad-activate 'org-capture)

(require 'org-capture)
(defun my-capture-finalize ()
  (interactive)
  (org-capture-finalize)
  (delete-frame))

(add-hook 'org-capture-mode-hook
          (lambda ()
            (define-key org-capture-mode-map "\C-c\C-x" (function my-capture-finalize))))
((lambda nil (define-key org-capture-mode-map "" (function my-capture-finalize))))

(setq org-capture-templates
        (quote (           
("f" "food" entry (file+headline "/home/zeltak/org/files/agenda/food.org" "Inbox")
 "* COOK %? %^g 
   :PROPERTIES:
   :Time:     
   :Rating:   
   :Source:   
   :Ammount:  
   :Fav: 
   :Type: 
   :ID:   
   :END:
%(org-meta-return)
"
 )

("F" "food" entry   (file+headline "/home/zeltak/org/files/agenda/food.org" "Inbox")
(function  blank-recipe-template))

            
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

("i" "dl_comics" entry (file+headline "~/org/files/agenda/dl.org" "comics")
 "*  %^{Description}" )


("t" "TechTODO" entry (file+headline "~/org/files/agenda/TODO.org" "Home TD's")
 "* TODO  %?\n%T" )

("h" "todo_home" entry (file+headline "~/org/files/agenda/home.org" "`TODO`")
 "* TODO  %?\n%T" )

("b" "todo_shopping" entry (file+headline "~/org/files/agenda/food.org" "shopping")
 "* SHOP  %^{Description} " )

;; for mail 
("r" "respond" entry (file+headline  "~/org/files/agenda/Research.org" "Mails")
 "* TODO Respond to %:from on %:subject\nSCHEDULED: %t\n\n%U\n\n%a\n\n" )

("n" "Quick Note" entry (file "~/org/quick-note.org")
  "* %?\n%U")

("w" "webCapture" entry (file+headline "refile.org" "Web")  "* BOOKMARKS %T\n%c\%a\n%i\n Note:%?" :prepend t :jump-to-captured t :empty-lines-after 1 :unnarrowed t)

;agenda captures
("R" "Work_short_term" entry (file+headline "~/org/files/agenda/Research.org" "Short term Misc")
 "* TODO  %^{Description} " )

("T" "Research TODO" entry (file +headline "~/org/files/agenda/Research.org" "Short term Misc") 
           "* TODO %?\n %U\n\n%a")


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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (sh . t)
   (matlab . t)
   (sqlite . t)
   (ruby . t)
   (perl . t)
   (org . t)
   (dot . t)
   (gnuplot . t)
   (octave .t)
   (plantuml . t)
   (R . t)
   ))

;; (defun my-org-confirm-babel-evaluate (lang body)
;;     (not (string= lang "emacs-lisp")))  ; don't ask for lisp
;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(setq org-confirm-babel-evaluate nil)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

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

(require 'ox-odt)
(require 'ox-beamer)
(require 'ox-latex)

(add-to-list 'load-path "/home/zeltak/.emacs.g/org-mode/contrib/lisp/")


(eval-after-load 'ox '(require 'ox-koma-letter))

(eval-after-load 'ox-latex
  '(add-to-list 'org-latex-packages-alist '("AUTO" "babel" t) t))

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

;; Make sizes human-readable by default, sort version numbers
;; correctly, and put dotfiles and capital-letters first.
(setq-default dired-listing-switches "-alhv --group-directories-first ")

(setq dired-dwim-target t)

(setq dired-dwim-target t)

(setq dired-recursive-deletes 'always); “always” means no asking
;Always recursively copy directory
;(setq dired-recursive-copies 'top) ; “top” means ask once
(setq dired-recursive-copies 'always) ; never ask

;; Allow running multiple async commands simultaneously
(defadvice shell-command (after shell-in-new-buffer (command &optional output-buffer error-buffer))
  (when (get-buffer "*Async Shell Command*")
    (with-current-buffer "*Async Shell Command*"
      (rename-uniquely))))
(ad-activate 'shell-command)

(require 'find-dired)
(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

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

;; Handle zip compression
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

(add-hook 'isearch-mode-end-hook 
  (lambda ()
    (when (and (eq major-mode 'dired-mode)
           (not isearch-mode-end-hook-quit))
      (dired-find-file))))



(add-hook 'isearch-mode-end-hook 
  (lambda ()
    (when (and (eq major-mode 'sunrise-mode)
           (not isearch-mode-end-hook-quit))
      (dired-find-file))))

(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

(eval-after-load "dired"
  '(define-key dired-mode-map "z" 'dired-zip-files))
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")

  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command 
     (concat "zip " 
             zip-file
             " "
             (concat-string-list 
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))

  (revert-buffer)

  ;; remove the mark on all the files  "*" to " "
  ;; (dired-change-marks 42 ?\040)
  ;; mark zip file
  ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
  )

(defun concat-string-list (list) 
   "Return a string which is a concatenation of all elements of the list separated by spaces" 
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))

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

(add-to-list
 'command-switch-alist
 '("gnus" . (lambda (&rest ignore)
              ;; Start Gnus when Emacs starts
              (add-hook 'emacs-startup-hook 'gnus t)
              ;; Exit Emacs after quitting Gnus
              (add-hook 'gnus-after-exiting-gnus-hook
                        'save-buffers-kill-emacs))))

(require 'nnir)
;nnir is a Gnus interface to a number of tools for searching through mail and news repositories. Different backends (like nnimap and nntp) work with different tools (called engines in nnir lingo), but all use the same basic search interface.


;;@see http://www.emacswiki.org/emacs/GnusGmail#toc1
(setq gnus-select-method '(nntp "news.gmane.org")) ;; if you read news groups 


;; ask encyption password once
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;better to use/store authentication information in one of these files: ~/.authinfo.gpg. if not use this config (may not work)
;;(setq smtpmail-auth-credentials "/home/zeltak/.gnupg/.authinfo.gpg")
;; don't ask confirmations etc on delete and other options 
(setq gnus-novice-user nil)

(setq  gnus-always-read-dribble-file 1)  ; always read auto-save file
(setq 
gnus-treat-buttonize t           ; Add buttons
      gnus-treat-buttonize-head 'head  ; Add buttons to the head
      gnus-treat-emphasize t           ; Emphasize text
      gnus-treat-display-smileys t     ; Use Smilies
      gnus-treat-strip-cr 'last        ; Remove carriage returns
 ;;     gnus-treat-hide-headers 'head    ; Hide headers
)

(add-hook 'gnus-article-display-hook 'gnus-article-highlight-citation t) ; highlight quotes
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)                        ; use topic separation in the Group overview

(setq gnus-asynchronous t)

;; Inline images?
   (setq mm-attachment-override-types '("image/.*"))
   ;; Or, like this:
   (add-to-list 'mm-attachment-override-types "image/.*")

(define-key gnus-summary-mode-map (kbd "<delete>") 'gnus-summary-delete-article)

; grab new news every 2 minutes
(gnus-demon-add-handler 'gnus-group-get-new-news 2 nil)

(eval-after-load "gnus"
  (lambda ()
;     (gnus-demon-add-handler 'gnus-group-get-new-news 2 nil)
     ;; subscribed, from Chen Bin
     (defun my-gnus-group-list-subscribed-groups ()
       (interactive)
       (gnus-group-list-all-groups 2))
     (define-key gnus-group-mode-map (kbd "o") 'my-gnus-group-list-subscribed-groups)
     (add-hook 'gnus-startup-hook
           'my-gnus-group-list-subscribed-groups)))

(setq gnus-fetch-old-headers 250 )

;; Personal Information
(setq user-full-name "Itai Kloog"
      user-mail-address "ikloog@gmail.com")

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "gmail"
                      (nnimap-address "imap.gmail.com")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)
;;                      (nnimap-authinfo-file "~/.gnupg/ikloogmail.gpg")
                      (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
                      (nnmail-expiry-wait 90)))

(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)))

;; Make Gnus NOT ignore [Gmail] mailboxes
    (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "ikloog@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "homepc")

(setq gnus-use-correct-string-widths nil)

(setq my-email-addresses '("ikloog@gmail.com"
                           "zeltak@gmail.com"
                            "ikloog@bgu.ac.il."
                           "ekloog@hsoh.harvard.edu"
                        ))

(setq message-alternative-emails
      (regexp-opt my-email-addresses))

;; Gnus from manipulation
(setq gnus-from-selected-index 0)
(defun gnus-loop-from ()
  (interactive)
  (setq gnus-article-current-point (point))
  (goto-char (point-min))
  (if (eq gnus-from-selected-index (length my-email-addresses))
      (setq gnus-from-selected-index 0) nil)
  (while (re-search-forward "^From:.*$" nil t)
    (replace-match (concat "From: " user-full-name " <" (nth gnus-from-selected-index my-email-addresses) ">")))
  (goto-char gnus-article-current-point)
  (setq gnus-from-selected-index (+ gnus-from-selected-index 1)))

(global-set-key (kbd "C-c f") 'gnus-loop-from)

;; You need install the command line brower 'w3m' and Emacs plugin 'w3m'
(setq mm-text-html-renderer 'w3m)

;; NO 'passive
(setq gnus-use-cache t)
;; Fetch only part of the article if we can.  I saw this in someone ;; else's .gnus
(setq gnus-read-active-file 'some)
;; Tree view for groups.  I like the organisational feel this has.
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a ton!
(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.  'gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

;; BBDB: Address list
;(add-to-list 'load-path "/where/you/place/bbdb/")
(require 'bbdb)
(bbdb-initialize 'message 'gnus 'sendmail)
(setq bbdb-file "~/.bbdb") ;; OPTIONAL, because I'm sharing my ~/.emacs.d
(add-hook 'gnus-stasrtup-hook 'bbdb-insinuate-gnus)
(setq bbdb/mail-auto-create-p t
      bbdb/news-auto-create-p t)

;; auto-complete emacs address using bbdb's own UI
(add-hook 'message-mode-hook
          '(lambda ()
             (flyspell-mode t)
             (local-set-key "<TAB>" 'bbdb-complete-name)))

(setq mm-text-html-renderer 'w3m)

(setq gnus-fetch-old-headers t)

;; ;; also I'd prefer to have sane default headers
;; (setq gnus-visible-headers '("^From:\\|^Subject:\\|To:\\|^Cc:\\|^Date:\\|^Newsgroups:\\|^User-Agent:\\|^X-Newsreader:\\|^X-Mailer:")
;;       gnus-sorted-header-list gnus-visible-headers)

;; reconfigure buffer positions for a wider screen
(gnus-add-configuration  ; summary view
 '(summary
   (horizontal 1.0
               (vertical 1.0 (group 0.25) (summary 1.0 point)))))
(gnus-add-configuration  ; article view
 '(article
   (horizontal 1.0
               (vertical 0.45 (group 0.25) (summary 1.0 point) ("*BBDB*" 0.15))
               (vertical 1.0 (article 1.0)))))
(gnus-add-configuration  ; post new stuff
 '(edit-form
   (horizontal 1.0
               (vertical 0.45 (group 0.25) (edit-form 1.0 point) ("*BBDB*" 0.15))
               (vertical 1.0 (article 1.0)))))

(when (string= system-name "zuni")
(add-to-list 'load-path "~/mu/mu4e/")
)

(require 'mu4e)
(require 'mu4e-contrib) 
;for below make sure the (mu4e-maildirs-extension) is installed from melpa/git

;;;;$Note-this may screw up header updates$ 
;(mu4e-maildirs-extension)
;; list of my email addresses.
(setq mu4e-user-mail-address-list '("ikloog@gmail.com"
                                    "ikloog@bgu.ac.il"
                                    "ekloog@hsph.harvard.edu"))

(setq mu4e-update-interval 60)
(setq mu4e-headers-auto-update t)
(setq mu4e-index-update-error-warning  t)
(setq mu4e-index-update-error-continue   t)

;; something about ourselves
(setq
   user-mail-address "ikloog@gmail.com"
   user-full-name  "itai kloog "
   mu4e-compose-signature
    (concat
      "itai kloog\n"
      "http://www.bgu.ac.il\n"))

(setq mu4e-compose-signature-auto-include 't)

;; default
;;(setq mu4e-maildir "~/.mail/gmail/")
(setq mu4e-maildir "/home/zeltak/Maildir")

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
       ("Starred"   . ?r)
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

(defgroup mu4e-faces nil 
  "Type faces (fonts) used in mu4e." 
  :group 'mu4e 
  :group 'faces) 

(defface mu4e-basic-face 
  '((t :inherit font-lock-keyword-face)) 
  "Basic Face." 
  :group 'mu4e-faces) 

(defface mu4e-list-default 
  '((t :inherit mu4e-basic-face)) 
  "Basic list Face." 
  :group 'mu4e-faces) 

(defface mu4e-rw-default 
  '((t :inherit mu4e-basic-face)) 
  "Basic rw Face." 
  :group 'mu4e-faces)

;; basic face from where the rest inherits 
 '(mu4e-basic-face ((t :inherit font-lock-keyword-face :weight normal :foreground "Gray10"))) 

;; read-write group 
 '(mu4e-rw-default ((t :inherit mu4e-basic-face))) ;; face from where all the read/write faces inherits 
 '(mu4e-header-face ((t :inherit mu4e-rw-default))) 
 '(mu4e-header-marks-face ((t :inherit mu4e-rw-default))) 
 '(mu4e-header-title-face ((t :inherit mu4e-rw-default))) 
 '(mu4e-header-highlight-face ((t :inherit mu4e-rw-default :foreground "Black" :background "LightGray"))) 
 '(mu4e-compose-header-face ((t :inherit mu4e-rw-default))) 
 '(mu4e-compose-separator-face ((t :inherit mu4e-rw-default :foreground "Gray30" :weight bold))) 
 '(mu4e-footer-face ((t :inherit mu4e-rw-default))) 
 '(mu4e-contact-face ((t :inherit mu4e-rw-default :foreground "Black"))) 
 '(mu4e-cited-1-face ((t :inherit mu4e-rw-default :foreground "Gray10"))) 
 '(mu4e-cited-2-face  ((t :inherit mu4e-cited-1-face :foreground "Gray20"))) 
 '(mu4e-cited-3-face   ((t :inherit mu4e-cited-2-face :foreground "Gray30"))) 
 '(mu4e-cited-4-face    ((t :inherit mu4e-cited-3-face :foreground "Gray40"))) 
 '(mu4e-cited-5-face     ((t :inherit mu4e-cited-4-face :foreground "Gray50"))) 
 '(mu4e-cited-6-face      ((t :inherit mu4e-cited-5-face :foreground "Gray60"))) 
 '(mu4e-cited-7-face       ((t :inherit mu4e-cited-6-face :foreground "Gray70"))) 
 '(mu4e-link-face ((t :inherit mu4e-rw-default :foreground "Blue" :weight bold))) 
 '(mu4e-system-face ((t :inherit mu4e-rw-defaul :foreground "DarkOrchid"))) 
 '(mu4e-url-number-face ((t :inherit mu4e-rw-default :weight bold))) 
 '(mu4e-attach-number-face ((t :inherit mu4e-rw-default :weight bold :foreground "Blue"))) 

;; lists (headers) group 
 '(mu4e-list-default ((t :inherit mu4e-basic-face))) ;; basic list face from where lists inherits 
 '(mu4e-draft-face ((t :inherit mu4e-list-default))) 
 '(mu4e-flagged-face ((t :inherit mu4e-list-default :weight bold :foreground "Black"))) 
 '(mu4e-forwarded-face ((t :inherit mu4e-list-default))) 
 '(mu4e-list-default-face ((t :inherit mu4e-list-default))) 
 '(mu4e-title-face ((t :inherit mu4e-list-default))) 
 '(mu4e-trashed-face ((t :inherit mu4e-list-default))) 
 '(mu4e-warning-face ((t :inherit mu4e-list-default :foreground "OrangeRed1"))) 
 '(mu4e-modeline-face ((t :inherit mu4e-list-default))) 
 '(mu4e-moved-face ((t :inherit mu4e-list-default))) 
 '(mu4e-ok-face ((t :inherit mu4e-list-default :foreground "ForestGreen"))) 
 '(mu4e-read-face ((t :inherit mu4e-list-default :foreground "Gray80"))) 
 '(mu4e-region-code-face ((t :inherit mu4e-list-default :background "Gray25"))) 
 '(mu4e-replied-face ((t :inherit mu4e-list-default :foreground "Black"))) 
 '(mu4e-unread-face ((t :inherit mu4e-list-default :foreground "Blue"))) 
 '(mu4e-highlight-face ((t :inherit mu4e-unread-face))) 

 '(mu4e-special-header-value-face ((t :inherit mu4e-contact-face))) 
 '(mu4e-header-key-face ((t :inherit mu4e-contact-face :foreground "Gray50"))) 
 '(mu4e-header-value-face ((t :inherit mu4e-contact-face))) 
 '(message-cited-text ((t :inherit mu4e-rw-default :foreground "Gray10")))

(if (string= system-name "zuni") 
(progn

(defvar xah-filelist nil "alist for files i need to open frequently. Key is a short abbrev, Value is file path.")
(setq xah-filelist
      '(
        ("z" . "~/ZH_tmp/" )
        ("k " . "~/BK/" )
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
       ("z" . "~/ZH_tmp/" )
        ("k " . "~/BK/" )
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
)

(defun z/dired-jump-folders  (openCode)
  "Prompt to open a file from a pre-defined set."
  (interactive
   (list (ido-completing-read "Open:" (mapcar (lambda (x) (car x)) xah-filelist)))
   )
  (find-file (cdr (assoc openCode xah-filelist)) ) )

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

(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))

(csetq ediff-window-setup-function 'ediff-setup-windows-plain)

(csetq ediff-split-window-function 'split-window-horizontally)

(csetq ediff-diff-options "-w")

(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-mode-hook 'ora-ediff-hook)

(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
