;;; load-nano.el -*- lexical-binding: t; -*-

;; (setq doom-theme 'nil)

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

(setq display-line-numbers-type nil
      hl-line-mode nil)

;; from nano-layout

(setq default-frame-alist
      (append (list
	       '(font . "Roboto Mono:style=Light:size=14")
	       ;; '(font . "Roboto Mono Emacs Regular:size=14")
	       '(min-height . 1)  '(height     . 45)
	       '(min-width  . 1) '(width      . 81)
               '(vertical-scroll-bars . nil)
               '(internal-border-width . 8)
               '(left-fringe    . 0)
               '(right-fringe   . 0)
               '(tool-bar-lines . 0)
               '(menu-bar-lines . 0))))

;; Fall back font for glyph missing in Roboto
(defface fallback '((t :family "Fira Code"
                       :inherit 'nano-face-faded)) "Fallback")
(set-display-table-slot standard-display-table 'truncation
                        (make-glyph-code ?… 'fallback))
(set-display-table-slot standard-display-table 'wrap
                         (make-glyph-code ?↩ 'fallback))

;; Fix bug on OSX in term mode & zsh (spurious % after each command)
(add-hook 'term-mode-hook
	  (lambda () (setq buffer-display-table (make-display-table))))

(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil)

(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)

(setq x-underline-at-descent-line t)
;; Vertical window divider
(setq window-divider-default-right-width 8)
(setq window-divider-default-places 'right-only)
;; No ugly button for checkboxes
(setq widget-image-enable nil)
;; Hide org markup for README
(setq org-hide-emphasis-markers t)

;; end nano-layout

(provide 'load-nano)

