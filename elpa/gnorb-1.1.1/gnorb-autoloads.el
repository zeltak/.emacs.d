;;; gnorb-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "gnorb-bbdb" "gnorb-bbdb.el" (21947 7552 527745
;;;;;;  833000))
;;; Generated autoloads from gnorb-bbdb.el

(autoload 'gnorb-bbdb-mail "gnorb-bbdb" "\
\\<bbdb-mode-map>Acts just like `bbdb-mail', except runs
RECORDS through `gnorb-bbdb-posting-styles', allowing
customization of message styles for certain records. From the
`bbdb-mail' docstring:

Compose a mail message to RECORDS (optional: using SUBJECT).
Interactively, use BBDB prefix \\[bbdb-do-all-records], see
`bbdb-do-all-records'. By default, the first mail addresses of
RECORDS are used. If prefix N is a number, use Nth mail address
of RECORDS (starting from 1). If prefix N is C-u (t
noninteractively) use all mail addresses of RECORDS. If VERBOSE
is non-nil (as in interactive calls) be verbose.

\(fn RECORDS &optional SUBJECT N VERBOSE)" t nil)

(autoload 'gnorb-bbdb-tag-agenda "gnorb-bbdb" "\
Open an Org agenda tags view from the BBDB buffer, using the
value of the record's org-tags field. This shows only TODOs by
default; a prefix argument shows all tagged headings; a \"*\"
prefix operates on all currently visible records. If you want
both, use \"C-u\" before the \"*\".

\(fn RECORDS)" t nil)

(autoload 'gnorb-bbdb-mail-search "gnorb-bbdb" "\
Initiate a mail search from the BBDB buffer.

Use the prefix arg to edit the search string first, and the \"*\"
prefix to search mails from all visible contacts. When using both
a prefix arg and \"*\", the prefix arg must come first.

\(fn RECORDS)" t nil)

(autoload 'gnorb-bbdb-cite-contact "gnorb-bbdb" "\


\(fn REC)" t nil)

(autoload 'gnorb-bbdb-open-link "gnorb-bbdb" "\
\\<bbdb-mode-map>Call this on a BBDB record to open one of the
links in the message field. By default, the first link will be
opened. Use a prefix arg to open different links. For instance,
M-3 \\[gnorb-bbdb-open-link] will open the third link in the
list. If the %:count escape is present in the message formatting
string (see `gnorb-bbdb-message-link-format-multi' and
`gnorb-bbdb-message-link-format-one'), that's the number to use.

This function also needs to be called on a contact once before
that contact will start collecting links to messages.

\(fn RECORD ARG)" t nil)

;;;***

;;;### (autoloads nil "gnorb-gnus" "gnorb-gnus.el" (21947 7552 484412
;;;;;;  335000))
;;; Generated autoloads from gnorb-gnus.el

(autoload 'gnorb-gnus-article-org-attach "gnorb-gnus" "\
Save MIME part N, which is the numerical prefix, of the
  article under point as an attachment to the specified org
  heading.

\(fn N)" t nil)

(autoload 'gnorb-gnus-mime-org-attach "gnorb-gnus" "\
Save the MIME part under point as an attachment to the
  specified org heading.

\(fn)" t nil)

(autoload 'gnorb-gnus-outgoing-do-todo "gnorb-gnus" "\
Use this command to use the message currently being composed
as an email todo action.

If it's a new message, or a reply to a message that isn't
referenced by any TODOs, a new TODO will be created.

If it references an existing TODO, you'll be prompted to trigger
a state-change or a note on that TODO after the message is sent.

You can call it with a prefix arg to force choosing an Org
subtree to associate with.

If you've already called this command, but realize you made a
mistake, you can call this command with a double prefix to reset
the association.

If a new todo is made, it needs a capture template: set
`gnorb-gnus-new-todo-capture-key' to the string key for the
appropriate capture template. If you're using a gnus-based
archive method (ie you have `gnus-message-archive-group' set to
something, and your outgoing messages have a \"Fcc\" header),
then a real link will be made to the outgoing message, and all
the gnus-type escapes will be available (see the Info
manual (org) Template expansion section). If you don't, then the
%:subject, %:to, %:toname, %:toaddress, and %:date escapes for
the outgoing message will still be available -- nothing else will
work.

\(fn &optional ARG)" t nil)

(autoload 'gnorb-gnus-incoming-do-todo "gnorb-gnus" "\
Call this function from a received gnus message to store a
link to the message, prompt for a related Org heading, visit the
heading, and trigger an action on it (see
`gnorb-org-trigger-actions').

If you've set up message tracking (with
`gnorb-tracking-initialize'), Gnorb can guess which Org heading
you probably want to trigger, which can save some time. It does
this by looking in the References header, and seeing if any of
the messages referenced there are already being tracked by any
headings.

If you mark several messages before calling this function, or
call it with a numerical prefix arg, those messages will be
\"bulk associated\" with the chosen Org heading: associations
will be made, but you won't be prompted to trigger an action, and
you'll stay in the Gnus summary buffer.

\(fn ARG &optional ID)" t nil)

(autoload 'gnorb-gnus-quick-reply "gnorb-gnus" "\
Compose a reply to the message under point, and associate both
the original message and the reply with the selected heading.
Take no other action.

Use this when you want to compose a reply to a message on the
spot, and track both messages, without having to go through the
hassle of triggering an action on a heading, and then starting a
reply.

\(fn)" t nil)

(autoload 'gnorb-gnus-search-messages "gnorb-gnus" "\
Initiate a search for gnus message links in an org subtree.
The arg STR can be one of two things: an Org heading id value
\(IDs should be prefixed with \"id+\"), in which case links will
be collected from that heading, or a string corresponding to an
Org tags search, in which case links will be collected from all
matching headings.

In either case, once a collection of links have been made, they
will all be displayed in an ephemeral group on the \"nngnorb\"
server. There must be an active \"nngnorb\" server for this to
work.

\(fn STR PERSIST &optional HEAD-TEXT RET)" t nil)

(autoload 'gnorb-gnus-view "gnorb-gnus" "\
Display the first relevant TODO heading for the message under point

\(fn)" t nil)

;;;***

;;;### (autoloads nil "gnorb-org" "gnorb-org.el" (21947 7552 517745
;;;;;;  794000))
;;; Generated autoloads from gnorb-org.el

(autoload 'gnorb-org-contact-link "gnorb-org" "\
Prompt for a BBDB record and insert a link to that record at
point.

There's really no reason to use this instead of regular old
`org-insert-link' with BBDB completion. But there might be in the
future!

\(fn REC)" t nil)

(autoload 'gnorb-org-handle-mail "gnorb-org" "\
Handle current headline as a mail TODO.

How this function behaves depends on whether you're using Gnorb
for email tracking, also on the prefix arg, and on the active
region.

If tracking is enabled and there is no prefix arg, Gnorb will
begin a reply to the newest associated message that wasn't sent
by the user -- ie, the Sender header doesn't match
`user-mail-address' or `message-alternative-emails'.

If tracking is enabled and there is a prefix arg, ignore the
tracked messages and instead scan the subtree for mail-related
links. This means links prefixed with gnus:, mailto:, or bbdb:.
See `gnorb-org-mail-scan-scope' to limit the scope of this scan.
Do something appropriate with the resulting links.

With a double prefix arg, ignore all tracked messages and all
links, and compose a blank new message.

If tracking is enabled and you want to reply to a
specific (earlier) message in the tracking history, use
`gnorb-org-view' to open an nnir *Summary* buffer containing all
the messages, and reply to the one you want. Your reply will be
automatically tracked, as well.

If tracking is not enabled and you want to use a specific link in
the subtree as a basis for the email action, then put the region
around that link before you call this message.

\(fn &optional ARG TEXT FILE)" t nil)

(autoload 'gnorb-org-email-subtree "gnorb-org" "\
Call on a subtree to export it either to a text string or a file,
then compose a mail message either with the exported text
inserted into the message body, or the exported file attached to
the message.

Export options default to the following: When exporting to a
buffer: async = nil, subtreep = t, visible-only = nil, body-only
= t. Options are the same for files, except body-only is set to
nil. Customize `gnorb-org-email-subtree-text-options' and
`gnorb-org-email-subtree-file-options', respectively.

Customize `gnorb-org-email-subtree-parameters' to your preferred
default set of parameters.

\(fn &optional ARG)" t nil)

(autoload 'gnorb-org-popup-bbdb "gnorb-org" "\
In an `org-tags-view' Agenda buffer, pop up a BBDB buffer
showing records whose `org-tags' field matches the current tags
search.

\(fn &optional STR)" t nil)

(autoload 'gnorb-org-view "gnorb-org" "\
Search the subtree at point for links to gnus messages, and
then show them in an ephemeral group, in Gnus.

With a prefix arg, create a search group that will persist across
Gnus sessions, and can be refreshed.

This won't work unless you've added a \"nngnorb\" server to
your gnus select methods.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "gnorb-utils" "gnorb-utils.el" (21947 7552
;;;;;;  504412 411000))
;;; Generated autoloads from gnorb-utils.el

(autoload 'gnorb-restore-layout "gnorb-utils" "\
Restore window layout and value of point after a Gnorb command.

Some Gnorb commands change the window layout (ie `gnorb-org-view'
or incoming email triggering). This command restores the layout
to what it was. Bind it to a global key, or to local keys in Org
and Gnus and BBDB maps.

\(fn)" t nil)

(autoload 'gnorb-tracking-initialize "gnorb-utils" "\
Start using the Gnus registry to track correspondences between
Gnus messages and Org headings. This requires that the Gnus
registry be in use, and should be called after the call to
`gnus-registry-initialize'.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("gnorb-pkg.el" "gnorb-registry.el" "gnorb.el"
;;;;;;  "nngnorb.el") (21947 7552 570107 20000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; gnorb-autoloads.el ends here
