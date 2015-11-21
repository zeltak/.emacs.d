   PopViewer Extension for the Sunrise Commander file manager.

This package is an enhancement for the Sunrise Commander, which is a
two-pane file manager, like Midnight Commander or Total Commander.

This extension advises several Sunrise Commander functions in order to
make the viewer window "float", i.e. instead of having a dedicated
window sitting under the panes all the time, a new frame is displayed
whenever the user requests to view a file (by pressing "o" or "v") or
to open a command line in the current directory.

Alternatively, it can be configured to make use of the pasive pane as
a transient viewer (and then press \ in the active pane to return to
normal state).

WARNING: This code and the Buttons extension (sunrise-x-buttons) do
NOT mix together, if you're using the Buttons extension remove it
first from your .emacs file.
