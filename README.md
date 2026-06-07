# AlgebraCore

[![Build Status](https://github.com/vlc1/AlgebraCore.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/vlc1/AlgebraCore.jl/actions/workflows/CI.yml?query=branch%3Amain)

A tiny, dependency-free package that owns the generic *verbs* shared by
symbolic algebra packages. It declares the functions (with their generic
docstrings) but ships **no methods**: each algebra package `import`s and
**extends** them for its own expression types, so the same verbs operate
across different algebras.

## Verbs

| Verb | Meaning |
|------|---------|
| `simplify(s)` | Structurally reduce an expression, returning the same kind of object. |
| `substitute(s, pairs)` | Replace named variables, staying symbolic; partial — unbound names are kept. |
| `materialize(s, pairs)` | Evaluate an expression to a concrete value. |
| `pushforward(f, x, ẋ)` | Forward-mode directional derivative (Jacobian–vector product). |
| `differentiate(f, x)` | Derivative / Jacobian, returning the same kind of object. |

## Extending

Add methods on your own types:

```julia
import AlgebraCore: differentiate

struct MyExpr end

differentiate(e::MyExpr, x) = ...   # your rule here
```

Consumers bring the verbs into scope with `using AlgebraCore`. Extending
packages typically do **not** re-export them.

AlgebraCore itself contains only the function declarations, their generic
docstrings, and the export list — no concrete methods and no dependencies.
