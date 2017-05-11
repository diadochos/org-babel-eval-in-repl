;;; org-babel-eval-in-repl.el --- Eval org-mode babel code blocks in various REPLs.   -*- lexical-binding: t; -*-
;;
;; Author: Takeshi Teshima <diadochos.developer@gmail.com>
;; Version:           20170511.2114
;; Package-Requires: ((eval-in-repl "0.9.2") (matlab-mode "3.3.6") (ess "16.10") (emacs "24"))
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
;; This package allows you to execute org-mode (babel) source code blocks with eval-in-repl.
;; ## Features
;; - Async execution (because it uses an external process!)
;; - Babel execution without the output written in the buffer (Less visual distraction! Output is reproducible as long as the code is saved)
;;
;; ## Usage
;; (with-eval-after-load "ob"
;;   (require 'org-babel-eval-in-repl)
;;   (define-key org-mode-map (kbd "C-<return>") 'ober-eval-in-repl)
;;   (define-key org-mode-map (kbd "C-c C-c") 'ober-eval-block-in-repl))
;;
;; ## Recommended config (optional):
;; (with-eval-after-load "eval-in-repl"
;;   (setq eir-jump-after-eval nil))

;;; Code:
(require 'ob)
(require 'org-element)
(require 'eval-in-repl)

;; @ Get data
(defun ober-get-block-content ()
  "Get source block content."
  (nth 1 (org-babel-get-src-block-info)))

(defun ober-get-type ()
  "Get language string from `org-babel-src-block-info'.
Returns nil if the cursor is outside a src block."
  (nth 0 (org-babel-get-src-block-info)))

;; Reference:
;; (org-babel-get-src-block-info) => '(language body arguments switches name start coderef)

;; @ Decide action
(defvar ober-org-babel-type-list
  '(("ruby" . (eval-in-repl-ruby eir-eval-in-ruby))
    ("clojure" . (eval-in-repl-cider eir-eval-in-cider))
    ("racket" . (eval-in-repl-geiser eir-eval-in-geiser))
    ;; ("racket" . (eval-in-repl-racket eir-eval-in-racket))
    ("scheme" . (eval-in-repl-scheme eir-eval-in-scheme))
    ("hy" . (eval-in-repl-hy eir-eval-in-hy))
    ("emacs-lisp" . (eval-in-repl-ielm eir-eval-in-ielm))
    ("javascript" . (eval-in-repl-javascript eir-eval-in-javascript))
    ("ocaml" . (eval-in-repl-ocaml eir-eval-in-ocaml))
    ("prolog" . (eval-in-repl-prolog eir-eval-in-prolog))
    ("python" . (eval-in-repl-python eir-eval-in-python))

    ;; ESS
    ("R" . (eval-in-repl-ess ober-eval-R))
    ("stata" . (eval-in-repl-ess ober-eval-stata))

    ("matlab" . (eval-in-repl-matlab ober-eval-matlab))

    ("sh" . (eval-in-repl-shell eir-eval-in-shell))
    ("lisp" . (eval-in-repl-slime eir-eval-in-slime))
    ;; ("perl" . (reply ober-eval-R))
    ("sml" . (eval-in-repl-sml eir-eval-in-sml)))
  "Association list of config.
Format: '((\"language-name\" . (feature-to-require execution-function-to-run)))")

(defun ober-get-exec-config (language)
  "Get exec procedure by looking up config by LANGUAGE.
`ober-org-babel-type-list' is the key variable to configure.
Return nil if it doesn't support the language"
  (cdr (assoc language ober-org-babel-type-list)))

;; @ Utility
(defun ober-src-block-empty-p (context)
  "CONTEXT is the context object returned by `org-element-context'.
Return t if source block is empty."
  (not (string-match "[^\s\n]+" (org-element-property :value context))))

(defun ober-select-block ()
  "Returns t if selected region. Otherwise, returns nil."
  (interactive)
  (when (org-in-block-p '("src" "example"))
    (let ((element (org-element-at-point)))
    (when (not (ober-src-block-empty-p element))
      (let ((area (org-src--contents-area element)))
        (set-mark (nth 0 area))
        (goto-char (nth 1 area))
        (setq deactivate-mark nil) ; Do not disable marking
        t)))))

;; @ Interface
;;;###autoload
(defun ober-eval-in-repl ()
  "Execute source code in a REPL. (The range to execute is determined by `eval-in-repl'.)"
  (interactive)
  (let ((config (ober-get-exec-config (ober-get-type))))
    (unless config (user-error "Language not supported"))
    (require (nth 0 config))
    (save-mark-and-excursion
     (funcall (nth 1 config)))))

;;;###autoload
(defun ober-eval-block-in-repl ()
  "Execute source code in a REPL. (The whole content in the block is evaluated)"
  (interactive)
  (let ((config (ober-get-exec-config (ober-get-type))))
    (unless config (user-error "Language not supported"))
    (save-mark-and-excursion
     (when (ober-select-block)
       (require (nth 0 config))
       (funcall (nth 1 config))
       (setq deactivate-mark nil)))))

(provide 'org-babel-eval-in-repl)
;;; org-babel-eval-in-repl.el ends here
