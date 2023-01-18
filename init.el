;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(unless (package-installed-p 'setup)
  (package-install 'setup))
(require 'setup)

(defmacro setc (&rest things)
  `(setup (:option ,@things)))

(setup-define :after-init
  (lambda (&rest body)
    `(if after-init-time (progn ,@body) (add-hook 'after-init-hook (lambda () ,@body)))
  :documentation "Run the specified body after Emacs has finished initializing."
  :signature '(body ...))

(setup-define :after-gui
  (lambda (&rest body)
    `(if (and (not (daemonp)) (display-graphic-p))
         (progn ,@body)
       (add-hook 'server-after-make-frame-hook (lambda ()
                                                 (when (display-graphic-p)
                                                   ,@body
                                                   t)))))
  :documentation "Run body after the first graphical frame is created."
  :signature '(BODY ...))

(setup-define :after-tty
  (lambda (&rest body)
    `(if (and (not (daemonp)) (not (display-graphic-p)))
         (progn ,@body)
       (add-hook 'server-after-make-frame-hook (lambda ()
                                                 (unless (display-graphic-p)
                                                   ,@body
                                                   t)))))
  :documentation "Run body after the first TTY frame is created."
  :signature '(body ...))

(setup
    (:package speechd-el)
  (:option
   speechd-speak-whole-line t
   speechd-speak-echo nil
   speechd-speak-read-command-keys nil
   speechd-voices '((nil
                           (rate . 100)
                           (output-module . "espeak-ng"))))
  (speechd-speak))

(defun retrieve-speechd-function (thing)
  "Retrieve the function that is defined by speechd-el.

Usually it is the form of speechd-speak-read-<thing>"
  (cl-loop for s being the symbols
	   when (string-match (concat "speechd-speak-read-" thing) (symbol-name s))
	   when (fboundp s)
	   return s))

(cl-loop for ent in '("paragraph" "sentence" "word" "character" "sexp")
	 for doc = (format "Advise the functions that move by %s to report the new %s after movement." ent ent)
	 for setup-name = (intern (concat ":" ent "-feedback"))
	 for speechd-command = (retrieve-speechd-function ent)
	 when (fboundp speechd-command) do
	 (eval
	  `(setup-define ,setup-name
	     (lambda (&rest funcs)
	       `(speechd-speak--command-feedback ,funcs after (funcall speechd-command)))
	     :documentation ,doc
	     :signature '(command ...))))

(setup-define :line-feedback
  (lambda (&rest funcs)
    `(speechd-speak-command-feedback ,funcs after (speechd-speak-read-line (not speechd-speak-whole-line))))
  :documentation "Advise the functions that move by lines to report the new line after execution."
  :signature '(COMMAND ...))

(setup
    (:package no-littering)
  (:require no-littering)
(:option
  auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
custom-file (no-littering-expand-etc-file-name "custom.el"))))

(setc user-full-name "Hunter Jozwiak"
      user-mail-address "hunter.t.joz@gmail.com"
      user-login-name "sektor")

(setc indent-tabs-mode nil)


