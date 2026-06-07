# AGENTS.md

This file provides guidance to agents when working with code in this
repository.

**AlgebraCore** is the canonical interface for the *verbs* shared by a family
of symbolic-algebra packages. It owns the generic functions and their generic
docstrings only; the actual rewrite/derivative/evaluation logic lives in the
packages that extend them.

## The verbs

`simplify`, `substitute`, `materialize`, `pushforward`, `differentiate` —
declared in `src/AlgebraCore.jl` as `function <verb> end`, documented with
their abstract contract, and exported. Summary:

- `simplify(s)` — structural reduction; same kind of object.
- `substitute(s, pairs)` — replace named variables, stay symbolic; **partial**
  (unbound names kept).
- `materialize(s, pairs)` — evaluate to a concrete value.
- `pushforward(f, x, ẋ)` — forward-mode directional derivative (JVP).
- `differentiate(f, x)` — derivative / Jacobian; same kind of object.

## Sticky decisions

1. **Interface only.** `src/AlgebraCore.jl` contains exactly: the module, the
`function <verb> end` declarations, their generic docstrings, and the `export`
list. **No concrete methods** — those belong in the extending packages.
2. **Dependency-free.** No `[deps]`; only `Test` as a test extra. Keep `julia`
compat broad (`"1.0"`). Adding a runtime dependency here would force it on
every consumer — don't.
3. **Generic docstrings only.** Document the abstract contract of each verb,
not any implementation specifics; the latter belong on the extending package's
method docstrings.
4. **Adding a verb.** Add `function X end`, a generic docstring, and an
`export` entry. Never add a method that constrains argument types in this
package.
5. **Extension contract.** Downstream packages `import AlgebraCore: <verb>` and
add methods on their own types. They typically do **not** re-export the verbs —
consumers `using AlgebraCore`.

## MCP Servers

### julia-mcp (REQUIRED for Julia work)

Always use julia-mcp for executing Julia code. Do NOT use Bash `julia`
commands.

julia-mcp provides:
- Persistent REPL session state across multiple code evaluations
- Efficient package management and compilation caching
- Better integration with the development environment
- Access to interactive Julia development

Use `mcp__julia__julia_eval` to run Julia code. This maintains state, avoids
repeated compilation, and is the standard Julia development tool for this
project.

**Stale session detection**: If `Pkg.test` passes in a subprocess but direct
`julia_eval` reproduces old behavior after editing source files, the session
has stale compiled code. Call `mcp__julia__julia_restart` (with `env_path`)
before re-running interactive checks. Revise.jl is loaded automatically but
cannot always hot-patch method table changes (e.g., adding a new dispatch
method that shadows a previously compiled one).
