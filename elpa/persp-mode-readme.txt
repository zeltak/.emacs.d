Based on perspective.el by Nathan Weizenbaum
 (http://github.com/nex3/perspective-el) but perspectives shared
  among frames + ability to save/restore perspectives to/from file
   and it less buggy(as for me).

Home: https://github.com/Bad-ptr/persp-mode.el

Installation:

From MELPA: M-x package-install RET persp-mode RET
From file: M-x package-install-file RET 'path to this file' RET
Or put this file into your load-path.

Configuration:

When installed through package-install:
(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil)
  ;; switch off animation of restoring window configuration
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

When installed without generating autoloads file:
(with-eval-after-load "persp-mode"
  (setq wg-morph-on nil)
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))
(require 'persp-mode)

Dependencies:

Ability to save/restore window configurations from/to file
 for emacs versions < 24.4 depends on
  workgroups.el(https://github.com/tlh/workgroups.el)

Keys:

s -- create/switch to perspective.
r -- rename perspective.
c -- kill perspective
(if you kill 'nil(initial or ~main~)' persp -- it'll kill all opened buffers).
a -- add buffer to perspective.
t -- switch to buffer without adding it to current perspective.
i -- import all buffers from another perspective.
k -- remove buffer from perspective.
w -- save perspectives to file.
l -- load perspectives from file.

These key sequences must follow `persp-keymap-prefix' which you can customize
 (by default it is 'C-c p' in older releases it was 'C-x x')
  so if you want to invoke the < s - create/switch perspective > command
   you must first type prefix ('C-c p') and then 's'(full sequence is C-c p s).

If you want to bind new key for persp-mode, use `persp-key-map`:
 `(define-key persp-key-map (kbd ...) ...)`.

If you kill buffer with 'C-x k' it will be killed only if it belongs to
 a single perspective, otherwise it'l be just removed from current perspective.
But if you kill buffer from 'none'(nil or main) perspective --
 it will be removed from all perspectives and then killed.


Customization:

M-x: customize-group RET persp-mode RET
