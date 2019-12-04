[![MELPA](http://melpa.org/packages/org-babel-eval-in-repl-badge.svg?)](http://melpa.org/#/org-babel-eval-in-repl) [![MELPA Stable](http://stable.melpa.org/packages/org-babel-eval-in-repl-badge.svg?)](http://stable.melpa.org/#/org-babel-eval-in-repl) [![Travis CI](https://travis-ci.org/diadochos/org-babel-eval-in-repl.svg)](https://travis-ci.org/diadochos/org-babel-eval-in-repl)
# org-babel-eval-in-repl
Execute babel source code blocks with [eval-in-repl](https://github.com/kaz-yos/eval-in-repl).


![Demonstration](https://user-images.githubusercontent.com/1299928/68528644-d6ab1200-02f5-11ea-8bf9-9997b3755429.gif)

## Features
- *Async execution* (because it uses an external process!)
- Babel execution without the output written in the buffer (Less visual distraction! Output is reproducible as long as the code is saved)

## Installation
Available via MELPA ([Set up MELPA](https://github.com/melpa/melpa) if you haven't already). Run
```
M-x package-install RET org-babel-eval-in-repl RET
```

## Usage
No keybindings are provided by default (because I couldn't find one that's appropriate). Create your own comfortable keybind for execution. Here's my case:

``` emacs-lisp
(with-eval-after-load "ob"
  (require 'org-babel-eval-in-repl)
  (define-key org-mode-map (kbd "C-<return>") 'ober-eval-in-repl)
  (define-key org-mode-map (kbd "M-<return>") 'ober-eval-block-in-repl))
```

See the [wiki](https://github.com/diadochos/org-babel-eval-in-repl/wiki) for more usage (you can find more practical keybindings)

### Recommended config (optional):
(This prevents the cursor to jump to the repl buffer after execution. I was more comfortable with this)
``` emacs-lisp
(with-eval-after-load "eval-in-repl"
  (setq eir-jump-after-eval nil))
```

### Example

``` org
#+BEGIN_SRC ruby
p "Test"
#+END_SRC
```
Press `C-<return>` on the source code.

### Available languages
| Available languages (Prepared in the package) | Requirements             |
| :-----------------------------------------    | :----------------------- |
| matlab                                        | matlab-mode settings     |
| R                                             | ESS-mode                 |
| stata                                         |                          |

| Available languages (Delegated to [eval-in-repl](https://github.com/kaz-yos/eval-in-repl)) | Requirements             |
| :-----------------------------------------                                                 | :----------------------- |
| ruby                                                                                       |                          |
| clojure                                                                                    |                          |
| racket                                                                                     |                          |
| scheme                                                                                     |                          |
| hy                                                                                         |                          |
| emacs-lisp                                                                                 |                          |
| javascript                                                                                 |                          |
| ocaml                                                                                      |                          |
| prolog                                                                                     |                          |
| python                                                                                     |                          |
| sh                                                                                         |                          |
| lisp                                                                                       |                          |
| perl                                                                                       |                          |
| sml                                                                                        |                          |

## Contributors
Check out [here](./THANKS.md) for a list of contributors.
