(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

(load-file "c:\\emacs\\custom-el-files\\sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(setq user-full-name "Kaleb C. Papesh"
      user-mail-address "kaleb.papesh@gmail.com"
      calendar-latitude 34.729542
      calendar-longitude -86.585297
      calendar-location-name "Huntsville, AL")

;;remove toolbar, menu, & scrollbar;
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

;;remove scrollbar in minibuffer
(set-window-scroll-bars (minibuffer-window) nil nil)

;;remove default start-up buffer
(setq inhibit-startup-message t)

;;implement colour coding
(global-font-lock-mode t)

;;show pretty symbols
(global-prettify-symbols-mode t)

;;use moody modeline
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

;;never show minor modes
(use-package minions
  :config
  (setq minions-mode-line-lighter ""
        minions-mode-line-delimiters '("" . ""))
  (minions-mode 1))

;;softly highlight the background of a line
(global-hl-line-mode)

;;show highlite different changes
(use-package diff-hl
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

;;change the ... for minimized org things
(setq org-ellipsis " ->>")
(setq org-src-fontify-natively t)
(setq org-src-window-setup 'current-window)
(add-to-list 'org-structure-template-alist
             '("el" . "src emacs-lisp"))

;;remove the window title
;;(setq frame-title-format '((:eval (projectile-project-name))))

;;  This makes Emacs ignore the "-e (make-frame-visible)"
;;  that it gets passed when started by emacsclientw.
;;
;;(add-to-list 'command-switch-alist '("(raise-frame)" .
;;				     (lambda (s))))

;;set default font
(setq kcp/default-font "Inconsolata")
(setq kcp/default-font-size 14)
(setq kcp/current-font-size kcp/default-font-size)

(setq kcp/font-change-increment 1.1)

(defun kcp/font-code ()
  "Return a string representing the current font (like \"Inconsolata-14\")."
  (concat kcp/default-font "-" (number-to-string kcp/current-font-size)))

(defun kcp/set-font-size ()
  "Set the font to `kcp/default-font' at `kcp/current-font-size'.
Set that for the current frame, and also make it the default for
other, future frames."
  (let ((font-code (kcp/font-code)))
    (add-to-list 'default-frame-alist (cons 'font font-code))
    (set-frame-font font-code)))

(defun kcp/reset-font-size ()
  "Change font size back to `kcp/default-font-size'."
  (interactive)
  (setq kcp/current-font-size kcp/default-font-size)
  (kcp/set-font-size))

(defun kcp/increase-font-size ()
  "Increase current font size by a factor of `kcp/font-change-increment'."
  (interactive)
  (setq kcp/current-font-size
        (ceiling (* kcp/current-font-size kcp/font-change-increment)))
  (kcp/set-font-size))

(defun kcp/decrease-font-size ()
  "Decrease current font size by a factor of `kcp/font-change-increment', down to a minimum size of 1."
  (interactive)
  (setq kcp/current-font-size
        (max 1
             (floor (/ kcp/current-font-size kcp/font-change-increment))))
  (kcp/set-font-size))

(define-key global-map (kbd "C-)") 'kcp/reset-font-size)
(define-key global-map (kbd "C-+") 'kcp/increase-font-size)
(define-key global-map (kbd "C-=") 'kcp/increase-font-size)
(define-key global-map (kbd "C-_") 'kcp/decrease-font-size)
(define-key global-map (kbd "C--") 'kcp/decrease-font-size)

(kcp/reset-font-size)

;;always use ibuffer
(defalias 'list-buffers 'ibuffer)

;;set default major-mode
(setq-default major-mode 'text-mode)

;;stop annoying backup files
(setq make-backup-files nil)

;;make autosave on the file rather than a separate file
(setq auto-save-visited-mode t)

;;change yes or no to y or p
(fset `yes-or-no-p `y-or-n-p)

;; Set Linum-Mode on
(global-linum-mode t)

;; Linum-Mode and add space after the number
(setq linum-format "%d ")

;;suppress symbolic link warnings
(setq find-file-visit-truename t)

;;show matching parens
(show-paren-mode 1)

;;overwrite the selected region after marking and yanking. ie cut and paste
(delete-selection-mode 1)

;;auto update buffer if changes are made to file.
(global-auto-revert-mode t)

;;global pabbrev-mode
(global-pabbrev-mode t)

;;tex-mode stuff
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(require 'latex-pretty-symbols)


;;spell check
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english")

;;setup files ending in .DTA to open in hexl-mode
(add-to-list 'auto-mode-alist '("\\.DTA\\'" . hexl-mode))

;;overwrite the selected region after marking and yanking. ie cut and paste
(delete-selection-mode 1)

;;auto update buffer if changes are made to file
(global-auto-revert-mode t)

;;switch to new window automatically when splitting
(defun kcp/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun kcp/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'kcp/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'kcp/split-window-right-and-switch)

;; look up definitions in Webster 1913 w/ C-x w
(defun kcp/dictionary-prompt ()
  (read-string
   (format "Word (%s): " (or (kcp/region-or-word) ""))
   nil
   nil
   (kcp/region-or-word)))

(defun kcp/dictionary-define-word ()
  (interactive)
  (let* ((word (kcp/dictionary-prompt))
         (buffer-name (concat "Definition: " word)))
    (with-output-to-temp-buffer buffer-name
      (shell-command (format "sdcv -n %s" word) buffer-name))))

(define-key global-map (kbd "C-x w") 'kcp/dictionary-define-word)

;; look up words in a thesaurus w/ C-x s
(use-package synosaurus)
(setq-default synosaurus-backend 'synosaurus-backend-wordnet)
(add-hook 'after-init-hook #'synosaurus-mode)
(define-key global-map "\C-xs" 'synosaurus-lookup)

;;save my location within a file
(save-place-mode t)

;;twitter bootstrap export
(require 'ox-twbs)

;;org mode bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-hide-leading-stars t)

;;use syntax highlighting in source blocks while editing
(setq org-src-fontify-natively t)

;;make TAB act as if it were issued in a buffer of the languages major mode
(setq org-src-tab-acts-natively t)

;;when editing a code snippet, use current window
(setq org-src-window-setup 'current-window)

;;quickly insert a block of elisp
(add-to-list 'org-structure-template-alist
             '("el" . "src emacs-lisp"))

;;keybindings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;;exporting to PDF
(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;;include =minted= package in all of my LaTeX exports
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

;;task and org-capture management
(setq org-directory "C:\\Users\\kaleb\\Dropbox\\orgdocs")

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

(setq org-inbox-file "C:\\Users\\kaleb\\Dropbox\\orgdocs\\inbox.org")
(setq org-index-file (org-file-path "index.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

;;set TODO states
(setq org-todo-keywords
  '((sequence "TODO" "STARTED" "WAITING" "|" "DONE" "CANCELED")))

;;store TODOs in index.org
(setq org-agenda-files (list org-index-file))

;;use syntax hi
(setq org-src-fontify-natively t)

(require 'ox-md)
(require 'ox-beamer)

(use-package gnuplot)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (dot . t)
   (gnuplot . t)))

(setq org-confirm-babel-evaluate nil)

(setq org-html-postamble nil)

(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq TeX-parse-self t)

(setq TeX-PDF-mode t)

(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "zathura %s"))))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

;;load all custom el files in directory
(defun load-directory (dir)
  (let ((load-it (lambda (f)
		   (load-file (concat (file-name-as-directory dir) f)))
		 ))
    (mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "c:\\emacs\\custom-el-files\\")

;;load custom themes
    (let ((basedir "c:\\emacs\\themes\\"))
      (dolist (f (directory-files basedir))
        (if (and (not (or (equal f ".") (equal f "..")))
                 (file-directory-p (concat basedir f)))
            (add-to-list 'custom-theme-load-path (concat basedir f)))))

;;save scripts as executable upon save
(add-hook 'after-save-hook
          #'(lambda ()
              (and (save-excursion
                     (save-restriction
                       (widen)
                       (goto-char (point-min))
                       (save-match-data
                         (looking-at "^#!"))))
                   (not (file-executable-p buffer-file-name))
                   (shell-command (concat "chmod +x " buffer-file-name))
                   (message
                    (concat "Saved as script: " buffer-file-name)))))

;;insert templates for known file types
(auto-insert-mode) ;;adds hook to find-files-hook
(setq auto-insert-directory "c:\\emacs\\myemacsprogrammingtemplates\\") ;;specifies template dir. Trailing\slash is important!
(setq auto-insert-query nil) ;;don't prompt before insertion
;;template sections
(define-auto-insert "\\.sh\\'" "my-sh-template.sh")

(load-theme 'solarized-dark t)

(if (daemonp)
    (cl-labels ((load-solarized (frame)
			   (with-selected-frame frame
			     (load-theme 'solarized-dark t))
			   (remove-hook 'after-make-frame-functions #'load-solarized)))
      (add-hook 'after-make-frame-functions #'load-solarized))
  (load-theme 'solarized-dark t))
