;;; weechat-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "weechat" "weechat.el" (22226 63708 88008 538000))
;;; Generated autoloads from weechat.el

(autoload 'weechat-connect "weechat" "\
Connect to WeeChat.

HOST is the relay host, `weechat-host-default' by default.
PORT is the port where the relay listens, `weechat-port-default' by default.
PASSWORD is either a string, a function or nil.
MODE is null or 'plain for a plain socket, t or 'ssl for a TLS socket;
a string denotes a command to run.  You can use %h and %p to interpolate host
and port number respectively.

\(fn &optional HOST PORT PASSWORD MODE FORCE-DISCONNECT)" t nil)

;;;***

;;;### (autoloads nil nil ("weechat-button.el" "weechat-cmd.el" "weechat-color.el"
;;;;;;  "weechat-complete.el" "weechat-core.el" "weechat-corrector.el"
;;;;;;  "weechat-image.el" "weechat-latex.el" "weechat-notifications.el"
;;;;;;  "weechat-pkg.el" "weechat-read-marker.el" "weechat-relay.el"
;;;;;;  "weechat-sauron.el" "weechat-secrets.el" "weechat-smiley.el"
;;;;;;  "weechat-speedbar.el" "weechat-spelling.el" "weechat-tracking.el")
;;;;;;  (22226 63708 307772 453000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; weechat-autoloads.el ends here
