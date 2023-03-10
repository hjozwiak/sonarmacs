(unless (fboundp 'setopt)
  (require 'wid-edit)
  (defmacro setopt (&rest pairs)
  "Set VARIABLE/VALUE pairs, and return the final VALUE.
This is like `setq', but is meant for user options instead of
plain variables.  This means that `setopt' will execute any
`custom-set' form associated with VARIABLE.

\(fn [VARIABLE VALUE]...)"
  (declare (debug setq))
  (unless (zerop (mod (length pairs) 2))
    (error "PAIRS must have an even number of variable/value members"))
  (let ((expr nil))
    (while pairs
      (unless (symbolp (car pairs))
	(error "Attempting to set a non-symbol: %s" (car pairs)))
      (push `(setopt--set ',(car pairs) ,(cadr pairs))
	    expr)
      (setq pairs (cddr pairs)))
    (macroexp-progn (nreverse expr))))
(defun setopt--set (variable value)
  (custom-load-symbol variable)
  ;; Check that the type is correct.
  (when-let ((type (get variable 'custom-type)))
    (unless (widget-apply (widget-convert type) :match value)
      (warn "Value `%S' does not match type %s" value type)))
  (put variable 'custom-check-value (list value))
  (funcall (or (get variable 'custom-set) #'set-default) variable value)))

;; -*- lexical-binding: t; -*-
(setopt package-quickstart-file (expand-file-name "var/package-quickstart.el" user-emacs-directory)
        package-quickstart t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(unless (and (version< emacs-version "29.0") (package-installed-p 'use-package))
  (package-install 'use-package))
(setopt use-package-compute-statistics t
        use-package-always-demand t)
(require 'use-package)

(use-package no-littering
  :ensure t
  :hook (after-init . (lambda () (load custom-file)))
  :custom
  (auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (custom-file (no-littering-expand-etc-file-name "custom.el")))

(use-package speechd-el
  :ensure t
  :custom
   (speechd-speak-whole-line t)
   (speechd-speak-echo nil)
   (speechd-speak-read-command-keys nil)
   (speechd-voices '((nil
                           (rate . 100)
                           (output-module . "espeak-ng"))))
:config
(speechd-speak))

(use-package which-key
  :ensure t
  :custom
  (which-key-idle-delay 1.0)
  (which-key-compute-remaps t)
  (which-key-popup-type 'minibuffer)
  (which-key-show-transient-maps t)
  (which-key-mode t))

(use-package general
  :ensure t
  :config
  (general-auto-unbind-keys)
  (general-evil-setup t)
  ;; Create the leader definer
  (general-create-definer mapleader
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC"
    :states '(normal visual insert emacs))
  (mapleader
   "b" '(:ignore t :which-key "Buffer operations")
   "bn" '(next-buffer :which-key "Go to the next buffer.")
   "bp" '(previous-buffer :which-key "Go to the previous buffer.")
   "bb" '(switch-to-buffer :which-key "Switch to a buffer.")
   "bj" '(:ignore t :which-key "Jumping to specific buffers.")
   "bjd" '(dired-jump :which-key "Go to a dired window.")
   "bjm" '((lambda () (interactive) (switch-to-buffer (messages-buffer))) :which-key "Jump to messages buffer.")
   "bjw" '((lambda () (interactive) (switch-to-buffer "*Warnings*")) :which-key "Go to the warnings buffer.")
   "bjs" '((lambda () (interactive) (switch-to-buffer "*scratch*")) :which-key "Switch to the scratch buffer.")
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
   "fd" '(dired :which-key "Open a dired buffer.")
   "fr" '(recentf-open-files :which-key "Open a recent file.")
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
   "hdv" '(describe-variable :which-key "Describe a variable.")
   ;; Info manuals
   "hi" '(:ignore t :which-key "Info")
   "hia" '(info-apropos :which-key "Search the info database.")
   "hii" '(info-index :which-key "Open the info index.")
   "him" '(info-display-manual :which-key "Open a specific info manual."))
  (general-create-definer maplocal
    :keymaps 'override
    :prefix ","
    :global-prefix "SPC m"
    :states '(normal visual)))

(use-package undo-tree
  :custom
  (global-undo-tree-mode t)
  :ensure t)

(use-package evil
  :ensure t
  :custom
  (evil-echo-state nil)
  (evil-want-integration t)
  (evil-want-c-i-jump nil)
  (evil-want-keybind nil)
  (evil-undo-system 'undo-tree)
  :preface
  (defun sonarmacs--evil-state-change-notify ()
    (when (and evil-next-state evil-previous-state (not (eq evil-previous-state evil-next-state)))
      (speechd-say-text (format "Changing state from %s to %s." evil-previous-state evil-next-state) :priority 'important)))
  :hook ((evil-insert-state-exit evil-normal-state-exit evil-motion-state-exit evil-operator-state-exit evil-replace-state-exit evil-visual-state-exit evil-emacs-state-exit) . sonarmacs--evil-state-change-notify)
  :general
  (mapleader
    "bd" '(evil-delete-buffer :which-key "Kill the current buffer."))
  (:states '(normal visual insert operator replace motion)
           speechd-speak-prefix speechd-speak-mode-map)
  (speechd-speak-mode-map
   "e" 'evil-scroll-line-down)
  :config
  (evil-mode t)
   (speechd-speak--command-feedback (evil-next-line evil-previous-line evil-next-visual-line evil-previous-visual-line evil-beginning-of-line) after (speechd-speak-read-line (not speechd-speak-whole-line)))
   (speechd-speak--command-feedback (evil-forward-paragraph evil-backward-paragraph) after
                                    (speechd-speak-read-paragraph))
   (speechd-speak--command-feedback (evil-forward-word-begin evil-backward-word-begin evil-backward-word-end evil-forward-word-end) after (speechd-speak-read-word))
   (speechd-speak--command-feedback (evil-backward-char) after (speechd-speak-read-char (following-char)))
   (speechd-speak--command-feedback (evil-forward-char) after (speechd-speak-read-char (preceding-char))))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package transient
  :ensure t
  :custom
  (transient-show-popup t)
  (transient-enable-popup-navigation t)
  (transient-force-single-column t)
  :config
  (speechd-speak--command-feedback (transient-forward-button transient-backward-button) after
                                   (with-current-buffer (window-buffer transient--window)
                                     ;; Get at the button to speak.
                                     (when-let ((button (button-at (point)))
                                                (start (button-start button))
                                                (end (button-end button)))
                                       (speechd-speak-read-region start end)))))

(use-package magit
  :custom
  (magit-delete-by-moving-to-trash nil)
  :general
  (mapleader
  "g" '(:ignore t :which-key "Git operations.")
  "gg" '(magit-status :which-key "Status of the project.")
  "gs" '(magit-stage-file :which-key "Stage a file."))
  :config
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-modules 'magit-insert-stashes))

(use-package forge
  :after magit
  :ensure t
  :general
  (mapleader
    "gf" '(forge-dispatch :which-key "Forge dispatch map.")))

(use-package git-timemachine
  :ensure t
  :general
  (mapleader
    "tg" '(git-timemachine-toggle :which-key "Toggle the time machine on or off.")))

(use-package magit-gitflow
  :ensure t
  :hook (magit-mode . turn-on-magit-gitflow))

(setopt user-full-name "Hunter Jozwiak"
      user-mail-address "hunter.t.joz@gmail.com"
      user-login-name "sektor")

(setopt use-short-answers t)

(setopt auto-revert-interval 0.1
        global-auto-revert-mode t)

(setopt savehist-mode t)

(setopt recentf-mode t)

(setopt winner-mode t)
(mapleader
  "w" '(:ignore t :which-key "Window operations.")
  "wl" 'windmove-right
  "wh" 'windmove-left
  "wk" 'windmove-up
  "wj" 'windmove-down
  "wr" 'winner-redo
  "wu" 'winner-undo
  "wo" 'other-window)

(use-package orderless
  :ensure t
  :custom
    (completion-styles '(orderless basic))
    (completion-category-overrides '((file (styles . (partial-completion))))))

(use-package vertico
  :ensure t
  :custom
  (vertico-count 20)
  (vertico-cycle t)
  (vertico-mode t)
  :general
  (vertico-map
   "C-j" 'vertico-next
   "C-K" 'vertico-previous)
  :preface
  (defvar-local spoken-index -1 "Indes of the last spoken candidate")
  (defvar-local last-spoken-candidate nil "Last spoken candidate.")
  :config
  (speechd-speak--command-feedback-region (vertico-insert))
(speechd-speak--defadvice vertico--exhibit after
  (let ((new-cand
         (substring (vertico--candidate)
                    (if (>= vertico--index 0)
                            (length vertico--base)
                      0)))
        (to-speak nil))
    (unless (equal last-spoken-candidate new-cand)
      (push new-cand to-speak)
      (when (or (equal vertico--index spoken-index)
                (and (not (equal vertico--index -1))
                     (equal spoken-index -1)))
        (push "candidate" to-speak)))
    (when (and (not vertico--allow-prompt)
               (equal last-spoken-candidate nil))
      (push "first candidate" to-speak))
    (when to-speak
      (speechd-say-text (mapconcat 'identity to-speak " ")))
    (setq-local
     last-spoken-candidate new-cand
    spoken-index  vertico--index))))

(use-package vertico-directory
  :after vertico
  :general
  (vertico-map
   "C-h" 'vertico-directory-up
   "C-l" 'vertico-directory-down))

(use-package marginalia
  :ensure t
  :custom
  (marginalia-mode t))

(use-package consult
  :ensure t)

(use-package embark
  :ensure t
  :general
  ([remap describe-bindings] 'embark-bindings
   "C-." 'embark-act)
  :custom
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :after embark consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.0)
  (corfu-cycle t)
  (corfu-echo-documentation 1)
  (global-corfu-mode t)
  :preface
  (defvar-local corfu--last-spoken nil "The last spoken candidate.")
  (defvar-local corfu--last-spoken-index nil "Index into the last spoken candidate.")
  :config
  (eldoc-add-command #'corfu-insert)
  (speechd-speak--defadvice corfu--exhibit after
  (let ((new-cand
         (substring (nth corfu--index corfu--candidates)
                    (if (>= corfu--index 0)
                            (length corfu--base)
                      0)))
        (to-speak nil))
    (unless (equal corfu--last-spoken new-cand)
      (push new-cand to-speak)
      (when (or (equal corfu--index corfu--last-spoken-index)
                (and (not (equal corfu--index -1))
                     (equal corfu--last-spoken-index -1)))
        (push "candidate" to-speak)))
    (when (equal corfu--last-spoken nil)
      (push "first candidate" to-speak))
    (when to-speak
      (speechd-say-text (mapconcat 'identity to-speak " ")))
    (setq-local
     corfu--last-spoken new-cand
     corfu--last-spoken-index corfu--index))))

(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(setopt indent-tabs-mode nil)

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

(unless (and (version< emacs-version "29.0") (package-installed-p 'eglot))
  (package-install 'eglot))
(use-package eglot
  :custom
  (eglot-autoshutdown t)
  :general
  (maplocal
    :states 'normal
    :keymaps 'eglot-mode-map
    "l" '(:ignore t :which-key "LSP.")
    "la" '(:ignore t :which-key "LSP actions.")
    "laa" '(eglot-code-actions :which-key "Code actions.")
    "lae" 'eglot-code-action-extract
    "laf" '(eglot-format :which-key "Format the highlighted region.")
    "laF" '(eglot-format-buffer :which-key "Format the current buffer.")
    "lai" 'eglot-code-action-inline
    "lao" '(eglot-code-action-organize-imports :which-key "Organize your imports.")
    "laq" 'eglot-code-action-quickfix
    "lar" '(eglot-rename :which-key "Rename the symbol under point.")
    "laR" 'eglot-code-action-rewrite
    "lr" '(eglot-reconnect :which-key "Reconnect to the LSP server.")))
