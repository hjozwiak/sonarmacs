;;; init.el --- Initialize Emacs.                    -*- lexical-binding: t; -*-

;; Copyright (C) 2022, 2023  Hunter Jozwiak

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
(require 'packaging)
(prepare-package-system)
(require 'use-package-prepare)

(require 'housekeeping)(require 'keymap-prepare)
(require 'speechd-el-prepare)
;; Our configuration group.
(defgroup sonarmacs '()
  "The main configuration point for Sonarmacs configuration."
  :tag "Sonarmacs"
  :group 'emacs)
(defcustom sonarmacs-load-customization-file t
  "Whether or not to load customizations from the custom file."
  :type 'boolean
  :group 'sonarmacs)

;; User load path and other things
(when (file-directory-p (expand-file-name "modules/" sonarmacs-configuration-path))
  (add-to-list 'load-path (expand-file-name "modules/" sonarmacs-configuration-path)))
(when (file-exists-p (expand-file-name "config.el" sonarmacs-configuration-path))
  ;; Load in the config.el file.
  (load (expand-file-name "config.el" sonarmacs-configuration-path)))
;; Ditto customization files.
(customize-set-variable 'custom-file (expand-file-name "custom.el" sonarmacs-configuration-path))
(when sonarmacs-load-customization-file
  (load custom-file t))
