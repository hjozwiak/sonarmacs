;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t
toolbar-mode nil
menu-bar-mode nil)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq load-prefer-newer 'noninteractive)
