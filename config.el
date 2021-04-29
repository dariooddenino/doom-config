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
(setq doom-theme 'doom-old-hope)
; doom-rouge
; doom-dark+
; manegarm

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Add closed timestamp to org todos
(setq org-log-done t)

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
(add-to-list 'load-path "~/.config/doom")
(require 'load-nano)

;; Packages
(add-hook! 'haskell-mode-hook #'flycheck-haskell-setup)
(add-to-list 'evil-emacs-state-modes 'font-lock-studio-mode)
(add-hook! 'prog-mode-hook 'highlight-indent-guides-mode)

(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap)
 )

;(after! psc-ide
;	(setq psc-ide-use-npm-bin t))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 4 (* 1024 1024)))
(setq lsp-idle-delay 0.500)

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

(use-package! dhall-mode
	      :mode "\\.dhall")

(use-package! pest-mode
        :mode "\\.pest\\'"
        :hook (pest-mode . flymake-mode)
 )

(use-package! direnv
	      :config (direnv-mode))

(after! lsp-mode
(dolist (dir '(
               "[/\\\\].spago"
               "[/\\\\].sass-cache"
               "[/\\\\].cache"
               "[/\\\\]purescript/output$" ;; these below are bm related...
               "[/\\\\]purescript/src$"
               "[/\\\\]purescript/node_modules"
               "[/\\\\]purescript"
               "[/\\\\]uploads$"
               "[/\\\\]sass$"
               "[/\\\\]static$"
                 ))
  (push dir lsp-file-watch-ignored)))

(after! js2-mode
  (setq js2-basic-offset 2))

(use-package! org-roam-server
 :config
(setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8085
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(setq haskell-process-type 'cabal-new-repl)

(setq read-process-output-max (* 1024 1024))

;; TODO this should be inside an after! ?
(eyebrowse-mode t)
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
		 :desc "Flycheck next error" :n "n" #'flycheck-next-error
		 :desc "Flycheck prev error" :n "p" #'flycheck-previous-error
		 :desc "Flycheck list errors" :n "l" #'flycheck-list-errors)

	(:prefix "f"
		 :desc "Search regexp occurrence in current project" :n "g" #'counsel-rg
		 :desc "Searc in copy/paste ring" :n "r" #'counsel-yank-pop
		 :desc "Saves the buffer" :n "s" #'save-buffer)

	(:prefix "g"
		 :desc "Magit" :n "g" #'magit
		 :desc "Time machine" :n "t" #'git-timemachine
     )

	(:prefix "l"
	        :desc "Eyebrowse previous config" :n "<" #'eyebrowse-prev-window-config
	        :desc "Eyebrowse next config" :n ">" #'eyebrowse-next-window-config
	        :desc "Eyebrowse last config" :n "'" #'eyebrowse-last-window-config
	        :desc "Eyebrowse close config" :n "\"" #'eyebrowse-close-window-config
	        :desc "Eyebrwose switch to" :n "." #'eyebrowse-switch-to-window-config
	        :desc "Eyebrowse rename" :n "," #'eyebrowse-rename-window-config
	        :desc "Eyebrowse create" :n "c" #'eyebrowse-create-window-config
	        :desc "Eyebrowse config -2" :n "0" #'eyebrowse-switch-to-window-config-0
	        :desc "Eyebrowse config -1" :n "1" #'eyebrowse-switch-to-window-config-1
	        :desc "Eyebrowse config 0" :n "2" #'eyebrowse-switch-to-window-config-2
	        :desc "Eyebrowse config 1" :n "3" #'eyebrowse-switch-to-window-config-3
	        :desc "Eyebrowse config 2" :n "4" #'eyebrowse-switch-to-window-config-4
	        :desc "Eyebrowse config 3" :n "5" #'eyebrowse-switch-to-window-config-5
	        :desc "Eyebrowse config 4" :n "6" #'eyebrowse-switch-to-window-config-6
	        :desc "Eyebrowse config 5" :n "7" #'eyebrowse-switch-to-window-config-7
	        :desc "Eyebrowse config 6" :n "8" #'eyebrowse-switch-to-window-config-8
	        :desc "Eyebrowse config 7" :n "9" #'eyebrowse-switch-to-window-config-9)

	(:prefix "s"
		 :desc "Clears the search highlights" :n "c" #'evil-ex-nohighlight)

	(:prefix "w"
		 :desc "Deletes other windows" :n "a" #'delete-other-windows)

    ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(lsp-haskell dhall-mode))
 '(safe-local-variable-values
   '((magit-todos-exclude-globs "*booking-form/dist/main.js")
     (dante-target . "blue-moon:lib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
