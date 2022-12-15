;;; packaging.el --- Library routines for ensuring the packaging system is ready for usage.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  

;; Author:  <sektor@tekunen>
;; Keywords: internal, lisp, maint, packaging

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

;; Ensure that the package system is ready for use by Sonarmacs.

;;; Code:
;; Modules.
(require 'package)
(require 'seq)
(customize-set-variable 'package-archives '(("melpa" . "https://melpa.org/packages/") ("gnu" . "https://elpa.gnu.org/packages/")))
(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9)))
(customize-set-variable 'package-user-dir (expand-file-name "elpa/" sonarmacs-configuration-path))
(unless (file-exists-p package-user-dir)
  (mkdir package-user-dir t))

;; Stale archive logic.
(defun stale-archive-p (archive)
  "Determine whether or not an archive is stale.

Archives who are older than one day are stale."
    (let ((today (time-to-days (current-time)))
        (archive-name (expand-file-name
                       (format "archives/%s/archive-contents" archive)
                       package-user-dir)))
    (time-less-p (time-to-days (file-attribute-modification-time
                                (file-attributes archive-name)))
                 today)))

(defun stale-archives-exist-p ()
  "Find out if any archives on disk are stale."
  (cl-some #'stale-archive-p (mapcar #'car package-archive-contents)))

(defun prepare-package-system ()
  "Set the package system up for use.

If there are any stale archives or the package archives don't exist at all, refresh the contents."
  (package-initialize)
  (cond
   ((seq-empty-p package-archive-contents) (progn
    (message "The package system is not yet initialized, initializing.")
    (package-refresh-contents)))
   ((stale-archives-exist-p) (progn
                                (message "Stale archives detected, refreshing.")
                                (package-refresh-contents t)))))
(provide 'packaging)
;;; packaging.el ends here
