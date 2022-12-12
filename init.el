;;; init.el --- Initialize Emacs.                    -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; The core initialization system for GNU Emacs.
;; Process the initial setup of the package system.
;; Install setup.
;; Install speechd-el.
;; Hand off to loading modules.

;;; Code:
;; Load in some libraries
;; For sequences.
(require 'seq)
;; The package system.
(require 'package)
(package-initialize)
;; Add melpa to the package archives.
(customize-set-variable 'package-archives '(("melpa" . "https://melpa.org/packages/") ("gnu" . "https://elpa.gnu.org/packages/")))
(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9)))
;; Check and see if we need to refresh the contents.
(unless (seq-empty-p package-archive-contents)
  (message "The package system is empty: initializing.")
  (package-refresh-contents))

;; Setup setup.el
(unless (package-installed-p 'setup)
  (package-install 'setup))

;; Handy macro for bulk defining customization forms.
(defmacro csetq (&rest args)
  "A macro like setq, but works with customize options."
  `(setup (:options ,@args)))

;; speechd-el
(defun brltty-running-p ()
  "Check and see if Brltty is running and the user can communicate with it.")

(setup (:package speechd-el)
  ;; Check and see if we can use Brltty at all.
  ;; If not, we need to remove it from the list of launched modules.
  ;; If we do not, we get an annoying error message.
  
       (speechd-speak))

;;; init.el ends here
