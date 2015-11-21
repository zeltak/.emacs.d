;;; buffer-flip-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "buffer-flip" "buffer-flip.el" (22092 39901
;;;;;;  127875 858000))
;;; Generated autoloads from buffer-flip.el

(defvar buffer-flip-mode nil "\
Non-nil if Buffer-Flip mode is enabled.
See the command `buffer-flip-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `buffer-flip-mode'.")

(custom-autoload 'buffer-flip-mode "buffer-flip" nil)

(autoload 'buffer-flip-mode "buffer-flip" "\
A global minor mode that lets you flip through buffers like
Alt-Tab in Windows, keeping the most recently used buffers on
the top of the stack.  Depends on `key-chord-mode'.

By default, the key chord to begin flipping through buffers is
\"u8\".  You can customize these keys with the variable
`buffer-flip-keys'.

\"u\" and \"8\" are roughly analogous to Alt and Tab,
respectively.  To begin cycling through the buffers, press u and
8 at the same time or in rapid succession, `key-chord' style.
This will flip to the second buffer in the stack returned by
`buffer-list'.  Repeatedly pressing \"8\" will continue to cycle
through the buffers.  Pressing * (shift-8) will cycle in the
opposite direction.  Just begin working in a buffer to stop
cycling.  C-g cancels cycling and restores the buffer you were in
before, analagous to Esc when cycling in Windows.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; buffer-flip-autoloads.el ends here
