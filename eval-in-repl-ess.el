;;; eval-in-repl-ess.el --- Eval org-mode babel code blocks in various REPLs.   -*- lexical-binding: t; -*-
;;
;; Author: Takeshi Teshima <diadochos.developer@gmail.com>
;; Keywords: literate programming, reproducible research, async execution
;; URL: https://github.com/diadochos/org-babel-eval-in-repl

;;
;; This file is not part of GNU Emacs.
;;
;; The MIT License (MIT)
;; Copyright (c) 2016 Takeshi Teshima
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

;;; Commentary:
;; This file complements eval-in-repl.

;;; Code:
(require 'ess)

;; TODO: Avoid shared process: two different languages in the same org-mode buffer
(defun ober--switch-to-process (language)
  (ess-get-process (concat (buffer-name) "-" language)))

(defun ober-eval-R ()
  (setq ess-dialect "R")
  (setq ess-language "S")
  (ober--switch-to-process "R")
  (ess-eval-line))

(defun ober-eval-stata ()
  (setq ess-dialect "stata")
  (setq ess-language "stata")
  (ober--switch-to-process "stata")
  (ess-eval-line))

(provide 'eval-in-repl-ess)
;;; eval-in-repl-ess.el ends here
