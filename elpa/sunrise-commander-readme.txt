   Sunrise Commander: Two-pane file manager for Emacs based on Dired.

The Sunrise Commmander is a powerful and versatile double-pane file manager
for GNU Emacs. It's built atop of Dired and takes advantage of most of its
functions, but also provides many handy features of its own:

 * Sunrise is implemented as a derived major mode confined inside the pane
 buffers, so its buffers and Dired ones can live together without easymenu
 or viper to avoid key binding collisions.
 
 * It automatically closes unused buffers and tries to never keep open more
 than the one or two used to display the panes, though this behavior may be
 disabled if desired.
 
 * Each pane has its own history stack: press M-y / M-u for moving
 backwards / forwards in the history of directories.
 
 * Press M-t to swap (transpose) the panes.
 
 * Press C-= for "smart" file comparison using `ediff'. It compares together
 the first two files marked on each pane or, if no files have been marked, it
 assumes that the second pane contains a file with the same name as the
 selected one and tries to compare these two. You can also mark whole lists of
 files to be compared and then just press C-= for comparing the next pair.
 
 * Press = for fast "smart" file comparison -- like above, but using regular
 diff.
 
 * Press C-M-= for directory comparison (by date / size / contents of files).
 
 * Press C-c C-s to change the layout of the panes (horizontal/vertical/top)
 
 * Press C-c / to interactively refine the contents of the current pane using
 fuzzy (a.k.a. flex) matching, then:
    - press Delete or Backspace to revert the buffer to its previous state
    - press Return, C-n or C-p to exit and accept the current narrowed state
    - press Esc or C-g to abort the operation and revert the buffer
    - use ! to prefix characters that should NOT appear after a given position
 Once narrowed and accepted, you can restore the original contents of the pane
 by pressing g (revert-buffer).
 
 * Sticky search: press C-c s to launch an interactive search that will remain
 active from directory to directory, until you hit a regular file or press C-g
 
 * Press C-x C-q to put the current pane in Editable Dired mode (allows to
 edit the pane as if it were a regular file -- press C-c C-c to commit your
 changes to the filesystem, or C-c C-k to abort).
 
 * Press y to recursively calculate the total size (in bytes) of all files and
 directories currently selected/marked in the active pane.
 
 * Sunrise VIRTUAL mode integrates dired-virtual mode to Sunrise, allowing to
 capture find and locate results in regular files and to use them later as if
 they were directories with all Dired and Sunrise operations at your
 fingertips.
 The results of the following operations are displayed in VIRTUAL mode:
    - find-name-dired (press C-c C-n),
    - find-grep-dired (press C-c C-g),
    - find-dired      (press C-c C-f),
    - locate          (press C-c C-l),
    - list all recently visited files (press C-c C-r -- requires recentf),
    - list all directories in active pane's history ring (press C-c C-d).
 
 * Supports AVFS (http://avf.sourceforge.net/) for transparent navigation
 inside compressed archives (*.zip, *.tgz, *.tar.bz2, *.deb, etc. etc.)
 You need to have AVFS with coda or fuse installed and running on your system
 for this to work, though.
 
 * Opening terminals directly from Sunrise:
    - Press C-c C-t to inconditionally open a new terminal into the currently
      selected directory in the active pane.
    - Use C-c t to switch to the last opened terminal, or (when already inside
      a terminal) to cycle through all open terminals.
    - Press C-c T to switch to the last opened terminal and change directory
      to the one in the current directory.
    - Press C-c M-t to be prompted for a program name, and then open a new
      terminal using that program into the currently selected directory
      (eshell is a valid value; if no program can be found with the given name
      then the value of `sr-terminal-program' is used instead).
 
 * Terminal integration and Command line expansion: integrates tightly with
 `eshell' and `term-mode' to allow interaction between terminal emulators in
 line mode (C-c C-j) and the panes: the most important navigation commands
 (up, down, mark, unmark, go to parent dir) can be executed on the active pane
 directly from the terminal by pressing the usual keys with Meta: <M-up>,
 <M-down>, etc. Additionally, the following substitutions are automagically
 performed in `eshell' and `term-line-mode':
     %f - expands to the currently selected file in the left pane
     %F - expands to the currently selected file in the right pane
     %m - expands to the list of paths of all marked files in the left pane
     %M - expands to the list of paths of all marked files in the right pane
     %n - expands to the list of names of all marked files in the left pane
     %N - expands to the list of names of all marked files in the right pane
     %d - expands to the current directory in the left pane
     %D - expands to the current directory in the right pane
     %a - expands to the list of paths of all marked files in the active pane
     %A - expands to the current directory in the active pane
     %p - expands to the list of paths of all marked files in the passive pane
     %P - expands to the current directory in the passive pane
 
 * Cloning of complete directory trees: press K to clone the selected files
 and directories into the passive pane. Cloning is a more general operation
 than copying, in which all directories are recursively created with the same
 names and structures at the destination, while what happens to the files
 within them depends on the option you choose:
    - "(F)ile System of..." clones the FS structure of paths in a VIRTUAL pane,
    - "(D)irectories only" ignores all files, copies only directories,
    - "(C)opies" performs a regular recursive copy of all files and dirs,
    - "(H)ardlinks" makes every new file a (hard) link to the original one
    - "(S)ymlinks" creates absolute symbolic links for all files in the tree,
    - "(R)elative symlinks” creates relative symbolic links.
 
 * Passive navigation: the usual navigation keys (n, p, Return, U, ;) combined
 with Meta allow to move across the passive pane without actually having to
 switch to it.
 
 * Synchronized navigation: press C-c C-z to enable / disable synchronized
 navigation. In this mode, the passive navigation keys (M-n, M-p, M-Return,
 etc.) operate on both panes simultaneously. I've found this quite useful for
 comparing hierarchically small to medium-sized directory trees (for large to
 very large directory trees one needs something on the lines of diff -r
 though).
 
And much more -- press ? while in Sunrise mode for basic help, or h for a
complete list of all keybindings available.
