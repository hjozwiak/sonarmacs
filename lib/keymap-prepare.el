;;; keymap-prepare.el --- Plumbing for keymaps.      -*- lexical-binding: t; -*-

;; Copyright (C) 2022  

;; Author:  Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: internal

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

;; The author of Sonarmacs has a bias for Evil bindings, and those are the prodomenent binding set.
;; However, not everyone has a Vim background so don't set it up all the way here.

;;; Code:

;; General, the awesome keybinder.
;; But first, we need to know some things.
(defcustom sonarmacs-leader-key "SPC"
  "The key that is meant to serve as the leader in Evil mode."
  :group 'sonarmacs
  :tag "Leader Key"
  :type 'key-sequence)
(use-package general
  :ensure t
  :init
  (general-evil-setup))

;; For getting information about the keybindings available.
(use-package which-key
  :ensure t
  :custom
  (which-key-idle-delay 1)
  :init
  (which-key-mode))

(provide 'keymap-prepare)
