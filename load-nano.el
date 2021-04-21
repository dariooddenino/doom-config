;;; load-nano.el -*- lexical-binding: t; -*-

(setq doom-theme 'nil)

(add-to-list 'load-path "~/dev/vendor/nano-emacs")
(require 'nano-base-colors)
(require 'nano-faces)
(nano-faces)
(require 'nano-theme-dark)
(require 'nano-theme)
(nano-theme)

(require 'nano-modeline)
(require 'nano-compact)
(require 'nano-help)
;; (require 'nano-layout)

(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)

(setq display-line-numbers-type nil
      hl-line-mode nil)

;(setq evil-default-cursor t)
;(setq custom-blue "#718591")
;(if (daemonp)
;    (add-hook 'after-make-frame-functions
;              (lambda (frame)
;                (with-selected-frame frame
;                  (set-cursor-color custom-blue))))
;  (set-cursor-color custom-blue))

(provide 'load-nano)

