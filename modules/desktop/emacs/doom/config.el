(setq user-full-name "Marvin Strangfeld"
      user-mail-address "marvin@strangfeld.io")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 26 :slant 'normal :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 26))

(setq doom-theme 'doom-material-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq ispell-dictionary "en")

(use-package! forge
  :config
  (add-to-list 'forge-alist '("gitlab.open-xchange.com" "gitlab.open-xchange.com/api/v4" "gitlab.open-xchange.com" forge-gitlab-repository)))

(use-package! go-translate
  :config
  (setq gts-translate-list '(("de" "en")))
  (setq gts-default-translator
        (gts-translator
         :picker (gts-prompt-picker)
         :engines (list
                   (gts-google-engine))
         :render (gts-buffer-render)))
  )

(map! :leader
      (:prefix-map ("l" . "language")
       (:desc "Translate" "t" #'gts-do-translate
        :desc "Synonyms" "s" #'powerthesaurus-lookup-synonyms-dwim)))

;; Org stuff

(setq org-directory "~/org/")
(setq org-latex-pdf-process '("latexmk -shell-escape -pdf -bibtex -f %f"))

(after! org
  (require 'org-ref))

(use-package! ox-extra
  :after org
  :config
  (ox-extras-activate '(ignore-headlines)))

(use-package! ox-latex
  :config
  (add-to-list 'org-latex-classes
               '("scrartcl"
                 "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

(after! org-ref
  (setq
   bibtex-completion-notes-path (concat (getenv "HOME") "/Documents/Notes/")
   bibtex-completion-bibliography (concat (getenv "HOME") "/Zotero/bibtex/library.bib")
   bibtex-completion-pdf-field "file"
   bibtex-completion-notes-template-multiple-files
   (concat
    "#+TITLE: ${title}\n"
    "#+ROAM_KEY: cite:${=key=}\n"
    "#+ROAM_TAGS: ${keywords}\n"
    "* TODO Notes\n"
    ":PROPERTIES:\n"
    ":Custom_ID: ${=key=}\n"
    ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
    ":AUTHOR: ${author-abbrev}\n"
    ":JOURNAL: ${journaltitle}\n"
    ":DATE: ${date}\n"
    ":YEAR: ${year}\n"
    ":DOI: ${doi}\n"
    ":URL: ${url}\n"
    ":END:\n\n"
    )
   )
  )

(use-package! org-ref
  :config
  (setq
   org-ref-completion-library 'org-ref-ivy-cite
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   bibtex-completion-bibliography (list (concat (getenv "HOME") "/Zotero/bibtex/library.bib"))
   bibtex-completion-notes-path (concat (getenv "HOME") "/Documents/Notes/bibnotes.org")
   org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
   org-ref-notes-directory (concat (getenv "HOME") "/Documents/Notes/")
   org-ref-notes-function 'orb-edit-notes
   )
  (add-hook 'org-export-before-parsing-hook #'org-ref-glossary-before-parsing))

;; E-Mail settings

(use-package! mu4e
  :config
  ;; Avoid deleting the message and move to the trash folder instead
  (setf (plist-get (alist-get 'trash mu4e-marks) :action)
        (lambda (docid msg target)
          (mu4e--server-move docid (mu4e--mark-check-target target) "+S-u-N"))) ; Instead of "+T-N"
  )

(set-email-account! "strangfeld-io"
                    '( (mu4e-sent-folder       . "/strangfeld-io/Sent")
                       (mu4e-drafts-folder     . "/strangfeld-io/Drafts")
                       (mu4e-trash-folder      . "/strangfeld-io/Trash")
                       ;; Dynamic archiving under the year of the message (What Open-Xchange does)
                       (mu4e-refile-folder     . (lambda (msg)
                                                   (let* ((time (mu4e-message-field-raw msg :date)))
                                                     (format-time-string "/strangfeld-io/Archive/%Y" time))
                                                   ))
                       (smtpmail-smtp-user     . "marvin@strangfeld.io")
                       (mu4e-maildir-shortcuts
                        ("/strangfeld-io/Inbox" . ?i)
                        ("/strangfeld-io/Drafts" . ?d)
                        ("/strangfeld-io/Sent" . ?s)
                        ("/strangfeld-io/Trash" . ?t)
                        )
                       )
                    t)

(setq sendmail-program "/etc/profiles/per-user/marvin/bin/msmtp"
      send-mail-function #'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function #'message-send-mail-with-sendmail)
