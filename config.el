;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
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

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dario Oddenino"
      user-mail-address "branch13@gmail.com")


;;
;; General config
(setq read-process-output-max (* 4 (* 1024 1024)))
(global-activity-watch-mode)

;;
;;; UI

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
(setq doom-font (font-spec :family "Iosevka" :size 15))
(setq doom-theme 'doom-homage-black)

;; Line numbers are slow
(setq display-line-numbers nil)

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;
;;; Modules

;;; :completion company
;; Set manual completion trigger
(after! company
 (setq company-show-quick-access t
       company-idle-delay nil))

;;; :ui modeline
;; An evil mode indicator is redudant with cursor shape
(advice-add #'doom-modeline-segment--modals :override #'ignore)

;;; :editor evil
;; Focus new window on splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Implicit /g flag on evil ex substitution
(setq evil-ex-substitute-global t)

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
 (setq lsp-enable-symbol-highlighting nil))
(after! lsp-ui
 (setq lsp-ui-sideline-enable nil ;; flycheck
       lsp-ui-doc-enable nil)) ;; use K

;(after! lsp-lens (setq lsp-lens-place-position 'above-line))


;;; :lang org

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;;; :ui doom-dashboard
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)


;;; :ui hydra
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


;;; :ui indent-guides
(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap)
 )


;;
;;; Additional files

(add-to-list 'load-path "~/.config/doom")
(require 'haskell-config)
;(require 'ghcid)

;;
;;; Extra packages
(use-package! direnv
	      :config (direnv-mode))
(use-package! forge
  :after magit)
(use-package! svelte-mode :mode "\\.svelte"
	      :hook #'lsp)

;;
;;; Language customizations

(add-hook! 'haskell-mode-hook #'flycheck-haskell-setup)
(add-hook! 'prog-mode-hook 'highlight-indent-guides-mode)


;(setq-hook! 'purescript-mode-hook +format-with 'purs-tidy)
;(set-formatter! 'purs-tidy "purs-tidy format") ; :modes '(purescript-mode))
(setq lsp-purescript-formatter "purs-tidy")

(defun lsp-purescript-build ()
 "Triggers a Purescript LSP build."
 (interactive)
  (unwind-protect
   (progn
    (lsp-request-async
      "workspace/executeCommand"
      (list :command "purescript.build")
      (lambda (res) (message "Purescript LSP build done."))
      :error-handler (lambda (err) 
        (cond
          ((lsp-json-error? err) (error (lsp:json-error-message err)))
          ((lsp-json-error? (cl-first err))
            (error (lsp:json-error-message (cl-first err))))))))))

;(after! eglot
;	(add-to-list 'eglot-server-programs '(php-mode . ("php" "vendor/bin/psalm-language-server")))
;	(add-hook 'php-mode-hook 'eglot-ensure)
;	(advice-add 'eglot-eldoc-function :around
;		    (lambda (oldfun)
;		      (let ((help (help-at-pt-kbd-string)))
;			(if help (message "%s" help) (funcall oldfun)))))
;	)

(after! css-mode
	(setq css-indent-offset 2)
	)

(after! keychain-environment
	(keychain-refresh-environment))

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

(after! haskell-mode
  (setq lsp-haskell-importlens-on nil)
 )

(setq haskell-process-type 'cabal-new-repl)


(global-diff-hl-mode)
(diff-hl-flydiff-mode)

(after! lsp-haskell (setq lsp-haskell-formatting-provider "brittany"))


;;
;;; Keybindings

(defun append-line-comment-block ()
  "Appends a new line after a comment block without expanding it.
Calls `evil-append-line` and `+default/newline` in sequence."
  (interactive)
  (call-interactively 'evil-append-line)
  (call-interactively '+default/newline)
  )


(after! company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "C-SPC") #'company-complete-selection)
 )

(after! purescript-mode
  (map! :map purescript-mode-map
        (:localleader 
         (:desc "Rebuild purescript bundle" :n "b" #'lsp-purescript-build))))

(after! haskell
  (map! :map haskell-mode-map 
        (:localleader (:desc "Updates the ghci session" :n "b" #'zellij-serve
                       :desc "Runs tests in ghci" :n "t" #'zellij-test))))

(map!
  (:prefix "g"
    :desc "New line after comment block" :n "o" #'append-line-comment-block
   )
  (:leader
  (:prefix "c"
    :desc "Search symbols defined in current file" :n "/" #'consult-lsp-file-symbols
    :desc "Choose lsp lens" :n "." #'lsp-avy-lens
   )
	(:prefix "d"
		 :desc "Flycheck buffer" :n "d" #'flycheck-buffer
     ;; temporary solution
    ;; :desc "Stylish buffer" :n "." #'haskell-mode-stylish-buffer
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
		 :desc "Clears the search highlights" :n "c" #'evil-ex-nohighlight
     :
     )

	(:prefix "w"
		 :desc "Deletes other windows" :n "a" #'delete-other-windows
     :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body)

    ))

;; manually expand path
;;(setenv "PATH" (concat (getenv "PATH") ":/home/dario/.nimble/bin"))
;;(setq exec-path (append exec-path '("/home/dario/.nimble/bin")))

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
