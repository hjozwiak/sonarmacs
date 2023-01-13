;;; keymap-prepare.el --- Plumbing for keymaps.      -*- lexical-binding: t; -*-

;; Copyright (C) 2022, 2023  

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
(defcustom sonarmacs-global-prefix-key "C-SPC"
  "The prefix key to use when the main leader is unavailable."
  :group 'sonarmacs
  :tag "Global Prefix Key")

(use-package general
  :ensure t
  :config
  (general-auto-unbind-keys)
  (general-evil-setup t)
  ;; Create the leader definer
  (general-create-definer mapleader
    :prefix sonarmacs-leader-key
    :global-prefix sonarmacs-global-prefix-key
    :states '(normal visual insert emacs))
  (mapleader
   "b" '(:ignore t :which-key "Buffer operations")
   "bn" '(next-buffer :which-key "Go to the next buffer.")
   "bp" '(previous-buffer :which-key "Go to the previous buffer.")
   "bb" '(switch-to-buffer :which-key "Switch to a buffer.")
   "bi" '(ibuffer :which-key "Interactive buffer management through the Ibuffer interface.")
   "br" '(revert-buffer :which-key "Revert the buffer to how it is on disk.")
   ;; Customization
   "c" '(:ignore t :which-key "Customization interface.")
   "cc" '(customize :which-key "Open the customization index.")
   "cf" '(customize-face :which-key "Customize a face.")
   "cg" '(customize-group :which-key "Customize a specific group.")
   "cv" '(customize-variable :which-key "Customize a variable in the custom interface.")
   "cV" '(customize-set-variable :which-key "Expert level variable setting, sans interface.")
   "f" '(:ignore t :which-key "File operations.")
   "fs" '(save-buffer :which-key "Save your currently opened file.")
   "ff" '(find-file :which-key "Find a file.")
   ;; Frame operations
   "F" '(:ignore t "Frames.")
   "Fo" '(other-frame :which-key "Go to another frame.")
   "h" '(:ignore t :which-key "Help")
   "hd" '(:ignore t :which-key "Describe parts of Emacs.")
   "hdb" '(describe-bindings :which-key "Describe the keybindings that are in effect right now.")
   "hdB" '(general-describe-keybindings :which-key "Get a list of the key bindings that are in effect via General.")
   "hdf" '(describe-function :which-key "Describe a function.")
   "hdF" '(describe-face :which-key "Describe a face.")
   "hdp" '(describe-package :which-key "Describe a package.")
   ;; Info manuals
   "hi" '(:ignore t :which-key "Info")
   "hia" '(info-apropos :which-key "Search the info database.")
   "hii" '(info-index :which-key "Open the info index.")
   "him" '(info-display-manual :which-key "Open a specific info manual.")))
;; Aliases
(defalias 'setc #'general-setq "A convenience alias for setting customizable variables.")
;; For getting information about the keybindings available.
(use-package which-key
  :ensure t
  :custom
  (which-key-idle-delay 1)
  :init
  (which-key-mode))

(provide 'keymap-prepare)
