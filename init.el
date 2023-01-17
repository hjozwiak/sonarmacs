;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))
(package-refresh-contents)
(unless (package-installed-p 'setup) (package-install 'setup))
(setup (:package speechd-el) (speechd-speak))
(setup (:package no-littering)
(:option
  auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))
