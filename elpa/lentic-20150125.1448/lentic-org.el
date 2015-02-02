;;; lentic-org.el --- org support for lentic -*- lexical-binding: t -*-

;;; Header:

;; This file is not part of Emacs

;; Author: Phillip Lord <phillip.lord@newcastle.ac.uk>
;; Maintainer: Phillip Lord <phillip.lord@newcastle.ac.uk>

;; The contents of this file are subject to the LGPL License, Version 3.0.

;; Copyright (C) 2014, Phillip Lord, Newcastle University

;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at your
;; option) any later version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
;; for more details.

;; You should have received a copy of the GNU Lesser General Public License
;; along with this program. If not, see http://www.gnu.org/licenses/.

;;; Commentary:

;; This file provides lentic for org and emacs-lisp files. This enables a
;; literate form of programming with Elisp, using org mode to provide
;; documentation mark up.

;; It provides too main ways of integrating between org and emacs-lisp. The
;; first which we call org-el (or el-org) is a relatively simple translation
;; between the two modes.

;; #+BEGIN_SRC emacs-lisp
(require 'cl-lib)
(require 'lentic-block)
(require 'm-buffer-at)
;; #+END_SRC


;;; Code:

;; ** Simple org->el

;; The simple transformation between org and elisp is to just comment out
;; everything that is not inside a BEGIN_SRC/END_SRC block. This provides only
;; minimal advantages over the embedded org mode environment. Org, for instance,
;; allows native fontification of the embedded code (i.e. elisp will be coloured
;; like elisp!), which is something that org-el translation also gives for free;
;; in this case of org-el, however, when the code is high-lighted, the org mode
;; text is visually reduced to `comment-face'. The other key advantage is
;; familiarity; it is possible to switch to the `emacs-lisp-mode' buffer and
;; eval-buffer, region or expression using all the standard keypresses.

;; One problem with this mode is that elisp has a first line semantics for
;; file-local variables. This is a particular issue if setting `lexical-binding'.
;; In a literate org file, this might appear on the first line of the
;; embedded lisp, but it will *not* appear in first line of an emacs-lisp
;; lentic, so the file will be interpreted with dynamic binding.


;; *** Implementation

;; The implementation is a straight-forward use of `lentic-block' with
;; regexps for org source blocks. It currently takes no account of
;; org-mode :tangle directives -- so all lisp in the buffer will be present in
;; the emacs-lisp mode lentic.

;; #+BEGIN_SRC emacs-lisp
(defun lentic-org-to-el-new ()
  (lentic-uncommented-block-configuration
   "lb-org-to-el"
   :this-buffer (current-buffer)
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".el")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC emacs-lisp"
   :comment-start "#\\\+END_SRC"))

;;;###autoload
(defun lentic-org-el-init ()
  (lentic-org-to-el-new))

(add-to-list 'lentic-init-functions
             'lentic-org-el-init)

(defun lentic-el-to-org-new ()
  (lentic-commented-block-configuration
   "lb-el-to-org"
   :this-buffer (current-buffer)
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".org")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC emacs-lisp"
   :comment-start "#\\\+END_SRC"))

;;;###autoload
(defun lentic-el-org-init ()
  (lentic-el-to-org-new))

(add-to-list 'lentic-init-functions
             'lentic-el-org-init)
;; #+END_SRC


;; ** orgel->org

;; In this section, we define a different transformation from what we call an
;; orgel file. This is a completely valid emacs-lisp file which transforms
;; cleanly into a valid org file. This requires constraits on both the emacs-lisp
;; and org representation. However, most of the features of both modes are
;; available.

;; The advantages of orgel files over a tangle-able literate org file are
;; several. The main one, however, is that the =.el= file remains a source
;; format. It can be loaded directly by Emacs with `load-library' or `require'.
;; Developers downloading from a VCS will find the =.el= file rather than looking
;; for an =.org= file. Developers wishing to offer patches can do so to the =.el=
;; file. Finally, tools which work over =.el= such as checkdoc will still work.
;; Finally, there is no disjoint between the org file and the emacs-lisp
;; comments. The commentary section, for example, can be edited using `org-mode'
;; rather than as comments in an elisp code block.

;; The disadvantages are that the structure of the org file is not arbitrary; it
;; most follow a specific structure. Without an untangling process, things like
;; noweb references will not work.

;; The transformation (orgel -> org) works as follows:
;;  - the first line summary is transformed into a comment in org
;;  - all single word ";;;" headers are transformed into level 1 org headings.
;;  - ";;" comments are removed except inside emacs-lisp source blocks.

;; *** Converting an Existing file

;; It is relatively simple to convert an existing emacs-lisp file, so that it
;; will work with the orgel transformation. orgel files work with (nearly) all
;; existing Emacs-Lisp documentaton standards but have a few extra bits added
;; in to work with org.

;; Current ";;;" section demarcation headers in emacs-lisp are used directly
;; and are transformed into Section 1 headings in org-mode. Unfortunately, in
;; emacs-lisp the header is *not* explicitly marked -- it's just the start
;; to the ";;; Commentary:" header. To enable folding of the header,
;; therefore, you need to introduce a ";;; Header:" line *after* the first line.
;; You may also wish to add a ";;; Footer:" heading as well.

;; Secondly, mark *all* of the code with org-mode source demarks. Finally, set
;; `lentic-init' to `lentic-orgel-org-init' (normally with a
;; file-local or dir-local variable). Now lentic can be started. The
;; header will appear as normal text in the org-mode buffer, with all other
;; comments inside a source block. You can now move through the buffer splitting
;; the source block (with `org-babel-demarcate-block' which has to win a prize
;; for the most obscurely named command), and move comments out of the source
;; block into the newly created text block.

;; *** Limitations

;; Currently, the implementation still requires some extra effort from the elisp
;; side, in that lisp must be marked up as a source code block. The short term
;; fix would be to add some functionality like `org-babel-demarcate-block' to
;; emacs-lisp-mode. Even better would to automatically add source markup when "("
;; was pressed at top level (if paredit were active, then it would also be
;; obvious where to put the close). Finally, have both `lentic-org' and
;; `org-mode' just recognise emacs-lisp as a source entity *without* any further
;; markup.

;; Finally, I don't like the treatment of the summary line -- ideally this should
;; appear somewhere in the org file not as a comment. I am constrained by the
;; start of file semantics of both =.org= and =.el= so this will probably remain.
;; The content can always be duplicated which is painful, but the summary line is
;; unlikely to get updated regularly.


;; *** Implementation

;; The main transformation issue is the first line. An =.el= file has a summary
;; at the top. This is checked by checkdoc, used by the various lisp management
;; tools, which in turn impacts on the packaging tools. Additionally, lexical
;; binding really must be set here.

;; We solve this problem by transforming the first line ";;;" into "# #". Having
;; three characters means that the width is maintained. It also means I can
;; distinguish between this kind of comment and an "ordinary" `org-mode' comment;
;; in practice, this doesn't matter, because I only check on the first line. The
;; space is necessary because `org-mode' doesn't recognised "###" as a comment.

;; Another possibility would be to transform the summary line into a header. I
;; choose against this because first it's not really a header being too long and
;; second `org-mode' uses the space before the first header to specify, for
;; example, properties relevant to the entire tree. This is prevented if I make
;; the first line a header 1.

;; **** org to orgel

;; Here we define a new class or org-to-orgel, as well as clone function which
;; adds the ";;;" header transformation in addition to the normal block semantics
;; from the superclass. Currently only single word headers are allowed which
;; seems consistent with emacs-lisp usage.

;; #+BEGIN_SRC emacs-lisp
(defclass lentic-org-to-orgel-configuration
  (lentic-uncommented-block-configuration)
  ())

(defmethod lentic-clone
  ((conf lentic-org-to-orgel-configuration)
   &optional start stop length-before
   start-converted stop-converted)
  ;; do everything else to the buffer
  (m-buffer-with-markers
      ((first-line
        (m-buffer-match-first-line
         (lentic-this conf)))
       (header-one-line
        (m-buffer-match
          (lentic-this conf)
          "^[*] \\(\\w*\\)$"
          :begin (cl-cadar first-line)))
       (special-lines
        (-concat first-line header-one-line)))
    ;; check whether we are in a special line -- if so widen the change extent
    (let*
        ((start-in-special
          (when
              (and
               start
               (m-buffer-in-match-p
                special-lines start))
            (m-buffer-at-line-beginning-position
             (lentic-this conf)
             start)))
         (start (or start-in-special start))
         (start-converted
          (if start-in-special
              (m-buffer-at-line-beginning-position
               (lentic-that conf)
               start-converted)
            start-converted))
         (stop-in-special
          (when
              (and
               stop
               (m-buffer-in-match-p
                special-lines stop))
            (m-buffer-at-line-end-position
             (lentic-this conf)
             stop)))
         (stop (or stop-in-special stop))
         (stop-converted
          (if stop-in-special
              (m-buffer-at-line-end-position
               (lentic-that conf)
               stop-converted)
            stop-converted)))
      (call-next-method conf start stop length-before
                        start-converted stop-converted)
      (let ((first-line-end-match
             (cl-cadar
              (m-buffer-match-first-line
               (lentic-that conf)))))
        (m-buffer-replace-match
         (m-buffer-match
          (lentic-that conf)
          ;; we can be in one of two states depending on whether we have made a new
          ;; clone or an incremental change
          "^;; \\(;;;\\|# #\\)"
          :end first-line-end-match)
         ";;;")
        ;; replace big headers, in either of their two states
        (m-buffer-replace-match
         (m-buffer-match
          (lentic-that conf)
          "^;; [*] \\(\\w*\\)$"
          :begin first-line-end-match)
         ";;; \\1:")
        (m-buffer-replace-match
         (m-buffer-match (lentic-that conf)
                         "^;; ;;; \\(\\w*:\\)$"
                         :begin first-line-end-match)
         ";;; \\1")))))

(defmethod lentic-convert
  ((conf lentic-org-to-orgel-configuration)
   location)
  (let ((converted (call-next-method conf location)))
    (m-buffer-with-current-position
        (oref conf :this-buffer)
        location
      (beginning-of-line)
      (if (looking-at "[*] \\w*$")
          (- converted 1)
        converted))))

(defmethod lentic-invert
  ((conf lentic-org-to-orgel-configuration))
  (let ((rtn
         (lentic-orgel-to-org-new)))
    (oset rtn :that-buffer
          (lentic-this conf))
    rtn))

(defun lentic-org-to-orgel-new ()
  (lentic-org-to-orgel-configuration
   "lb-orgel-to-el"
   :this-buffer (current-buffer)
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".el")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC emacs-lisp"
   :comment-start "#\\\+END_SRC"))

;;;###autoload
(defun lentic-org-orgel-init ()
  (lentic-org-to-orgel-new))

(add-to-list 'lentic-init-functions
             'lentic-org-orgel-init)
;; #+END_SRC

;; **** orgel->org

;; And the orgel->org implementation. Currently, this means that I have all the
;; various regexps in two places which is a bit ugly. I am not sure how to stop
;; this.

;; #+BEGIN_SRC emacs-lisp

(defclass lentic-orgel-to-org-configuration
  (lentic-commented-block-configuration)
  ())

(defmethod lentic-clone
  ((conf lentic-orgel-to-org-configuration)
   &optional start stop length-before start-converted stop-converted)
  ;; do everything else to the buffer
  (call-next-method conf start stop length-before
                    start-converted stop-converted)
  (m-buffer-replace-match
   (m-buffer-match
    (lentic-that conf)
    ";;; "
    :end
    (cl-cadar
     (m-buffer-match-first-line
      (lentic-that conf))))
   "# # ")
  (m-buffer-replace-match
   (m-buffer-match (lentic-that conf)
                   "^;;; \\(\\\w*\\):")
   "* \\1"))

(defmethod lentic-invert
  ((conf lentic-orgel-to-org-configuration))
  (let ((rtn
         (lentic-org-to-orgel-new)))
    (oset rtn :delete-on-exit t)
    (oset rtn :that-buffer (lentic-this conf))
    rtn))

(defun lentic-orgel-to-org-new ()
  (lentic-orgel-to-org-configuration
   "lb-orgel-to-org"
   :this-buffer (current-buffer)
   ;; we don't really need a file and could cope without, but org mode assumes
   ;; that the buffer is file name bound when it exports. As it happens, this
   ;; also means that file saving is possible which in turn saves the el file
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".org")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC emacs-lisp"
   :comment-start "#\\\+END_SRC"))

;;;###autoload
(defun lentic-orgel-org-init ()
  (lentic-orgel-to-org-new))

(add-to-list 'lentic-init-functions
             'lentic-orgel-org-init)

;; #+END_SRC




;; *** org->clojure

;; #+BEGIN_SRC emacs-lisp
(defun lentic-org-to-clojure-new ()
  (lentic-uncommented-block-configuration
   "lb-org-to-clojure"
   :this-buffer (current-buffer)
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".clj")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC clojure"
   :comment-start "#\\\+END_SRC"
   ;; don't ignore case -- so using lower case begin_src
   ;; will be ignored. Probably we should count instead!
   :case-fold-search nil))

(defun lentic-org-clojure-init ()
  (lentic-org-to-clojure-new))

(add-to-list 'lentic-init-functions
             'lentic-org-clojure-init)

(defun lentic-clojure-to-org-new ()
  (lentic-commented-block-configuration
   "lb-clojure-to-org"
   :this-buffer (current-buffer)
   :lentic-file
   (concat
    (file-name-sans-extension
     (buffer-file-name))
    ".org")
   :comment ";; "
   :comment-stop "#\\\+BEGIN_SRC clojure"
   :comment-start "#\\\+END_SRC"))

(defun lentic-clojure-org-init ()
  (lentic-clojure-to-org-new))

(add-to-list 'lentic-init-functions
             'lentic-clojure-org-init)
;; #+END_SRC


;;; Footer:

;; Declare the end of the file, and add file-local support for orgel->org
;; transformation. Do not use lentics on this file while changing the
;; lisp in the file without backing up first!

;; #+BEGIN_SRC emacs-lisp
(provide 'lentic-org)
;;; lentic-org.el ends here
;; #+END_SRC

