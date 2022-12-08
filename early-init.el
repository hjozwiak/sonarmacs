;;; early-init.el --- Early initialization file.     -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: 

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
(setq load-prefer-newer 'noninteractive')

;; The load path for the user's configuration.
(defvar sonar-configuration-path
  ()
  "The place where user configuration is to be stored.")
(provide 'early-init)
;;; early-init.el ends here
