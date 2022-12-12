;;; speechd-el-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "braille" "braille.el" (0 0 0 0))
;;; Generated autoloads from braille.el

(register-definition-prefixes "braille" '("braille-"))

;;;***

;;;### (autoloads nil "brltty" "brltty.el" (0 0 0 0))
;;; Generated autoloads from brltty.el

(register-definition-prefixes "brltty" '("brltty-"))

;;;***

;;;### (autoloads nil "mmanager" "mmanager.el" (0 0 0 0))
;;; Generated autoloads from mmanager.el

(register-definition-prefixes "mmanager" '("mmanager-"))

;;;***

;;;### (autoloads nil "speechd" "speechd.el" (0 0 0 0))
;;; Generated autoloads from speechd.el

(autoload 'speechd-open "speechd" "\
Open connection to Speech Dispatcher using the given method.
If the connection corresponding to the current `speechd-client-name' value
already exists, close it and reopen again, with the same connection parameters.

Available methods are `unix-socket' and `inet-socket' for communication
over Unix sockets and TCP sockets respectively.  Default is 'unix-socket'.

The key arguments HOST and PORT are only relevant to the `inet-socket'
communication method and identify the speechd server location.  They can
override default values stored in the variables `speechd-host' and
`speechd-port'.

The SOCKET-NAME argument is only relevant to the `unix-socket' communication
method and can override the default path to the Dispatcher's Unix socket for
the given user.

If the key argument QUIET is non-nil, don't report failures and quit silently.
If the key argument FORCE-REOPEN is non-nil, try to reopen an existent
connection even if it previously failed.

Return the opened connection on success, nil otherwise.

\(fn &optional METHOD &key HOST PORT SOCKET-NAME QUIET FORCE-REOPEN)" t nil)

(autoload 'speechd-say-text "speechd" "\
Speak the given TEXT, represented by a string.
The key argument `priority' defines the priority of the message and must be one
of the symbols `important', `message', `text', `notification' or
`progress'.
The key argument SAY-IF-EMPTY is non-nil, TEXT is sent through SSIP even if it
is empty.

\(fn TEXT &key (PRIORITY speechd-default-text-priority) SAY-IF-EMPTY MARKERS)" t nil)

(autoload 'speechd-cancel "speechd" "\
Stop speaking all the messages sent through the current client so far.
If the universal argument is given, stop speaking messages of all clients.
If a numeric argument is given, stop speaking messages of all current Emacs
session clients.
If no argument is given, stop speaking messages of the current client and all
the clients of the current Emacs session named in
`speechd-cancelable-connections'.

\(fn &optional ALL)" t nil)

(autoload 'speechd-stop "speechd" "\
Stop speaking the currently spoken message (if any) of this client.
If the optional argument ALL is non-nil, stop speaking the currently spoken
messages of all clients.

\(fn &optional ALL)" t nil)

(autoload 'speechd-pause "speechd" "\
Pause speaking in the current client.
If the optional argument ALL is non-nil, pause speaking in all clients.

\(fn &optional ALL)" t nil)

(autoload 'speechd-resume "speechd" "\
Resume previously stopped speaking in the current client.
If the optional argument ALL is non-nil, resume speaking messages of all
clients.

\(fn &optional ALL)" t nil)

(autoload 'speechd-repeat "speechd" "\
Repeat the last message sent to speechd." t nil)

(register-definition-prefixes "speechd" '("speechd-"))

;;;***

;;;### (autoloads nil "speechd-braille" "speechd-braille.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from speechd-braille.el

(register-definition-prefixes "speechd-braille" '("speechd-braille-"))

;;;***

;;;### (autoloads nil "speechd-brltty" "speechd-brltty.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from speechd-brltty.el

(register-definition-prefixes "speechd-brltty" '("speechd-br"))

;;;***

;;;### (autoloads nil "speechd-bug" "speechd-bug.el" (0 0 0 0))
;;; Generated autoloads from speechd-bug.el

(autoload 'speechd-bug "speechd-bug" "\
Send a bug report on speechd-el or Speech Dispatcher." t nil)

(register-definition-prefixes "speechd-bug" '("speechd-bug-"))

;;;***

;;;### (autoloads nil "speechd-common" "speechd-common.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from speechd-common.el

(register-definition-prefixes "speechd-common" '("speechd-" "with-speechd-coding-protection"))

;;;***

;;;### (autoloads nil "speechd-compile" "speechd-compile.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from speechd-compile.el

(register-definition-prefixes "speechd-compile" '("speechd-compile"))

;;;***

;;;### (autoloads nil "speechd-out" "speechd-out.el" (0 0 0 0))
;;; Generated autoloads from speechd-out.el

(register-definition-prefixes "speechd-out" '("speechd-"))

;;;***

;;;### (autoloads nil "speechd-speak" "speechd-speak.el" (0 0 0 0))
;;; Generated autoloads from speechd-speak.el

(autoload 'speechd-speak-mode "speechd-speak" "\
Toggle speaking, the speechd-speak mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

This is a minor mode.  If called interactively, toggle the
`Speechd-Speak mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `speechd-speak-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

When speechd-speak mode is enabled, speech output is provided to Speech
Dispatcher on many actions.

The following key bindings are offered by speechd-speak mode, prefixed with
the value of the `speechd-speak-prefix' variable:

\\{speechd-speak-mode-map}

\(fn &optional ARG)" t nil)

(put 'global-speechd-speak-mode 'globalized-minor-mode t)

(defvar global-speechd-speak-mode nil "\
Non-nil if Global Speechd-Speak mode is enabled.
See the `global-speechd-speak-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-speechd-speak-mode'.")

(custom-autoload 'global-speechd-speak-mode "speechd-speak" nil)

(autoload 'global-speechd-speak-mode "speechd-speak" "\
Toggle Speechd-Speak mode in all buffers.
With prefix ARG, enable Global Speechd-Speak mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Speechd-Speak mode is enabled in all buffers where `(lambda nil
\(speechd-speak-mode 1))' would do it.

See `speechd-speak-mode' for more information on Speechd-Speak mode.

\(fn &optional ARG)" t nil)

(autoload 'speechd-speak "speechd-speak" "\
Start or restart speaking." t nil)

(register-definition-prefixes "speechd-speak" '("speechd-"))

;;;***

;;;### (autoloads nil "speechd-ssip" "speechd-ssip.el" (0 0 0 0))
;;; Generated autoloads from speechd-ssip.el

(register-definition-prefixes "speechd-ssip" '("speechd-ssip-"))

;;;***

;;;### (autoloads nil "speechd-version" "speechd-version.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from speechd-version.el

(register-definition-prefixes "speechd-version" '("speechd-version"))

;;;***

;;;### (autoloads nil nil ("speechd-el-pkg.el" "speechd-el.el") (0
;;;;;;  0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; speechd-el-autoloads.el ends here
