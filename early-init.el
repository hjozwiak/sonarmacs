;;; early-init.el --- Early initialization file.     -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
; Keywords: initialization

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

;; This file is executed before anything is done regarding user initialization.

;;; Code:
;; A garbage collection change to make the startup faster.
(setq gc-cons-threshold (* 51000 10000))

;; Load the newest compiled files.
(setq load-prefer-newer 'noninteractive)

;; The Load path for the user's configuration.
(defvar sonarmacs-configuration-path
  (cond
   ((featurep 'chemacs)
    (if (getenv "SONARMACS_HOME")
        (expand-file-name (getenv "SONARMACS_HOME"))
      (expand-file-name "sonarmacs" user-emacs-directory)))
   ;; Do they have the variable in their environment
   ((getenv "SONARMACS_HOME") (expand-file-name (getenv "SONARMACS_HOME")))
   ;; Check and see if we have the XDG_CONFIG_HOME environment variable set
   ((or (getenv "XDG_CONFIG_HOME") (file-exists-p "~/.config/sonarmacs"))
    (if (getenv "XDG_CONFIG_HOME")
        (expand-file-name "sonarmacs" (getenv "XDG_CONFIG_HOME"))
      (expand-file-name "~/.config/sonarmacs")))
    ((getenv "HOME") (expand-file-name ".sonarmacs" (getenv "HOME"))))
  "The place where user configuration is to be stored.")

;; Make the directory in the event that it doens't exist.
(unless (file-exists-p sonarmacs-configuration-path)
  (mkdir sonarmacs-configuration-path t))
;; Tack it onto the load path now.
(add-to-list 'load-path (expand-file-name sonarmacs-configuration-path))

;; If you are using nativecomp, make the buffer less spammy.
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t)
  ;; The cache recirection
  (when (boundp 'startup-redirect-eln-cache)
    (if (version< emacs-version "29")
        (add-to-list 'native-comp-eln-load-path (convert-standard-file-name (expand-file-name "var/eln-cache/" user-emacs-directory)))
      (startup-redirect-eln-cache (convert-standard-filename (expand-file-name "var/eln-cache/" user-emacs-directory)))))
  ;; Add it to the load path
  (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory)))

;; Let's strip out some of the UI elements that we don't really need to have on at the moment.
(setq inhibit-startup-message t
      ;; Make the first mode fundamental for the scratch buffer
      initial-major-mode 'fundamental-mode
      ;; Turn off some modes
      tool-bar-mode nil
      menu-bar-mode nil)

;; Edit the default frame alist.
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(add-to-list 'load-path (expand-file-name "lib/" user-emacs-directory))
