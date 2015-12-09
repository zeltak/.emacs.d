;;; elfeed-goodies-new-entry-hooks.el --- new-entry hooks for Elfeed goodies
;;
;; Copyright (c) 2015 Gergely Nagy
;;
;; Author: Gergely Nagy
;; URL: https://github.com/algernon/elfeed-goodies
;;
;; This file is NOT part of GNU Emacs.
;;
;;; License: GPLv3+

;;; Code:

(require 'elfeed-goodies)
(require 'cl-lib)

(defcustom elfeed-goodies/html-decode-title-tags '()
  "Decode HTML entities in the titles of entries tagged with any of these tags."
  :group 'elfeed-goodies
  :type '(repeat symbol))

(defun decode-entities (html)
  (with-temp-buffer
    (save-excursion (insert html))
    (xml-parse-string)))

(defun elfeed-goodies/html-decode-title (entry)
  (let ((tags (elfeed-deref (elfeed-entry-tags entry))))
    (if (cl-intersection tags elfeed-goodies/html-decode-title-tags)
        (let* ((original (elfeed-deref (elfeed-entry-title entry)))
               (replace (decode-entities original)))
          (setf (elfeed-entry-title entry) replace)))))

(provide 'elfeed-goodies-new-entry-hooks)

;;; elfeed-goodies-new-entry-hooks.el ends here
