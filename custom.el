(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-isearch-function (quote ace-jump-char-mode))
 '(ace-isearch-input-idle-delay 0.4)
 '(ace-isearch-input-length 9)
 '(ace-isearch-submode (quote ace-jump-char-mode))
 '(ace-isearch-use-ace-jump (quote printing-char))
 '(ace-isearch-use-jump (quote printing-char))
 '(ansi-color-names-vector
   ["#242424" "#E5786D" "#95E454" "#CAE682" "#8AC6F2" "#333366" "#CCAA8F" "#F6F3E8"])
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" . t)))
 '(elfeed-feeds
   (quote
    ("http://phdcomics.com/gradfeed.php" "http://wtfevolution.tumblr.com/rss" "http://theoatmeal.com/feed/rss" "http://researchinprogress.tumblr.com/rss" "http://feeds.feedburner.com/bazekalim" "http://feeds2.feedburner.com/thai-food-blog/main" "http://www.tapuz.co.il/blog/rssBlog.asp?FolderName=TickTack" "http://feeds2.feedburner.com/humus101rss" "http://feeds.feedburner.com/ptitim" "http://what-efrat.blogspot.com/feeds/posts/default" "http://lifehacker.com/index.xml" "http://feeds.feedburner.com/Makeuseof" "http://www.tuxradar.com/rss" "http://xbmc.org/feed/" "http://www.engadget.com/rss.xml" "http://oremacs.com/atom.xml" "http://karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-and-content.xml" "http://alinuxblog.wordpress.com/feed/" "http://emacsmovies.org/atom.xml" "http://endlessparentheses.com/atom.xml" "http://thelinuxrain.com/feed" "http://planet.emacsen.org/atom.xml" "http://sachachua.com/blog/feed/" "http://kitchingroup.cheme.cmu.edu/blog/feed" "http://whattheemacsd.com/atom.xml" "http://adventuresinopensource.blogspot.com/feeds/posts/default" "http://adventuresinubuntu.blogspot.com/feeds/posts/default" "http://feeds.feedburner.com/AllAboutLinux" "http://amarok.kde.org/blog/feeds/index.rss2" "http://ampache.org/blog/index.php?/feeds/index.rss2" "http://www.archlinux.org/feeds/news/" "http://www.debuntu.org/feed" "http://www.freesoftwaremagazine.com/rss.xml" "http://www.fsdaily.com/feed/published/All" "http://www.kde.org/dotkdeorg.rdf" "http://www.linuxjournal.com/node/feed" "http://linuxondesktop.blogspot.com/feeds/posts/default" "http://www.go2linux.org/rss.xml" "http://www.lunduke.com/?feed=rss2" "http://mostlycli.blogspot.com/feeds/posts/default" "http://kmandla.wordpress.com/feed/" "http://mylinuxramblings.wordpress.com/feed/" "http://pentablg.blogspot.com/feeds/posts/default" "http://www.phoronix.com/rss.php" "http://planet.linux.org.il/atom.xml" "http://planetkde.org/rss20.xml" "http://ubuntuweblogs.org/atom.xml" "http://blog.sarine.nl/feed/" "http://rss.slashdot.org/Slashdot/slashdotLinux" "http://subforge.org/projects/subtle/news.atom" "http://thedailyubuntu.blogspot.com/feeds/posts/default" "http://whatsup.org.il/backend.php" "https://bbs.archlinux.org/extern.php?action=feed&fid=27&type=atom" "http://e17releasemanager.wordpress.com/feed/" "http://www.masteringemacs.org/feed/" "http://www.geekologie.com/index.xml" "http://feeds.feedburner.com/xda-developers/ShsH" "http://debuzzer.com/feed/" "http://emacsredux.com/atom.xml" "http://rforpublichealth.blogspot.com/feeds/posts/default" "http://renkun.me/atom.xml" "http://www.lunaryorn.com/feed.atom" "http://debuzzer.com/" "http://googlecode.blogspot.com/atom.xml" "http://igurublog.wordpress.com/feed/" "http://inconsolation.wordpress.com/feed/" "https://muspy.com/feed?id=f9qypqwxc658e6dbzwk8n9mqthsgv4" "http://feeds.feedburner.com/yuval" "http://xkcd.com/rss.xml")))
 '(image-dired-db-file "/home/zeltak/.emacs.t/image-dired/.image-dired_db")
 '(image-dired-dir "~/.emacs.t/image-dired/")
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files
   (quote
    ("/home/zeltak/org/files/agenda/Research.org" "/home/zeltak/org/files/agenda/TODO.org" "/home/zeltak/org/files/agenda/dl.org" "/home/zeltak/org/files/agenda/food.org" "/home/zeltak/org/files/agenda/travel.org")))
 '(org-capture-after-finalize-hook nil)
 '(org-download-image-width 300)
 '(org-download-screenshot-method "gm import %s")
 '(sr-avfs-root "~/.avfs")
 '(sr-history-length 30)
 '(sr-popviewer-enabled t)
 '(sr-show-hidden-files t)
 '(sr-traditional-other-window nil)
 '(sr-use-commander-keys nil)
 '(sr-windows-default-ratio 88))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t)
 '(sr-active-path-face ((t (:background "DodgerBlue4" :foreground "deep sky blue" :weight bold))))
 '(sr-symlink-face ((t (:foreground "dim gray" :slant italic)))))
