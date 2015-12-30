;;; link-hint.el --- Use avy to open or copy visible urls.

;; Author: Lit Wakefield <noct@openmailbox.org>
;; URL: https://github.com/noctuid/link-hint.el
;; Package-Version: 20151228.1443
;; Keywords: url
;; Package-Requires: ((avy "0.3.0") (emacs "24.1"))
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; This packages gives commands for operating on visible links with avy. It is
;; inspired by link-hinting from vim-like browsers and browser plugins such as
;; pentadactyl. For example, `link-hint-open-link' will use avy to select and
;; open a link in the current buffer. A link can be a text, shr, mu4e or org
;; (htmlize) url. Mu4e attachments and mailto addresses, help mode links, and
;; info mode links are also considered to be links. The user can set
;; `link-hint-ignore-types' to can change what is considered a link. Commands
;; are also provided for copying links to the kill ring (and optionally the
;; clipboard and/or primary) and for opening multiple urls at once like with
;; pentadactyl's "g;".

;; For more information see the README in the github repo.

;;; Code:
(require 'avy)
(require 'url-util)
(require 'browse-url)
(unless (boundp 'link-hint-url-regexp)
  (require 'goto-addr))
(require 'ffap)
;; (require 'rx)

(defgroup link-hint nil
  "Gives commands for operating on visible links with avy."
  :group 'convenience
  :prefix 'link-hint)

(defcustom link-hint-url-regexp
  goto-address-url-regexp
  "Regexp used to determine what constitutes a text url.
Defaults to `goto-address-url-regxp'."
  :group 'link-hint
  :type 'regexp)

(defcustom link-hint-maybe-file-regexp
  (rx (or bol blank) (zero-or-one "~") "/" (1+ not-newline))
  "Regexp used to determine what constitutes a potential file link."
  :group 'link-hint
  :type 'regexp)

(defcustom link-hint-avy-style
  avy-style
  "Method for displaying avy overlays.
Defaults to `avy-style'."
  :group 'link-hint
  :type '(choice
          (const :tag "Pre" pre)
          (const :tag "At" at)
          (const :tag "At Full" at-full)
          (const :tag "Post" post)
          (const :tag "De Bruijn" de-bruijn)))

(defcustom link-hint-avy-keys
  avy-keys
  "Keys used for selecting urls.
Defaults to `avy-keys'."
  :group 'link-hint
  :type '(repeat :tag "Keys" (choice (character :tag "char"))))

(defconst link-hint-all-types
  '(text-url
    file-link
    shr-url
    htmlize-url
    mu4e-url
    mu4e-mailto
    mu4e-attachment
    help-link
    info-link
    package-description-link
    package-keyword-link
    package-install-link
    compilation-link
    woman-button-link
    other-button-link)
  "List containing all suported link types.")

(define-widget 'link-hint-link-type-set 'lazy
  "A set of link types supported by link-hint."
  :type '(set
          (const :tag "Text url" text-url)
          (const :tag "File link openable with ffap" file-link)
          (const :tag "Simple HTML Renderer url" shr-url)
          (const :tag "Htmlize (org mode) url" htmlize-url)
          (const :tag "Mu4e url" mu4e-url)
          (const :tag "Mu4e mailto address" mu4e-mailto)
          (const :tag "Mu4e attachment" mu4e-attachment)
          (const :tag "Help mode link" help-link)
          (const :tag "Info mode link" info-link)
          (const :tag "Package.el menu links" package-description-link)
          (const :tag "Package.el keyword buttons" package-keyword-link)
          (const :tag "Package.el install buttons" package-install-link)
          (const :tag "Compilation mode link" compilation-link)
          (const :tag "WoMan button link" woman-button-link)
          (const :tag "Other button link" other-button-link)))

(defcustom link-hint-ignore-types
  nil
  "Types to be ignored when selecting a url with avy."
  :group 'link-hint
  :type 'link-hint-link-type-set)

(defvar link-hint-copy-ignore-types
  '(help-link
    info-link
    package-description-link
    package-keyword-link
    package-install-link
    compilation-link
    woman-button-link
    other-button-link)
  "Link types that the copy action will ignore.
It defaults to the unsupported types.")

(defcustom link-hint-act-on-multiple-ignore-types
  '(file-link
    mu4e-mailto
    mu4e-attachment
    help-link
    info-link
    compilation-link
    woman-button-link
    other-button-link)
  "Types of links to ignore with commands that act on multiple visible links.
Thes commands are `link-hint-open-multiple-links' and
`link-hint-copy-multiple-links'."
  :group 'link-hint
  :type 'link-hint-link-type-set)

(defcustom link-hint-act-on-all-ignore-types
  '(file-link
    mu4e-mailto
    mu4e-attachment
    help-link
    info-link
    compilation-link
    woman-button-link
    other-button-link)
  "Types of links to ignore with commands that act on all visible links.
These commands are `link-hint-open-all-links' and
`link-hint-copy-all-links'."
  :group 'link-hint
  :type 'link-hint-link-type-set)

(defun link-hint--find-regexp (search-regexp &optional start-bound end-bound)
  "Find the first visible occurrence of SEARCH-REGEXP.
Only the range between just after START-BOUND and the END-BOUND will be
searched."
  (save-excursion
    (let* ((start-bound (or start-bound (window-start)))
           (end-bound (or end-bound (window-end)))
           match-pos)
      (goto-char start-bound)
      (right-char)
      (while (and (re-search-forward search-regexp end-bound t)
                  (setq match-pos (match-beginning 0))
                  (invisible-p match-pos)))
      (when (and match-pos
                 (not (invisible-p match-pos)))
        match-pos))))

(defun link-hint--next-regexp (search-regexp &optional end-bound)
  "Find the next visible occurrence of SEARCH-REGEXP.
Only the range between just after the point and END-BOUND will be searched."
  (link-hint--find-regexp search-regexp (point) end-bound))

(defun link-hint--find-file-link (&optional start-bound end-bound)
  "Find the first file link.
Only the range between just after START-BOUND and the END-BOUND will be
searched."
  (save-excursion
    (let ((start-bound (or start-bound (window-start)))
          (end-bound (or end-bound (window-end)))
          file-link-pos)
      (goto-char start-bound)
      (while (and
              (setq file-link-pos
                    (link-hint--find-regexp link-hint-maybe-file-regexp
                                            (point) end-bound))
              (progn
                (goto-char file-link-pos)
                (when (looking-at (rx blank))
                  (right-char)
                  (setq file-link-pos (point)))
                t)
              (not (ffap-file-at-point))))
      (when (and file-link-pos
                 (ffap-file-at-point))
        file-link-pos))))

(defun link-hint--next-file-link (&optional end-bound)
  "Find the next visible file link.
Only the range between just after the point and END-BOUND will be searched."
  (link-hint--find-file-link (point) end-bound))

;; only using for woman since need `next-single-char-property-change' (slow)
(defun link-hint--find-button (&optional start-bound end-bound)
  "Find the first visible button location.
Only the range between just after START-BOUND and the END-BOUND will be
searched."
  (save-excursion
    (let* ((start-bound (or start-bound (window-start)))
           (end-bound (or end-bound (window-end)))
           button
           button-pos)
      (goto-char start-bound)
      (while (and (setq button (next-button (point) nil))
                  (setq button-pos (button-start button))
                  (goto-char button-pos)
                  (< button-pos end-bound)
                  (invisible-p button-pos)))
      button-pos)))

(defun link-hint--next-button (&optional end-bound)
  "Find the next visible button location.
Only the range between just after the point and END-BOUND will be searched."
  (link-hint--find-button (point) end-bound))

(defun link-hint--find-property (property &optional start-bound end-bound)
  "Find visible location where PROPERTY exists.
Only the range from between just after the START-BOUND and the END-BOUND will be
searched."
  (save-excursion
    (let* ((start-bound (or start-bound (window-start)))
           (end-bound (or end-bound (window-end))))
      (goto-char start-bound)
      (while
          (and (goto-char (next-single-property-change (point) property
                                                       nil end-bound))
               ;; next-single-property returns limit if match not found
               (not (= (point) end-bound))
               (invisible-p (point))))
      (when (plist-get (text-properties-at (point)) property)
        (point)))))

(defun link-hint--next-property (property &optional end-bound)
  "Find the next visible location where PROPERTY exists.
Only the range from between just after the point and END-BOUND will be
searched."
  (link-hint--find-property property (point) end-bound))

(defun link-hint--find-property-with-value
    (property value &optional start-bound end-bound)
  "Find the first visible location where PROPERTY has VALUE.
Only the range from between just after the START-BOUND and the END-BOUND will be
searched. When VALUE is not found, nil will be returned."
  (save-excursion
    (let ((start-bound (or start-bound (window-start)))
          (end-bound (or end-bound (window-end)))
          (next-change-pos (next-single-property-change start-bound property
                                                        nil end-bound))
          last-change-pos
          match-pos)
      (while (and (not match-pos)
                  (not (equal next-change-pos last-change-pos)))
        (setq last-change-pos next-change-pos)
        (goto-char next-change-pos)
        (if (and (equal (plist-get (text-properties-at (point)) property)
                        value)
                 (not (invisible-p (point))))
            (setq match-pos (point))
          (setq next-change-pos
                (next-single-property-change (point) property
                                             nil end-bound))))
      (when match-pos
        match-pos))))

(defun link-hint--next-property-with-value (property value &optional end-bound)
  "Find the first visible location where PROPERTY has VALUE.
Only the range from between just after the point and the END-BOUND will be
searched. When VALUE is not found, nil will be returned."
  (link-hint--find-property-with-value property value (point) end-bound))

(defun link-hint--not-ignored-p (type)
  "Return t if TYPE is not ignored else nil."
  (not (member type link-hint-ignore-types)))

(defun link-hint--min (numbers)
  "Find the minimum from the list NUMBERS, ignoring nil values."
  (let (number-list
        number)
    (while (> (length numbers) 0)
      (setq number (pop numbers))
      (when number
        (push number number-list)))
    (when (> (length number-list) 0)
      (apply #'min number-list))))

;; TODO: reduce redundancy here
(defun link-hint--next-link-pos (&optional end-bound)
  "Find the closest visible link of all types that are not ignored.
Only the range between just after the point and END-BOUND will be searched."
  (let* ((end-bound (or end-bound (window-end)))
         (text-url-pos (when (link-hint--not-ignored-p 'text-url)
                         (link-hint--next-regexp link-hint-url-regexp
                                                 end-bound)))
         (file-link-pos (when (link-hint--not-ignored-p 'file-link)
                          (link-hint--next-file-link end-bound)))
         (shr-url-pos (when (link-hint--not-ignored-p 'shr-url)
                        (link-hint--next-property 'shr-url end-bound)))
         (htmlize-url-pos (when (link-hint--not-ignored-p 'htmlize-url)
                            (link-hint--next-property 'htmlize-link end-bound)))
         (mu4e-link-pos (link-hint--next-property 'mu4e-url end-bound))
         (mu4e-link-text (when mu4e-link-pos
                           (plist-get (text-properties-at mu4e-link-pos) 'mu4e-url)))
         (mu4e-url-pos
          (when (and mu4e-link-text
                     (link-hint--not-ignored-p 'mu4e-url)
                     (not (string-prefix-p "mailto" mu4e-link-text)))
            mu4e-link-pos))
         (mu4e-mailto-pos
          (when (and mu4e-link-text
                     (link-hint--not-ignored-p 'mu4e-mailto)
                     (string-prefix-p "mailto" mu4e-link-text))
            mu4e-link-pos))
         (mu4e-att-pos
          (when (not (member 'mu4e-attachment link-hint-ignore-types))
            (link-hint--next-property 'mu4e-attnum end-bound)))
         (help-link-pos (when (link-hint--not-ignored-p 'help-link)
                          (link-hint--next-property 'help-args end-bound)))
         (info-link-pos (when (link-hint--not-ignored-p 'info-link)
                          (link-hint--next-property-with-value
                           'font-lock-face 'info-xref end-bound)))
         (info-link-visited-pos
          (when (link-hint--not-ignored-p 'info-link)
            (link-hint--next-property-with-value
             'font-lock-face 'info-xref-visited end-bound)))
         (package-description-link-pos
          (when (link-hint--not-ignored-p 'package-description-link)
            (link-hint--next-property-with-value
             'action 'package-menu-describe-package)))
         (package-keyword-link-pos
          (when (link-hint--not-ignored-p 'package-keyword-link)
            (link-hint--next-property-with-value
             'action 'package-keyword-button-action)))
         (package-install-link-pos
          (when (link-hint--not-ignored-p 'package-install-link)
            (link-hint--next-property-with-value
             'action 'package-install-button-action)))
         (compilation-link-pos
          (when (link-hint--not-ignored-p 'compilation-link)
            (link-hint--next-property 'compilation-message end-bound)))
         (woman-button-link-pos
          ;; next-single-char-property-change is slow but is necessary for
          ;; see also buttons in woman mode
          (when (and (equal major-mode 'woman-mode)
                     (link-hint--not-ignored-p 'woman-button-link))
            (link-hint--next-button end-bound)))
         (other-button-link-pos
          (when (link-hint--not-ignored-p 'other-button-link)
            (link-hint--next-property 'button end-bound)))
         (closest-pos
          (link-hint--min (list text-url-pos
                                file-link-pos
                                shr-url-pos
                                htmlize-url-pos
                                mu4e-url-pos
                                mu4e-mailto-pos
                                mu4e-att-pos
                                help-link-pos
                                info-link-pos
                                info-link-visited-pos
                                package-description-link-pos
                                package-keyword-link-pos
                                package-install-link-pos
                                compilation-link-pos
                                woman-button-link-pos
                                other-button-link-pos))))
    (when closest-pos
      closest-pos)))

(defmacro link-hint--types-at-point-let-wrapper (body)
  "Wrap BODY in let statement that checks for supported types at the point."
  `(let* ((text-properties (text-properties-at (point)))
          (shr-url (plist-get text-properties 'shr-url))
          (htmlize-url (plist-get text-properties 'htmlize-link))
          (text-url (looking-at link-hint-url-regexp))
          (file-link (ffap-file-at-point))
          ;; will work for attachments in addition to mail-tos and urls
          (mu4e-url (plist-get text-properties 'mu4e-url))
          (mu4e-att (plist-get text-properties 'mu4e-attnum))
          (help-link (plist-get text-properties 'help-args))
          (info-link (or (equal (plist-get text-properties 'font-lock-face)
                                'info-xref)
                         (equal (plist-get text-properties 'font-lock-face)
                                'info-xref-visited)))
          (package-description-link
           (equal (plist-get text-properties 'action)
                  'package-menu-describe-package))
          (package-keyword-link
           (equal (plist-get text-properties 'action)
                  'package-keyword-button-action))
          (package-install-link
           (equal (plist-get text-properties 'action)
                  'package-install-button-action))
          (compilation-link
           (plist-get text-properties 'compilation-message))
          (other-button-link (button-at (point))))
     ,body))

;;;###autoload
(defun link-hint-open-link-at-point ()
  "Open a link of any supported type at the point."
  (interactive)
  (link-hint--types-at-point-let-wrapper
   (cond (shr-url (browse-url shr-url))
         (htmlize-url (browse-url (cadr htmlize-url)))
         (text-url (browse-url-at-point))
         ;; distinguish between opening in browser and view-atachment?
         (mu4e-url (mu4e~view-browse-url-from-binding))
         (mu4e-att (mu4e-view-open-attachment nil mu4e-att))
         ((or help-link
              package-keyword-link
              package-install-link)
          (push-button))
         (info-link (Info-follow-nearest-node))
         (package-description-link (package-menu-describe-package))
         (compilation-link (compile-goto-error))
         ;; lowest precedence
         (other-button-link (push-button))
         (file-link (find-file-at-point (ffap-file-at-point)))
         (t (message "There is no supported link at the point.")))))

;;;###autoload
(defun link-hint-copy-link-at-point ()
  "Copy a link of any supported type at the point. See the default value of
`link-hint-copy-ignore-types' for the unsupported types."
  (interactive)
  (link-hint--types-at-point-let-wrapper
   (cond (shr-url (kill-new shr-url))
         (htmlize-url (kill-new (cadr htmlize-url)))
         (text-url (let ((url (url-get-url-at-point)))
                     (when url (kill-new url))))
         (file-link (kill-new (ffap-file-at-point)))
         (mu4e-url (kill-new mu4e-url))
         (mu4e-att (mu4e-view-save-attachment-single nil mu4e-att))
         (t (message "There is no supported link at the point.")))))

(defun link-hint--link-action
    (action &optional require-multiple-links get-links)
  "Jump to a url using avy and execute ACTION.
When REQUIRE-MULTIPLE-LINKS is non-nil, this function will return nil if there
is only one visible link. When GET-LINKS is non-nil, the list of visible links
will be returned instead of calling avy then ACTION."
  (save-excursion
    (goto-char (1- (window-start)))
    (let* ((end-bound (window-end))
           (current-link (link-hint--next-link-pos end-bound))
           (current-window (get-buffer-window))
           link-positions
           ;; prevent window from shifting avy overlays out of view
           (scroll-margin 0)
           avy-all-windows)
      (while current-link
        (push (cons current-link current-window) link-positions)
        (goto-char current-link)
        (setq current-link (link-hint--next-link-pos end-bound)))
      (when (and link-positions
                 (if require-multiple-links
                     (> (length link-positions) 1)
                   t))
        (if get-links
            link-positions
          (avy--process (nreverse link-positions)
                        (avy--style-fn link-hint-avy-style))
          (funcall action))))))

;;;###autoload
(defun link-hint-open-link ()
  "Use avy to select and open a visible link."
  (interactive)
  (link-hint--link-action #'link-hint-open-link-at-point))

;; reason for emacs 24.1 dependency:
;;;###autoload
(defun link-hint-copy-link ()
  "Copy a visible link of a supported type to the kill ring with avy.
`select-enable-clipboard' and `select-enable-primary' can be set to non-nil
values to copy the link to the clipboard and/or primary as well. See the
default value of `link-hint-copy-ignore-types' for the unsupported types.
When selecting a mu4e attachment with this, it will prompt for a location to
save (since this is the closest behaviour to copying)."
  (interactive)
  (let ((link-hint-ignore-types (append link-hint-ignore-types
                                        link-hint-copy-ignore-types)))
    (link-hint--link-action #'link-hint-copy-link-at-point)))

(defun link-hint--multiple-link-action (action)
  "Move point to a link selected by avy and execute ACTION.
The point will be returned to its previous location afterwards.
This function will not do anything if only one link is visible."
  (let ((link-hint-ignore-types
         (append link-hint-ignore-types
                 link-hint-act-on-multiple-ignore-types))
        current-point
        point-list)
    (while (setq current-point
                 (ignore-errors
                   (link-hint--link-action #'point t)))
      (push current-point point-list))
    (save-excursion
      (dolist (point (nreverse point-list))
        (goto-char point)
        (funcall action)))))

;;;###autoload
(defun link-hint-open-multiple-links ()
  "Use avy to select and open multiple visible links at once.
The links will be opened as soon as a non-hint key (a key not appearing in an
overlay) is pressed. More than one link must be visible for this command to have
an effect."
  (interactive)
  (link-hint--multiple-link-action #'link-hint-open-link-at-point))

;;;###autoload
(defun link-hint-copy-multiple-links ()
  "Use avy to select and copy multiple, visible links at once to the kill ring.
See `link-hint-copy-link' for more information. More than one supported link
must be visible for this command to have an effect."
  (interactive)
  (let ((link-hint-ignore-types (append link-hint-ignore-types
                                        link-hint-copy-ignore-types)))
    (link-hint--multiple-link-action #'link-hint-copy-link-at-point)))

(defun link-hint--all-links-action (action)
  "Call ACTION on the location of every visible link in the buffer.
The point will be returned to its previous location afterwards."
  ;; * so ignored types takes effect for link-hint--link-action
  (let* ((link-hint-ignore-types
          (append link-hint-ignore-types
                  link-hint-act-on-all-ignore-types))
         (point-list (link-hint--link-action nil nil t)))
    (save-excursion
      (dolist (point (nreverse point-list))
        (goto-char (car point))
        (funcall action)))))

;;;###autoload
(defun link-hint-open-all-links ()
  "Open all visible links."
  (interactive)
  (link-hint--all-links-action #'link-hint-open-link-at-point))

;;;###autoload
(defun link-hint-copy-all-links ()
  "Copy all visible links of a supported type.
See `link-hint-copy-link' for more information."
  (interactive)
  (let ((link-hint-ignore-types (append link-hint-ignore-types
                                        link-hint-copy-ignore-types)))
    (link-hint--all-links-action #'link-hint-copy-link-at-point)))

(provide 'link-hint)
;;; link-hint.el ends here
