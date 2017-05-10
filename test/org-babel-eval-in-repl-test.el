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
(ert-deftest should-be-true ()
  "This test should pass."
  (should t))

(load "test/0-paths-test")

(provide 'org-babel-eval-in-repl-test)
;;; org-babel-eval-in-repl-test.el ends here
