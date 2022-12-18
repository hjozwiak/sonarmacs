;;; housekeeping.el --- Keep the configuration directories clean.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  

;; Author:  Hunter Jozwiak <hunter.t.joz@gmail.com
;; Keywords: litter, housekeeping, no-littering

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

;; 

;;; Code:
(use-package no-littering
  :ensure t
  :custom
  (no-littering-etc-directory (expand-file-name "etc/" sonarmacs-configuration-path))
  (no-littering-var-directory (expand-file-name "var/" sonarmacs-configuration-path))
  (auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))


(provide 'housekeeping)
;;; housekeeping.el ends here
