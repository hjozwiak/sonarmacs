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

;; The load path for the user's configuration.
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


;;; early-init.el ends here

;; Local Variables:
;; no-byte-compile: t
;; End:
