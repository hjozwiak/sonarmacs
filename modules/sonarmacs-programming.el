;;; sonarmacs-programming.el --- Programming facilities both provided and external to Emacs.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022, 2023  Hunter Jozwiak

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

;; 

;;; Code:

;; Eldoc tweaks
;; By default, Eldoc is hella spammy and needs to be tuned down a bit.
;; So we will have it print to its buffer instead of to the message window, and have speechd-el autoread that buffer instead.
(use-package eldoc
  :init
  ;; Bookkeeping
  (defvar sonarmacs--last-spoken-eldoc-message nil "The last documentation that we spoke.")
  (defun sonarmacs--speak-eldoc (docs interactive)
    "Speak the eldoc documentation from the buffer.

If the documentation strings are the same as before, i.e., the symbol has not changed, do not respeak them; the user can go back and view the buffer if they like."
    (when (and eldoc--doc-buffer (buffer-live-p eldoc--doc-buffer))
      (with-current-buffer eldoc--doc-buffer
      (unless (equal sonarmacs--last-spoken-eldoc-message eldoc--doc-buffer-docs)
        (speechd-say-text (buffer-string) :priority 'important)
        (setq sonarmacs--last-spoken-eldoc-message docs)))))
  :ghook
  ('eldoc-display-functions (list #'sonarmacs--speak-eldoc #'eldoc-display-in-buffer))
  :custom
  (eldoc-echo-area-prefer-doc-buffer t)
  :config
  (remove-hook 'eldoc-display-functions #'eldoc-display-in-echo-area))
;; Parenthesis matching
(use-package paren
  :custom
  (show-paren-delay 0))
(provide 'sonarmacs-programming)
;;; sonarmacs-programming.el ends here
