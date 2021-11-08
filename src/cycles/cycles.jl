"""
...
"""
struct ML{C<:AbstractCycle, S<:AbstractSolver, T}
    cycle::C
    numcycle::Int
    branch::Bool
    solver::S
    initial::T
end

(ml::ML)(hierarchy, level) = cycle!(hierarchy, ml, level)

"""
"""
abstract type AbstractCycle end

_cycle!(hierarchy,::AbstractCycle, ml, level) = error("Undefined cycle type")

"""
"""
cycle!(hierarchy, ml) = cycle!(solution, hierarchy, ml, 1)
function cycle!(hierarchy, ml, level)
    preprocessing!(hierarchy, ml, level)
    _cycle!(hierarchy, ml, level)
    postprocessing!(hierarchy, ml, level)
    return solution
end

function _cycle!(hierarchy, ml, level)
    for i in 1:ml.numcycle
        precycle!(hierarchy, ml.solver, level)
        _cycle!(hierarchy, ml.cycle, ml, level)
        postcycle!(hierarchy, ml.solver, level)
    end
    return solution
end 

