Zap to char using [avy].

This package is basically a fork of the functionality of [ace-jump-zap],
but using [avy] instead of [ace-jump-mode] as the jumping method.


[avy] https://github.com/abo-abo/avy

[ace-jump-zap] https://github.com/waymondo/ace-jump-zap

[ace-jump-mode] https://github.com/winterTTr/ace-jump-mode


1 Setup
=======

,----
| (add-to-list 'load-path "/path/to/avy-zap.el")
| (require 'avy-zap)
`----


2 Usage
=======

Use `avy-zap-to-char' or `avy-zap-up-to-char' to perform `zap-to-char'
or `zap-up-to-char' in "avy-style"!

There are two *Do-What-I-Mean* versions: `avy-zap-to-char-dwim' and
`avy-zap-up-to-char-dwim'. `avy-zap-(up-)to-char-dwim' will perform
`zap-(up-)to-char' without prefix. If calling *dwim* versions with
prefix, then `avy-zap-(up-)to-char' will be used instead.

You can give key bindings to these commands. For example:
,----
| (global-set-key (kbd "M-z") 'avy-zap-to-char-dwim)
| (global-set-key (kbd "M-Z") 'avy-zap-up-to-char-dwim)
`----


3 Customization
===============

- `avy-zap-forward-only': Setting this variable to non-nil means
zapping from the current point. The default value is `nil'.
- `avy-zap-function': Choose between `kill-region' or `delete-region'.
The default value is `kill-region'.


4 Compared to ace-jump-zap
==========================

This package provides the same functionality as `ace-jump-zap', but
lacks the `ajz/sort-by-closest' and `ajz/52-character-limit'
customization options. I don't use the sorting feature of
`ace-jump-zap', but if someone finds it useful, welcome to submit a
pull request!


5 Related packages
==================

- [ace-jump-zap]
- [avy]


[ace-jump-zap] https://github.com/waymondo/ace-jump-zap

[avy] https://github.com/abo-abo/avy
