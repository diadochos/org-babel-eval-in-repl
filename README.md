# org-babel-eval-in-repl
Execute babel source code blocks with [eval-in-repl](https://github.com/kaz-yos/eval-in-repl).

## Features
- Async execution (because it uses an external process!)
- Babel execution without 

## Usage
```
(with-eval-after-load "ob"
  (require 'org-babel-eval-in-repl)
  (define-key org-mode-map (kbd "C-<return>") 'ober:eval-in-repl))
```

### Recommended config (optional):
```
(with-eval-after-load "eval-in-repl"
  (setq eir-jump-after-eval nil))
```