;; Example configuration for Sonarmacs.

;; You can load modules like this:
;; (modload foo)
;; And pass further use-package arguments along.
;; Similarly, you can set customization variables with the setc macro, which is aliased to general-setq.
;; Tell Emacs who you are.
(setc user-full-name "The Dude."
      user-mail-address "thedude@earthlink.net")

;; Load in some modules.
(modload sonarmacs-evil)
(modload sonarmacs-git)
(modload sonarmacs-programming)
;; ...
;; Enjoy!
