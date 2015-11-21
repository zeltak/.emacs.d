;;; bind-map.el --- Bind personal keymaps in multiple locations -*- lexical-binding: t; -*-

;; Copyright (C) 2015 Justin Burkett

;; Author: Justin Burkett <justin@burkett.cc>
;; URL: https://github.com/justbur/emacs-bind-map
;; Package-Version: 20151117.1827
;; Version: 0.0
;; Keywords:
;; Package-Requires: ((emacs "24.3"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; bind-map is an Emacs package providing the macro `bind-map' which can be used
;; to make a keymap available across different "leader keys" including ones tied
;; to evil states. It is essentially a generalization of the idea of a leader
;; key as used in vim or the Emacs https://github.com/cofi/evil-leader package,
;; and allows for an arbitrary number of "leader keys". This is probably best
;; explained with an example.

;; (bind-map my-lisp-map
;;   :keys ("M-m")
;;   :evil-keys ("SPC")
;;   :evil-states (normal visual)
;;   :major-modes (emacs-lisp-mode
;;                 lisp-interaction-mode
;;                 lisp-mode))

;; This will take my-lisp-map and make it available under the prefixes (or
;; leaders) M-m and SPC, where the latter is only bound in evil's normal or
;; visual state (defaults in `bind-map-default-evil-states') when one of the
;; specified major mode is active (there is no need to make sure the respective
;; modes' packages are loaded before this declaration). It is also possible to
;; make the bindings conditional on minor modes being loaded, or a mix of major
;; and minor modes. If no modes are specified, the relevant global maps are
;; used. See the docstring of `bind-map' for more options.

;; The idea behind this package is that you want to organize your personal
;; bindings in a series of keymaps separate from built-in mode maps. You can
;; simply add keys using the built-in `define-key' to my-lisp-map for example,
;; and a declaration like the one above will take care of ensuring that these
;; bindings are available in the correct places.

;; Binding keys in the maps

;; You may use the built-in `define-key' which will function as intended.
;; `bind-key' (part of https://github.com/jwiegley/use-package) is another
;; option. For those who want a different interface, the following functions are
;; also provided, which both just use `define-key' internally, but allow for
;; multiple bindings without much syntax.

;; (bind-map-set-keys my-lisp-map
;;   "c" 'compile
;;   "C" 'check
;;   ;; ...
;;   )
;; (bind-map-set-key-defaults my-lisp-map
;;   "c" 'compile
;;   "C" 'check
;;   ;; ...
;;   )

;; The second function only adds the bindings if there is no existing binding
;; for that key. It is probably only useful for shared configurations, where you
;; want to provide a default binding but don't want that binding to overwrite
;; one made by the user. Note the keys in both functions are strings that are
;; passed to `kbd' before binding them.

;;; Code:

(defgroup bind-map nil
  "Bind personal keymaps in multiple locations."
  :group 'emacs)

(defcustom bind-map-default-evil-states '(normal motion visual)
  "Default states for evil bindings."
  :group 'bind-map)

(defcustom bind-map-default-map-suffix "-bm-map"
  "Default suffix to use for `bind-map-for-major-mode' and
`bind-map-for-minor-mode'."
  :group 'bind-map)

;;;###autoload
(defmacro bind-map (map &rest args)
  "Bind keymap MAP in multiple locations.
If MAP is not defined, this will create a new sparse keymap with
the name MAP. Supports binding in evil states and conditioning
the bindings on major and/or minor modes being active. The
options are controlled through the keyword arguments ARGS, all of
which are optional.

:keys (KEY1 KEY2 ...)

The keys to use for the leader binding. These are strings
suitable for use in `kbd'.

:evil-keys (KEY1 KEY2 ...)

Like :keys but these bindings are only active in certain evil
states.

:evil-states (STATE1 STATE2 ...)

Symbols representing the states to use for :evil-keys. If nil,
use `bind-map-default-evil-states'.

:major-modes (MODE1 MODE2 ...)

If specified, the keys will only be bound when these major modes
are active. If both :major-modes and :minor-modes are nil or
unspecified the bindings are global.

:minor-modes (MODE1 MODE2 ...)

If specified, the keys will only be bound when these minor modes
are active. If both :major-modes and :minor-modes are nil or
unspecified the bindings are global.

:prefix-cmd COMMAND-NAME

Declare a prefix command for MAP named COMMAND-NAME."
  (let* ((root-map-sym (intern (format "%s-root-map" map)))
         (major-mode-list (intern (format "%s-major-modes" map)))
         (activate (intern (format "%s-activate" map)))
         (activate-func (intern (format "%s-activate-function" map)))
         (prefix-cmd (or (plist-get args :prefix-cmd)
                         (intern (format "%s-prefix" map))))
         (keys (mapcar 'bind-map-kbd (plist-get args :keys)))
         (evil-keys (mapcar 'bind-map-kbd (plist-get args :evil-keys)))
         (evil-states (or (plist-get args :evil-states)
                          bind-map-default-evil-states))
         (minor-modes (plist-get args :minor-modes))
         (major-modes (plist-get args :major-modes)))
    `(progn
       (defvar ,map (make-sparse-keymap))
       (setq ,prefix-cmd ,map)
       (setf (symbol-function ',prefix-cmd) ,map)

       (when ',minor-modes
         (defvar ,root-map-sym (make-sparse-keymap))
         (dolist (mode ',minor-modes)
           (push (cons mode ,root-map-sym) minor-mode-map-alist)))

       (when ',major-modes
         (defvar ,root-map-sym (make-sparse-keymap))
         (defvar ,major-mode-list '())
         (defvar-local ,activate nil)
         (push (cons ',activate ,root-map-sym) minor-mode-map-alist)
         (setq ,major-mode-list (append ,major-mode-list ',major-modes))
         (defun ,activate-func ()
           (setq ,activate (not (null (member major-mode ,major-mode-list)))))
         (add-hook 'change-major-mode-after-body-hook ',activate-func))

       (if (or ',minor-modes ',major-modes)
           ;;bind keys in root-map
           (progn
             (dolist (key ',keys)
               (define-key ,root-map-sym key ',prefix-cmd))
             (when ',evil-keys
               (bind-map-evil-define-key
                ',evil-states ,root-map-sym ',evil-keys ',prefix-cmd)))
         ;;bind in global maps
         (dolist (key ',keys)
           (global-set-key key ',prefix-cmd))
         (when ',evil-keys
           (bind-map-evil-define-key
            ',evil-states nil ',evil-keys ',prefix-cmd))))))
(put 'bind-map 'lisp-indent-function 'defun)

;;;###autoload
(defmacro bind-map-for-major-mode (major-mode-sym &rest args)
  "Short version of `bind-map' if you want to bind a map for a
single major mode. MAJOR-MODE-SYM is the unquoted symbol
representing a major mode. This macro makes the call

\(bind-map map-name
  :major-modes \(MAJOR-MODE-SYM\)
  ARGS\)

where ARGS should include :keys or :evil-keys. The name of the
generated keymap is returned, which is MAJOR-MODE-SYM concatenated
with `bind-map-default-map-suffix'."
  (let ((map-name (intern (concat (symbol-name major-mode-sym)
                                  bind-map-default-map-suffix))))
    `(progn
       (bind-map ,map-name
         :major-modes (,major-mode-sym)
         ,@args)
       ',map-name)))
(put 'bind-map-for-major-mode 'lisp-indent-function 'defun)

;;;###autoload
(defmacro bind-map-for-minor-mode (minor-mode-sym &rest args)
  "Short version of `bind-map' if you want to bind a map for a
single minor mode. MINOR-MODE-SYM is the unquoted symbol
representing a minor mode. This macro makes the call

\(bind-map map-name
  :minor-modes \(MINOR-MODE-SYM\)
  ARGS\)

where ARGS should include :keys or :evil-keys. The name of the
generated keymap is returned, which is MINOR-MODE-SYM
concatenated with `bind-map-default-map-suffix'."
  (let ((map-name (intern (concat (symbol-name minor-mode-sym)
                                  bind-map-default-map-suffix))))
    `(progn
       (bind-map ,map-name
         :minor-modes (,minor-mode-sym)
         ,@args)
       ',map-name)))
(put 'bind-map-for-minor-mode 'lisp-indent-function 'defun)

(defun bind-map-kbd (key)
  (if (stringp key) (kbd key) (kbd (eval key))))

(defun bind-map-evil-define-key (states map keys def)
  "Version of `evil-define-key' that binds DEF across multiple
STATES and KEYS."
  (require 'evil)
  (dolist (state states)
    (dolist (key keys)
      (if map
          (eval
           `(evil-define-key ',state ',map ,key ',def))
        (eval
         `(evil-global-set-key ',state ,key ',def))))))

;;;###autoload
(defun bind-map-set-keys (map key def &rest bindings)
  "Add a series of bindings to MAP.
BINDINGS is a series of KEY DEF pairs. Each KEY should be a
string suitable for `kbd'."
  (while key
    (define-key map (bind-map-kbd key) def)
    (setq key (pop bindings) def (pop bindings))))
(put 'bind-map-set-keys 'lisp-indent-function 'defun)

;;;###autoload
(defun bind-map-set-key-defaults (map key def &rest bindings)
  "Add a series of default bindings to MAP.
Default bindings never override existing ones. BINDINGS is a
series of KEY DEF pairs. Each KEY should be a string suitable for
`kbd'."
  (while key
    (unless (lookup-key map (bind-map-kbd key))
      (define-key map (bind-map-kbd key) def))
    (setq key (pop bindings) def (pop bindings))))
(put 'bind-map-set-key-defaults 'lisp-indent-function 'defun)

(provide 'bind-map)
;;; bind-map.el ends here
