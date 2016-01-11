;;; buffer-flip-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "buffer-flip" "buffer-flip.el" (22162 37361
;;;;;;  717551 674000))
;;; Generated autoloads from buffer-flip.el

(defvar buffer-flip-mode nil "\
Non-nil if Buffer-Flip mode is enabled.
See the command `buffer-flip-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `buffer-flip-mode'.")

(custom-autoload 'buffer-flip-mode "buffer-flip" nil)

(autoload 'buffer-flip-mode "buffer-flip" "\
A global minor mode that streamlines the operation of
switching between recent buffers, with an emphasis on minimizing
keystrokes.  Inspired by the Alt-Tab convention in Windows, it
keeps the most recently used buffers on the top of the stack.
Depends on `key-chord-mode'.

By default, the key chord to begin flipping through buffers is
\"u8\".  You can customize these keys with the variable
`buffer-flip-keys'.

\"u\" and \"8\" are roughly analogous to Alt and Tab,
respectively.  To begin cycling through the buffers, press u and
8 at the same time or in rapid succession, `key-chord' style.
This begins the flipping process by switching to the most
recently used buffer.  At this point, pressing \"8\" by itself
will continue to cycle through the buffer stack, more recent
buffers first.  Pressing * (shift-8 on an English keyboard) will
cycle in the opposite direction.  Just begin working in the
current buffer to stop cycling.  Doing so places the current
buffer on top of the stack.  C-g cancels cycling and restores the
buffer you were in before, analagous to Esc when cycling in
Windows.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; buffer-flip-autoloads.el ends here
