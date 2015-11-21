   Mirror Extension for the Sunrise Commander file manager.

This package is an enhancement for the Sunrise Commander, which is a
two-pane file manager, like Midnight Commander or Total Commander.

It allows browsing compressed archives in full read-write
mode. Sunrise does offer means for transparent browsing archives
(using AVFS), but they just provide read-only navigation -- if you
want to edit a file inside the virtual filesystem, copy, remove, or
rename anything, you still have to uncompress the archive, do the
stuff and compress it back yourself.

It uses one or unionfs-fuse or funionfs to create a writeable overlay
on top of the read-only filesystem provided by AVFS. You can freely
add, remove or modify anything inside the resulting union filesystem
(a.k.a. the "mirror area"), and then commit all modifications (or not)
to the original archive with a single keystroke. There is no
preliminary uncompressing of the archive and nothing happens if you
don't make changes (or if you don't commit them).  On commit, the
contents of the union fs are compressed to create an updated archive
to replace the original one (optionally after making a backup copy of
it, just in case).

Navigating outside a mirror area will automatically close it, so if
you do it you may be asked whether to commit or not to the archive all
your changes. In nested archives (e.g. a jar inside a zip inside a
tgz), partial modifications are committed silently on the fly if
moving out from a modified archive to one that contains it. Only if
you leave the topmost mirror area you will be asked for confirmation
whether to modify the resulting archive.

Be warned, though, that this method may be impractical for very large
or very deeply nested archives with strong compression, since the
uncompressing happens in the final stage and requires multiple access
operations through AVFS. What this means is that probably you'll have
to wait a looooong time if you try to commit changes to a tar.bz2 file
with several hundreds of megabytes in size, or under five or six other
layers of strong compression.

For this extension to work you must have:

  1) FUSE + AVFS support in your Sunrise Commander. If you can
  navigate (read- only) inside compressed archives you already have
  this.
  
  2) One of unionfs-fuse or funionfs. Debian squeeze (stable) offers a
  package for the first, which is currently the recommended
  implementation.
  
  3) Programs required for repacking archives -- at least zip and tar.
  
  4) Your AVFS mount point (and the value of variable `sr-avfs-root')
  must be in a directory where you have writing access.

All this means is that most probably this extension will work
out-of-the-box on Linux (or MacOS, or other unices), but you'll have a
hard time to make it work on Windows.
