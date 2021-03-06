;;; elfeed-lib.el --- misc functions for elfeed -*- lexical-binding: t; -*-

;; This is free and unencumbered software released into the public domain.

;;; Commentary:

;; These are general functions that aren't specific to web feeds. It's
;; a library of useful functions to Elfeed.

;;; Code:

(require 'xml)
(require 'cl-lib)
(require 'time-date)
(require 'url-parse)

(defun elfeed-expose (function &rest args)
  "Return an interactive version of FUNCTION, 'exposing' it to the user."
  (lambda () (interactive) (apply function args)))

(defun elfeed-goto-line (n)
  "Like `goto-line' but for non-interactive use."
  (goto-char (point-min))
  (forward-line (1- n)))

(defun elfeed-kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun elfeed-kill-line ()
  "Clear out the current line without touching anything else."
  (beginning-of-line)
  (let ((start (point)))
    (end-of-line)
    (delete-region start (point))))

(defun elfeed-time-duration (time)
  "Turn a time expression into a number of seconds. Uses
`timer-duration' but allows a bit more flair."
  (if (numberp time)
      time
    (when (string-match-p "[[:alpha:]]" time)
      (let ((clean (replace-regexp-in-string "\\(ago\\|old\\|-\\)" " " time)))
        (timer-duration clean)))))

(defun elfeed-looks-like-url-p (string)
  "Return true if STRING looks like it could be a URL."
  (and (stringp string)
       (not (string-match-p "[ \n\t\r]" string))
       (not (null (url-type (url-generic-parse-url string))))))

(defun elfeed-format-column (string width &optional align)
  "Return STRING truncated or padded to WIDTH following ALIGNment.
Align should be a keyword :left or :right."
  (if (<= width 0)
      ""
    (format (format "%%%s%d.%ds" (if (eq align :left) "-" "") width width)
            string)))

(defun elfeed-clamp (min value max)
  "Clamp a value between two values."
  (min max (max min value)))

(defun elfeed-valid-regexp-p (regexp)
  "Return t if REGEXP is a valid REGEXP."
  (ignore-errors
    (prog1 t
      (string-match-p regexp ""))))

(defun elfeed-cleanup (name)
  "Trim trailing and leading spaces and collapse multiple spaces."
  (let ((trim (replace-regexp-in-string "[\n\t]+" " " (or name ""))))
    (replace-regexp-in-string "^ +\\| +$" "" trim)))

(defun elfeed-parse-simple-iso-8601 (string)
  "Attempt to parse STRING as a simply formatted ISO 8601 date.
Examples: 2015-02-22, 2015-02, 20150222"
  (save-match-data
    (let ((re "^\\([0-9]\\{4\\}\\)-?\\([0-9]\\{2\\}\\)-?\\([0-9]\\{2\\}\\)?$")
          (clean (elfeed-cleanup string)))
      (when (string-match re clean)
        (let ((year (string-to-number (match-string 1 clean)))
              (month (string-to-number (match-string 2 clean)))
              (day (string-to-number (or (match-string 3 clean) "1"))))
          (when (and (>= year 1900) (< year 2200))
            (float-time (encode-time 0 0 0 day month year t))))))))

(defun elfeed-new-date-for-entry (old-date new-date)
  "Decide entry date, given an existing date (nil for new) and a new date.
Existing entries' dates are unchanged if the new date is not
parseable. New entries with unparseable dates default to the
current time."
  (or (elfeed-float-time new-date)
      old-date
      (float-time)))

(defun elfeed-float-time (date)
  "Like `float-time' but accept anything reasonable for DATE.
Defaults to nil if DATE could not be parsed. Date is allowed to
be relative to now (`elfeed-time-duration')."
  (cl-typecase date
    (string
     (let ((iso-8601 (elfeed-parse-simple-iso-8601 date)))
       (if iso-8601
           iso-8601
         (let ((duration (elfeed-time-duration date)))
           (if duration
               (- (float-time) duration)
             (let ((time (ignore-errors (date-to-time date))))
               (if (equal time '(14445 17280)) ; date-to-time silently failed
                   nil
                 (float-time time))))))))
    (integer date)
    (otherwise nil)))

(defun elfeed-xml-parse-region (&optional beg end buffer parse-dtd parse-ns)
  "Decode (if needed) and parse XML file. Uses coding system from
XML encoding declaration."
  (unless beg (setq beg (point-min)))
  (unless end (setq end (point-max)))
  (setf (point) beg)
  (when (re-search-forward
         "<\\?xml.*?encoding=[\"']\\([^\"']+\\)[\"'].*?\\?>" nil t)
    (let ((coding-system (intern-soft (downcase (match-string 1)))))
      (when (ignore-errors (check-coding-system coding-system))
        (let ((mark-beg (make-marker))
              (mark-end (make-marker)))
          ;; Region changes with encoding, so use markers to track it.
          (set-marker mark-beg beg)
          (set-marker mark-end end)
          (set-buffer-multibyte t)
          (recode-region mark-beg mark-end coding-system 'raw-text)
          (setf beg (marker-position mark-beg)
                end (marker-position mark-end))))))
  (xml-parse-region beg end buffer parse-dtd parse-ns))

(defun elfeed-xml-unparse (element)
  "Inverse of `elfeed-xml-parse-region', writing XML to the buffer."
  (cl-destructuring-bind (tag attrs . body) element
    (insert (format "<%s" tag))
    (dolist (attr attrs)
      (cl-destructuring-bind (key . value) attr
        (insert (format " %s='%s'" key (xml-escape-string value)))))
    (if (null body)
        (insert "/>")
      (insert ">")
      (dolist (sub body)
        (if (stringp sub)
            (insert (xml-escape-string sub))
          (elfeed-xml-unparse sub)))
      (insert (format "</%s>" tag)))))

(defun elfeed-directory-empty-p (dir)
  "Return non-nil if DIR is empty."
  (null (cddr (directory-files dir))))

(defun elfeed-slurp (file &optional literally)
  "Return the contents of FILE as a string."
  (with-temp-buffer
    (if literally
        (insert-file-contents-literally file)
      (insert-file-contents file))
    (buffer-string)))

(cl-defun elfeed-spit (file string &key fsync append (encoding 'utf-8))
  "Write STRING to FILE."
  (let ((coding-system-for-write encoding)
        (write-region-inhibit-fsync (not fsync)))
    (with-temp-buffer
      (insert string)
      (write-region nil nil file append 0))))

(defvar elfeed-gzip-supported-p--cache :unknown
  "To avoid running the relatively expensive test more than once.")

(defun elfeed-gzip-supported-p ()
  "Return non-nil if `auto-compression-mode' can handle gzip."
  (if (not (eq elfeed-gzip-supported-p--cache :unknown))
      elfeed-gzip-supported-p--cache
    (setf elfeed-gzip-supported-p--cache
          (and (executable-find "gzip")
               (ignore-errors
                 (save-window-excursion
                   (let ((file (make-temp-file "gziptest" nil ".gz"))
                         (data (cl-loop for i from 32 to 3200
                                        collect i into chars
                                        finally
                                        (return (apply #'string chars)))))
                     (unwind-protect
                         (progn
                           (elfeed-spit file data)
                           (and (string= data (elfeed-slurp file))
                                (not (string= data (elfeed-slurp file t)))))
                       (delete-file file)))))))))

(defun elfeed-libxml-supported-p ()
  "Return non-nil if `libxml-parse-html-region' is available."
  (with-temp-buffer
    (insert "<html></html>")
    (and (fboundp 'libxml-parse-html-region)
         (not (null (libxml-parse-html-region (point-min) (point-max)))))))

(defun elfeed-keyword->symbol (keyword)
  "If a keyword, convert KEYWORD into a plain symbol (remove the colon)."
  (if (keywordp keyword)
      (intern (substring (symbol-name keyword) 1))
    keyword))

(defun elfeed-resize-vector (vector length)
  "Return a copy of VECTOR set to size LENGTH."
  (let ((new-vector (make-vector length nil)))
    (prog1 new-vector ; don't use dotimes result (bug#16206)
      (dotimes (i (min (length new-vector) (length vector)))
        (setf (aref new-vector i) (aref vector i))))))

(defun elfeed-readable-p (value)
  "Return non-nil if VALUE can be serialized."
  (condition-case _
      (prog1 t (read (prin1-to-string value)))
    (error nil)))

(defun elfeed-strip-properties (string)
  "Return a copy of STRING with all properties removed.
If STRING is nil, returns nil."
  (when string
    (let ((copy (copy-sequence string)))
      (prog1 copy
        (set-text-properties 0 (length copy) nil copy)))))

(defun elfeed-clipboard-get ()
  "Try to get a sensible value from the system clipboard.
On systems running X, it will try to use the PRIMARY selection
first, then fall back onto the standard clipboard like other
systems."
  (elfeed-strip-properties
   (or (and (fboundp 'x-get-selection-value)
            (funcall 'x-get-selection-value))
       (and (functionp interprogram-paste-function)
            (funcall interprogram-paste-function))
       (and (fboundp 'w32-get-clipboard-data)
            (funcall 'w32-get-clipboard-data))
       (current-kill 0 :non-destructively))))

(defun elfeed-move-to-first-empty-line ()
  "Place point after first blank line, for use with `url-retrieve'.
If no such line exists, point is left in place."
  (let ((start (point)))
    (setf (point) (point-min))
    (unless (search-forward-regexp "^$" nil t)
      (setf (point) start))))

(defun elfeed--shuffle (seq)
  "Destructively shuffle SEQ."
  (let ((n (length seq)))
    (prog1 seq  ; don't use dotimes result (bug#16206)
      (dotimes (i n)
        (cl-rotatef (elt seq i) (elt seq (+ i (cl-random (- n i)))))))))

(defun elfeed-split-ranges-to-numbers (str n)
  "Convert STR containing enclosure numbers into a list of numbers.
STR is a string; N is the highest possible number in the list.
This includes expanding e.g. 3-5 into 3,4,5.  If the letter
\"a\" ('all')) is given, that is expanded to a list with numbers [1..n]."
  (let ((str-split (split-string str))
        beg end list)
    (dolist (elem str-split list)
      ;; special number "a" converts into all enclosures 1-N.
      (when (equal elem "a")
        (setf elem (concat "1-" (int-to-string n))))
      (if (string-match "\\([0-9]+\\)-\\([0-9]+\\)" elem)
          ;; we have found a range A-B, which needs converting
          ;; into the numbers A, A+1, A+2, ... B.
          (progn
            (setf beg (string-to-number (match-string 1 elem))
                  end (string-to-number (match-string 2 elem)))
            (while (<= beg end)
              (setf list (nconc list (list beg))
                    beg (1+ beg))))
        ;; else just a number
        (push (string-to-number elem) list)))))

(provide 'elfeed-lib)

;;; elfeed-lib.el ends here
