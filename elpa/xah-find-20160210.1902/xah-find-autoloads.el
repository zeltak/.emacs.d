;;; xah-find-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "xah-find" "xah-find.el" (22209 10941 873410
;;;;;;  187000))
;;; Generated autoloads from xah-find.el

(autoload 'xah-find-count "xah-find" "\
Report how many occurrences of a string, of a given dir.
Similar to `rgrep', but written in pure elisp.
Result is shown in buffer *xah-find output*.
Case sensitivity is determined by `case-fold-search'. Call `toggle-case-fold-search' to change.
\\{xah-find-keymap}

\(fn ΦSEARCH-STR ΦCOUNT-EXPR ΦCOUNT-NUMBER ΦINPUT-DIR ΦPATH-REGEX)" t nil)

(autoload 'xah-find-text "xah-find" "\
Report files that contain string.
By default, not case sensitive, and print surrounding text.
If `universal-argument' is called first, prompt to ask.
Result is shown in buffer *xah-find output*.
\\{xah-find-keymap}

\(fn ΦSEARCH-STR1 ΦINPUT-DIR ΦPATH-REGEX ΦFIXED-CASE-SEARCH-P ΦPRINTCONTEXT-P)" t nil)

(autoload 'xah-find-replace-text "xah-find" "\
Find/Replace string in all files of a directory.
Search string can span multiple lines.
No regex.

Backup, if requested, backup filenames has suffix with timestamp, like this: ~xf20150531T233826~

Result is shown in buffer *xah-find output*.
\\{xah-find-keymap}

\(fn ΦSEARCH-STR ΦREPLACE-STR ΦINPUT-DIR ΦPATH-REGEX ΦWRITE-TO-FILE-P ΦFIXED-CASE-SEARCH-P ΦFIXED-CASE-REPLACE-P &optional ΦBACKUP-P)" t nil)

(autoload 'xah-find-text-regex "xah-find" "\
Report files that contain a string pattern, similar to `rgrep'.
Result is shown in buffer *xah-find output*.
\\{xah-find-keymap}

\(fn ΦSEARCH-REGEX ΦINPUT-DIR ΦPATH-REGEX ΦFIXED-CASE-SEARCH-P ΦPRINT-CONTEXT-LEVEL)" t nil)

(autoload 'xah-find-replace-text-regex "xah-find" "\
Find/Replace by regex in all files of a directory.

Backup, if requested, backup filenames has suffix with timestamp, like this: ~xf20150531T233826~

When called in lisp code:
ΦREGEX is a regex pattern.
ΦREPLACE-STR is replacement string.
ΦINPUT-DIR is input directory to search (includes all nested subdirectories).
ΦPATH-REGEX is a regex to filter file paths.
ΦWRITE-TO-FILE-P, when true, write to file, else, print a report of changes only.
ΦFIXED-CASE-SEARCH-P sets `case-fold-search' for this operation.
ΦFIXED-CASE-REPLACE-P if true, then the letter-case in replacement is literal. (this is relevant only if ΦFIXED-CASE-SEARCH-P is true.)
Result is shown in buffer *xah-find output*.
\\{xah-find-keymap}

\(fn ΦREGEX ΦREPLACE-STR ΦINPUT-DIR ΦPATH-REGEX ΦWRITE-TO-FILE-P ΦFIXED-CASE-SEARCH-P ΦFIXED-CASE-REPLACE-P)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; xah-find-autoloads.el ends here
