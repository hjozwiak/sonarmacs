;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(unless (package-installed-p 'use-package)
  (package-install ''use-package))
(require 'use-package)

(use-package speechd-el
  :ensure t
  :custom
   (speechd-speak-whole-line t)
   (speechd-speak-echo nil)
   (speechd-speak-read-command-keys nil)
   (speechd-voices '((nil
			   (rate . 100)
			   (output-module . "espeak-ng"))))
:init
(speechd-speak))

(defun retrieve-speechd-function (thing)
  "Retrieve the function that is defined by speechd-el.

Usually it is the form of speechd-speak-read-<thing>"
  (cl-loop for s being the symbols
	   when (string-match (concat "speechd-speak-read-" thing) (symbol-name s))
	   when (fboundp s)
	   return s))

(use-package no-littering
  :ensure t
  :demand t
  :custom
  (auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (custom-file (no-littering-expand-etc-file-name "custom.el")))

(use-package which-key
  :ensure t
  :custom
  (which-key-idle-delay 0.1)
  :init
  (which-key-mode))

(use-package general
  :ensure t
  :config
  (general-auto-unbind-keys)
  (general-evil-setup t)
  ;; Create the leader definer
  (general-create-definer mapleader
    :prefix "SPC"
    :global-prefix "C-SPC"
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
   "Fd" '(delete-frame :which-key "Delete this frame.")
   "Fo" '(other-frame :which-key "Go to another frame.")
   "h" '(:ignore t :which-key "Help")
   "hd" '(:ignore t :which-key "Describe parts of Emacs.")
   "hdb" '(describe-bindings :which-key "Describe the keybindings that are in effect right now.")
   "hdB" '(general-describe-keybindings :which-key "Get a list of the key bindings that are in effect via General.")
   "hdf" '(describe-function :which-key "Describe a function.")
   "hdF" '(describe-face :which-key "Describe a face.")
   "hdk" '(describe-key :which-key "Describe what a key is bound to.")
   "hdp" '(describe-package :which-key "Describe a package.")
   ;; Info manuals
   "hi" '(:ignore t :which-key "Info")
   "hia" '(info-apropos :which-key "Search the info database.")
   "hii" '(info-index :which-key "Open the info index.")
   "him" '(info-display-manual :which-key "Open a specific info manual.")))
;; Aliases
(defalias 'setc #'general-setq "A convenience alias for setting customizable variables.")

(setc user-full-name "Hunter Jozwiak"
      user-mail-address "hunter.t.joz@gmail.com"
      user-login-name "sektor")

(setc indent-tabs-mode nil)


