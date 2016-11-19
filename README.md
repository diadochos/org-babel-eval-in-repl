[![MELPA](http://melpa.org/packages/org-babel-eval-in-repl-badge.svg?)](http://melpa.org/#/org-babel-eval-in-repl) [![MELPA Stable](http://stable.melpa.org/packages/org-babel-eval-in-repl-badge.svg?)](http://stable.melpa.org/#/org-babel-eval-in-repl)
# org-babel-eval-in-repl
Execute babel source code blocks with [eval-in-repl](https://github.com/kaz-yos/eval-in-repl).

## Features
- *Async execution* (because it uses an external process!)
- Babel execution without the output written in the buffer (Less visual distraction! Output is reproducible as long as the code is saved)

## Installation
Available via MELPA ([Set up MELPA](https://github.com/melpa/melpa) if you haven't already). Run
```
M-x package-install RET org-babel-eval-in-repl RET
```

## Usage
``` emacs-lisp
(with-eval-after-load "ob"
  (require 'org-babel-eval-in-repl)
  (define-key org-mode-map (kbd "C-<return>") 'ober-eval-in-repl)
  (define-key org-mode-map (kbd "C-c C-c") 'ober-eval-block-in-repl))
```

### Recommended config (optional):
``` emacs-lisp
(with-eval-after-load "eval-in-repl"
  (setq eir-jump-after-eval nil))
```
