;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(unless (package-installed-p 'setup)
  (package-install 'setup))
(require 'setup)

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
   speechd-speak-voices '((nil
			   (rate . 100)
			   (output-module . "espeak-ng"))))
  (speechd-speak))

(setup
    (:package no-littering)
  (:require no-littering)
(:option
  auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
custom-file (no-littering-expand-etc-file-name "custom.el"))))
