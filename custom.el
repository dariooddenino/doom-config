(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/org/gdt.org" "~/org/someday.org" "~/org/tickler.org" "~/org/tasks.org" "~/org-basics.org" "/home/dario/org/todo.org" "~/org"))
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
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo" :height 2.0 :underline nil))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#383a42" :font "ETBembo"))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
