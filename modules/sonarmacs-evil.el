;;; sonarmacs-evil.el --- Evil configuration for Evil mode and friends.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  

;; Author:  <sektor@tekunen>
;; Keywords: evil

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

;; Evil is a package that provides vim-like bindings for Emacs.

;;; Code:

(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :ensure t)

(use-package evil
  :ensure t
  :custom
  (evil-want-integration t)
  (evil-want-c-i-jump nil)
  (evil-want-keybind nil)
  (evil-undo-system 'undo-tree)
  :preface
  (defun sonarmacs--evil-state-change-notify ()
    (when (and evil-next-state evil-previous-state (not (eq evil-previous-state evil-next-state)))
      (speechd-say-text (format "Changing state from %s to %s." evil-previous-state evil-next-state) :priority 'notification)))
  :hook ((evil-insert-state-exit evil-normal-state-exit evil-motion-state-exit evil-operator-state-exit evil-replace-state-exit evil-visual-state-exit evil-emacs-state-exit) . sonarmacs--evil-state-change-notify)
   :init
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(provide 'sonarmacs-evil)
;;; sonarmacs-evil.el ends here
