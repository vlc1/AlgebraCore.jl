module AlgebraCore

export simplify,
       substitute,
       isliteral,
       materialize,
       pushforward,
       pullback,
       differentiate

"""
    simplify(s)

Structurally simplify an algebra expression, returning an expression of the same
kind reduced by the implementation's rewrite rules (identities, constant folding,
…), without changing the represented value.
"""
function simplify end

"""
    substitute(s, pairs::NamedTuple)

Replace the named variables of `pairs` inside expression `s`, returning an
expression of the **same kind** (unlike [`materialize`](@ref), which evaluates to
a concrete value). Substitution is partial — variables absent from `pairs` are
kept symbolic — and a binding may itself be an expression, splicing a subtree.
"""
function substitute end

"""
    isliteral(s)

Whether expression `s` can be [`materialize`](@ref)d — i.e. contains no free
symbols. A purely structural (type-level) predicate.
"""
function isliteral end

"""
    materialize(s)

Evaluate a **literal** expression `s` (see [`isliteral`](@ref)) to a concrete
value. Bind any free symbols first with [`substitute`](@ref).
"""
function materialize end

"""
    pushforward(f, x, ẋ)

Forward-mode directional derivative (Jacobian–vector product) of expression `f`
with respect to variable `x`, along the input tangent `ẋ`.
"""
function pushforward end

"""
    pullback(f, x, ȳ)

Reverse-mode vector–Jacobian product of expression `f` with respect to variable
`x`, propagating the output cotangent `ȳ`. The result lives in `x`'s value
space.
"""
function pullback end

"""
    differentiate(f, x)

Derivative / Jacobian of expression `f` with respect to variable `x`, as an
expression of the same kind.
"""
function differentiate end

end
