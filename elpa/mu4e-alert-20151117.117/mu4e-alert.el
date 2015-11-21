;;; mu4e-alert.el --- Desktop notification for mu4e  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Iqbal Ansari

;; Author: Iqbal Ansari <iqbalansari02@yahoo.com>
;; URL: https://github.com/iqbalansari/mu4e-alert
;; Package-Version: 20151117.117
;; Keywords: mail, convenience
;; Version: 0.2
;; Package-Requires: ((alert "1.2") (s "1.10.0") (emacs "24.1"))

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

;; This package provides desktop notifications for mu4e, additionally it can
;; display the number of unread emails in the modeline



;;; Code:

(require 'mu4e)
(require 'alert)
(require 's)

(require 'time)
(require 'advice)



;; Customizations

(defgroup mu4e-alert nil
  "Customization options for mu4e-alert"
  :group 'mail
  :prefix "mu4e-alert-")

(defcustom mu4e-alert-interesting-mail-query
  "flag:unread AND NOT flag:trashed"
  "The query to get count of unread (read interesting) emails.
By default only unread emails are considered interesting, it should
be string to be sent to the mu's find command."
  :type 'string
  :group 'mu4e-alert)

(defcustom mu4e-alert-modeline-formatter
  #'mu4e-alert-default-mode-line-formatter
  "The function used to get the string to be displayed in the mode-line.
It should be a function that accepts a single argument the current count of
unread emails and should return the string to be displayed in the mode-line"
  :type 'function
  :group 'mu4e-alert)

(defcustom mu4e-alert-notification-formatter
  #'mu4e-alert-default-notification-formatter
  "The function used to get the message for the desktop notification.
It should be a function that accepts a single argument the current count of
unread emails and should return the string to be used for the notification"
  :type 'function
  :group 'mu4e-alert)

(defcustom mu4e-alert-title "mu4e"
  "The title to use for desktop notifications."
  :type 'string
  :group 'mu4e-alert)

;;;###autoload
(defun mu4e-alert-set-default-style (value)
  "Set the default style for unread email notifications.

VALUE is the value to be used as the default style."
  (let ((notification-style (if (consp value)
                                (eval value)
                              value)))
    (unless (assoc value alert-styles)
      (user-error "[mu4e-alert] Do not know how to use `%s' style, please one of %s"
                  value
                  (mapcar #'car alert-styles)))
    (alert-add-rule :category "mu4e-alert" :style notification-style)
    (setq-default mu4e-alert-style notification-style)))

(defcustom mu4e-alert-style alert-default-style
  "The default style to use for notifying the user about unread emails.

This should be one of `alert-styles'.  Setting this directly from Lisp will not
work, to customize this value from Lisp use the function
`mu4e-alert-set-default-style', if you want more fine grained customizations you
can use alert's API and add rules for the category \"mu4e-alert\"

See also https://github.com/jwiegley/alert."
  :type (alert-styles-radio-type 'radio)
  :set (lambda (_ value) (mu4e-alert-set-default-style value))
  :group 'mu4e-alert)



;; Basic functions

(defun mu4e-alert--sanity-check ()
  "Sanity check run before attempting to fetch unread emails."
  (unless (and (bound-and-true-p mu4e-mu-binary)
               (stringp mu4e-mu-binary)
               (file-executable-p mu4e-mu-binary))
    (user-error "Please set `mu4e-mu-binary' to the full path to the mu binary, before attempting to enable `mu4e-alert'")))

(defun mu4e-alert--get-mu-unread-mail-count (callback)
  "Get the count of unread emails asynchronously.
CALLBACK is called with one argument the number of unread emails"
  (mu4e-alert--sanity-check)
  (let* ((mail-count-command (append (mapcar #'shell-quote-argument
                                             (append (list mu4e-mu-binary
                                                           "find"
                                                           "--nocolor")
                                                     (when mu4e-mu-home
                                                       (list (concat "--muhome=" mu4e-mu-home)))
                                                     (split-string mu4e-alert-interesting-mail-query)))
                                     '("2>/dev/null | wc -l")))
         (mail-count-command-string (s-join " " mail-count-command))
         (process-filter (lambda (_ output)
                           (funcall callback (string-to-number (s-trim output))))))
    (set-process-filter (start-process "mu4e-unread-count"
                                       nil
                                       (getenv "SHELL")
                                       "-c"
                                       mail-count-command-string)
                        process-filter)))



;; Mode-line indicator for unread emails

(defvar mu4e-alert-mode-line nil "The mode-line indicator to display the count of unread emails.")

(defun mu4e-alert-default-mode-line-formatter (mail-count)
  "Default formatter used to get the string to be displayed in the mode-line.
MAIL-COUNT is the count of mails for which the string is to displayed"
  (when (not (zerop mail-count))
    (concat " "
            (propertize
             "Mail"
             'display (when (display-graphic-p)
                        display-time-mail-icon)
             'face display-time-mail-face
             'help-echo (concat (if (= mail-count 1)
                                    "You have an unread email"
                                  (format "You have %s unread emails" mail-count))
                                "\nClick here to view "
                                (if (= mail-count 1) "it" "them"))
             'mouse-face 'mode-line-highlight
             'keymap '(mode-line keymap
                                 (mouse-1 . mu4e-alert-view-unread-mails)
                                 (mouse-2 . mu4e-alert-view-unread-mails)
                                 (mouse-3 . mu4e-alert-view-unread-mails)))
            (if (zerop mail-count)
                " "
              (format " [%d] " mail-count)))))

(defun mu4e-alert-view-unread-mails ()
  "View unread mails.
This is primarily used to enable viewing unread emails by default mode-line
formatter when user clicks on mode-line indicator"
  (interactive)
  (mu4e-headers-search mu4e-alert-interesting-mail-query))

(defun mu4e-alert-update-mail-count-modeline ()
  "Update mail count in the mode-line."
  (mu4e-alert--get-mu-unread-mail-count (lambda (count)
                                          (setq mu4e-alert-mode-line (funcall mu4e-alert-modeline-formatter count))
                                          (force-mode-line-update))))



;; Desktop notifications for unread emails

(defun mu4e-alert-default-notification-formatter (mail-count)
  "Default formatter used to get the string for desktop notification.
MAIL-COUNT is the count of mails for which the string is to displayed"
  (when (not (zerop mail-count))
    (if (= mail-count 1)
        "You have an unread email"
      (format "You have %s unread emails" mail-count))))

(defun mu4e-alert-notify-unread-messages (mail-count)
  "Display desktop notification for given MAIL-COUNT."
  (when (not (zerop mail-count))
    (alert (funcall 'mu4e-alert-default-notification-formatter
                    mail-count)
           :title mu4e-alert-title
           :category "mu4e-alert")))

(defun mu4e-alert-notify-async ()
  "Send a desktop notification about currently unread email."
  (mu4e-alert--get-mu-unread-mail-count #'mu4e-alert-notify-unread-messages))



;; Tying all the above together

(defadvice mu4e-mark-execute-all (after mu4e-alert-update-mail-count-modeline disable)
  "Advice `mu4e-mark-execute-all' to update mode-line after execution."
  (mu4e-alert-update-mail-count-modeline))

;;;###autoload
(defun mu4e-alert-enable-mode-line-display ()
  "Enable display of unread emails in mode-line."
  (interactive)
  (add-to-list 'global-mode-string '(:eval mu4e-alert-mode-line) t)
  (add-hook 'mu4e-view-mode-hook #'mu4e-alert-update-mail-count-modeline)
  (add-hook 'mu4e-index-updated-hook #'mu4e-alert-update-mail-count-modeline)
  (ad-enable-advice #'mu4e-mark-execute-all 'after 'mu4e-alert-update-mail-count-modeline)
  (ad-activate #'mu4e-mark-execute-all)
  (mu4e-alert-update-mail-count-modeline))

(defun mu4e-alert-disable-mode-line-display ()
  "Disable display of unread emails in mode-line."
  (interactive)
  (setq global-mode-string (delete '(:eval mu4e-alert-mode-line) global-mode-string))
  (remove-hook 'mu4e-view-mode-hook #'mu4e-alert-update-mail-count-modeline)
  (remove-hook 'mu4e-index-updated-hook #'mu4e-alert-update-mail-count-modeline)
  (ad-disable-advice #'mu4e-mark-execute-all 'after 'mu4e-alert-update-mail-count-modeline)
  (ad-activate #'mu4e-mark-execute-all))

;;;###autoload
(defun mu4e-alert-enable-notifications ()
  "Enable desktop notifications for unread emails."
  (interactive)
  (add-hook 'mu4e-index-updated-hook #'mu4e-alert-notify-async)
  (mu4e-alert-notify-async))

(defun mu4e-alert-disable-notifications ()
  "Disable desktop notifications for unread emails."
  (interactive)
  (remove-hook 'mu4e-index-updated-hook #'mu4e-alert-notify-async))

(provide 'mu4e-alert)
;;; mu4e-alert.el ends here
