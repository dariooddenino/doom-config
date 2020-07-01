;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! evil-magit)
(package! shakespeare-mode)
(package! evil-matchit)
(package! protobuf-mode)
(package! eyebrowse)
(package! git-timemachine)
(package! eglot)
(package! dhall-mode)
(package! happy-mode
  :recipe (:host github :repo "sergv/happy-mode")
  )
(package! keychain-environment)
