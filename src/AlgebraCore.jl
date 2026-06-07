module AlgebraCore

export simplify,
       substitute,
       materialize,
       pushforward,
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
    materialize(s, pairs::NamedTuple)

Evaluate expression `s` to a concrete value, substituting the variable bindings
in `pairs`.
"""
function materialize end

"""
    pushforward(f, x, ẋ)

Forward-mode directional derivative (Jacobian–vector product) of expression `f`
with respect to variable `x`, along the input tangent `ẋ`.
"""
function pushforward end

"""
    differentiate(f, x)

Derivative / Jacobian of expression `f` with respect to variable `x`, as an
expression of the same kind.
"""
function differentiate end

end
