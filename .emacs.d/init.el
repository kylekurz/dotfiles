(require 'cask "~/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(setq inhibit-startup-message t)
;; Highlight TODO FIXME XXX BUG
(add-hook 'prog-mode-hook 
		  (lambda()
			(font-lock-add-keywords nil 
									'(("\\<\\(FIXME\\|TODO\\|XXX+\\|BUG\\):" 
									   1 font-lock-warning-face prepend))))) 

;; )

(require 'use-package)

(use-package ace-jump-mode
  :defer t
  :bind ("C-o" . ace-jump-mode))

(use-package company
  :config
  (add-hook 'emacs-lisp-mode-hook 'company-mode))

(use-package eldoc
  :config
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

(use-package ido
  :config
  (ido-mode 1)
  (ido-everywhere 1))

(use-package neotree
  :bind ("<f8>" . neotree-toggle))

(use-package typescript-mode
  :defer t
  :init 
  (add-hook 'typescript-mode-hook
			(lambda()
			  (tide-setup)
			  (flycheck-mode +1)
			  (eldoc-mode +1)
			  (company-mode +1))))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package js2-mode
  :defer t
  :init
  (progn
	(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
	(use-package tern-auto-complete
	  :init (progn
			  (add-hook 'js2-mode-hook 'tern-mode)
			  (add-hook 'js2-mode-hook 'auto-complete-mode))
	  :config (tern-ac-setup))
	(use-package flycheck
	  :init (add-hook 'js2-mode-hook 'flycheck-mode))))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sh . t))))						;allow shell scripts to be executed in org mode

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-safe-themes (quote ("cd70962b469931807533f5ab78293e901253f5eeb133a46c2965359f23bfb2ea" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(enable-local-variables nil)
 '(fci-rule-color "#383838")
 '(fill-column 80)
 '(js2-bounce-indent-p nil)
 '(js2-global-externs (quote ("$" "describe" "it" "before" "beforeEach" "after" "afterEach")))
 '(js2-include-node-externs t)
 '(js2-skip-preprocessor-directives t)
 '(nxml-slash-auto-complete-flag t)
 '(tab-width 4)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
;; /autosave

(load-theme 'zenburn t)
(setq tab-width 4)
;; (smart-tabs-advice js2-indent-line js2-basic-offset)

;; http://stackoverflow.com/questions/915985/in-emacs-how-to-line-up-equals-signs-in-a-series-of-initialization-statements
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(global-set-key (kbd "C-c .") 'align-regexp)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
