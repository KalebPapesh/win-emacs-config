;;function to auto-download a list of packages\
;;-list the packages you want
(setq package-list '(pabbrev))
(setq package-list '(solarized-theme))
(setq package-list '(moody))
(setq package-list '(synosaurus))
(setq package-list '(org))
(setq package-list '(diff-hl))
(setq package-list '(org-bullets))
(setq package-list '(latex-pretty-symbols))
(setq package-list '(use-package))
(setq package-list '(use-package-ensure))
(setq package-list '(flyspell))
(setq package-list '(minions))
(setq package-list '(htmlize))
(setq package-list '(ox-twbs))

;;-list the repositories containing them
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;;-activate all the packages (in particular autoloads)
(package-initialize)

;;-fetch the list of packages available
(or (file-exists-p package-user-dir) (package-refresh-contents))

;;-install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'package)

;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;;function to save macros
(defun save-macro (name)
    "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
     (interactive "SName of the macro: ")  ; ask for the name of the macro
     (kmacro-name-last-macro name)         ; use this name for the macro
     (find-file user-init-file)            ; open ~/.emacs or other user init file
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro
     (newline)                             ; insert a newline
     (save-buffer)                         ; save buffery
     (switch-to-buffer nil))               ; switch back to original buffer

(fset 'removeline
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 11 backspace 14] 0 "%d")) arg)))

;;load org config file
(org-babel-load-file "C:\\emacs\\org\\config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit live-preview diff-hl use-package synosaurus solarized-theme pabbrev org-bullets moody minions latex-pretty-symbols gnuplot auto-compile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
