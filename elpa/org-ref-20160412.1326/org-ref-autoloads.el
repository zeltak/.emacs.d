;;; org-ref-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "doi-utils" "doi-utils.el" (22286 19095 830014
;;;;;;  94000))
;;; Generated autoloads from doi-utils.el

(autoload 'doi-utils-get-bibtex-entry-pdf "doi-utils" "\
Download pdf for entry at point if the pdf does not already exist locally.
The entry must have a doi.  The pdf will be saved
to `org-ref-pdf-directory', by the name %s.pdf where %s is the
bibtex label.  Files will not be overwritten.  The pdf will be
checked to make sure it is a pdf, and not some html failure
page.  you must have permission to access the pdf.  We open the pdf
at the end.

\(fn)" t nil)

(autoload 'doi-utils-add-bibtex-entry-from-doi "doi-utils" "\
Add DOI entry to end of a file in the current directory.
Pick the file ending with .bib or in
`org-ref-default-bibliography'.  If you have an active region that
starts like a DOI, that will be the initial prompt.  If no region
is selected and the first entry of the ‘kill-ring’ starts like a
DOI, then that is the intial prompt.  Otherwise, you have to type
or paste in a DOI.
Argument BIBFILE the bibliography to use.

\(fn DOI BIBFILE)" t nil)

(autoload 'doi-utils-doi-to-org-bibtex "doi-utils" "\
Convert a DOI to an ‘org-bibtex’ form and insert it at point.

\(fn DOI)" t nil)

(autoload 'bibtex-set-field "doi-utils" "\
Set FIELD to VALUE in bibtex file.  create field if it does not exist.
Optional argument NODELIM see `bibtex-make-field'.

\(fn FIELD VALUE &optional NODELIM)" t nil)

(autoload 'doi-utils-update-bibtex-entry-from-doi "doi-utils" "\
Update fields in a bibtex entry from the DOI.
Every field will be updated, so previous change will be lost.

\(fn DOI)" t nil)

(autoload 'doi-utils-update-field "doi-utils" "\
Update the field at point in the bibtex entry.
Data is retrieved from the doi in the entry.

\(fn)" t nil)

(autoload 'doi-utils-wos "doi-utils" "\
Open Web of Science entry for DOI.

\(fn DOI)" t nil)

(autoload 'doi-utils-wos-citing "doi-utils" "\
Open Web of Science citing articles entry for DOI.
May be empty if none are found.

\(fn DOI)" t nil)

(autoload 'doi-utils-wos-related "doi-utils" "\
Open Web of Science related articles page for DOI.

\(fn DOI)" t nil)

(autoload 'doi-utils-open "doi-utils" "\
Open DOI in browser.

\(fn DOI)" t nil)

(autoload 'doi-utils-open-bibtex "doi-utils" "\
Search through variable `reftex-default-bibliography' for DOI.

\(fn DOI)" t nil)

(autoload 'doi-utils-crossref "doi-utils" "\
Search DOI in CrossRef.

\(fn DOI)" t nil)

(autoload 'doi-utils-google-scholar "doi-utils" "\
Google scholar the DOI.

\(fn DOI)" t nil)

(autoload 'doi-utils-pubmed "doi-utils" "\
Search Pubmed for the DOI.

\(fn DOI)" t nil)

(autoload 'doi-link-menu "doi-utils" "\
Generate the link menu message, get choice and execute it.
Options are stored in `doi-link-menu-funcs'.
Argument LINK-STRING Passed in on link click.

\(fn LINK-STRING)" t nil)

(autoload 'doi-utils-crossref-citation-query "doi-utils" "\
Query Crossref with the title of the bibtex entry at point.
Get a list of possible matches.  This opens a helm buffer to
select an entry.  The default action inserts a doi and url field
in the bibtex entry at point.  The second action opens the doi
url.  If there is already a doi field, the function raises an
error.

\(fn)" t nil)

(autoload 'doi-utils-debug "doi-utils" "\
Generate an org-buffer showing data about DOI.

\(fn DOI)" t nil)

(autoload 'doi-utils-add-entry-from-crossref-query "doi-utils" "\
Search Crossref with QUERY and use helm to select an entry to add to BIBTEX-FILE.

\(fn QUERY BIBTEX-FILE)" t nil)

;;;***

;;;### (autoloads nil "nist-webbook" "nist-webbook.el" (22286 19095
;;;;;;  653353 220000))
;;; Generated autoloads from nist-webbook.el

(autoload 'nist-webbook-formula "nist-webbook" "\
Search NIST webbook for FORMULA.

\(fn FORMULA)" t nil)

(autoload 'nist-webbook-name "nist-webbook" "\
Search NIST webbook for NAME.

\(fn NAME)" t nil)

;;;***

;;;### (autoloads nil "org-ref" "org-ref.el" (22286 19095 813347
;;;;;;  974000))
;;; Generated autoloads from org-ref.el

(autoload 'org-ref-show-link-messages "org-ref" "\
Turn on link messages.
You will see a message in the minibuffer when on a cite, ref or
label link.

\(fn)" t nil)

(autoload 'org-ref-cancel-link-messages "org-ref" "\
Stop showing messages in minibuffer when on a link.

\(fn)" t nil)

(autoload 'org-ref-change-completion "org-ref" "\
Change the completion backend.
Options are \"org-ref-helm-bibtex\", \"org-ref-helm-cite\",
\"org-ref-ivy-bibtex\" and \"org-ref-reftex\".

\(fn)" t nil)

(autoload 'org-ref-mouse-message "org-ref" "\
Display message for link under mouse cursor.

\(fn)" t nil)

(autoload 'org-ref-mouse-messages-on "org-ref" "\
Turn on mouse messages.

\(fn)" t nil)

(autoload 'org-ref-mouse-messages-off "org-ref" "\
Turn off mouse messages.

\(fn)" t nil)

(autoload 'org-ref-insert-bibliography-link "org-ref" "\
Insert a bibliography with completion.

\(fn)" t nil)

(autoload 'org-ref-list-of-figures "org-ref" "\
Generate buffer with list of figures in them.
ARG does nothing.
Ignore figures in COMMENTED sections.

\(fn &optional ARG)" t nil)

(autoload 'org-ref-list-of-tables "org-ref" "\
Generate a buffer with a list of tables.
ARG does nothing.

\(fn &optional ARG)" t nil)

(autoload 'org-ref-insert-ref-link "org-ref" "\
Completion function for a ref link.

\(fn)" t nil)

(autoload 'org-pageref-insert-ref-link "org-ref" "\
Insert a pageref link with completion.

\(fn)" t nil)

(autoload 'org-ref-define-citation-link "org-ref" "\
Add a citation link of TYPE for `org-ref'.
With optional KEY, set the reftex binding.  For example:
\(org-ref-define-citation-link \"citez\" ?z) will create a new
citez link, with reftex key of z, and the completion function.

\(fn TYPE &optional KEY)" t nil)

(autoload 'org-ref-insert-cite-with-completion "org-ref" "\
Insert a cite link of TYPE with completion.

\(fn TYPE)" t nil)

(autoload 'org-ref-store-bibtex-entry-link "org-ref" "\
Save a citation link to the current bibtex entry.
Save in the default link type.

\(fn)" t nil)

(autoload 'org-ref-index "org-ref" "\
Open an *index* buffer with links to index entries.
PATH is required for the org-link, but it does nothing here.

\(fn &optional PATH)" t nil)

(autoload 'org-ref-open-bibtex-pdf "org-ref" "\
Open pdf for a bibtex entry, if it exists.
assumes point is in
the entry of interest in the bibfile.  but does not check that.

\(fn)" t nil)

(autoload 'org-ref-open-bibtex-notes "org-ref" "\
From a bibtex entry, open the notes if they exist.
If the notes do not exist, then create a heading.

I never did figure out how to use reftex to make this happen
non-interactively.  the `reftex-format-citation' function did not
work perfectly; there were carriage returns in the strings, and
it did not put the key where it needed to be.  so, below I replace
the carriage returns and extra spaces with a single space and
construct the heading by hand.

\(fn)" t nil)

(autoload 'org-ref-open-in-browser "org-ref" "\
Open the bibtex entry at point in a browser using the url field or doi field.

\(fn)" t nil)

(autoload 'org-ref-build-full-bibliography "org-ref" "\
Build pdf of all bibtex entries, and open it.

\(fn)" t nil)

(autoload 'org-ref-extract-bibtex-entries "org-ref" "\
Extract the bibtex entries in the current buffer into a src block.

\(fn)" t nil)

(autoload 'org-ref-find-bad-citations "org-ref" "\
Create a list of citation keys that do not have a matching bibtex entry.
List is displayed in an `org-mode' buffer using the known bibtex
file.  Makes a new buffer with clickable links.

\(fn)" t nil)

(autoload 'org-ref-find-non-ascii-characters "org-ref" "\
Find non-ascii characters in the buffer.  Useful for cleaning up bibtex files.

\(fn)" t nil)

(autoload 'org-ref-sort-bibtex-entry "org-ref" "\
Sort fields of entry in standard order and downcase them.

\(fn)" t nil)

(autoload 'org-ref-clean-bibtex-entry "org-ref" "\
Clean and replace the key in a bibtex entry.
See functions in `org-ref-clean-bibtex-entry-hook'.

\(fn)" t nil)

(autoload 'org-ref-sort-citation-link "org-ref" "\
Replace link at point with sorted link by year.

\(fn)" t nil)

(autoload 'org-ref-swap-citation-link "org-ref" "\
Move citation at point in DIRECTION +1 is to the right, -1 to the left.

\(fn DIRECTION)" t nil)

(autoload 'org-ref-next-key "org-ref" "\
Move cursor to the next cite key when on a cite link.
Otherwise run `right-word'. If the cursor moves off the link,
move to the beginning of the next cite link after this one.

\(fn)" t nil)

(autoload 'org-ref-previous-key "org-ref" "\
Move cursor to the previous cite key when on a cite link.
Otherwise run `left-word'. If the cursor moves off the link,
move to the beginning of the previous cite link after this one.

\(fn)" t nil)

(autoload 'org-ref-link-message "org-ref" "\
Print a minibuffer message about the link that point is on.

\(fn)" t nil)

(autoload 'org-ref-help "org-ref" "\
Open the `org-ref' manual.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-arxiv" "org-ref-arxiv.el" (22286 19095
;;;;;;  940010 488000))
;;; Generated autoloads from org-ref-arxiv.el

(autoload 'arxiv-add-bibtex-entry "org-ref-arxiv" "\
Add bibtex entry for ARXIV-NUMBER to BIBFILE.

\(fn ARXIV-NUMBER BIBFILE)" t nil)

(autoload 'arxiv-get-pdf "org-ref-arxiv" "\
Retrieve a pdf for ARXIV-NUMBER and save it to PDF.

\(fn ARXIV-NUMBER PDF)" t nil)

(autoload 'arxiv-get-pdf-add-bibtex-entry "org-ref-arxiv" "\
Add bibtex entry for ARXIV-NUMBER to BIBFILE.
Remove troublesome chars from the bibtex key, retrieve a pdf
for ARXIV-NUMBER and save it to PDFDIR with the same name of the
key.

\(fn ARXIV-NUMBER BIBFILE PDFDIR)" t nil)

;;;***

;;;### (autoloads nil "org-ref-bibtex" "org-ref-bibtex.el" (22286
;;;;;;  19095 866679 559000))
;;; Generated autoloads from org-ref-bibtex.el

(autoload 'org-ref-bibtex-generate-longtitles "org-ref-bibtex" "\
Generate longtitles.bib which are @string definitions.
The full journal names are in `org-ref-bibtex-journal-abbreviations'.

\(fn)" t nil)

(autoload 'org-ref-bibtex-generate-shorttitles "org-ref-bibtex" "\
Generate shorttitles.bib which are @string definitions.
The abbreviated journal names in `org-ref-bibtex-journal-abbreviations'.

\(fn)" t nil)

(autoload 'org-ref-stringify-journal-name "org-ref-bibtex" "\
Replace journal name in a bibtex entry with a string.
The strings are defined in
`org-ref-bibtex-journal-abbreviations'.  The optional arguments KEY,
START and END allow you to use this with `bibtex-map-entries'

\(fn &optional KEY START END)" t nil)

(autoload 'org-ref-helm-set-journal-string "org-ref-bibtex" "\
Helm interface to set a journal string in a bibtex entry.
Entries come from `org-ref-bibtex-journal-abbreviations'.

\(fn)" t nil)

(autoload 'org-ref-set-journal-string "org-ref-bibtex" "\
Set a bibtex journal name to the string that represents FULL-JOURNAL-NAME.
This is defined in `org-ref-bibtex-journal-abbreviations'.

\(fn FULL-JOURNAL-NAME)" t nil)

(autoload 'org-ref-replace-nonascii "org-ref-bibtex" "\
Hook function to replace non-ascii characters in a bibtex entry.

\(fn)" t nil)

(autoload 'org-ref-title-case-article "org-ref-bibtex" "\
Convert a bibtex entry article title to title-case.
The arguments KEY, START and END are optional, and are only there
so you can use this function with `bibtex-map-entries' to change
all the title entries in articles.

\(fn &optional KEY START END)" t nil)

(autoload 'org-ref-sentence-case-article "org-ref-bibtex" "\
Convert a bibtex entry article title to sentence-case.
The arguments KEY, START and END are optional, and are only there
so you can use this function with `bibtex-map-entries' to change
all the title entries in articles.

\(fn &optional KEY START END)" t nil)

(autoload 'org-ref-bibtex-next-entry "org-ref-bibtex" "\
Jump to the beginning of the next bibtex entry.
N is a prefix argument.  If it is numeric, jump that many entries
forward.  Negative numbers do nothing.

\(fn &optional N)" t nil)

(autoload 'org-ref-bibtex-previous-entry "org-ref-bibtex" "\
Jump to beginning of the previous bibtex entry.
N is a prefix argument.  If it is numeric, jump that many entries back.

\(fn &optional N)" t nil)

(autoload 'org-ref-bibtex-entry-doi "org-ref-bibtex" "\
Get doi from entry at point.

\(fn)" t nil)

(autoload 'org-ref-bibtex-wos "org-ref-bibtex" "\
Open bibtex entry in Web Of Science if there is a DOI.

\(fn)" t nil)

(autoload 'org-ref-bibtex-wos-citing "org-ref-bibtex" "\
Open citing articles for bibtex entry in Web Of Science if
there is a DOI.

\(fn)" t nil)

(autoload 'org-ref-bibtex-wos-related "org-ref-bibtex" "\
Open related articles for bibtex entry in Web Of Science if
there is a DOI.

\(fn)" t nil)

(autoload 'org-ref-bibtex-crossref "org-ref-bibtex" "\
Open the bibtex entry in Crossref by its doi.

\(fn)" t nil)

(autoload 'org-ref-bibtex-google-scholar "org-ref-bibtex" "\
Open the bibtex entry at point in google-scholar by its doi.

\(fn)" t nil)

(autoload 'org-ref-bibtex-pubmed "org-ref-bibtex" "\
Open the bibtex entry at point in Pubmed by its doi.

\(fn)" t nil)

(autoload 'org-ref-bibtex-pdf "org-ref-bibtex" "\
Open the pdf for the bibtex entry at point.
Thin wrapper to get `org-ref-bibtex' to open pdf, because it
calls functions with a DOI argument.

\(fn DOI)" t nil)

(autoload 'org-ref-bibtex "org-ref-bibtex" "\
Menu command to run in a bibtex entry.
Functions from `org-ref-bibtex-menu-funcs'.  They all rely on the
entry having a doi.

\(fn)" t nil)

(autoload 'org-ref-email-bibtex-entry "org-ref-bibtex" "\
Email current bibtex entry at point and pdf if it exists.

\(fn)" t nil)

(autoload 'org-ref-set-bibtex-keywords "org-ref-bibtex" "\
Add KEYWORDS to a bibtex entry.
If KEYWORDS is a list, it is converted to a comma-separated
string.  The KEYWORDS are added to the beginning of the
field.  Otherwise KEYWORDS should be a string of comma-separate
keywords.  Optional argument ARG prefix arg to replace keywords.

\(fn KEYWORDS &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "org-ref-glossary" "org-ref-glossary.el" (22286
;;;;;;  19095 913344 695000))
;;; Generated autoloads from org-ref-glossary.el

(autoload 'org-ref-add-glossary-entry "org-ref-glossary" "\
Insert a new glossary entry.
LABEL is how you refer to it with links.
NAME is the name of the entry to be defined.
DESCRIPTION is the definition of the entry.
Entry gets added after the last #+latex_header line.

\(fn LABEL NAME DESCRIPTION)" t nil)

(autoload 'org-ref-add-acronym-entry "org-ref-glossary" "\
Add an acronym entry with LABEL.
ABBRV is the abbreviated form.
FULL is the expanded acronym.

\(fn LABEL ABBRV FULL)" t nil)

(autoload 'org-ref-insert-glossary-link "org-ref-glossary" "\
Helm command to insert glossary and acronym entries as links.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-helm" "org-ref-helm.el" (22286 19095
;;;;;;  876679 231000))
;;; Generated autoloads from org-ref-helm.el

(autoload 'org-ref-helm-insert-label-link "org-ref-helm" "\
Insert a label link.
Helm just shows you what labels already exist.  If you are on a
label link, replace it.

\(fn)" t nil)

(autoload 'org-ref-helm-insert-ref-link "org-ref-helm" "\
Helm menu to insert ref links to labels in the document.
If you are on link, replace with newly selected label.  Use
\\[universal-argument] to insert a different kind of ref link.
Use a double \\[universal-argument] \\[universal-argument] to insert a
\[[#custom-id]] link

\(fn)" t nil)

(autoload 'org-ref "org-ref-helm" "\
Opens a helm interface to actions for `org-ref'.
Shows bad citations, ref links and labels.
This widens the file so that all links go to the right place.

\(fn)" t nil)

(autoload 'helm-tag-bibtex-entry "org-ref-helm" "\
Helm interface to add keywords to a bibtex entry.
Run this with the point in a bibtex entry.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-helm-bibtex" "org-ref-helm-bibtex.el"
;;;;;;  (22286 19095 856679 886000))
;;; Generated autoloads from org-ref-helm-bibtex.el

(autoload 'org-ref-bibtex-completion-completion "org-ref-helm-bibtex" "\
Use helm and ‘helm-bibtex’ for completion.

\(fn)" t nil)

(autoload 'org-ref-helm-insert-cite-link "org-ref-helm-bibtex" "\
Insert a citation link with `helm-bibtex'.
With one prefix ARG, insert a ref link.
With two prefix ARGs, insert a label link.

\(fn ARG)" t nil)

(autoload 'org-ref-cite-click-helm "org-ref-helm-bibtex" "\
Open helm for actions on a cite link.
subtle points.

1. get name and candidates before entering helm because we need
the org-buffer.

2. switch back to the org buffer before evaluating the
action.  most of them need the point and buffer.

KEY is returned for the selected item(s) in helm.

\(fn KEY)" t nil)

;;;***

;;;### (autoloads nil "org-ref-isbn" "org-ref-isbn.el" (22286 19095
;;;;;;  886678 903000))
;;; Generated autoloads from org-ref-isbn.el

(autoload 'isbn-to-bibtex-lead "org-ref-isbn" "\
Search lead.to for ISBN bibtex entry.
You have to copy the entry if it is on the page to your bibtex
file.

\(fn ISBN)" t nil)

(autoload 'isbn-to-bibtex "org-ref-isbn" "\
Get bibtex entry for ISBN and insert it into BIBFILE.
Nothing happens if an entry with the generated key already exists
in the file. Data comes from worldcat.

\(fn ISBN BIBFILE)" t nil)

;;;***

;;;### (autoloads nil "org-ref-ivy-bibtex" "org-ref-ivy-bibtex.el"
;;;;;;  (22286 19095 976675 952000))
;;; Generated autoloads from org-ref-ivy-bibtex.el

(autoload 'org-ref-ivy-bibtex-completion "org-ref-ivy-bibtex" "\
Use helm and ‘helm-bibtex’ for completion.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-latex" "org-ref-latex.el" (22286 19095
;;;;;;  663352 893000))
;;; Generated autoloads from org-ref-latex.el

(autoload 'org-ref-latex-debug "org-ref-latex" "\


\(fn)" t nil)

(autoload 'org-ref-latex-click "org-ref-latex" "\
Jump to entry clicked on.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-pdf" "org-ref-pdf.el" (22286 19095
;;;;;;  846680 215000))
;;; Generated autoloads from org-ref-pdf.el

(autoload 'org-ref-pdf-dnd-func "org-ref-pdf" "\
Drag-n-drop support to add a bibtex entry from a pdf file.

\(fn EVENT)" t nil)

(autoload 'org-ref-pdf-dir-to-bibtex "org-ref-pdf" "\
Create BIBFILE from pdf files in DIRECTORY.

\(fn BIBFILE DIRECTORY)" t nil)

(autoload 'org-ref-pdf-debug-pdf "org-ref-pdf" "\
Try to debug getting a doi from a pdf.
Opens a buffer with the pdf converted to text, and `occur' on the
variable `org-ref-pdf-doi-regex'.

\(fn PDF-FILE)" t nil)

;;;***

;;;### (autoloads nil "org-ref-pubmed" "org-ref-pubmed.el" (22286
;;;;;;  19095 696685 133000))
;;; Generated autoloads from org-ref-pubmed.el

(autoload 'pubmed-insert-bibtex-from-pmid "org-ref-pubmed" "\
Insert a bibtex entry at point derived from PMID.
You must clean the entry after insertion.

\(fn PMID)" t nil)

(autoload 'pubmed-get-medline-xml "org-ref-pubmed" "\
Get MEDLINE xml for PMID as a string.

\(fn PMID)" t nil)

(autoload 'pubmed "org-ref-pubmed" "\
Open http://www.ncbi.nlm.nih.gov/pubmed in a browser.

\(fn)" t nil)

(autoload 'pubmed-advanced "org-ref-pubmed" "\
Open http://www.ncbi.nlm.nih.gov/pubmed/advanced in a browser.

\(fn)" t nil)

(autoload 'pubmed-simple-search "org-ref-pubmed" "\
Open QUERY in Pubmed in a browser.

\(fn QUERY)" t nil)

;;;***

;;;### (autoloads nil "org-ref-reftex" "org-ref-reftex.el" (22286
;;;;;;  19095 920011 143000))
;;; Generated autoloads from org-ref-reftex.el

(autoload 'org-ref-reftex-completion "org-ref-reftex" "\
Use reftex and org-mode for completion.

\(fn)" t nil)

(autoload 'org-ref-open-notes-from-reftex "org-ref-reftex" "\
Call reftex, and open notes for selected entry.

\(fn)" t nil)

(autoload 'org-ref-cite-onclick-minibuffer-menu "org-ref-reftex" "\
Action when a cite link is clicked on.
Provides a menu of context sensitive actions.  If the bibtex entry
has a pdf, you get an option to open it.  If there is a doi, you
get a lot of options.  LINK-STRING is used by the link function.

\(fn &optional LINK-STRING)" t nil)

;;;***

;;;### (autoloads nil "org-ref-scifinder" "org-ref-scifinder.el"
;;;;;;  (22286 19095 960009 832000))
;;; Generated autoloads from org-ref-scifinder.el

(autoload 'scifinder "org-ref-scifinder" "\
Open https://scifinder.cas.org/scifinder/view/scifinder/scifinderExplore.jsf in a browser.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-ref-scopus" "org-ref-scopus.el" (22286
;;;;;;  19095 676685 789000))
;;; Generated autoloads from org-ref-scopus.el

(autoload 'scopus-related-by-keyword-url "org-ref-scopus" "\
Return a Scopus url to articles related by keyword for DOI.

\(fn DOI)" t nil)

(autoload 'scopus-related-by-author-url "org-ref-scopus" "\
Return a Scopus url to articles related by author for DOI.

\(fn DOI)" t nil)

(autoload 'scopus-related-by-references-url "org-ref-scopus" "\
Return a Scopus url to articles related by references for DOI.

\(fn DOI)" t nil)

(autoload 'scopus-open-eid "org-ref-scopus" "\
Open article with EID in browser.

\(fn EID)" t nil)

(autoload 'scopus-basic-search "org-ref-scopus" "\
Open QUERY as a basic title-abstract-keyword search at scopus.com.

\(fn QUERY)" t nil)

(autoload 'scopus-advanced-search "org-ref-scopus" "\
Open QUERY as an advanced search at scopus.com.

\(fn QUERY)" t nil)

;;;***

;;;### (autoloads nil "org-ref-url-utils" "org-ref-url-utils.el"
;;;;;;  (22286 19095 893345 351000))
;;; Generated autoloads from org-ref-url-utils.el

(autoload 'org-ref-url-debug-url "org-ref-url-utils" "\
Open a buffer to URL with all doi patterns highlighted.

\(fn URL)" t nil)

(autoload 'org-ref-url-dnd-debug "org-ref-url-utils" "\
Drag-n-drop function to debug a url.

\(fn EVENT)" t nil)

(autoload 'org-ref-url-dnd-all "org-ref-url-utils" "\
Drag-n-drop function to get all DOI bibtex entries for a url.
You probably do not want to do this since the DOI patterns are
not perfect, and some hits are not actually DOIs.

\(fn EVENT)" t nil)

(autoload 'org-ref-url-dnd-first "org-ref-url-utils" "\
Drag-n-drop function to download the first DOI in a url.

\(fn EVENT)" t nil)

;;;***

;;;### (autoloads nil "org-ref-utils" "org-ref-utils.el" (22286 19095
;;;;;;  840013 767000))
;;; Generated autoloads from org-ref-utils.el

(autoload 'org-ref-version "org-ref-utils" "\
Provide a version string for org-ref.
Copies the string to the clipboard.

\(fn)" t nil)

(autoload 'org-ref-debug "org-ref-utils" "\
Print some debug information to a buffer.

\(fn)" t nil)

(autoload 'org-ref-open-pdf-at-point "org-ref-utils" "\
Open the pdf for bibtex key under point if it exists.

\(fn)" t nil)

(autoload 'org-ref-open-url-at-point "org-ref-utils" "\
Open the url for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-open-notes-at-point "org-ref-utils" "\
Open the notes for bibtex key under point in a cite link in a buffer.
Can also be called with THEKEY in a program.

\(fn &optional THEKEY)" t nil)

(autoload 'org-ref-citation-at-point "org-ref-utils" "\
Give message of current citation at point.

\(fn)" t nil)

(autoload 'org-ref-open-citation-at-point "org-ref-utils" "\
Open bibtex file to key at point.

\(fn)" t nil)

(autoload 'org-ref-copy-entry-as-summary "org-ref-utils" "\
Copy the bibtex entry for the citation at point as a summary.

\(fn)" t nil)

(autoload 'org-ref-copy-entry-at-point-to-file "org-ref-utils" "\
Copy the bibtex entry for the citation at point to NEW-FILE.
Prompt for NEW-FILE includes bib files in
`org-ref-default-bibliography', and bib files in current working
directory.  You can also specify a new file.

\(fn)" t nil)

(autoload 'org-ref-wos-at-point "org-ref-utils" "\
Open the doi in wos for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-wos-citing-at-point "org-ref-utils" "\
Open the doi in wos citing articles for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-wos-related-at-point "org-ref-utils" "\
Open the doi in wos related articles for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-google-scholar-at-point "org-ref-utils" "\
Open the doi in google scholar for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-pubmed-at-point "org-ref-utils" "\
Open the doi in pubmed for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-crossref-at-point "org-ref-utils" "\
Open the doi in crossref for bibtex key under point.

\(fn)" t nil)

(autoload 'org-ref-bibliography "org-ref-utils" "\
Create a new buffer with a bibliography.
If SORT is non-nil it is alphabetically sorted by key
This is mostly for convenience to see what has been cited.
Entries are formatted according to the bibtex entry type in
`org-ref-bibliography-entry-format', and the actual entries are
generated by `org-ref-reftex-format-citation'.

\(fn &optional SORT)" t nil)

;;;***

;;;### (autoloads nil "org-ref-wos" "org-ref-wos.el" (22286 19095
;;;;;;  643353 548000))
;;; Generated autoloads from org-ref-wos.el

(autoload 'wos-search "org-ref-wos" "\
Open the word at point or selection in Web of Science as a topic query.

\(fn)" t nil)

(autoload 'wos "org-ref-wos" "\
Open Web of Science search page in a browser.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "x2bib" "x2bib.el" (22286 19095 950010 160000))
;;; Generated autoloads from x2bib.el

(autoload 'ris2bib "x2bib" "\
Convert RISFILE to bibtex and insert at point.
Without a prefix arg, stderr is diverted.
If VERBOSE is non-nil show command output.

\(fn RISFILE &optional VERBOSE)" t nil)

(autoload 'medxml2bib "x2bib" "\
Convert MEDFILE (in Pubmed xml) to bibtex and insert at point.
Without a prefix arg, stderr is diverted.
Display output if VERBOSE is non-nil.

\(fn MEDFILE &optional VERBOSE)" t nil)

(autoload 'clean-entries "x2bib" "\
Map over bibtex entries and clean them.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("org-ref-helm-cite.el" "org-ref-pkg.el"
;;;;;;  "org-ref-sci-id.el" "org-ref-worldcat.el") (22286 19095 998977
;;;;;;  583000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; org-ref-autoloads.el ends here
