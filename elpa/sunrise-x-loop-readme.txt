   Loop Extension for the Sunrise Commander file manager.

This package is an enhancement for the Sunrise Commander, which is a
two-pane file manager, like Midnight Commander or Total Commander.

It adds to Sunrise the capability of performing copy and rename
operations in the background. It provides prefixable drop-in
replacements for the `sr-do-copy' and `sr-do-rename' commands and uses
them to redefine their bindings in the `sr-mode-map' keymap. When
invoked the usual way (by pressing C or R), these new functions work
exactly as the old ones, i.e. they simply pass the control flow to the
logic already provided by Sunrise, but when prefixed (e.g. by pressing
C-u C or C-u R) they launch a separate Elisp intepreter in the
background, delegate to it the execution of all further operations and
return immediately, so the Emacs UI remains fully responsive while any
potentially long-running copy or move tasks can be let alone to
eventually reach their completion in the background.

After all requested actions have been performed, the background
interpreter remains active for a short period of time (30 seconds by
default, but it can be customized), after which it shuts down
automatically.

At any moment you can abort all tasks scheduled and under execution
and force the background interpreter to shut down by invoking the
`sr-loop-stop' command (M-x sr-loop-stop).

If you need to debug something or are just curious about how this
extension works, you can set the variable `sr-loop-debug' to t to have
the interpreter launched in debug mode. In this mode all input and
output of background operations are sent to a buffer named
*SUNRISE-LOOP*. To return to normal mode set `sr-loop-debug' back to
nil and use `sr-loop-stop' to kill the currently running interpreter.

The extension disables itself and tries to do its best to keep out of
the way when working with remote directories through FTP (e.g. when
using ange-ftp), since in these cases the execution of file transfers
in the background should be managed directly by the FTP client.
