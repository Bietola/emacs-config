(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/main/life/org/1.todo.org"))
 '(package-selected-packages '(magit undo-tree ## evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set up package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; List of packages to install
(defvar my-packages '(use-package evil undo-tree magit))

;; Install packages that are not already installed
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package)))

;; Org mode keybindings
(add-hook 'org-mode-hook
  (lambda ()
    ;;; Normal keys
    (define-key org-mode-map (kbd "C-c a") #'org-agenda)
    (define-key org-mode-map (kbd "C-c l") #'org-store-link)
    (define-key org-mode-map (kbd "C-c c") #'org-capture)
    (define-key org-mode-map (kbd "C-c t") #'org-insert-structure-template)

    ;;; Evil mode
    (evil-define-key 'normal org-mode-map (kbd "L") #'org-demote-subtree)
    (evil-define-key 'normal org-mode-map (kbd "H") #'org-promote-subtree)

    (evil-define-key 'normal org-mode-map (kbd "òo")
	(lambda ()
	    (interactive)
	    (find-file "/home/dincio/main/life/org/1.todo.org")))

    (evil-define-key 'normal org-mode-map (kbd "òf")
	(lambda ()
	    (interactive)
	    (shell-command "rclone sync -P db:/main/life/org/ /home/dincio/main/life/org/")
	    (revert-buffer :ignore-auto :noconfirm)))

    (evil-define-key 'normal org-mode-map (kbd "òp")
	(lambda ()
	    (interactive)
	    (shell-command "rclone sync -P /home/dincio/main/life/org/ db:/main/life/org/")
	    (revert-buffer :ignore-auto :noconfirm)))))

;; Actuvate evil mode
(require 'evil)
(evil-mode 1)

;; Evil mode keymaps
(evil-define-key 'normal 'global (kbd "àoo")
  (lambda ()
    (interactive)
    (find-file "/home/dincio/main/life/org/1.todo.org")))

(evil-define-key 'normal 'global (kbd "àoc")
  (lambda ()
    (interactive)
    (find-file "/home/dincio/.emacs")))

;; Vim options
(require 'undo-tree)
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)
