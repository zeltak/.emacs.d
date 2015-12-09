;;; elfeed-goodies.el --- Elfeed goodies
;;
;; Copyright (c) 2015 Gergely Nagy
;;
;; Author: Gergely Nagy
;; URL: https://github.com/algernon/elfeed-goodies
;; Package-Requires: ((popwin "1.0.0") (powerline "2.2") (elfeed "20151201.1742") (cl-lib "0.5"))
;;
;; This file is NOT part of GNU Emacs.
;;
;;; Commentary:
;;
;; Various bits and pieces to enhance the Elfeed user experience:
;;
;;  * Includes an adaptive, powerline-based header for the `*elfeed-search*'
;;    buffer with a matching entry format.
;;  * A split-pane setup.
;;  * A more compact, powerline-based `*elfeed-entry*' buffer.
;;  * A function to toggle the display of Elfeed logs in a popup window.
;;
;;; License: GPLv3+

;;; Code:

(provide 'elfeed-goodies)

(require 'elfeed-goodies-search-mode)
(require 'elfeed-goodies-show-mode)
(require 'elfeed-goodies-split-pane)
(require 'elfeed-goodies-new-entry-hooks)
(require 'elfeed-goodies-logging)

(defgroup elfeed-goodies nil
  "Customisation group for `elfeed-goodies'."
  :group 'comm)

(defcustom elfeed-goodies/powerline-separators t
  "Toggle powerline separator use on or off within Elfeed buffers.

When disabled, powerline will still be in use, but without separators."
  :group 'elfeed-goodies
  :type 'boolean)

(defun maybe-separator (separator-func face-left face-right)
  (if elfeed-goodies/powerline-separators
      (funcall separator-func face-left face-right)
    (powerline-raw " " face-left)))

;;;###autoload
(defun elfeed-goodies/setup ()
  "Setup Elfeed with extras:

* Adaptive header bar and entries.
* Header bar using powerline.
* Split pane view via popwin."
  (interactive)
  (add-hook 'elfeed-show-mode-hook #'elfeed-goodies/show-mode-setup)
  (add-hook 'elfeed-new-entry-hook #'elfeed-goodies/html-decode-title)
  (setq elfeed-search-header-function #'elfeed-goodies/search-header-draw
        elfeed-search-print-entry-function #'elfeed-goodies/entry-line-draw
        elfeed-show-entry-switch #'elfeed-goodies/switch-pane
        elfeed-show-entry-delete #'elfeed-goodies/delete-pane
        elfeed-show-refresh-function #'elfeed-goodies/show-refresh--plain))

;;; elfeed-goodies.el ends here
