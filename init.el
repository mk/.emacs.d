(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(defun gugl/mac? ()
  "Returns `t' if this is an Apple machine, nil otherwise."
  (eq system-type 'darwin))

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
    
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode))
  (setq parinfer-auto-switch-indent-mode nil))
    

(use-package smartparens-config
  :ensure smartparens
  :bind
  (("M-<up>" . sp-up-sexp)))

(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(use-package projectile
  :bind
  (("M-t" . projectile-switch-to-buffer)))

(setq show-paren-delay 0)
(show-paren-mode 1)

(defun cider-connect-cljs ()
  (interactive)
  (cider-connect "localhost" "7888")
  (cider-create-sibling-cljs-repl (cider-current-connection)))

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
