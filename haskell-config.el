;;; haskell.el --- Functions and settings to handle haskell

(defun async-shell-command-no-window
  (command)
  "Helper function to run async shell commands without opening a buffer window."
  (interactive)
  (let
   ((display-buffer-alist (list (cons "\\*Async Shell Command\\*.*"
                                 (cons #'display-buffer-no-window nil)))))
   (async-shell-command command)))

(defun zellij-serve ()
 "Updates the ghci session in zellij reloading the files and running DevelMain.update."
 (interactive)
 (async-shell-command-no-window "zellij -s ONE action 'WriteChars: \":serve\\n\"'")
 )

(provide 'haskell-config)
