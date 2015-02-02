;;; m-buffer-macro.el --- Create and dispose of markers -*- lexical-binding: t -*-

;;; Header:

;; This file is not part of Emacs

;; The contents of this file are subject to the GPL License, Version 3.0.

;; Copyright (C) 2014, Phillip Lord, Newcastle University

;; This program is free software: you can redistribute it and/or modify
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

;; Macro support for markers with post-cleanup.

;;; Code:

;; #+begin_src emacs-lisp
(defmacro m-buffer-with-markers (varlist &rest body)
  "Bind variables after VARLIST then eval BODY.
All variables should contain markers or collections of markers.
All markers are niled after BODY."
  ;; indent let part specially, and debug like let
  (declare (indent 1)(debug let))
  ;; so, create a rtn var with make-symbol (for hygene)
  (let* ((rtn-var (make-symbol "rtn-var"))
         (marker-vars
          (mapcar 'car varlist))
         (full-varlist
          (append
           varlist
           `((,rtn-var
              (progn
                ,@body))))))
    `(let* ,full-varlist
       (m-buffer-nil-marker
        (list ,@marker-vars))
       ,rtn-var)))

(defmacro m-buffer-with-current-marker
    (marker &rest body)
  "At MARKER location run BODY."
  (declare (indent 1) (debug t))
  `(with-current-buffer
       (marker-buffer ,marker)
     (save-excursion
       (goto-char ,marker)
       ,@body)))

(defmacro m-buffer-with-current-position
    (buffer location &rest body)
  "In BUFFER at LOCATION, run BODY."
  (declare (indent 2)
           (debug t))
  `(with-current-buffer
       ,buffer
     (save-excursion
       (goto-char ,location)
      ,@body)))

(defmacro m-buffer-with-current-location
    (location &rest body)
  "At LOCATION, run BODY.
LOCATION should be a list. If a one element list, it is a marker.
If a two element, it is a buffer and position."
  (declare (indent 1) (debug t))
  ;; multiple eval of location!
  (let ((loc (make-symbol "loc")))
    `(let ((,loc ,location))
       (if (= 1 (length ,loc))
           (m-buffer-with-current-marker
               (nth 0 ,loc)
             ,@body)
         (if (= 2 (length ,loc))
             (m-buffer-with-current-position
                 (nth 0 ,loc)
                 (nth 1 ,loc)
               ,@body)
           (t
            (error "m-buffer-with-current-location requires a list of one or two elements")))))))


(provide 'm-buffer-macro)
;; #+end_src

;;; m-buffer-macro.el ends here
