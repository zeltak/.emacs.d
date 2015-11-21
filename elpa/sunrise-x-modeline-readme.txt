   Modeline Extension for the Sunrise Commander file manager.

This package is an enhancement for the Sunrise Commander, which is a
two-pane file manager, like Midnight Commander or Total Commander.

It modifies the format of the mode lines under the Sunrise Commander
panes so they display only the paths to the current directories (or
the tail if the whole path is too long) and a row of three small
icons. These icons are by default plain ASCII characters, but nicer
semigraphical versions (in Unicode) can also be used by customizing
the variable `sr-modeline-use-utf8-marks'.

Here is the complete list of indicator icons (in ASCII) and their
respective meanings:


1. Pane modes:          *   Normal mode.
                        !   Editable Pane mode.
                        @   Virtual Directory mode.
                        T   Tree View mode (with tree extension).

2. Navigation modes:    &   Synchronized Navigation.
                        $   Sticky Search.

3. Transient states:    #   Contents snapshot available.


The regular mode line format remains available: press C-c m to toggle
between one format and the other.

The extension is provided as a minor mode, so you can enable / disable
it totally by issuing the command `sr-modeline'.
