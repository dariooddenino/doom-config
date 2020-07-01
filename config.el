;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;
;; Keybindings
;;
(map! :map ivy-minibuffer-map
      "C-f" 'ivy-toggle-calling
      )

(map!
  (:leader

    (:prefix "d"
      :desc "Flycheck buffer" :n "d" #'flycheck-buffer
      :desc "Stylish Haskell" :n "," #'haskell-mode-stylish-buffer
      :desc "Comment line" :n "/" #'comment-line
      :desc "Comment region" :n ";" #'comment-region)

    (:prefix "e"
      :desc "Flycheck next error" :n "n" #'flycheck-next-error
      :desc "Flycheck prev error" :n "p" #'flycheck-previous-error
      :desc "Flycheck list errors" :n "l" #'flycheck-list-errors)

    (:prefix "f"
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
      :desc "Eyebrowse config 0" :n "0" #'eyebrowse-switch-to-window-config-0
      :desc "Eyebrowse config 1" :n "1" #'eyebrowse-switch-to-window-config-1
      :desc "Eyebrowse config 2" :n "2" #'eyebrowse-switch-to-window-config-2
      :desc "Eyebrowse config 3" :n "3" #'eyebrowse-switch-to-window-config-3
      :desc "Eyebrowse config 4" :n "4" #'eyebrowse-switch-to-window-config-4
      :desc "Eyebrowse config 5" :n "5" #'eyebrowse-switch-to-window-config-5
      :desc "Eyebrowse config 6" :n "6" #'eyebrowse-switch-to-window-config-6
      :desc "Eyebrowse config 7" :n "7" #'eyebrowse-switch-to-window-config-7
      :desc "Eyebrowse config 8" :n "8" #'eyebrowse-switch-to-window-config-8
      :desc "Eyebrowse config 9" :n "9" #'eyebrowse-switch-to-window-config-9
    )	

    (:prefix "f"
	:desc "Search regexp occurrence in current project" :n "g" #'counsel-rg
	:desc "Search in copy/paste ring" :n "r" #'counsel-yank-pop
	     )	
;    (:prefix "p"
;      :desc "Rg in project" :n "f" #'helm-projectile-rg
;      :desc "Rg in subfolder" :n "g" #'helm-do-ag
;    )

    (:prefix "s"
      :desc "Clears the search highlights" :n "c" #'evil-ex-nohighlight)

    (:prefix "w"
       :desc "Deletes other windows" :n "m" #'delete-other-windows)
))

;;
;; Modules
;;

(use-package dhall-mode
	      :ensure t
	      :mode "\\.dhall'"
	      )

(add-hook! 'haskell-mode-hook #'flycheck-haskell-setup)

(after! psc-ide
  (setq psc-ide-use-npm-bin t))
(eyebrowse-mode t)

(after! eglot
	(add-to-list 'eglot-server-programs '(php-mode . ("php" "vendor/bin/psalm-language-server")))
	(add-hook 'php-mode-hook 'eglot-ensure)
	(advice-add 'eglot-eldoc-function :around
		    (lambda (oldfun)
		      (let ((help (help-at-pt-kbd-string)))
			(if help (message "%s" help) (funcall oldfun)))))
	)

;;(use-package lsp-haskell
;;	     :ensure t
;;	     :config
;;	     (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
;;	     ;;(setq lsp-log-io t)
;;	     )

(after! circe

  (set-irc-server! "chat.freenode.net"
    `(:tls t
      :port 6697
      :nick "dario-"
      :sasl-username "dario-"
      :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
      :channels ("#i3", "#manjaro")))
  )

(after! keychain-environment
	(keychain-refresh-environment))

(global-diff-hl-mode)
(diff-hl-flydiff-mode)

;;
;; Appearance
;;
(setq doom-font (font-spec :family "Iosevka" :size 12)
      doom-theme 'doom-challenger-deep
      )
