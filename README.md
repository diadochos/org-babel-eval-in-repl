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
  (define-key org-mode-map (kbd "M-<return>") 'ober-eval-block-in-repl))
```

### Recommended config (optional):
``` emacs-lisp
(with-eval-after-load "eval-in-repl"
  (setq eir-jump-after-eval nil))
```

### More org-mode integrated usage
``` emacs-lisp
  (defun org-ctrl-return-around (org-fun &rest args)
    "Run `ober-eval-in-repl' if in source code block and `org-insert-heading-respect-content' otherwise."
    (if (org-in-block-p '("src" "example"))
        (ober-eval-in-repl)
      (apply org-fun args)))
  (advice-add 'org-insert-heading-respect-content :around #'org-ctrl-return-around)

  (defun org-meta-return-around (org-fun &rest args)
    "Run `ober-eval-block-in-repl' if in source code block or example block and `org-meta-return' otherwise."
    (if (org-in-block-p '("src" "example"))
        (ober-eval-block-in-repl)
      (apply org-fun args)))
  (advice-add 'org-meta-return :around #'org-meta-return-around)
```
If you write the above code in your `.emacs.d`:
- `C-<return>` will run **the code under the cursor** if in a source or example block.
- `C-<return>` will work the same as usual if outside a source or example block.
- `M-<return>` will run **the block under the cursor** if in a source or example block.
- `M-<return>` will work the same as usual if outside a source or example block.
