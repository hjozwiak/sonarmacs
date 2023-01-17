;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(unless (package-installed-p 'setup)
  (package-install 'setup))
(require 'setup)

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
(:option
  auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
custom-file (no-littering-expand-etc-file-name "custom.el"))))
