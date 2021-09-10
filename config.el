;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dario Oddenino"
      user-mail-address "branch13@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Hack" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)
; doom-rouge
; doom-dark+
; manegarm

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Add closed timestamp to org todos
(setq org-log-done t)

;; Org config
;; Hide emphasis markers
(setq org-hide-emphasis-markers t)
;; Replaces lists - with dots
;(font-lock-add-keywords 'org-mode
;                          '(("^ *\\([-]\\) "
;                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; Sets org mode fonts
(defun org-mode-set-fonts ()
  (let* ((variable-tuple
          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))
  )

(if (daemonp)
  (add-hook 'after-make-frame-functions
	    (lambda (frame)
	      (select-frame frame)
	      (org-mode-set-fonts)))
  (org-mode-set-fonts))

;; Sets variable pitch font face
(custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
   '(fixed-pitch ((t ( :family "Fira Code Retina" :height 160)))))

;; Enable variable pitch mode for og
;; (add-hook 'org-mode-hook 'variable-pitch-mode)
;; Adapts line lengths to window width
(add-hook 'org-mode-hook 'visual-line-mode)
;; Use different fonts for different org sections
(custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(use-package! websocket :after org-roam)
(use-package! org-roam-ui
	      :after org-roam
	      ;; This should be hooked to something else to improve startup time
	      :hook (after-init . org-roam-ui-mode)
	      :config
	      (setq org-roam-ui-sync-theme t
		    org-roam-ui-follow t
		    org-roam-ui-update-on-save t
		    org-roam-ui-open-on-start t))

(setq org-roam-dailies-capture-templates
  '(("d" "default" entry "* %<%H:%M >: %?"
      :if-new (file+head "%<Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

;; END ORG CONFIG

(defhydra doom-window-resize-hydra (:hint nil)
  "
             _k_ increase height
_h_ decrease width    _l_ increase width
             _j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)

  ("q" nil))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;(add-to-list 'load-path "~/.config/doom")
;;(require 'load-nano)

(add-to-list 'load-path "~/.config/doom")
(require 'ghcid)

;; Packages
(add-hook! 'haskell-mode-hook #'flycheck-haskell-setup)
(add-to-list 'evil-emacs-state-modes 'font-lock-studio-mode)
(add-hook! 'prog-mode-hook 'highlight-indent-guides-mode)

(add-to-list '+lookup-provider-url-alist '("Pursuit" "https://pursuit.purescript.org/search?q=%s"))
(add-to-list '+lookup-provider-url-alist '("Stackage" "https://www.stackage.org/lts-16.31/hoogle?q=%s"))

(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap)
 )

(set-formatter! 'purs-tidy "purs-tidy format" :modes '(purescript-mode))
;(set-company-backend! 'purescript-mode-hook '(company-tabnine :separate company-capf company-yasnippet))

;(after! company
;  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
;  (setq company-backends '(company-tabnine company-capf company-yasnippet))
;  (setq company-show-numbers t)
;  (setq company-idle-delay 0)
;)

;; === LSP CONFIG ===
; (with-eval-after-load 'lsp-mode
  ;; no real time syntax check 
  ; (setq lsp-diagnostic-package :none)
  ;; handle yasnippet by myself
  ; (setq lsp-enable-snippet nil)
  ;; use `company-ctags' only.
  ;; Please note `company-lsp' is automatically enabled if installed
  ; (setq lsp-enable-completion-at-point nil)
  ;; turn off for better performance
  ; (setq lsp-enable-symbol-highlighting nil)
  ; (setq lsp-enable-links nil)

  ;; don't ping LSP language server too frequently
  ; (defvar lsp-on-touch-time 0)
  ; (defadvice lsp-on-change (around lsp-on-change-hack activate)
  ;  ;; dont' run `lsp-on-change' too frequently
  ;  (when (> (- (float-time (current-time))
  ;            lsp-on-touch-time) 30) ;; 30 seconds
  ;   (setq lsp-on-touch-time (float-time (current-time)))
  ;   ad-do-it))
  ; )

(setq read-process-output-max (* 4 (* 1024 1024)))
(setq lsp-idle-delay 0.200)
(setq company-minimum-prefix-length 3)

(after! eglot
	(add-to-list 'eglot-server-programs '(php-mode . ("php" "vendor/bin/psalm-language-server")))
	(add-hook 'php-mode-hook 'eglot-ensure)
	(advice-add 'eglot-eldoc-function :around
		    (lambda (oldfun)
		      (let ((help (help-at-pt-kbd-string)))
			(if help (message "%s" help) (funcall oldfun)))))
	)

(after! css-mode
	(setq css-indent-offset 2)
	)

(after! keychain-environment
	(keychain-refresh-environment))

(use-package! svelte-mode :mode "\\.svelte"
	      :hook #'lsp)

(use-package! dhall-mode
	      :mode "\\.dhall")

(use-package! pest-mode
        :mode "\\.pest\\'"
        :hook (pest-mode . flymake-mode)
 )

(use-package! direnv
	      :config (direnv-mode))

(global-activity-watch-mode)

(after! lsp-mode
(dolist (dir '(
               "[/\\\\].spago"
               "[/\\\\].sass-cache"
               "[/\\\\].cache"
               "[/\\\\].hie"
               "[/\\\\].stack-work"
               "[/\\\\].circleci"
               "[/\\\\]node_modules"
               "[/\\\\]uploads"
               "[/\\\\]sass$"
               "[/\\\\]static$"
               "[/\\\\]output$" ;; these below are bm related...
               "[/\\\\]dce-output$" ;; these below are bm related...
               "[/\\\\]generated$" ;; wp stuff
               "[/\\\\]docker" ;;
               "[/\\\\]vendor" ;;
                 ))
  (push dir lsp-file-watch-ignored)))

(after! js2-mode
  (setq js2-basic-offset 2))

;(use-package! org-roam-server
; :config
;(setq org-roam-server-host "127.0.0.1"
;        org-roam-server-port 8088
;        org-roam-server-authenticate nil
;        org-roam-server-export-inline-images t
;        org-roam-server-serve-files nil
;        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
;        org-roam-server-network-poll t
;        org-roam-server-network-arrows nil
;        org-roam-server-network-label-truncate t
;        org-roam-server-network-label-truncate-length 60
;        org-roam-server-network-label-wrap-length 20))

(setq haskell-process-type 'cabal-new-repl)

(setq read-process-output-max (* 1024 1024))

(global-diff-hl-mode)
(diff-hl-flydiff-mode)

(setq-hook! 'haskell-mode-hook +format-with 'stylish-haskell)

(defun append-line-comment-block ()
  "Appends a new line after a comment block without expanding it.
Calls `evil-append-line` and `+default/newline` in sequence."
  (interactive)
  (call-interactively 'evil-append-line)
  (call-interactively '+default/newline)
  )

;; Keybindings
(map!
  :map ivy-minibuffer-map
  "C-f" 'ivy-toggle-calling
  )

(map!
  (:prefix "g"
    :desc "New line after comment block" :n "o" #'append-line-comment-block
   )
  (:leader
	(:prefix "d"
		 :desc "Flycheck buffer" :n "d" #'flycheck-buffer
     ;; temporary solution
     :desc "Stylish buffer" :n "." #'haskell-mode-stylish-buffer
		 :desc "Format buffer" :n "," #'format-all-buffer
		 :desc "Comment line" :n "/" #'comment-line
		 :desc "Comment region" :n ";" #'comment-region)

	(:prefix "e"
     :desc "helm lsp errors" :n "a" #'helm-lsp-diagnostics
		 :desc "Flycheck next error" :n "n" #'flycheck-next-error
		 :desc "Flycheck prev error" :n "p" #'flycheck-previous-error
		 :desc "Flycheck list errors" :n "l" #'flycheck-list-errors)

;	(:prefix "f"
;		 :desc "Search regexp occurrence in current project" :n "g" #'counsel-rg
;		 :desc "Searc in copy/paste ring" :n "r" #'counsel-yank-pop
;		 :desc "Saves the buffer" :n "s" #'save-buffer)

	(:prefix "g"
		 :desc "Magit" :n "g" #'magit
		 :desc "Time machine" :n "t" #'git-timemachine
     )


	(:prefix "s"
		 :desc "Clears the search highlights" :n "c" #'evil-ex-nohighlight)

	(:prefix "w"
		 :desc "Deletes other windows" :n "a" #'delete-other-windows
     :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body)

    ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(dhall-mode))
 '(safe-local-variable-values
   '((magit-todos-exclude-globs "*booking-form/dist/main.js")
     (dante-target . "blue-moon:lib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
