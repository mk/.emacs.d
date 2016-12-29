;; (require 'cask "~/.cask/cask.el")
;; Run `cask install` to install required packages

(require 'cask "/usr/local/Cellar/cask/0.8.1/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))
  
(tool-bar-mode -1)
(global-linum-mode 1)

(load-theme 'material t)

(global-auto-revert-mode t)

(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

(setq auto-save-default nil)
(setq backup-inhibited t)
(setq ring-bell-function 'ignore)
(setq default-truncate-lines t)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default tab-always-indent nil)
(setq-default indent-tabs-mode nil)

(defvaralias 'c-basic-offset 'tab-with)

(use-package parinfer
  :ensure t
  :bind
  (("C-," . parinfer-toggle-mode))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
            pretty-parens  ; different paren styles for different modes.
            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
            smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
   (setq parinfer-auto-switch-indent-mode nil)))

(use-package smartparens-config
  :ensure smartparens
  :bind
  (("M-<up>" . sp-up-sexp)))

(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x f") 'helm-find)

(helm-mode 1)

(use-package projectile
  :bind
  (("M-t" . projectile-switch-to-buffer))
  (("M-T" . projectile-find-file)))

;; turns on projectile mode by default for all file types
(projectile-global-mode)

(require 'helm-projectile)
(setq helm-M-x-fuzzy-match 1)

;; asks for file to open when project is switched
(setq projectile-switch-project-action 'helm-projectile-find-file)

(helm-projectile-on)

(setq show-paren-delay 0)
(show-paren-mode 1)

(defun cider-connect-cljs ()
  (interactive)
  (cider-connect "localhost" "7888")
  (cider-create-sibling-cljs-repl (cider-current-connection)))

(require 'neotree)

(global-set-key (kbd "M-\\") 'neotree-toggle)
(global-set-key [f8] 'neotree-toggle)

(setq neo-smart-open 1)
(setq projectile-switch-project-action 'neotree-projectile-action)

(global-set-key (kbd "C-x g") 'magit-status)
(winner-mode t)

;; custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(when (file-exists-p "~/.emacs.d/customizations.el")
  (load "~/.emacs.d/customizations.el"))
