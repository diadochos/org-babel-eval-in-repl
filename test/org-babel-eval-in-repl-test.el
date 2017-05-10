;;; org-babel-eval-in-repl-test.el --- Description.
;;
;; Author: Takeshi Teshima <diadochos.developer@gmail.com>
;; URL: 
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:
;; Test-runner dependencies
(require 'ert)
(eval-when-compile
  (require 'cl))

;; Load main code
(require 'org-babel-eval-in-repl)

;; tests
(load "test/trivial-test")

(provide 'org-babel-eval-in-repl-test)
;;; org-babel-eval-in-repl-test.el ends here
