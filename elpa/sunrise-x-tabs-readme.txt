   Tab-based Navigation for the Sunrise Commander file manager.

This package is an enhancement for the Sunrise Commander, which is a
two-pane file manager, like Midnight Commander or Total Commander.

It adds to the list of optional mechanisms already available in
Sunrise for moving around the file system (like regular bookmarks,
checkpoints, history rings, materialized virtual buffers, navigable
paths and file-following) another way to maintain a list of selected
locations one wants to return later on, or to compose "breadcrumb
trails" for complex repetitive operations.

The main difference between tabs and other mechanisms is that once a
buffer has been assigned to a tab, it will not be killed automatically
by Sunrise, so it's possible to keep it around as long as necessary
with all its marks and state untouched. Tabs can be persisted across
sessions using the DeskTop feature.

Creating, using and destroying tabs are fast and easy operations,
either with mouse or keyboard:

  * Press C-j (or select Sunrise > Tabs > Add Tab in the menu) to
  create a new tab or to rename an already existing tab.
  
  * Press C-k (or right-click the tab) to kill an existing
  tab. Combine with M- (M-C-k) to kill the tab on the passive
  pane. Prefix with a digit to kill tabs by relative order (e.g. 2 C-k
  kills the second tab in the current pane, while 4 M-C-k kills the
  fourth tab in the passive pane).
  
  * Press C-n and C-p to move from tab to tab ("Next", "Previous"), or
  simply left-click on the tab to focus its assigned buffer. These two
  keybindings can be prefixed with an integer to move faster.
  
  * The last four bindings can be combined with Meta (i.e. M-C-j,
  M-C-k, M-C-n and M-C-p) to perform the equivalent operation on the
  passive pane or (when in synchronized navigation mode) on both panes
  simultaneously.
  
  * Press * C-k to kill in one go all the tabs in the current
  pane. Similarly, press * M-C-k to wipe all the tabs off the passive
  pane or (when synchronized mode is active) on both panes
  simultaneously.
  
  * Killing the current buffer with C-x k automatically switches to
  the one assigned to the first available tab (if any).

The extension is provided as a minor mode, so you can enable / disable
it totally by using the command `sr-tabs-mode'.

It does *not* pretend to be a generic solution for tabs in Emacs. See
TabBar mode (http://www.emacswiki.org/emacs/TabBarMode) by David Ponce
if you need one. I wrote this just because it turned out to be easier
to write this than to customize tabbar to behave exactly like I wanted
inside the Sunrise panes. It's meant to be simple and to work nicely
with Sunrise with just a few tabs (up to 10-15 per pane, maybe).
