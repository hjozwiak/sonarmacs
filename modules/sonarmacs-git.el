;;; sonarmacs-git.el --- Magit interface.            -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: git, magit

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

;; Provide an interface to Magit, a handy dandy git porcelin

;;; Code:

(use-package magit
  :ensure t
  :custom
  (magit-delete-by-moving-to-trash nil)
  :general
  (mapleader
    "g" '(:ignore t :which-key "Git operations.")
    "gg" '(magit-status :which-key "Magit status.")
    "gs" '(magit-stage-file :which-key "Stage the working file."))
  :config
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-modules 'magit-insert-stashes 'append))

;; For working with Forges.
(use-package forge
  :after magit
  :ensure t
  :general
  (mapleader
    "gf" '(forge-dispatch :which-key "Forge dispatch map.")))

(use-package magit-gitflow
  :ensure t
  :hook (magit-mode . turn-on-magit-gitflow))

(use-package git-timemachine
  :ensure t
  :general
  (mapleader
    "tg" '(git-timemachine-toggle :which-key "Toggle the time machine on or off.")))

(provide 'sonarmacs-git)
;;; sonarmacs-git.el ends here
