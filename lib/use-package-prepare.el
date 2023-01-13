;;; use-package-prepare.el --- Install and configure use-package.  -*- lexical-binding: t; -*-

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

;; use-package is a macro for declaritively configuring and installing Emacs packages.

;;; Code:


;; Compute the statistics for the user.
(customize-set-variable 'use-package-compute-statistics t)
;; Allways require things.
(customize-set-variable 'use-package-always-demand t)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(defalias 'modload #'use-package)
(provide 'use-package-prepare)
;;; use-package-prepare.el ends here
