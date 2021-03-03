(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/org/tasks.org" "~/org-basics.org" "/home/dario/org/todo.org"))
 '(package-selected-packages '(lsp-haskell dhall-mode))
 '(safe-local-variable-values
   '((flycheck-disabled-checkers haskell-stack-ghc)
     (flycheck-disabled-checkers
      (haskell-stack-ghc))
     (add-to-list 'flycheck-disabled-checkers 'haskell-stack-ghc)
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)
     (haskell-process-type . ghci)
     (dante-repl-command-line "ghci")
     (magit-todos-exclude-globs "*booking-form/dist/main.js")
     (dante-target . "blue-moon:lib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
